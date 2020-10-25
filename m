Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF292984E5
	for <lists+target-devel@lfdr.de>; Mon, 26 Oct 2020 00:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419424AbgJYXDk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 25 Oct 2020 19:03:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419494AbgJYXDj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 25 Oct 2020 19:03:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09PN0Ukm052104;
        Sun, 25 Oct 2020 23:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Rsrz99BrkzStgeMqc6qRzgBCAPhSxlNb2PINu42snVU=;
 b=mJOHuqVbf/rqRvTTxCtc4C0S+L1ZfLiFr66rTMjWn3QKBHfVRVT28ymGJ2aKDEdCGnJu
 /787kEUw35s8jBSqTk+udkvIyt3Yj+sCkXK4kNbiFU9nYUmEz1vj9EUuzAoB2Xy3/FAt
 Cd4tATTtQkLyv4xFbaQEO0U7f2zs54B2VESTkinLA088eiwo9FhSFxyYHy75yfu6xUKV
 fFzuJ56erRpdOmtsotDMm7qL05//+qu5JAGuyuRCQds3KoFtpo3rGsfopZEy3pZtTRDA
 vFT67H5+vXBGvgfBQ9vPpEMlfM2/ZBR4cgbulkam6UAOXvSfdhiBe4I5Rts0D+jxWitL rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34dgm3r2yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Oct 2020 23:03:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09PN0Ife032797;
        Sun, 25 Oct 2020 23:03:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34cwujrt6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Oct 2020 23:03:27 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09PN3Q9a022881;
        Sun, 25 Oct 2020 23:03:26 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 25 Oct 2020 16:03:26 -0700
From:   Mike Christie <michael.christie@oracle.com>
To:     himanshu.madhani@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH 5/7] target: Drop sess_cmd_lock from IO path
Date:   Sun, 25 Oct 2020 18:03:16 -0500
Message-Id: <1603666998-8086-6-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603666998-8086-1-git-send-email-michael.christie@oracle.com>
References: <1603666998-8086-1-git-send-email-michael.christie@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9785 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010250174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9785 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010250174
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

To remove the sess_cmd_lock this patch does:

- Removes the sess_cmd_list use from lio core, because it's been
moved to qla2xxx.

- Removes sess_tearing_down check in the IO path. Instead of using
that bit and the sess_cmd_lock, we rely on the cmd_count percpu
ref. To do this we switch to
percpu_ref_kill_and_confirm/percpu_ref_tryget_live.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c |  2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c   |  2 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.c      |  9 +---
 drivers/target/target_core_tpg.c        |  2 +-
 drivers/target/target_core_transport.c  | 77 ++++++++++++++-------------------
 drivers/target/tcm_fc/tfc_sess.c        |  2 +-
 include/target/target_core_base.h       |  6 +--
 include/target/target_core_fabric.h     |  2 +-
 8 files changed, 43 insertions(+), 59 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 695f701..62a4be9 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2480,7 +2480,7 @@ static void isert_release_work(struct work_struct *work)
 	isert_info("iscsi_conn %p\n", conn);
 
 	if (conn->sess) {
-		target_sess_cmd_list_set_waiting(conn->sess->se_sess);
+		target_stop_session(conn->sess->se_sess);
 		target_wait_for_sess_cmds(conn->sess->se_sess);
 	}
 }
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 0065eb1..8377113 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2084,7 +2084,7 @@ static void srpt_release_channel_work(struct work_struct *w)
 	se_sess = ch->sess;
 	BUG_ON(!se_sess);
 
-	target_sess_cmd_list_set_waiting(se_sess);
+	target_stop_session(se_sess);
 	target_wait_for_sess_cmds(se_sess);
 
 	target_remove_session(se_sess);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 076e0ab..c971c4f 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -368,15 +368,10 @@ static void tcm_qla2xxx_put_sess(struct fc_port *sess)
 static void tcm_qla2xxx_close_session(struct se_session *se_sess)
 {
 	struct fc_port *sess = se_sess->fabric_sess_ptr;
-	struct scsi_qla_host *vha;
-	unsigned long flags;
 
 	BUG_ON(!sess);
-	vha = sess->vha;
 
-	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
-	target_sess_cmd_list_set_waiting(se_sess);
-	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
+	target_stop_session(se_sess);
 
 	sess->explicit_logout = 1;
 	tcm_qla2xxx_put_sess(sess);
@@ -825,7 +820,7 @@ static void tcm_qla2xxx_clear_nacl_from_fcport_map(struct fc_port *sess)
 
 static void tcm_qla2xxx_shutdown_sess(struct fc_port *sess)
 {
-	target_sess_cmd_list_set_waiting(sess->se_sess);
+	target_stop_session(sess->se_sess);
 }
 
 static int tcm_qla2xxx_init_nodeacl(struct se_node_acl *se_nacl,
diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index 62aa5fa..736847c 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -328,7 +328,7 @@ static void target_shutdown_sessions(struct se_node_acl *acl)
 restart:
 	spin_lock_irqsave(&acl->nacl_sess_lock, flags);
 	list_for_each_entry(sess, &acl->acl_sess_list, sess_acl_list) {
-		if (sess->sess_tearing_down)
+		if (atomic_read(&sess->stopped))
 			continue;
 
 		list_del_init(&sess->sess_acl_list);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 465b6583..b228c66 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -215,7 +215,7 @@ static void target_release_sess_cmd_refcnt(struct percpu_ref *ref)
 {
 	struct se_session *sess = container_of(ref, typeof(*sess), cmd_count);
 
-	wake_up(&sess->cmd_list_wq);
+	wake_up(&sess->cmd_count_wq);
 }
 
 /**
@@ -228,9 +228,10 @@ int transport_init_session(struct se_session *se_sess)
 {
 	INIT_LIST_HEAD(&se_sess->sess_list);
 	INIT_LIST_HEAD(&se_sess->sess_acl_list);
-	INIT_LIST_HEAD(&se_sess->sess_cmd_list);
 	spin_lock_init(&se_sess->sess_cmd_lock);
-	init_waitqueue_head(&se_sess->cmd_list_wq);
+	init_waitqueue_head(&se_sess->cmd_count_wq);
+	init_completion(&se_sess->stop_done);
+	atomic_set(&se_sess->stopped, 0);
 	return percpu_ref_init(&se_sess->cmd_count,
 			       target_release_sess_cmd_refcnt, 0, GFP_KERNEL);
 }
@@ -239,11 +240,11 @@ int transport_init_session(struct se_session *se_sess)
 void transport_uninit_session(struct se_session *se_sess)
 {
 	/*
-	 * Drivers like iscsi and loop do not call
-	 * target_sess_cmd_list_set_waiting during session shutdown so we
-	 * have to drop the ref taken at init time here.
+	 * Drivers like iscsi and loop do not call target_stop_session
+	 * during session shutdown so we have to drop the ref taken at init
+	 * time here.
 	 */
-	if (!se_sess->sess_tearing_down)
+	if (!atomic_read(&se_sess->stopped))
 		percpu_ref_put(&se_sess->cmd_count);
 
 	percpu_ref_exit(&se_sess->cmd_count);
@@ -1632,9 +1633,8 @@ int target_submit_cmd_map_sgls(struct se_cmd *se_cmd, struct se_session *se_sess
 	if (flags & TARGET_SCF_UNKNOWN_SIZE)
 		se_cmd->unknown_data_length = 1;
 	/*
-	 * Obtain struct se_cmd->cmd_kref reference and add new cmd to
-	 * se_sess->sess_cmd_list.  A second kref_get here is necessary
-	 * for fabrics using TARGET_SCF_ACK_KREF that expect a second
+	 * Obtain struct se_cmd->cmd_kref reference. A second kref_get here is
+	 * necessary for fabrics using TARGET_SCF_ACK_KREF that expect a second
 	 * kref_put() to happen during fabric packet acknowledgement.
 	 */
 	ret = target_get_sess_cmd(se_cmd, flags & TARGET_SCF_ACK_KREF);
@@ -2763,14 +2763,13 @@ int transport_generic_free_cmd(struct se_cmd *cmd, int wait_for_tasks)
 EXPORT_SYMBOL(transport_generic_free_cmd);
 
 /**
- * target_get_sess_cmd - Add command to active ->sess_cmd_list
+ * target_get_sess_cmd - Verify the session is accepting cmds and take ref
  * @se_cmd:	command descriptor to add
  * @ack_kref:	Signal that fabric will perform an ack target_put_sess_cmd()
  */
 int target_get_sess_cmd(struct se_cmd *se_cmd, bool ack_kref)
 {
 	struct se_session *se_sess = se_cmd->se_sess;
-	unsigned long flags;
 	int ret = 0;
 
 	/*
@@ -2785,15 +2784,8 @@ int target_get_sess_cmd(struct se_cmd *se_cmd, bool ack_kref)
 		se_cmd->se_cmd_flags |= SCF_ACK_KREF;
 	}
 
-	spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
-	if (se_sess->sess_tearing_down) {
+	if (!percpu_ref_tryget_live(&se_sess->cmd_count))
 		ret = -ESHUTDOWN;
-		goto out;
-	}
-	list_add_tail(&se_cmd->se_cmd_list, &se_sess->sess_cmd_list);
-	percpu_ref_get(&se_sess->cmd_count);
-out:
-	spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
 
 	if (ret && ack_kref)
 		target_put_sess_cmd(se_cmd);
@@ -2818,13 +2810,6 @@ static void target_release_cmd_kref(struct kref *kref)
 	struct se_session *se_sess = se_cmd->se_sess;
 	struct completion *free_compl = se_cmd->free_compl;
 	struct completion *abrt_compl = se_cmd->abrt_compl;
-	unsigned long flags;
-
-	if (se_sess) {
-		spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
-		list_del_init(&se_cmd->se_cmd_list);
-		spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
-	}
 
 	target_free_cmd_mem(se_cmd);
 	se_cmd->se_tfo->release_cmd(se_cmd);
@@ -2952,21 +2937,25 @@ void target_show_cmd(const char *pfx, struct se_cmd *cmd)
 }
 EXPORT_SYMBOL(target_show_cmd);
 
+static void target_stop_session_confirm(struct percpu_ref *ref)
+{
+	struct se_session *se_sess = container_of(ref, struct se_session,
+						  cmd_count);
+	complete_all(&se_sess->stop_done);
+}
+
 /**
- * target_sess_cmd_list_set_waiting - Set sess_tearing_down so no new commands are queued.
- * @se_sess:	session to flag
+ * target_stop_session - Stop new IO from being queued on the session.
+ * @se_sess:    session to stop
  */
-void target_sess_cmd_list_set_waiting(struct se_session *se_sess)
+void target_stop_session(struct se_session *se_sess)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
-	se_sess->sess_tearing_down = 1;
-	spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
-
-	percpu_ref_kill(&se_sess->cmd_count);
+	pr_debug("Stopping session queue.\n");
+	if (atomic_cmpxchg(&se_sess->stopped, 0, 1) == 0)
+		percpu_ref_kill_and_confirm(&se_sess->cmd_count,
+					    target_stop_session_confirm);
 }
-EXPORT_SYMBOL(target_sess_cmd_list_set_waiting);
+EXPORT_SYMBOL(target_stop_session);
 
 /**
  * target_wait_for_sess_cmds - Wait for outstanding commands
@@ -2974,19 +2963,19 @@ void target_sess_cmd_list_set_waiting(struct se_session *se_sess)
  */
 void target_wait_for_sess_cmds(struct se_session *se_sess)
 {
-	struct se_cmd *cmd;
 	int ret;
 
-	WARN_ON_ONCE(!se_sess->sess_tearing_down);
+	WARN_ON_ONCE(!atomic_read(&se_sess->stopped));
 
 	do {
-		ret = wait_event_timeout(se_sess->cmd_list_wq,
+		pr_debug("Waiting for running cmds to complete.\n");
+		ret = wait_event_timeout(se_sess->cmd_count_wq,
 				percpu_ref_is_zero(&se_sess->cmd_count),
 				180 * HZ);
-		list_for_each_entry(cmd, &se_sess->sess_cmd_list, se_cmd_list)
-			target_show_cmd("session shutdown: still waiting for ",
-					cmd);
 	} while (ret <= 0);
+
+	wait_for_completion(&se_sess->stop_done);
+	pr_debug("Waiting for cmds done.\n");
 }
 EXPORT_SYMBOL(target_wait_for_sess_cmds);
 
diff --git a/drivers/target/tcm_fc/tfc_sess.c b/drivers/target/tcm_fc/tfc_sess.c
index 4fd6a1d..23ce506 100644
--- a/drivers/target/tcm_fc/tfc_sess.c
+++ b/drivers/target/tcm_fc/tfc_sess.c
@@ -275,7 +275,7 @@ static struct ft_sess *ft_sess_delete(struct ft_tport *tport, u32 port_id)
 
 static void ft_close_sess(struct ft_sess *sess)
 {
-	target_sess_cmd_list_set_waiting(sess->se_sess);
+	target_stop_session(sess->se_sess);
 	target_wait_for_sess_cmds(sess->se_sess);
 	ft_sess_put(sess);
 }
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index b3c9946..2824463 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -608,7 +608,7 @@ static inline struct se_node_acl *fabric_stat_to_nacl(struct config_item *item)
 }
 
 struct se_session {
-	unsigned		sess_tearing_down:1;
+	atomic_t		stopped;
 	u64			sess_bin_isid;
 	enum target_prot_op	sup_prot_ops;
 	enum target_prot_type	sess_prot_type;
@@ -618,9 +618,9 @@ struct se_session {
 	struct percpu_ref	cmd_count;
 	struct list_head	sess_list;
 	struct list_head	sess_acl_list;
-	struct list_head	sess_cmd_list;
 	spinlock_t		sess_cmd_lock;
-	wait_queue_head_t	cmd_list_wq;
+	wait_queue_head_t	cmd_count_wq;
+	struct completion	stop_done;
 	void			*sess_cmd_map;
 	struct sbitmap_queue	sess_tag_pool;
 };
diff --git a/include/target/target_core_fabric.h b/include/target/target_core_fabric.h
index 6adf4d7..d60a3eb 100644
--- a/include/target/target_core_fabric.h
+++ b/include/target/target_core_fabric.h
@@ -178,7 +178,7 @@ int	transport_send_check_condition_and_sense(struct se_cmd *,
 int	target_send_busy(struct se_cmd *cmd);
 int	target_get_sess_cmd(struct se_cmd *, bool);
 int	target_put_sess_cmd(struct se_cmd *);
-void	target_sess_cmd_list_set_waiting(struct se_session *);
+void	target_stop_session(struct se_session *se_sess);
 void	target_wait_for_sess_cmds(struct se_session *);
 void	target_show_cmd(const char *pfx, struct se_cmd *cmd);
 
-- 
1.8.3.1

