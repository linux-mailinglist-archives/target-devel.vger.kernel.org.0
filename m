Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB721B36F
	for <lists+target-devel@lfdr.de>; Fri, 10 Jul 2020 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgGJKsy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 10 Jul 2020 06:48:54 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.5]:46889 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727828AbgGJKss (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1594378124; i=@ts.fujitsu.com;
        bh=keNBsnwlLdRdvdF8bifP+1oBj9UxnqkimfzxMjNjbcw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=IM0RJIvC6Np2xd9fQTIkE4zoBHJjfA6qW3gRwQTlyXelpzjaMxJ9st7aVfzPNqDt6
         vmLScTGN26DXE3hOt0pguNY+tIl27uV+F00qe+K0lIWy2e7rpFDWqzW0y0qbb6HoOe
         qpvDN+7/UfgFwRZFEy8IBuUYjoWEWcy/k4HyvdolhPhWv5LDjSqrKuw8xeUnleeQAk
         Bhc5gn+YkFT9VMC2o8mgUa2AUvO+OYTsgE9SQXgosxdy52darvR6drHGnWy3QOjXtY
         BcnbLjQTYHuC6r/mZilY0+j7NWpy3JYPsNfbsMygiGWbagcMvMjOVK7aSOmBc2k+/9
         OkhjaSV2lP6DA==
Received: from [100.112.192.107] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-west-1.aws.symcld.net id 74/54-05965-C87480F5; Fri, 10 Jul 2020 10:48:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeJIrShJLcpLzFFi42Kxs+EI0e1x54g
  3WD2L2aL7+g42i+XH/zFZ/J10g9WidelbJgcWj49Pb7F4fN4kF8AUxZqZl5RfkcCaMbP/P1vB
  y/SKfzMfMTcwfg3vYuTiEBKYzCixemsXM4QznVGi99MTti5GTg42AQOJFZPus4AkRATWMEqsv
  DOPGSTBLKAnMe3fOnYQW1jATaLl0xLWLkYODhYBVYnXW1lBwrwCdhKvvp0AsyUE5CU6DkxmAb
  E5Bewl9nf9A7OFgGp29T1kncDIvYCRYRWjRVJRZnpGSW5iZo6uoYGBrqGhka6hpQkQG+klVuk
  m6qWW6panFpfoGuollhfrFVfmJuek6OWllmxiBIZJSsGhAzsYl735oHeIUZKDSUmUd9pH9ngh
  vqT8lMqMxOKM+KLSnNTiQ4wyHBxKErwOrhzxQoJFqempFWmZOcCQhUlLcPAoifDOdwFK8xYXJ
  OYWZ6ZDpE4xGnPc3rBkETPH5rlLFzELseTl56VKifP+cwYqFQApzSjNgxsEi6VLjLJSwryMDA
  wMQjwFqUW5mSWo8q8YxTkYlYAqQO7hycwrgdv3CugUJqBTjnKwgZxSkoiQkmpgMjlt8XZBdUb
  YW+bbmSWXXUwjao6+S9PRk9f+duc+60kvayt5nroJ7vkKvGbbgnUn5d33+Tzh58L4Nd1zTDW5
  1KIyDLatqoxfHteR9Z7PZ5905rb95QxcHGEPHTYZat6TKLLbd/7Z+fU6ngG28d1ZrhMPx56r3
  c55VWRjXHbbqRbjyzlnLl75NV+RdffbkNCtFUYiwvc29VW+Mf61Q1pDSpTn9Mop75v9fNV7TF
  R2Jy6oXyqi/X7Dmftp80LmFOp+Fo1m9C05WqVfnVd1WC6lZanYaWbvgqLbl8/1WE8S4WZ42h0
  npN9nkqSo/vqzyCqXjkUCTpqeSYrB8ecqUra+uBMdb61XL3Lt59xr65VYijMSDbWYi4oTARzU
  4xogAwAA
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-8.tower-271.messagelabs.com!1594378123!7952!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6092 invoked from network); 10 Jul 2020 10:48:43 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-8.tower-271.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Jul 2020 10:48:43 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 06AAmgm3017892;
        Fri, 10 Jul 2020 11:48:42 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id 8E4FB208C4;
        Fri, 10 Jul 2020 12:48:42 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [PATCH 7/8] scsi: target: tcmu: Implement tmr_notify callback
Date:   Fri, 10 Jul 2020 12:48:16 +0200
Message-Id: <20200710104817.19462-8-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20200710104817.19462-1-bstroesser@ts.fujitsu.com>
References: <20200710104817.19462-1-bstroesser@ts.fujitsu.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch implements the tmr_notify callback for tcmu.
When the callback is called, tcmu checks the list of aborted
commands it received as parameter:
 - aborted commands in the qfull_queue are removed from
   the queue and target_complete_command is called
 - from the cmd_ids of aborted commands currently uncompleted
   in cmd ring it creates a list of aborted cmd_ids.
Finally a TMR notification is written to cmd ring containing
TMR type and cmd_id list. If there is no space in ring, the
TMR notification is queued on a TMR specific queue.

The TMR specific queue 'tmr_queue' can be seen as a extension
of the cmd ring. At the end of each iexecution of
tcmu_complete_commands() we check, whether tmr_queue contains
TMRs and try to move them onto the ring. If tmr_queue is not
empty after that, we don't call run_qfull_queue() because
commands must not overtake TMRs.

Operating that way we guarantee that cmd_ids in TMR notification
received by userspace either match an active, not yet completed
command or are no longer valid due to userspace having complete
some cmd_ids meanwhile.

New commands that were assigned to an aborted cmd_id will always
appear on the cmd ring _after_ the TMR.

Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
---
 drivers/target/target_core_user.c     | 226 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/target_core_user.h |  25 ++++
 2 files changed, 242 insertions(+), 9 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 6adf4e7cc00b..e864706de977 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -137,6 +137,7 @@ struct tcmu_dev {
 
 	struct mutex cmdr_lock;
 	struct list_head qfull_queue;
+	struct list_head tmr_queue;
 
 	uint32_t dbi_max;
 	uint32_t dbi_thresh;
@@ -183,6 +184,15 @@ struct tcmu_cmd {
 #define TCMU_CMD_BIT_EXPIRED 0
 	unsigned long flags;
 };
+
+struct tcmu_tmr {
+	struct list_head queue_entry;
+
+	uint8_t tmr_type;
+	uint32_t tmr_cmd_cnt;
+	int16_t tmr_cmd_ids[0];
+};
+
 /*
  * To avoid dead lock the mutex lock order should always be:
  *
@@ -844,6 +854,9 @@ static bool is_ring_space_avail(struct tcmu_dev *udev, struct tcmu_cmd *cmd,
 		return false;
 	}
 
+	if (!data_needed)
+		return true;
+
 	/* try to check and get the data blocks as needed */
 	space = spc_bitmap_free(udev->data_bitmap, udev->dbi_thresh);
 	if ((space * DATA_BLOCK_SIZE) < data_needed) {
@@ -1106,6 +1119,61 @@ static int queue_cmd_ring(struct tcmu_cmd *tcmu_cmd, sense_reason_t *scsi_err)
 	return 1;
 }
 
+/*
+ * queue_tmr_ring - queue tmr info to ring or internally
+ *
+ * @dev: related tcmu_dev
+ * @tmr: tcmu_tmr containing tmr info to queue
+ *
+ * Returns:
+ *  0 success
+ *  1 internally queued to wait for ring memory to free.
+ */
+static int
+queue_tmr_ring(struct tcmu_dev *dev, struct tcmu_tmr *tmr)
+{
+	struct tcmu_tmr_entry *entry;
+	int cmd_size;
+	int id_list_sz;
+	struct tcmu_mailbox *mb = dev->mb_addr;
+	uint32_t cmd_head;
+
+	if (test_bit(TCMU_DEV_BIT_BROKEN, &dev->flags))
+		goto out_free;
+
+	id_list_sz = sizeof(tmr->tmr_cmd_ids[0]) * tmr->tmr_cmd_cnt;
+	cmd_size = round_up(sizeof(*entry) + id_list_sz, TCMU_OP_ALIGN_SIZE);
+
+	if (!list_empty(&dev->tmr_queue) ||
+	    !is_ring_space_avail(dev, NULL, cmd_size, 0)) {
+		list_add_tail(&tmr->queue_entry, &dev->tmr_queue);
+		pr_debug("adding tmr %p on dev %s to TMR ring space wait queue\n",
+			 tmr, dev->name);
+		return 1;
+	}
+
+	cmd_head = ring_insert_padding(dev, cmd_size);
+
+	entry = (void *)mb + CMDR_OFF + cmd_head;
+	memset(entry, 0, cmd_size);
+	tcmu_hdr_set_op(&entry->hdr.len_op, TCMU_OP_TMR);
+	tcmu_hdr_set_len(&entry->hdr.len_op, cmd_size);
+	entry->tmr_type = tmr->tmr_type;
+	entry->cmd_cnt = tmr->tmr_cmd_cnt;
+	memcpy(&entry->cmd_ids[0], &tmr->tmr_cmd_ids[0], id_list_sz);
+	tcmu_flush_dcache_range(entry, cmd_size);
+
+	UPDATE_HEAD(mb->cmd_head, cmd_size, dev->cmdr_size);
+	tcmu_flush_dcache_range(mb, sizeof(*mb));
+
+	uio_event_notify(&dev->uio_info);
+
+out_free:
+	kfree(tmr);
+
+	return 0;
+}
+
 static sense_reason_t
 tcmu_queue_cmd(struct se_cmd *se_cmd)
 {
@@ -1141,6 +1209,85 @@ static void tcmu_set_next_deadline(struct list_head *queue,
 		del_timer(timer);
 }
 
+static int
+tcmu_tmr_type(enum tcm_tmreq_table tmf)
+{
+	switch (tmf) {
+	case TMR_ABORT_TASK:		return TCMU_TMR_ABORT_TASK;
+	case TMR_ABORT_TASK_SET:	return TCMU_TMR_ABORT_TASK_SET;
+	case TMR_CLEAR_ACA:		return TCMU_TMR_CLEAR_ACA;
+	case TMR_CLEAR_TASK_SET:	return TCMU_TMR_CLEAR_TASK_SET;
+	case TMR_LUN_RESET:		return TCMU_TMR_LUN_RESET;
+	case TMR_TARGET_WARM_RESET:	return TCMU_TMR_TARGET_WARM_RESET;
+	case TMR_TARGET_COLD_RESET:	return TCMU_TMR_TARGET_COLD_RESET;
+	case TMR_LUN_RESET_PRO:		return TCMU_TMR_LUN_RESET_PRO;
+	default:			return TCMU_TMR_UNKNOWN;
+	}
+}
+
+static void
+tcmu_tmr_notify(struct se_device *se_dev, enum tcm_tmreq_table tmf,
+		struct list_head *cmd_list)
+{
+	int i = 0, cmd_cnt = 0;
+	bool unqueued = false;
+	uint16_t *cmd_ids = NULL;
+	struct tcmu_cmd *cmd;
+	struct se_cmd *se_cmd;
+	struct tcmu_tmr *tmr;
+	struct tcmu_dev *dev = TCMU_DEV(se_dev);
+
+	mutex_lock(&dev->cmdr_lock);
+
+	// First we check for aborted commands in qfull_queue
+	list_for_each_entry(se_cmd, cmd_list, state_list) {
+		i++;
+		if (!se_cmd->priv)
+			continue;
+		cmd = se_cmd->priv;
+		// Commands on qfull queue have no id yet
+		if (cmd->cmd_id) {
+			cmd_cnt++;
+			continue;
+		}
+		pr_debug("Removing aborted command %p from queue on dev %s.\n",
+			 cmd, dev->name);
+
+		list_del_init(&cmd->queue_entry);
+		tcmu_free_cmd(cmd);
+		target_complete_cmd(se_cmd, SAM_STAT_TASK_ABORTED);
+		unqueued = true;
+	}
+	if (unqueued)
+		tcmu_set_next_deadline(&dev->qfull_queue, &dev->qfull_timer);
+
+	pr_debug("TMR event %d on dev %s, aborted cmds %d, afflicted cmd_ids %d\n",
+		 tcmu_tmr_type(tmf), dev->name, i, cmd_cnt);
+
+	tmr = kmalloc(sizeof(*tmr) + cmd_cnt * sizeof(*cmd_ids), GFP_KERNEL);
+	if (!tmr)
+		goto unlock;
+
+	tmr->tmr_type = tcmu_tmr_type(tmf);
+	tmr->tmr_cmd_cnt = cmd_cnt;
+
+	if (cmd_cnt != 0) {
+		cmd_cnt = 0;
+		list_for_each_entry(se_cmd, cmd_list, state_list) {
+			if (!se_cmd->priv)
+				continue;
+			cmd = se_cmd->priv;
+			if (cmd->cmd_id)
+				tmr->tmr_cmd_ids[cmd_cnt++] = cmd->cmd_id;
+		}
+	}
+
+	queue_tmr_ring(dev, tmr);
+
+unlock:
+	mutex_unlock(&dev->cmdr_lock);
+}
+
 static void tcmu_handle_completion(struct tcmu_cmd *cmd, struct tcmu_cmd_entry *entry)
 {
 	struct se_cmd *se_cmd = cmd->se_cmd;
@@ -1208,11 +1355,43 @@ static void tcmu_handle_completion(struct tcmu_cmd *cmd, struct tcmu_cmd_entry *
 	tcmu_free_cmd(cmd);
 }
 
+static int tcmu_run_tmr_queue(struct tcmu_dev *dev)
+{
+	struct tcmu_tmr *tmr, *tmp;
+	LIST_HEAD(tmrs);
+
+	if (list_empty(&dev->tmr_queue))
+		return 1;
+
+	pr_debug("running %s's tmr queue\n", dev->name);
+
+	list_splice_init(&dev->tmr_queue, &tmrs);
+
+	list_for_each_entry_safe(tmr, tmp, &tmrs, queue_entry) {
+		list_del_init(&tmr->queue_entry);
+
+		pr_debug("removing tmr %p on dev %s from queue\n",
+			 tmr, dev->name);
+
+		if (queue_tmr_ring(dev, tmr)) {
+			pr_debug("ran out of space during tmr queue run\n");
+			/*
+			 * tmr was requeued, so just put all tmrs back in
+			 * the queue
+			 */
+			list_splice_tail(&tmrs, &dev->tmr_queue);
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
 static unsigned int tcmu_handle_completions(struct tcmu_dev *udev)
 {
 	struct tcmu_mailbox *mb;
 	struct tcmu_cmd *cmd;
-	int handled = 0;
+	bool free_space = false;
 
 	if (test_bit(TCMU_DEV_BIT_BROKEN, &udev->flags)) {
 		pr_err("ring broken, not handling completions\n");
@@ -1235,7 +1414,10 @@ static unsigned int tcmu_handle_completions(struct tcmu_dev *udev)
 		tcmu_flush_dcache_range(entry, ring_left < sizeof(*entry) ?
 					ring_left : sizeof(*entry));
 
-		if (tcmu_hdr_get_op(entry->hdr.len_op) == TCMU_OP_PAD) {
+		free_space = true;
+
+		if (tcmu_hdr_get_op(entry->hdr.len_op) == TCMU_OP_PAD ||
+		    tcmu_hdr_get_op(entry->hdr.len_op) == TCMU_OP_TMR) {
 			UPDATE_HEAD(udev->cmdr_last_cleaned,
 				    tcmu_hdr_get_len(entry->hdr.len_op),
 				    udev->cmdr_size);
@@ -1256,9 +1438,9 @@ static unsigned int tcmu_handle_completions(struct tcmu_dev *udev)
 		UPDATE_HEAD(udev->cmdr_last_cleaned,
 			    tcmu_hdr_get_len(entry->hdr.len_op),
 			    udev->cmdr_size);
-
-		handled++;
 	}
+	if (free_space)
+		free_space = tcmu_run_tmr_queue(udev);
 
 	if (atomic_read(&global_db_count) > tcmu_global_max_blocks &&
 	    idr_is_empty(&udev->commands) && list_empty(&udev->qfull_queue)) {
@@ -1271,7 +1453,7 @@ static unsigned int tcmu_handle_completions(struct tcmu_dev *udev)
 	if (udev->cmd_time_out)
 		tcmu_set_next_deadline(&udev->inflight_queue, &udev->cmd_timer);
 
-	return handled;
+	return free_space;
 }
 
 static void tcmu_check_expired_ring_cmd(struct tcmu_cmd *cmd)
@@ -1381,6 +1563,7 @@ static struct se_device *tcmu_alloc_device(struct se_hba *hba, const char *name)
 	INIT_LIST_HEAD(&udev->node);
 	INIT_LIST_HEAD(&udev->timedout_entry);
 	INIT_LIST_HEAD(&udev->qfull_queue);
+	INIT_LIST_HEAD(&udev->tmr_queue);
 	INIT_LIST_HEAD(&udev->inflight_queue);
 	idr_init(&udev->commands);
 
@@ -1455,8 +1638,8 @@ static int tcmu_irqcontrol(struct uio_info *info, s32 irq_on)
 	struct tcmu_dev *udev = container_of(info, struct tcmu_dev, uio_info);
 
 	mutex_lock(&udev->cmdr_lock);
-	tcmu_handle_completions(udev);
-	run_qfull_queue(udev, false);
+	if (tcmu_handle_completions(udev))
+		run_qfull_queue(udev, false);
 	mutex_unlock(&udev->cmdr_lock);
 
 	return 0;
@@ -1609,6 +1792,16 @@ static void tcmu_blocks_release(struct radix_tree_root *blocks,
 	}
 }
 
+static void tcmu_remove_all_queued_tmr(struct tcmu_dev *dev)
+{
+	struct tcmu_tmr *tmr, *tmp;
+
+	list_for_each_entry_safe(tmr, tmp, &dev->tmr_queue, queue_entry) {
+		list_del_init(&tmr->queue_entry);
+		kfree(tmr);
+	}
+}
+
 static void tcmu_dev_kref_release(struct kref *kref)
 {
 	struct tcmu_dev *udev = container_of(kref, struct tcmu_dev, kref);
@@ -1631,6 +1824,8 @@ static void tcmu_dev_kref_release(struct kref *kref)
 		if (tcmu_check_and_free_pending_cmd(cmd) != 0)
 			all_expired = false;
 	}
+	// There can be left over TMR cmds. Remove them.
+	tcmu_remove_all_queued_tmr(udev);
 	if (!list_empty(&udev->qfull_queue))
 		all_expired = false;
 	idr_destroy(&udev->commands);
@@ -1885,7 +2080,9 @@ static int tcmu_configure_device(struct se_device *dev)
 	/* Initialise the mailbox of the ring buffer */
 	mb = udev->mb_addr;
 	mb->version = TCMU_MAILBOX_VERSION;
-	mb->flags = TCMU_MAILBOX_FLAG_CAP_OOOC | TCMU_MAILBOX_FLAG_CAP_READ_LEN;
+	mb->flags = TCMU_MAILBOX_FLAG_CAP_OOOC |
+		    TCMU_MAILBOX_FLAG_CAP_READ_LEN |
+		    TCMU_MAILBOX_FLAG_CAP_TMR;
 	mb->cmdr_off = CMDR_OFF;
 	mb->cmdr_size = udev->cmdr_size;
 
@@ -2055,6 +2252,15 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
 
 	del_timer(&udev->cmd_timer);
 
+	/*
+	 * ring is empty and qfull queue never contains aborted commands.
+	 * So TMRs in tmr queue do not contain relevant cmd_ids.
+	 * After a ring reset userspace should do a fresh start, so
+	 * even LUN RESET message is no longer relevant.
+	 * Therefore remove all TMRs from qfull queue
+	 */
+	tcmu_remove_all_queued_tmr(udev);
+
 	run_qfull_queue(udev, false);
 
 	mutex_unlock(&udev->cmdr_lock);
@@ -2607,6 +2813,7 @@ static struct target_backend_ops tcmu_ops = {
 	.destroy_device		= tcmu_destroy_device,
 	.free_device		= tcmu_free_device,
 	.parse_cdb		= tcmu_parse_cdb,
+	.tmr_notify		= tcmu_tmr_notify,
 	.set_configfs_dev_params = tcmu_set_configfs_dev_params,
 	.show_configfs_dev_params = tcmu_show_configfs_dev_params,
 	.get_device_type	= sbc_get_device_type,
@@ -2633,7 +2840,8 @@ static void find_free_blocks(void)
 		}
 
 		/* Try to complete the finished commands first */
-		tcmu_handle_completions(udev);
+		if (tcmu_handle_completions(udev))
+			run_qfull_queue(udev, false);
 
 		/* Skip the udevs in idle */
 		if (!udev->dbi_thresh) {
diff --git a/include/uapi/linux/target_core_user.h b/include/uapi/linux/target_core_user.h
index b7b57967d90f..95b1597f16ae 100644
--- a/include/uapi/linux/target_core_user.h
+++ b/include/uapi/linux/target_core_user.h
@@ -45,6 +45,7 @@
 #define ALIGN_SIZE 64 /* Should be enough for most CPUs */
 #define TCMU_MAILBOX_FLAG_CAP_OOOC (1 << 0) /* Out-of-order completions */
 #define TCMU_MAILBOX_FLAG_CAP_READ_LEN (1 << 1) /* Read data length */
+#define TCMU_MAILBOX_FLAG_CAP_TMR (1 << 2) /* TMR notifications */
 
 struct tcmu_mailbox {
 	__u16 version;
@@ -62,6 +63,7 @@ struct tcmu_mailbox {
 enum tcmu_opcode {
 	TCMU_OP_PAD = 0,
 	TCMU_OP_CMD,
+	TCMU_OP_TMR,
 };
 
 /*
@@ -128,6 +130,29 @@ struct tcmu_cmd_entry {
 
 } __packed;
 
+struct tcmu_tmr_entry {
+	struct tcmu_cmd_entry_hdr hdr;
+
+#define TCMU_TMR_UNKNOWN		0
+#define TCMU_TMR_ABORT_TASK		1
+#define TCMU_TMR_ABORT_TASK_SET		2
+#define TCMU_TMR_CLEAR_ACA		3
+#define TCMU_TMR_CLEAR_TASK_SET		4
+#define TCMU_TMR_LUN_RESET		5
+#define TCMU_TMR_TARGET_WARM_RESET	6
+#define TCMU_TMR_TARGET_COLD_RESET	7
+/* Pseudo reset due to received PR OUT */
+#define TCMU_TMR_LUN_RESET_PRO		128
+	__u8 tmr_type;
+
+	__u8 __pad1;
+	__u16 __pad2;
+	__u32 cmd_cnt;
+	__u64 __pad3;
+	__u64 __pad4;
+	__u16 cmd_ids[0];
+} __packed;
+
 #define TCMU_OP_ALIGN_SIZE sizeof(__u64)
 
 enum tcmu_genl_cmd {
-- 
2.12.3

