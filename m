Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08B86428F5
	for <lists+target-devel@lfdr.de>; Mon,  5 Dec 2022 14:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiLENIP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 5 Dec 2022 08:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiLENIO (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:08:14 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1562AF5;
        Mon,  5 Dec 2022 05:08:10 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 77C3234150F;
        Mon,  5 Dec 2022 16:08:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:message-id:mime-version:reply-to:subject:subject:to
        :to; s=mta-01; bh=i/xo2XQ1NS1UXhqHfAooHjcxyK56Mp21DQ4E7RlCNFM=; b=
        fIW0RSrUjsivwvQFoMDhuRZ/bKS4N/jrOYHfZ67bExZzRFZn9OlMcFrdviBdpI5d
        ykRIw4d9U7r7UqTM+9pV7ZDc3Wmy92HPMDXTAWeykscHprMopvO5LFUFoMcF0T4o
        0wm+oOJpSxrnEHFcIpfyUUYZuKQetU/Z0r7Lfx+8yG0=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 6BF7A341506;
        Mon,  5 Dec 2022 16:08:08 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Mon, 5 Dec 2022 16:08:07 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Mike Christie <michael.christie@oracle.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH v2] scsi: qla2xxx: abort TMR commands
Date:   Mon, 5 Dec 2022 16:08:00 +0300
Message-ID: <20221205130800.15816-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

TCM calls aborted_task callback for TMR too and then releases the
command. But qla2xx ignores that callback for TMR and leaks an FC
exchange.
Add terminating the exchange of task management IOCBs to free its
FW resources.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
Changelog:
  v2:
     fix sparse warning 'expected restricted __le16' [usertype] control_flags
     fix checkpatch warning 'quoted string split across lines'
---
 drivers/scsi/qla2xxx/qla_target.c  | 120 ++++++++++++++++++++++++-----
 drivers/scsi/qla2xxx/qla_target.h  |   1 +
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |   8 +-
 3 files changed, 110 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index bb754a950802..7746d66cd01f 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1857,6 +1857,72 @@ static int qlt_build_abts_resp_iocb(struct qla_tgt_mgmt_cmd *mcmd)
 	return rc;
 }
 
+static int __qlt_send_term_abts_exchange(struct qla_qpair *qpair,
+					 struct scsi_qla_host *vha,
+					 struct abts_recv_from_24xx *abts)
+{
+	struct qla_hw_data *ha = vha->hw;
+	struct abts_resp_to_24xx *resp;
+	__le32 f_ctl;
+	uint8_t *p;
+	int rc;
+
+	ql_dbg(ql_dbg_tgt, vha, 0xe006,
+	    "Sending terminate exchange of ABTS (ha=%p)\n",
+	    ha);
+
+	rc = qlt_check_reserve_free_req(qpair, 1);
+	if (rc) {
+		ql_dbg(ql_dbg_tgt, vha, 0xe04a,
+		    "qla_target(%d): %s failed: unable to allocate request packet\n",
+		    vha->vp_idx, __func__);
+		return -EAGAIN;
+	}
+
+	resp = (struct abts_resp_to_24xx *)qpair->req->ring_ptr;
+	memset(resp, 0, sizeof(*resp));
+
+	resp->entry_type = ABTS_RESP_24XX;
+	resp->entry_count = 1;
+	resp->handle = QLA_TGT_SKIP_HANDLE;
+	resp->nport_handle = abts->nport_handle;
+	resp->control_flags = cpu_to_le16(ABTS_CONTR_FLG_TERM_EXCHG);
+	resp->vp_index = vha->vp_idx;
+	resp->sof_type = abts->sof_type;
+	resp->exchange_address = abts->exchange_address;
+	/*
+	 * Although no basic accept/reject frame is sent to the wire, the basic
+	 * accept/reject frame (from IOCB offsets 14h-37h) must be filled by the
+	 * driver, because the QLogic ASIC firmware performs a cross-check
+	 * before terminating the ABTS exchange.
+	 */
+	resp->fcp_hdr_le = abts->fcp_hdr_le;
+	f_ctl = cpu_to_le32(F_CTL_EXCH_CONTEXT_RESP |
+	    F_CTL_LAST_SEQ | F_CTL_END_SEQ |
+	    F_CTL_SEQ_INITIATIVE);
+	p = (uint8_t *)&f_ctl;
+	resp->fcp_hdr_le.f_ctl[0] = *p++;
+	resp->fcp_hdr_le.f_ctl[1] = *p++;
+	resp->fcp_hdr_le.f_ctl[2] = *p;
+
+	resp->fcp_hdr_le.d_id = abts->fcp_hdr_le.s_id;
+	resp->fcp_hdr_le.s_id = abts->fcp_hdr_le.d_id;
+	resp->fcp_hdr_le.r_ctl = R_CTL_BASIC_LINK_SERV | R_CTL_B_RJT;
+	resp->payload.ba_rjt.reason_code =
+		BA_RJT_REASON_CODE_UNABLE_TO_PERFORM;
+	resp->exchange_addr_to_abort = abts->exchange_addr_to_abort;
+
+	vha->vha_tgt.qla_tgt->abts_resp_expected++;
+
+	/* Memory Barrier */
+	wmb();
+	if (qpair->reqq_start_iocbs)
+		qpair->reqq_start_iocbs(qpair);
+	else
+		qla2x00_start_iocbs(vha, qpair->req);
+
+	return rc;
+}
 /*
  * ha->hardware_lock supposed to be held on entry. Might drop it, then reaquire
  */
@@ -3666,10 +3732,9 @@ static void qlt_send_term_imm_notif(struct scsi_qla_host *vha,
  * This function sends the appropriate CTIO to ISP 2xxx or 24xx
  */
 static int __qlt_send_term_exchange(struct qla_qpair *qpair,
-	struct qla_tgt_cmd *cmd,
+	struct scsi_qla_host *vha,
 	struct atio_from_isp *atio)
 {
-	struct scsi_qla_host *vha = qpair->vha;
 	struct ctio7_to_24xx *ctio24;
 	struct qla_hw_data *ha = vha->hw;
 	request_t *pkt;
@@ -3678,9 +3743,6 @@ static int __qlt_send_term_exchange(struct qla_qpair *qpair,
 
 	ql_dbg(ql_dbg_tgt, vha, 0xe009, "Sending TERM EXCH CTIO (ha=%p)\n", ha);
 
-	if (cmd)
-		vha = cmd->vha;
-
 	pkt = (request_t *)qla2x00_alloc_iocbs_ready(qpair, NULL);
 	if (pkt == NULL) {
 		ql_dbg(ql_dbg_tgt, vha, 0xe050,
@@ -3689,16 +3751,6 @@ static int __qlt_send_term_exchange(struct qla_qpair *qpair,
 		return -ENOMEM;
 	}
 
-	if (cmd != NULL) {
-		if (cmd->state < QLA_TGT_STATE_PROCESSED) {
-			ql_dbg(ql_dbg_tgt, vha, 0xe051,
-			    "qla_target(%d): Terminating cmd %p with "
-			    "incorrect state %d\n", vha->vp_idx, cmd,
-			    cmd->state);
-		} else
-			ret = 1;
-	}
-
 	qpair->tgt_counters.num_term_xchg_sent++;
 	pkt->entry_count = 1;
 	pkt->handle = QLA_TGT_SKIP_HANDLE | CTIO_COMPLETION_HANDLE_MARK;
@@ -3739,14 +3791,22 @@ static void qlt_send_term_exchange(struct qla_qpair *qpair,
 	else
 		vha = qpair->vha;
 
+	if (cmd != NULL) {
+		if (cmd->state < QLA_TGT_STATE_PROCESSED) {
+			ql_dbg(ql_dbg_tgt, vha, 0xe051,
+			    "qla_target(%d): Terminating cmd %p with incorrect state %d\n",
+			    vha->vp_idx, cmd, cmd->state);
+		}
+	}
+
 	if (ha_locked) {
-		rc = __qlt_send_term_exchange(qpair, cmd, atio);
+		rc = __qlt_send_term_exchange(qpair, vha, atio);
 		if (rc == -ENOMEM)
 			qlt_alloc_qfull_cmd(vha, atio, 0, 0);
 		goto done;
 	}
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
-	rc = __qlt_send_term_exchange(qpair, cmd, atio);
+	rc = __qlt_send_term_exchange(qpair, vha, atio);
 	if (rc == -ENOMEM)
 		qlt_alloc_qfull_cmd(vha, atio, 0, 0);
 
@@ -3810,6 +3870,30 @@ static void qlt_chk_exch_leak_thresh_hold(struct scsi_qla_host *vha)
 
 }
 
+int qlt_abort_mcmd(struct qla_tgt_mgmt_cmd *mcmd)
+{
+	struct scsi_qla_host *vha = mcmd->vha;
+	struct se_cmd *se_cmd = &mcmd->se_cmd;
+	unsigned long flags;
+	int rc = 0;
+
+	ql_dbg(ql_dbg_tgt_mgt, vha, 0xf022,
+	    "qla_target(%d): terminating exchange for aborted mcmd=%p (se_cmd=%p, tag=%llu)",
+	    vha->vp_idx, mcmd, se_cmd, se_cmd->tag);
+
+	spin_lock_irqsave(mcmd->qpair->qp_lock_ptr, flags);
+	if (mcmd->orig_iocb.atio.u.raw.entry_type == ABTS_RECV_24XX)
+		rc = __qlt_send_term_abts_exchange(mcmd->qpair, vha,
+						   &mcmd->orig_iocb.abts);
+	else
+		rc = __qlt_send_term_exchange(mcmd->qpair, vha,
+					      &mcmd->orig_iocb.atio);
+	spin_unlock_irqrestore(mcmd->qpair->qp_lock_ptr, flags);
+
+	return rc;
+}
+EXPORT_SYMBOL(qlt_abort_mcmd);
+
 int qlt_abort_cmd(struct qla_tgt_cmd *cmd)
 {
 	struct qla_tgt *tgt = cmd->tgt;
@@ -5578,7 +5662,7 @@ qlt_free_qfull_cmds(struct qla_qpair *qpair)
 			/* cmd->state is a borrowed field to hold status */
 			rc = __qlt_send_busy(qpair, &cmd->atio, cmd->state);
 		else if (cmd->term_exchg)
-			rc = __qlt_send_term_exchange(qpair, NULL, &cmd->atio);
+			rc = __qlt_send_term_exchange(qpair, vha, &cmd->atio);
 
 		if (rc == -ENOMEM)
 			break;
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 7df86578214f..7902f5b5f4aa 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -1057,6 +1057,7 @@ extern void qlt_response_pkt_all_vps(struct scsi_qla_host *, struct rsp_que *,
 extern int qlt_rdy_to_xfer(struct qla_tgt_cmd *);
 extern int qlt_xmit_response(struct qla_tgt_cmd *, int, uint8_t);
 extern int qlt_abort_cmd(struct qla_tgt_cmd *);
+extern int qlt_abort_mcmd(struct qla_tgt_mgmt_cmd *mcmd);
 extern void qlt_xmit_tm_rsp(struct qla_tgt_mgmt_cmd *);
 extern void qlt_free_mcmd(struct qla_tgt_mgmt_cmd *);
 extern void qlt_free_cmd(struct qla_tgt_cmd *cmd);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 8fa0056b56dd..0ef09b43e0f7 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -773,8 +773,14 @@ static void tcm_qla2xxx_aborted_task(struct se_cmd *se_cmd)
 	struct qla_tgt_cmd *cmd;
 	unsigned long flags;
 
-	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB)
+	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB) {
+		struct qla_tgt_mgmt_cmd *mcmd = container_of(se_cmd,
+				struct qla_tgt_mgmt_cmd, se_cmd);
+
+		qlt_abort_mcmd(mcmd);
+
 		return;
+	}
 
 	cmd  = container_of(se_cmd, struct qla_tgt_cmd, se_cmd);
 
-- 
2.25.1


