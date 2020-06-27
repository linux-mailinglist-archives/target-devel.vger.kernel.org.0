Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7DF20BE50
	for <lists+target-devel@lfdr.de>; Sat, 27 Jun 2020 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgF0Ef0 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 27 Jun 2020 00:35:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42098 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgF0EfZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:35:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05R4XMoV045503;
        Sat, 27 Jun 2020 04:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=bFauG9J0QSOQTPezXO9LjXZIsjaX/YTF7L9Oyz6xfv0=;
 b=vKdRqWKltFn01qMRp0wYaWQZx4wE5rR1iFOGoVCO4uX2OzYisqspf+m/sMxIzi06OYvZ
 vWAuy9CTAMe06IGDUHiqdV4ZKrwuge/tHbJ5vFpd30UHnl/l0I37HmF/VJYftMH4j5wj
 3ScgKN+WjoSrIw1el6xd3hHAf8FYLVuB/Or+iZf3DKO/E9/dO0xo54eQ4tsGdQZeK+V3
 sPj93i8mZI46dBs18eKN31OiSkn0nyXyeLjjLcUU3g2X9LTrVyuKJWxeCKhprfq6erEC
 ASx5uKwhJIE6wG6HxZ/z6BokeJwiYCdQt1KP737UkaGW7YrF8/cve0M3HL8NYvbGEg++ PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31wx2m82g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 27 Jun 2020 04:35:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05R4XZ2I061234;
        Sat, 27 Jun 2020 04:35:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31wu7rq97j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Jun 2020 04:35:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05R4ZC21004121;
        Sat, 27 Jun 2020 04:35:13 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 27 Jun 2020 04:35:11 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hare@suse.de, bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [RFC PATCH 02/10] iscsi target: replace module sids with lio's sid
Date:   Fri, 26 Jun 2020 23:35:01 -0500
Message-Id: <1593232509-13720-3-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593232509-13720-1-git-send-email-michael.christie@oracle.com>
References: <1593232509-13720-1-git-send-email-michael.christie@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=2 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 impostorscore=0 cotscore=-2147483648 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006270030
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This is the first phase in hooking iscsi into the sysfs API. This patch
has it use lio core's sid instead of its internal ones.

We have 2 sids in the iscsi target layer:
- module sid: int id that is unique across all iscsi targets. Used for
  sess_get_index().
- iscsi target port group sid: int id that is unique in the tpg. Uses
  for logging.

The lio one works exactly like the iscsi target module one, and the
iscsi
tpg one is not very useful because when you have multiple tpgs you can't
tell which tpg the session is under. In the latter case the lio core one
is more useful, because it matches what we see in userspace and logs and
we can distinguish what fabric/target/tpg the session is under.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/target/iscsi/iscsi_target.c          |  6 ++----
 drivers/target/iscsi/iscsi_target_configfs.c |  6 ++----
 drivers/target/iscsi/iscsi_target_erl0.c     | 11 ++++++-----
 drivers/target/iscsi/iscsi_target_erl2.c     |  8 ++++----
 drivers/target/iscsi/iscsi_target_login.c    | 20 ++------------------
 drivers/target/iscsi/iscsi_target_stat.c     |  3 +--
 drivers/target/iscsi/iscsi_target_tmr.c      |  2 +-
 drivers/target/iscsi/iscsi_target_tpg.c      | 16 +++++++---------
 drivers/target/iscsi/iscsi_target_util.c     |  2 +-
 include/target/iscsi/iscsi_target_core.h     |  6 ------
 10 files changed, 26 insertions(+), 54 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index c968961..e3b3de6 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -49,7 +49,6 @@
 static DEFINE_MUTEX(np_lock);
 
 static struct idr tiqn_idr;
-DEFINE_IDA(sess_ida);
 struct mutex auth_id_lock;
 
 struct iscsit_global *iscsit_global;
@@ -2331,7 +2330,7 @@ int iscsit_logout_closesession(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 	struct iscsi_session *sess = conn->sess;
 
 	pr_debug("Received logout request CLOSESESSION on CID: %hu"
-		" for SID: %u.\n", conn->cid, conn->sess->sid);
+		" for SID: %u.\n", conn->cid, conn->sess->se_sess->sid);
 
 	atomic_set(&sess->session_logout, 1);
 	atomic_set(&conn->conn_logout_remove, 1);
@@ -4110,7 +4109,7 @@ int iscsit_close_connection(
 	struct iscsi_session	*sess = conn->sess;
 
 	pr_debug("Closing iSCSI connection CID %hu on SID:"
-		" %u\n", conn->cid, sess->sid);
+		" %u\n", conn->cid, sess->se_sess->sid);
 	/*
 	 * Always up conn_logout_comp for the traditional TCP and HW_OFFLOAD
 	 * case just in case the RX Thread in iscsi_target_rx_opcode() is
@@ -4406,7 +4405,6 @@ int iscsit_close_session(struct iscsi_session *sess)
 	pr_debug("Decremented number of active iSCSI Sessions on"
 		" iSCSI TPG: %hu to %u\n", tpg->tpgt, tpg->nsessions);
 
-	ida_free(&sess_ida, sess->session_index);
 	kfree(sess->sess_ops);
 	sess->sess_ops = NULL;
 	spin_unlock_bh(&se_tpg->session_lock);
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 0fa1d57..d0021bf 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -520,7 +520,7 @@ static ssize_t lio_target_nacl_info_show(struct config_item *item, char *page)
 
 		rb += sprintf(page+rb,
 			      "LIO Session ID: %u   ISID: 0x%6ph  TSIH: %hu  ",
-			      sess->sid, sess->isid, sess->tsih);
+			      se_sess->sid, sess->isid, sess->tsih);
 		rb += sprintf(page+rb, "SessionType: %s\n",
 				(sess->sess_ops->SessionType) ?
 				"Discovery" : "Normal");
@@ -1344,9 +1344,7 @@ static int iscsi_get_cmd_state(struct se_cmd *se_cmd)
 
 static u32 lio_sess_get_index(struct se_session *se_sess)
 {
-	struct iscsi_session *sess = se_sess->fabric_sess_ptr;
-
-	return sess->session_index;
+	return se_sess->sid;
 }
 
 static u32 lio_sess_get_initiator_sid(
diff --git a/drivers/target/iscsi/iscsi_target_erl0.c b/drivers/target/iscsi/iscsi_target_erl0.c
index b4abd7b..e6acd54 100644
--- a/drivers/target/iscsi/iscsi_target_erl0.c
+++ b/drivers/target/iscsi/iscsi_target_erl0.c
@@ -761,7 +761,7 @@ void iscsit_handle_time2retain_timeout(struct timer_list *t)
 	sess->time2retain_timer_flags |= ISCSI_TF_EXPIRED;
 
 	pr_err("Time2Retain timer expired for SID: %u, cleaning up"
-			" iSCSI session.\n", sess->sid);
+			" iSCSI session.\n", sess->se_sess->sid);
 
 	iscsit_fill_cxn_timeout_err_stats(sess);
 	spin_unlock_bh(&se_tpg->session_lock);
@@ -786,7 +786,8 @@ void iscsit_start_time2retain_handler(struct iscsi_session *sess)
 		return;
 
 	pr_debug("Starting Time2Retain timer for %u seconds on"
-		" SID: %u\n", sess->sess_ops->DefaultTime2Retain, sess->sid);
+		" SID: %u\n", sess->sess_ops->DefaultTime2Retain,
+		sess->se_sess->sid);
 
 	sess->time2retain_timer_flags &= ~ISCSI_TF_STOP;
 	sess->time2retain_timer_flags |= ISCSI_TF_RUNNING;
@@ -815,7 +816,7 @@ int iscsit_stop_time2retain_timer(struct iscsi_session *sess)
 	spin_lock(&se_tpg->session_lock);
 	sess->time2retain_timer_flags &= ~ISCSI_TF_RUNNING;
 	pr_debug("Stopped Time2Retain Timer for SID: %u\n",
-			sess->sid);
+		 sess->se_sess->sid);
 	return 0;
 }
 
@@ -882,8 +883,8 @@ void iscsit_cause_connection_reinstatement(struct iscsi_conn *conn, int sleep)
 
 void iscsit_fall_back_to_erl0(struct iscsi_session *sess)
 {
-	pr_debug("Falling back to ErrorRecoveryLevel=0 for SID:"
-			" %u\n", sess->sid);
+	pr_debug("Falling back to ErrorRecoveryLevel=0 for SID: %u\n",
+		 sess->se_sess->sid);
 
 	atomic_set(&sess->session_fall_back_to_erl0, 1);
 }
diff --git a/drivers/target/iscsi/iscsi_target_erl2.c b/drivers/target/iscsi/iscsi_target_erl2.c
index b1b7db9d..bdc9558 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.c
+++ b/drivers/target/iscsi/iscsi_target_erl2.c
@@ -93,7 +93,7 @@ static int iscsit_attach_inactive_connection_recovery_entry(
 
 	sess->conn_recovery_count++;
 	pr_debug("Incremented connection recovery count to %u for"
-		" SID: %u\n", sess->conn_recovery_count, sess->sid);
+		" SID: %u\n", sess->conn_recovery_count, sess->se_sess->sid);
 	spin_unlock(&sess->cr_i_lock);
 
 	return 0;
@@ -176,7 +176,7 @@ int iscsit_remove_active_connection_recovery_entry(
 
 	sess->conn_recovery_count--;
 	pr_debug("Decremented connection recovery count to %u for"
-		" SID: %u\n", sess->conn_recovery_count, sess->sid);
+		" SID: %u\n", sess->conn_recovery_count, sess->se_sess->sid);
 	spin_unlock(&sess->cr_a_lock);
 
 	kfree(cr);
@@ -251,11 +251,11 @@ void iscsit_discard_cr_cmds_by_expstatsn(
 	if (!cr->cmd_count) {
 		pr_debug("No commands to be reassigned for failed"
 			" connection CID: %hu on SID: %u\n",
-			cr->cid, sess->sid);
+			cr->cid, sess->se_sess->sid);
 		iscsit_remove_inactive_connection_recovery_entry(cr, sess);
 		iscsit_attach_active_connection_recovery_entry(sess, cr);
 		pr_debug("iSCSI connection recovery successful for CID:"
-			" %hu on SID: %u\n", cr->cid, sess->sid);
+			" %hu on SID: %u\n", cr->cid, sess->se_sess->sid);
 		iscsit_remove_active_connection_recovery_entry(cr, sess);
 	} else {
 		iscsit_remove_inactive_connection_recovery_entry(cr, sess);
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 85748e3..417b797 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -186,7 +186,7 @@ int iscsi_check_for_session_reinstatement(struct iscsi_conn *conn)
 
 	pr_debug("%s iSCSI Session SID %u is still active for %s,"
 		" performing session reinstatement.\n", (sessiontype) ?
-		"Discovery" : "Normal", sess->sid,
+		"Discovery" : "Normal", sess->se_sess->sid,
 		sess->sess_ops->InitiatorName);
 
 	spin_lock_bh(&sess->conn_lock);
@@ -258,7 +258,6 @@ static int iscsi_login_zero_tsih_s1(
 {
 	struct iscsi_session *sess = NULL;
 	struct iscsi_login_req *pdu = (struct iscsi_login_req *)buf;
-	int ret;
 
 	sess = kzalloc(sizeof(struct iscsi_session), GFP_KERNEL);
 	if (!sess) {
@@ -292,15 +291,6 @@ static int iscsi_login_zero_tsih_s1(
 	timer_setup(&sess->time2retain_timer,
 		    iscsit_handle_time2retain_timeout, 0);
 
-	ret = ida_alloc(&sess_ida, GFP_KERNEL);
-	if (ret < 0) {
-		pr_err("Session ID allocation failed %d\n", ret);
-		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
-				ISCSI_LOGIN_STATUS_NO_RESOURCES);
-		goto free_sess;
-	}
-
-	sess->session_index = ret;
 	sess->creation_time = get_jiffies_64();
 	/*
 	 * The FFP CmdSN window values will be allocated from the TPG's
@@ -314,7 +304,7 @@ static int iscsi_login_zero_tsih_s1(
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
 		pr_err("Unable to allocate memory for"
 				" struct iscsi_sess_ops.\n");
-		goto free_id;
+		goto free_sess;
 	}
 
 	sess->se_sess = transport_alloc_session(TARGET_PROT_NORMAL);
@@ -328,8 +318,6 @@ static int iscsi_login_zero_tsih_s1(
 
 free_ops:
 	kfree(sess->sess_ops);
-free_id:
-	ida_free(&sess_ida, sess->session_index);
 free_sess:
 	kfree(sess);
 	conn->sess = NULL;
@@ -768,9 +756,6 @@ void iscsi_post_login_handler(
 		sess->sess_ops->InitiatorName);
 	spin_unlock_bh(&sess->conn_lock);
 
-	sess->sid = tpg->sid++;
-	if (!sess->sid)
-		sess->sid = tpg->sid++;
 	pr_debug("Established iSCSI session from node: %s\n",
 			sess->sess_ops->InitiatorName);
 
@@ -1161,7 +1146,6 @@ void iscsi_target_login_sess_out(struct iscsi_conn *conn,
 		goto old_sess_out;
 
 	transport_free_session(conn->sess->se_sess);
-	ida_free(&sess_ida, conn->sess->session_index);
 	kfree(conn->sess->sess_ops);
 	kfree(conn->sess);
 	conn->sess = NULL;
diff --git a/drivers/target/iscsi/iscsi_target_stat.c b/drivers/target/iscsi/iscsi_target_stat.c
index 35e75a3..8167fdc 100644
--- a/drivers/target/iscsi/iscsi_target_stat.c
+++ b/drivers/target/iscsi/iscsi_target_stat.c
@@ -630,8 +630,7 @@ static ssize_t iscsi_stat_sess_indx_show(struct config_item *item, char *page)
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%u\n",
-					sess->session_index);
+			ret = snprintf(page, PAGE_SIZE, "%u\n", se_sess->sid);
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
 
diff --git a/drivers/target/iscsi/iscsi_target_tmr.c b/drivers/target/iscsi/iscsi_target_tmr.c
index 7d618db..dbc95eb 100644
--- a/drivers/target/iscsi/iscsi_target_tmr.c
+++ b/drivers/target/iscsi/iscsi_target_tmr.c
@@ -186,7 +186,7 @@ static void iscsit_task_reassign_remove_cmd(
 	spin_unlock(&cr->conn_recovery_cmd_lock);
 	if (!ret) {
 		pr_debug("iSCSI connection recovery successful for CID:"
-			" %hu on SID: %u\n", cr->cid, sess->sid);
+			" %hu on SID: %u\n", cr->cid, sess->se_sess->sid);
 		iscsit_remove_active_connection_recovery_entry(cr, sess);
 	}
 }
diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index 8075f60..e252a7f 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -64,16 +64,13 @@ int iscsit_load_discovery_tpg(void)
 	 */
 	tpg->tpg_se_tpg.se_tpg_tfo = &iscsi_ops;
 	ret = core_tpg_register(NULL, &tpg->tpg_se_tpg, -1);
-	if (ret < 0) {
-		kfree(tpg);
-		return -1;
-	}
+	if (ret < 0)
+		goto free_tpg;
 
-	tpg->sid = 1; /* First Assigned LIO Session ID */
 	iscsit_set_default_tpg_attribs(tpg);
 
 	if (iscsi_create_default_params(&tpg->param_list) < 0)
-		goto out;
+		goto dereg_se_tpg;
 	/*
 	 * By default we disable authentication for discovery sessions,
 	 * this can be changed with:
@@ -97,11 +94,12 @@ int iscsit_load_discovery_tpg(void)
 	pr_debug("CORE[0] - Allocated Discovery TPG\n");
 
 	return 0;
+
 free_pl_out:
 	iscsi_release_param_list(tpg->param_list);
-out:
-	if (tpg->sid == 1)
-		core_tpg_deregister(&tpg->tpg_se_tpg);
+dereg_se_tpg:
+	core_tpg_deregister(&tpg->tpg_se_tpg);
+free_tpg:
 	kfree(tpg);
 	return -1;
 }
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 45ba07c6..1b6c2db 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1219,7 +1219,7 @@ void iscsit_print_session_params(struct iscsi_session *sess)
 	struct iscsi_conn *conn;
 
 	pr_debug("-----------------------------[Session Params for"
-		" SID: %u]-----------------------------\n", sess->sid);
+		" SID: %u]-----------------------------\n", sess->se_sess->sid);
 	spin_lock_bh(&sess->conn_lock);
 	list_for_each_entry(conn, &sess->sess_conn_list, conn_list)
 		iscsi_dump_conn_ops(conn->conn_ops);
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 4fda324..836eee2 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -644,11 +644,7 @@ struct iscsi_session {
 	atomic_t		max_cmd_sn;
 	struct list_head	sess_ooo_cmdsn_list;
 
-	/* LIO specific session ID */
-	u32			sid;
 	char			auth_type[8];
-	/* unique within the target */
-	int			session_index;
 	/* Used for session reference counting */
 	int			session_usage_count;
 	int			session_waiting_on_uc;
@@ -820,8 +816,6 @@ struct iscsi_portal_group {
 	u32			nsessions;
 	/* Number of Network Portals available for this TPG */
 	u32			num_tpg_nps;
-	/* Per TPG LIO specific session ID. */
-	u32			sid;
 	/* Spinlock for adding/removing Network Portals */
 	spinlock_t		tpg_np_lock;
 	spinlock_t		tpg_state_lock;
-- 
1.8.3.1

