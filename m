Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF764B9A04
	for <lists+target-devel@lfdr.de>; Thu, 17 Feb 2022 08:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiBQHqG (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 17 Feb 2022 02:46:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiBQHqF (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:46:05 -0500
Received: from mail-m2836.qiye.163.com (mail-m2836.qiye.163.com [103.74.28.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5623A1A8;
        Wed, 16 Feb 2022 23:45:50 -0800 (PST)
Received: from localhost.localdomain (unknown [218.94.118.90])
        by mail-m2836.qiye.163.com (Hmail) with ESMTPA id 4CCD7C04BC;
        Thu, 17 Feb 2022 15:45:48 +0800 (CST)
From:   mingzhe.zou@easystack.cn
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     zoumingzhe@qq.com, Mingzhe Zou <mingzhe.zou@easystack.cn>
Subject: [PATCH v2] target: add iscsi/cpus_allowed_list in configfs
Date:   Thu, 17 Feb 2022 15:45:11 +0800
Message-Id: <20220217074511.9696-1-mingzhe.zou@easystack.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125083821.18225-1-mingzhe.zou@easystack.cn>
References: <20220125083821.18225-1-mingzhe.zou@easystack.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlCN1dZLVlBSVdZDwkaFQgSH1lBWRpNGEpWTEJJTR0aThlMHx
        hJVRkRExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6DSo4EjI8Iw9MCEseEis*
        QwgwFDBVSlVKTU9OS0NIQk9DQ0lNVTMWGhIXVRYSFRwBEx5VARQOOx4aCAIIDxoYEFUYFUVZV1kS
        C1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBQkxOTjcG
X-HM-Tid: 0a7f06a4f5c6841ekuqw4ccd7c04bc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

From: Mingzhe Zou <mingzhe.zou@easystack.cn>

The RX/TX threads for iSCSI connection can be scheduled to
any online cpus, and will not be rescheduled.

If bind other heavy load threads with iSCSI connection
RX/TX thread to the same cpu, the iSCSI performance will
be worse.

This patch add iscsi/cpus_allowed_list in configfs. The
available cpus set of iSCSI connection RX/TX threads is
allowed_cpus & online_cpus. If it is modified, all RX/TX
threads will be rescheduled.

Signed-off-by: Mingzhe Zou <mingzhe.zou@easystack.cn>
---
 drivers/target/iscsi/iscsi_target.c          | 66 +++++++++++++++++++-
 drivers/target/iscsi/iscsi_target_configfs.c | 32 ++++++++++
 drivers/target/iscsi/iscsi_target_login.c    |  8 +++
 include/target/iscsi/iscsi_target_core.h     | 31 ++-------
 4 files changed, 109 insertions(+), 28 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 2c54c5d8412d..82f54b59996d 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -702,13 +702,19 @@ static int __init iscsi_target_init_module(void)
 	if (!iscsit_global->ts_bitmap)
 		goto configfs_out;
 
+	if (!zalloc_cpumask_var(&iscsit_global->allowed_cpumask, GFP_KERNEL)) {
+		pr_err("Unable to allocate iscsit_global->allowed_cpumask\n");
+		goto bitmap_out;
+	}
+	cpumask_setall(iscsit_global->allowed_cpumask);
+
 	lio_qr_cache = kmem_cache_create("lio_qr_cache",
 			sizeof(struct iscsi_queue_req),
 			__alignof__(struct iscsi_queue_req), 0, NULL);
 	if (!lio_qr_cache) {
 		pr_err("Unable to kmem_cache_create() for"
 				" lio_qr_cache\n");
-		goto bitmap_out;
+		goto cpumask_out;
 	}
 
 	lio_dr_cache = kmem_cache_create("lio_dr_cache",
@@ -753,6 +759,8 @@ static int __init iscsi_target_init_module(void)
 	kmem_cache_destroy(lio_dr_cache);
 qr_out:
 	kmem_cache_destroy(lio_qr_cache);
+cpumask_out:
+	free_cpumask_var(iscsit_global->allowed_cpumask);
 bitmap_out:
 	vfree(iscsit_global->ts_bitmap);
 configfs_out:
@@ -782,6 +790,7 @@ static void __exit iscsi_target_cleanup_module(void)
 
 	target_unregister_template(&iscsi_ops);
 
+	free_cpumask_var(iscsit_global->allowed_cpumask);
 	vfree(iscsit_global->ts_bitmap);
 	kfree(iscsit_global);
 }
@@ -3587,6 +3596,11 @@ static int iscsit_send_reject(
 void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
 {
 	int ord, cpu;
+	cpumask_t conn_allowed_cpumask;
+
+	cpumask_and(&conn_allowed_cpumask, iscsit_global->allowed_cpumask,
+		    cpu_online_mask);
+
 	/*
 	 * bitmap_id is assigned from iscsit_global->ts_bitmap from
 	 * within iscsit_start_kthreads()
@@ -3595,8 +3609,9 @@ void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
 	 * iSCSI connection's RX/TX threads will be scheduled to
 	 * execute upon.
 	 */
-	ord = conn->bitmap_id % cpumask_weight(cpu_online_mask);
-	for_each_online_cpu(cpu) {
+	cpumask_clear(conn->conn_cpumask);
+	ord = conn->bitmap_id % cpumask_weight(&conn_allowed_cpumask);
+	for_each_cpu(cpu, &conn_allowed_cpumask) {
 		if (ord-- == 0) {
 			cpumask_set_cpu(cpu, conn->conn_cpumask);
 			return;
@@ -3609,6 +3624,51 @@ void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
 	cpumask_setall(conn->conn_cpumask);
 }
 
+static void iscsit_thread_reschedule(struct iscsi_conn *conn)
+{
+	/*
+	 * If iscsit_global->allowed_cpumask modified, reschedule iSCSI
+	 * connection's RX/TX threads update conn->allowed_cpumask.
+	 */
+	if (!cpumask_equal(iscsit_global->allowed_cpumask,
+			   conn->allowed_cpumask)) {
+		iscsit_thread_get_cpumask(conn);
+		conn->conn_tx_reset_cpumask = 1;
+		conn->conn_rx_reset_cpumask = 1;
+		cpumask_copy(conn->allowed_cpumask,
+			     iscsit_global->allowed_cpumask);
+	}
+}
+
+void iscsit_thread_check_cpumask(
+	struct iscsi_conn *conn,
+	struct task_struct *p,
+	int mode)
+{
+	iscsit_thread_reschedule(conn);
+
+	/*
+	 * mode == 1 signals iscsi_target_tx_thread() usage.
+	 * mode == 0 signals iscsi_target_rx_thread() usage.
+	 */
+	if (mode == 1) {
+		if (!conn->conn_tx_reset_cpumask)
+			return;
+		conn->conn_tx_reset_cpumask = 0;
+	} else {
+		if (!conn->conn_rx_reset_cpumask)
+			return;
+		conn->conn_rx_reset_cpumask = 0;
+	}
+	/*
+	 * Update the CPU mask for this single kthread so that
+	 * both TX and RX kthreads are scheduled to run on the
+	 * same CPU.
+	 */
+	set_cpus_allowed_ptr(p, conn->conn_cpumask);
+}
+EXPORT_SYMBOL(iscsit_thread_check_cpumask);
+
 int
 iscsit_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
 {
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 2a9de24a8bbe..0cedcfe207b5 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1127,8 +1127,40 @@ static ssize_t lio_target_wwn_lio_version_show(struct config_item *item,
 
 CONFIGFS_ATTR_RO(lio_target_wwn_, lio_version);
 
+static ssize_t lio_target_wwn_cpus_allowed_list_show(
+		struct config_item *item, char *page)
+{
+	return sprintf(page, "%*pbl\n",
+		       cpumask_pr_args(iscsit_global->allowed_cpumask));
+}
+
+static ssize_t lio_target_wwn_cpus_allowed_list_store(
+		struct config_item *item, const char *page, size_t count)
+{
+	int ret;
+	char *orig;
+	cpumask_t new_allowed_cpumask;
+
+	orig = kstrdup(page, GFP_KERNEL);
+	if (!orig)
+		return -ENOMEM;
+
+	cpumask_clear(&new_allowed_cpumask);
+	ret = cpulist_parse(orig, &new_allowed_cpumask);
+
+	kfree(orig);
+	if (ret != 0)
+		return ret;
+
+	cpumask_copy(iscsit_global->allowed_cpumask, &new_allowed_cpumask);
+	return count;
+}
+
+CONFIGFS_ATTR(lio_target_wwn_, cpus_allowed_list);
+
 static struct configfs_attribute *lio_target_wwn_attrs[] = {
 	&lio_target_wwn_attr_lio_version,
+	&lio_target_wwn_attr_cpus_allowed_list,
 	NULL,
 };
 
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 1a9c50401bdb..9c01fb864585 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -1129,8 +1129,15 @@ static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
 		goto free_conn_ops;
 	}
 
+	if (!zalloc_cpumask_var(&conn->allowed_cpumask, GFP_KERNEL)) {
+		pr_err("Unable to allocate conn->allowed_cpumask\n");
+		goto free_conn_cpumask;
+	}
+
 	return conn;
 
+free_conn_cpumask:
+	free_cpumask_var(conn->conn_cpumask);
 free_conn_ops:
 	kfree(conn->conn_ops);
 put_transport:
@@ -1142,6 +1149,7 @@ static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
 
 void iscsit_free_conn(struct iscsi_conn *conn)
 {
+	free_cpumask_var(conn->allowed_cpumask);
 	free_cpumask_var(conn->conn_cpumask);
 	kfree(conn->conn_ops);
 	iscsit_put_transport(conn->conn_transport);
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 1eccb2ac7d02..adc87de0362b 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -580,6 +580,7 @@ struct iscsi_conn {
 	struct ahash_request	*conn_tx_hash;
 	/* Used for scheduling TX and RX connection kthreads */
 	cpumask_var_t		conn_cpumask;
+	cpumask_var_t		allowed_cpumask;
 	unsigned int		conn_rx_reset_cpumask:1;
 	unsigned int		conn_tx_reset_cpumask:1;
 	/* list_head of struct iscsi_cmd for this connection */
@@ -878,6 +879,7 @@ struct iscsit_global {
 	/* Thread Set bitmap pointer */
 	unsigned long		*ts_bitmap;
 	spinlock_t		ts_bitmap_lock;
+	cpumask_var_t		allowed_cpumask;
 	/* Used for iSCSI discovery session authentication */
 	struct iscsi_node_acl	discovery_acl;
 	struct iscsi_portal_group	*discovery_tpg;
@@ -898,29 +900,8 @@ static inline u32 session_get_next_ttt(struct iscsi_session *session)
 
 extern struct iscsi_cmd *iscsit_find_cmd_from_itt(struct iscsi_conn *, itt_t);
 
-static inline void iscsit_thread_check_cpumask(
-	struct iscsi_conn *conn,
-	struct task_struct *p,
-	int mode)
-{
-	/*
-	 * mode == 1 signals iscsi_target_tx_thread() usage.
-	 * mode == 0 signals iscsi_target_rx_thread() usage.
-	 */
-	if (mode == 1) {
-		if (!conn->conn_tx_reset_cpumask)
-			return;
-		conn->conn_tx_reset_cpumask = 0;
-	} else {
-		if (!conn->conn_rx_reset_cpumask)
-			return;
-		conn->conn_rx_reset_cpumask = 0;
-	}
-	/*
-	 * Update the CPU mask for this single kthread so that
-	 * both TX and RX kthreads are scheduled to run on the
-	 * same CPU.
-	 */
-	set_cpus_allowed_ptr(p, conn->conn_cpumask);
-}
+extern void iscsit_thread_check_cpumask(struct iscsi_conn *conn,
+					struct task_struct *p,
+					int mode);
+
 #endif /* ISCSI_TARGET_CORE_H */
-- 
2.17.1

