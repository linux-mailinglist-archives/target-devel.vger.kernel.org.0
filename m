Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6172A20E6
	for <lists+target-devel@lfdr.de>; Sun,  1 Nov 2020 19:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgKAS7y (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 1 Nov 2020 13:59:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46402 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgKAS7x (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:59:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A1IxJg3170380;
        Sun, 1 Nov 2020 18:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=lz40e/gR/+wkauvEQVjvBQ2U7xucmXuxFsZk0Y3/l+A=;
 b=D2ErFGz3QIz27MRt2jZ9ihBCt0s9NC2SVvMtp4Vk8lRHJvH9LqKN6jZbPPmCgraPOY4D
 Imz1khOpQmG6Q7sL+V3AvcBytgxSMWprcUoZgrAFZtJvQlSrjMnmGSvKWr9Mxhq3twLt
 GZ/U0DpEKlqykiOjoAoJ0aYnwDa0cdTYA0WkzYbYcQ/Mp2ZDIqJEPLguAxeoUmeyaxKv
 hJ0MEIGBQCNjv1hcgaDsnKpyweHHXvZjxRmaxMGEWfDFu9IaNHp2ho8dCnpxaziEGF1q
 u610bRR4VWD0OeSSUouAUXKDAs1mmVgtdlvjjLgds7yhzWLCVDCffkCRr8Pi9p+l1OWE jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34hhvc1arj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 01 Nov 2020 18:59:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A1IsZu7091173;
        Sun, 1 Nov 2020 18:59:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34hw0aprf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Nov 2020 18:59:49 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A1IxkqD006674;
        Sun, 1 Nov 2020 18:59:48 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Nov 2020 10:59:45 -0800
From:   Mike Christie <michael.christie@oracle.com>
To:     himanshu.madhani@oracle.com, njavali@marvell.com,
        james.bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH 5/8] qla2xxx: move sess cmd list/lock to driver
Date:   Sun,  1 Nov 2020 12:59:31 -0600
Message-Id: <1604257174-4524-6-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604257174-4524-1-git-send-email-michael.christie@oracle.com>
References: <1604257174-4524-1-git-send-email-michael.christie@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011010154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011010154
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Except for debug output in the shutdown path, tcm qla2xxx is the only
driver using the se_session sess_cmd_list. This moves the list to that
driver so in the next patches we can remove the sess_cmd_lock from the
main IO path for the rest of the drivers.

Cc: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

---
 drivers/scsi/qla2xxx/qla_def.h     |  2 ++
 drivers/scsi/qla2xxx/qla_init.c    |  3 ++
 drivers/scsi/qla2xxx/qla_target.c  |  1 +
 drivers/scsi/qla2xxx/qla_target.h  |  1 +
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 57 +++++++++++++++++++++++---------------
 5 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 4f0486f..ed9b10f 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2493,6 +2493,8 @@ enum rscn_addr_format {
 	int generation;
 
 	struct se_session *se_sess;
+	struct list_head sess_cmd_list;
+	spinlock_t sess_cmd_lock;
 	struct kref sess_kref;
 	struct qla_tgt *tgt;
 	unsigned long expires;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 898c70b..5626e9b 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4974,6 +4974,9 @@ void qla2x00_set_fcport_state(fc_port_t *fcport, int state)
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
 
+	INIT_LIST_HEAD(&fcport->sess_cmd_list);
+	spin_lock_init(&fcport->sess_cmd_lock);
+
 	return fcport;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index f88548b..6603cad 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4292,6 +4292,7 @@ static struct qla_tgt_cmd *qlt_get_tag(scsi_qla_host_t *vha,
 
 	cmd->cmd_type = TYPE_TGT_CMD;
 	memcpy(&cmd->atio, atio, sizeof(*atio));
+	INIT_LIST_HEAD(&cmd->sess_cmd_list);
 	cmd->state = QLA_TGT_STATE_NEW;
 	cmd->tgt = vha->vha_tgt.qla_tgt;
 	qlt_incr_num_pend_cmds(vha);
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 1cff7c6..10e5e6c8 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -856,6 +856,7 @@ struct qla_tgt_cmd {
 	uint8_t cmd_type;
 	uint8_t pad[7];
 	struct se_cmd se_cmd;
+	struct list_head sess_cmd_list;
 	struct fc_port *sess;
 	struct qla_qpair *qpair;
 	uint32_t reset_count;
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index f5a91bf..e122da9 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -255,6 +255,7 @@ static void tcm_qla2xxx_free_mcmd(struct qla_tgt_mgmt_cmd *mcmd)
 static void tcm_qla2xxx_complete_free(struct work_struct *work)
 {
 	struct qla_tgt_cmd *cmd = container_of(work, struct qla_tgt_cmd, work);
+	unsigned long flags;
 
 	cmd->cmd_in_wq = 0;
 
@@ -265,6 +266,10 @@ static void tcm_qla2xxx_complete_free(struct work_struct *work)
 	cmd->trc_flags |= TRC_CMD_FREE;
 	cmd->cmd_sent_to_fw = 0;
 
+	spin_lock_irqsave(&cmd->sess->sess_cmd_lock, flags);
+	list_del_init(&cmd->sess_cmd_list);
+	spin_unlock_irqrestore(&cmd->sess->sess_cmd_lock, flags);
+
 	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
@@ -451,13 +456,14 @@ static int tcm_qla2xxx_handle_cmd(scsi_qla_host_t *vha, struct qla_tgt_cmd *cmd,
 	struct se_portal_group *se_tpg;
 	struct tcm_qla2xxx_tpg *tpg;
 #endif
-	int flags = TARGET_SCF_ACK_KREF;
+	int target_flags = TARGET_SCF_ACK_KREF;
+	unsigned long flags;
 
 	if (bidi)
-		flags |= TARGET_SCF_BIDI_OP;
+		target_flags |= TARGET_SCF_BIDI_OP;
 
 	if (se_cmd->cpuid != WORK_CPU_UNBOUND)
-		flags |= TARGET_SCF_USE_CPUID;
+		target_flags |= TARGET_SCF_USE_CPUID;
 
 	sess = cmd->sess;
 	if (!sess) {
@@ -479,11 +485,15 @@ static int tcm_qla2xxx_handle_cmd(scsi_qla_host_t *vha, struct qla_tgt_cmd *cmd,
 		return 0;
 	}
 #endif
-
 	cmd->qpair->tgt_counters.qla_core_sbt_cmd++;
+
+	spin_lock_irqsave(&sess->sess_cmd_lock, flags);
+	list_add_tail(&cmd->sess_cmd_list, &sess->sess_cmd_list);
+	spin_unlock_irqrestore(&sess->sess_cmd_lock, flags);
+
 	return target_submit_cmd(se_cmd, se_sess, cdb, &cmd->sense_buffer[0],
-				cmd->unpacked_lun, data_length, fcp_task_attr,
-				data_dir, flags);
+				 cmd->unpacked_lun, data_length, fcp_task_attr,
+				 data_dir, target_flags);
 }
 
 static void tcm_qla2xxx_handle_data_work(struct work_struct *work)
@@ -617,25 +627,20 @@ static int tcm_qla2xxx_handle_tmr(struct qla_tgt_mgmt_cmd *mcmd, u64 lun,
 static struct qla_tgt_cmd *tcm_qla2xxx_find_cmd_by_tag(struct fc_port *sess,
     uint64_t tag)
 {
-	struct qla_tgt_cmd *cmd = NULL;
-	struct se_cmd *secmd;
+	struct qla_tgt_cmd *cmd;
 	unsigned long flags;
 
 	if (!sess->se_sess)
 		return NULL;
 
-	spin_lock_irqsave(&sess->se_sess->sess_cmd_lock, flags);
-	list_for_each_entry(secmd, &sess->se_sess->sess_cmd_list, se_cmd_list) {
-		/* skip task management functions, including tmr->task_cmd */
-		if (secmd->se_cmd_flags & SCF_SCSI_TMR_CDB)
-			continue;
-
-		if (secmd->tag == tag) {
-			cmd = container_of(secmd, struct qla_tgt_cmd, se_cmd);
-			break;
-		}
+	spin_lock_irqsave(&sess->sess_cmd_lock, flags);
+	list_for_each_entry(cmd, &sess->sess_cmd_list, sess_cmd_list) {
+		if (cmd->se_cmd.tag == tag)
+			goto done;
 	}
-	spin_unlock_irqrestore(&sess->se_sess->sess_cmd_lock, flags);
+	cmd = NULL;
+done:
+	spin_unlock_irqrestore(&sess->sess_cmd_lock, flags);
 
 	return cmd;
 }
@@ -765,11 +770,19 @@ static void tcm_qla2xxx_queue_tm_rsp(struct se_cmd *se_cmd)
 
 static void tcm_qla2xxx_aborted_task(struct se_cmd *se_cmd)
 {
-	struct qla_tgt_cmd *cmd = container_of(se_cmd,
-				struct qla_tgt_cmd, se_cmd);
+	struct qla_tgt_cmd *cmd;
+	unsigned long flags;
 
-	if (qlt_abort_cmd(cmd))
+	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB)
 		return;
+
+	cmd  = container_of(se_cmd, struct qla_tgt_cmd, se_cmd);
+
+	spin_lock_irqsave(&cmd->sess->sess_cmd_lock, flags);
+	list_del_init(&cmd->sess_cmd_list);
+	spin_unlock_irqrestore(&cmd->sess->sess_cmd_lock, flags);
+
+	qlt_abort_cmd(cmd);
 }
 
 static void tcm_qla2xxx_clear_sess_lookup(struct tcm_qla2xxx_lport *,
-- 
1.8.3.1

