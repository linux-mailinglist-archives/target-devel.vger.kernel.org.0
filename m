Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A1520E23
	for <lists+target-devel@lfdr.de>; Tue, 10 May 2022 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiEJGzk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 10 May 2022 02:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiEJGze (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 10 May 2022 02:55:34 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C66225E9A;
        Mon,  9 May 2022 23:51:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VCpZSOO_1652165414;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VCpZSOO_1652165414)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 14:51:34 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     bostroesser@gmail.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH] scsi:tcmu: switch tcmu completion path to work queue context
Date:   Tue, 10 May 2022 14:50:14 +0800
Message-Id: <1652165414-15933-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Currently, tcmu do completion in uio_write context, the userspace
will wait until tcmu`s done synchronously, switch completion path to
work queue context for better performance.

Use tcmu + file to evaluate performance,
fio job: fio -filename=/dev/sdb  -direct=1 -size=2G -name=1 -thread
-runtime=60 -time_based  -rw=randwrite -numjobs=16 -iodepth=16 -bs=128k

Without this patch:
	READ: bw=2775MiB/s (2910MB/s), 173MiB/s-174MiB/s
(181MB/s-183MB/s), io=163GiB (175GB), run=60001-60001msec

With this patch:
	READ: bw=3333MiB/s (3495MB/s), 208MiB/s-209MiB/s
(218MB/s-219MB/s), io=195GiB (210GB), run=60001-60001msec

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/target/target_core_user.c | 151 +++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 67 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index fd7267b..0eb3396 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -168,6 +168,8 @@ struct tcmu_dev {
 	char dev_config[TCMU_CONFIG_LEN];
 
 	int nl_reply_supported;
+
+	struct work_struct complete_work;
 };
 
 #define TCMU_DEV(_se_dev) container_of(_se_dev, struct tcmu_dev, se_dev)
@@ -223,6 +225,7 @@ struct tcmu_tmr {
 
 static atomic_t global_page_count = ATOMIC_INIT(0);
 static struct delayed_work tcmu_unmap_work;
+struct workqueue_struct *tcmu_comp_wq;
 static int tcmu_global_max_pages = TCMU_GLOBAL_MAX_PAGES_DEF;
 
 static int tcmu_set_global_max_data_area(const char *str,
@@ -1596,6 +1599,76 @@ static void tcmu_detach_hba(struct se_hba *hba)
 	hba->hba_ptr = NULL;
 }
 
+static void run_qfull_queue(struct tcmu_dev *udev, bool fail)
+{
+	struct tcmu_cmd *tcmu_cmd, *tmp_cmd;
+	LIST_HEAD(cmds);
+	sense_reason_t scsi_ret;
+	int ret;
+
+	if (list_empty(&udev->qfull_queue))
+		return;
+
+	pr_debug("running %s's cmdr queue forcefail %d\n", udev->name, fail);
+
+	list_splice_init(&udev->qfull_queue, &cmds);
+
+	list_for_each_entry_safe(tcmu_cmd, tmp_cmd, &cmds, queue_entry) {
+		list_del_init(&tcmu_cmd->queue_entry);
+
+		pr_debug("removing cmd %p on dev %s from queue\n",
+			 tcmu_cmd, udev->name);
+
+		if (fail) {
+			/*
+			 * We were not able to even start the command, so
+			 * fail with busy to allow a retry in case runner
+			 * was only temporarily down. If the device is being
+			 * removed then LIO core will do the right thing and
+			 * fail the retry.
+			 */
+			tcmu_cmd->se_cmd->priv = NULL;
+			target_complete_cmd(tcmu_cmd->se_cmd, SAM_STAT_BUSY);
+			tcmu_free_cmd(tcmu_cmd);
+			continue;
+		}
+
+		ret = queue_cmd_ring(tcmu_cmd, &scsi_ret);
+		if (ret < 0) {
+			pr_debug("cmd %p on dev %s failed with %u\n",
+				 tcmu_cmd, udev->name, scsi_ret);
+			/*
+			 * Ignore scsi_ret for now. target_complete_cmd
+			 * drops it.
+			 */
+			tcmu_cmd->se_cmd->priv = NULL;
+			target_complete_cmd(tcmu_cmd->se_cmd,
+					    SAM_STAT_CHECK_CONDITION);
+			tcmu_free_cmd(tcmu_cmd);
+		} else if (ret > 0) {
+			pr_debug("ran out of space during cmdr queue run\n");
+			/*
+			 * cmd was requeued, so just put all cmds back in
+			 * the queue
+			 */
+			list_splice_tail(&cmds, &udev->qfull_queue);
+			break;
+		}
+	}
+
+	tcmu_set_next_deadline(&udev->qfull_queue, &udev->qfull_timer);
+}
+
+static void tcmu_complete_work(struct work_struct *work)
+{
+	struct tcmu_dev *udev = container_of(work, struct tcmu_dev, complete_work);
+
+	mutex_lock(&udev->cmdr_lock);
+	if (tcmu_handle_completions(udev))
+		run_qfull_queue(udev, false);
+	mutex_unlock(&udev->cmdr_lock);
+}
+
 static struct se_device *tcmu_alloc_device(struct se_hba *hba, const char *name)
 {
 	struct tcmu_dev *udev;
@@ -1634,6 +1707,7 @@ static struct se_device *tcmu_alloc_device(struct se_hba *hba, const char *name)
 
 	xa_init(&udev->data_pages);
 
+	INIT_WORK(&udev->complete_work, tcmu_complete_work);
 	return &udev->se_dev;
 }
 
@@ -1725,75 +1799,10 @@ static void tcmu_dev_kref_release(struct kref *kref)
 	call_rcu(&dev->rcu_head, tcmu_dev_call_rcu);
 }
 
-static void run_qfull_queue(struct tcmu_dev *udev, bool fail)
-{
-	struct tcmu_cmd *tcmu_cmd, *tmp_cmd;
-	LIST_HEAD(cmds);
-	sense_reason_t scsi_ret;
-	int ret;
-
-	if (list_empty(&udev->qfull_queue))
-		return;
-
-	pr_debug("running %s's cmdr queue forcefail %d\n", udev->name, fail);
-
-	list_splice_init(&udev->qfull_queue, &cmds);
-
-	list_for_each_entry_safe(tcmu_cmd, tmp_cmd, &cmds, queue_entry) {
-		list_del_init(&tcmu_cmd->queue_entry);
-
-		pr_debug("removing cmd %p on dev %s from queue\n",
-			 tcmu_cmd, udev->name);
-
-		if (fail) {
-			/*
-			 * We were not able to even start the command, so
-			 * fail with busy to allow a retry in case runner
-			 * was only temporarily down. If the device is being
-			 * removed then LIO core will do the right thing and
-			 * fail the retry.
-			 */
-			tcmu_cmd->se_cmd->priv = NULL;
-			target_complete_cmd(tcmu_cmd->se_cmd, SAM_STAT_BUSY);
-			tcmu_free_cmd(tcmu_cmd);
-			continue;
-		}
-
-		ret = queue_cmd_ring(tcmu_cmd, &scsi_ret);
-		if (ret < 0) {
-			pr_debug("cmd %p on dev %s failed with %u\n",
-				 tcmu_cmd, udev->name, scsi_ret);
-			/*
-			 * Ignore scsi_ret for now. target_complete_cmd
-			 * drops it.
-			 */
-			tcmu_cmd->se_cmd->priv = NULL;
-			target_complete_cmd(tcmu_cmd->se_cmd,
-					    SAM_STAT_CHECK_CONDITION);
-			tcmu_free_cmd(tcmu_cmd);
-		} else if (ret > 0) {
-			pr_debug("ran out of space during cmdr queue run\n");
-			/*
-			 * cmd was requeued, so just put all cmds back in
-			 * the queue
-			 */
-			list_splice_tail(&cmds, &udev->qfull_queue);
-			break;
-		}
-	}
-
-	tcmu_set_next_deadline(&udev->qfull_queue, &udev->qfull_timer);
-}
-
 static int tcmu_irqcontrol(struct uio_info *info, s32 irq_on)
 {
 	struct tcmu_dev *udev = container_of(info, struct tcmu_dev, uio_info);
-
-	mutex_lock(&udev->cmdr_lock);
-	if (tcmu_handle_completions(udev))
-		run_qfull_queue(udev, false);
-	mutex_unlock(&udev->cmdr_lock);
-
+	queue_work(tcmu_comp_wq, &udev->complete_work);
 	return 0;
 }
 
@@ -3281,12 +3290,17 @@ static int __init tcmu_module_init(void)
 
 	INIT_DELAYED_WORK(&tcmu_unmap_work, tcmu_unmap_work_fn);
 
+	tcmu_comp_wq = alloc_workqueue("tcmu-comp-wq",
+			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!tcmu_comp_wq)
+		return -ENOMEM;
+
 	tcmu_cmd_cache = kmem_cache_create("tcmu_cmd_cache",
 				sizeof(struct tcmu_cmd),
 				__alignof__(struct tcmu_cmd),
 				0, NULL);
 	if (!tcmu_cmd_cache)
-		return -ENOMEM;
+		goto out_free_comp_wq;
 
 	tcmu_root_device = root_device_register("tcm_user");
 	if (IS_ERR(tcmu_root_device)) {
@@ -3335,6 +3349,8 @@ static int __init tcmu_module_init(void)
 	root_device_unregister(tcmu_root_device);
 out_free_cache:
 	kmem_cache_destroy(tcmu_cmd_cache);
+out_free_comp_wq:
+	destroy_workqueue(tcmu_comp_wq);
 
 	return ret;
 }
@@ -3347,6 +3363,7 @@ static void __exit tcmu_module_exit(void)
 	genl_unregister_family(&tcmu_genl_family);
 	root_device_unregister(tcmu_root_device);
 	kmem_cache_destroy(tcmu_cmd_cache);
+	destroy_workqueue(tcmu_comp_wq);
 }
 
 MODULE_DESCRIPTION("TCM USER subsystem plugin");
-- 
1.8.3.1

