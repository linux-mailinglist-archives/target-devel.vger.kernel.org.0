Return-Path: <target-devel+bounces-596-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32854BA9B39
	for <lists+target-devel@lfdr.de>; Mon, 29 Sep 2025 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4263A5A35
	for <lists+target-devel@lfdr.de>; Mon, 29 Sep 2025 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A28E3090FA;
	Mon, 29 Sep 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="Qcbkh7gR"
X-Original-To: target-devel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838792BF00B
	for <target-devel@vger.kernel.org>; Mon, 29 Sep 2025 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.71.130.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157521; cv=none; b=t9G+yWK5vKUvo12sWbj/U30LKSWvsntL5KK5+hktSQTUFR9jUnuHkB1j/fyRtOEnwXGS5BaXqW6MX0kTrpqVh48+yFKiIeq94NDFifY55MOd4adNhkuTJwsDbFdsOOfj3YPufYsKuGpx0tVOmy4UoX0NXcUxZm++IuDjCLCKnUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157521; c=relaxed/simple;
	bh=+VgOLQihNXC3Yn56mbhmuoWZBNh/Azj11L0jB1gt5Is=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W0DTn1n5gFi5CrZtPJA3PoxzVb1usv1L81FhsrOTpLQIjT01zb19FxatHs8Qa+JdZVYjYHx5DN7m87klEbv1TjPBcKgO4vljM/jOjN+qWIt7e9ynfqPoVJKA5MH2StTkSMq6/7Ef1q7IGTgQ+llBi6pb76g4PTqkOu+Mb0aJftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=Qcbkh7gR; arc=none smtp.client-ip=173.71.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id JQot2AbfcZ4A6qD4; Mon, 29 Sep 2025 10:51:57 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=JxataOkahTQdyQrQouLCgD+k43OUqm50ZTB0msMAx0s=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=Qcbkh7gRadJdNGlVJcKl
	iTkkmskktOpqKYk3nvidipVWPfgo/edyZ6vHDhAeqGtC1aU3ADTpalRC100/jAQIlQuXg0S09YHj6
	4eAAJdGCirMM3tq6DCckCZ00VGUCe2y8AKwgDgDCtHawdhBYQikmzIDCTXEWf91i031/hG+5d0=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14216667; Mon, 29 Sep 2025 10:51:57 -0400
Message-ID: <a5e6fa18-4391-4722-a575-f0c610fa1d1e@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 29 Sep 2025 10:51:57 -0400
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [SCST PATCH v2 15/16] scsi: qla2xxx: add back SRR support
Content-Language: en-US
X-ASG-Orig-Subj: [SCST PATCH v2 15/16] scsi: qla2xxx: add back SRR support
From: Tony Battersby <tonyb@cybernetics.com>
To: Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, target-devel@vger.kernel.org,
 scst-devel@lists.sourceforge.net,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Xose Vazquez Perez <xose.vazquez@gmail.com>
References: <e95ee7d0-3580-4124-b854-7f73ca3a3a84@cybernetics.com>
 <8d56cc7e-b7c9-4fa8-b138-2d73bc241035@cybernetics.com>
In-Reply-To: <8d56cc7e-b7c9-4fa8-b138-2d73bc241035@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1759157517
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 8962
X-Barracuda-BRTS-Status: 1
X-ASG-Debug-ID: 1759157517-1cf43947df3c0600001-W1KF7h

This patch applies to the out-of-tree SCST project, not to the Linux
kernel.  Apply when importing the upstream patch with the same title.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

v1 -> v2: sqa_on_hw_pending_cmd_timeout() changes had to be redone due to
changes in prior patch "scsi: qla2xxx: fix races with aborting commands".

 qla2x00t-32gbit/qla2x00-target/scst_qla2xxx.c | 157 +++++++++++++++---
 1 file changed, 134 insertions(+), 23 deletions(-)

diff --git a/qla2x00t-32gbit/qla2x00-target/scst_qla2xxx.c b/qla2x00t-32gbit/qla2x00-target/scst_qla2xxx.c
index fb5956346..3fca87ff0 100644
--- a/qla2x00t-32gbit/qla2x00-target/scst_qla2xxx.c
+++ b/qla2x00t-32gbit/qla2x00-target/scst_qla2xxx.c
@@ -72,6 +72,8 @@
 #endif
 #endif
 
+#define sense_initiator_detected_error HARDWARE_ERROR, 0x48, 0x00
+
 static LIST_HEAD(sqa_tgt_glist);
 
 /* Function definitions for callbacks from the SCST target core. */
@@ -395,6 +397,17 @@ static struct qla_tgt_cmd *sqa_qla2xxx_get_cmd(struct fc_port *sess)
 	return cmd;
 }
 
+static int sqa_qla2xxx_get_cmd_ref(struct qla_tgt_cmd *cmd)
+{
+	scst_cmd_get(cmd->scst_cmd);
+	return 0;
+}
+
+static void sqa_qla2xxx_put_cmd_ref(struct qla_tgt_cmd *cmd)
+{
+	scst_cmd_put(cmd->scst_cmd);
+}
+
 static DEFINE_MUTEX(sqa_mutex);
 
 
@@ -527,8 +540,12 @@ static void sqa_qla2xxx_handle_data(struct qla_tgt_cmd *cmd)
 			break;
 		case DIF_ERR_NONE:
 		default:
-			scst_set_cmd_error(scst_cmd,
-				SCST_LOAD_SENSE(scst_sense_aborted_command));
+			if (cmd->srr_failed)
+				scst_set_cmd_error(scst_cmd,
+					SCST_LOAD_SENSE(sense_initiator_detected_error));
+			else
+				scst_set_cmd_error(scst_cmd,
+					SCST_LOAD_SENSE(scst_sense_aborted_command));
 			break;
 		}
 	}
@@ -1546,6 +1563,11 @@ static int sqa_xmit_response(struct scst_cmd *scst_cmd)
 		}
 	}
 
+	if (unlikely(cmd->free_sg)) {
+		cmd->free_sg = 0;
+		qlt_free_sg(cmd);
+	}
+
 	cmd->bufflen = scst_cmd_get_adjusted_resp_data_len(scst_cmd);
 	cmd->sg = scst_cmd_get_sg(scst_cmd);
 	cmd->sg_cnt = scst_cmd_get_sg_cnt(scst_cmd);
@@ -1556,6 +1578,15 @@ static int sqa_xmit_response(struct scst_cmd *scst_cmd)
 	cmd->lba = scst_cmd_get_lba(scst_cmd);
 	cmd->trc_flags |= TRC_XMIT_STATUS;
 
+	/*
+	 * se_cmd::data_length,t_data_sg,t_data_nents used by
+	 * qlt_restore_orig_sg()
+	 */
+	cmd->se_cmd.data_length = cmd->bufflen;
+	cmd->se_cmd.t_data_sg = cmd->sg;
+	cmd->se_cmd.t_data_nents = cmd->sg_cnt;
+	cmd->se_cmd.scsi_status = cmd->scsi_status;
+
 #if QLA_ENABLE_PI
 	if (scst_get_tgt_dif_actions(scst_cmd->cmd_dif_actions)) {
 		cmd->blk_sz = scst_cmd_get_block_size(scst_cmd);
@@ -1600,7 +1631,7 @@ static int sqa_xmit_response(struct scst_cmd *scst_cmd)
 		  cmd->bufflen, cmd->sg_cnt, cmd->dma_data_direction,
 		  cmd->se_cmd.residual_count);
 
-	res = qlt_xmit_response(cmd, xmit_type, scst_cmd_get_status(scst_cmd));
+	res = qlt_xmit_response(cmd, xmit_type, cmd->scsi_status);
 
 	switch (res) {
 	case 0:
@@ -1630,16 +1661,30 @@ static int sqa_rdy_to_xfer(struct scst_cmd *scst_cmd)
 	TRACE(TRACE_SCSI, "sqatgt(%ld/%d): tag=%lld", cmd->vha->host_no,
 	      cmd->vha->vp_idx, scst_cmd_get_tag(scst_cmd));
 
+	if (unlikely(cmd->free_sg)) {
+		cmd->free_sg = 0;
+		qlt_free_sg(cmd);
+	}
+
 	cmd->bufflen = scst_cmd_get_write_fields(scst_cmd, &cmd->sg,
 						 &cmd->sg_cnt);
+
 	cmd->dma_data_direction =
 		scst_to_tgt_dma_dir(scst_cmd_get_data_direction(scst_cmd));
+	cmd->offset = 0;
 
-	cmd->sg = scst_cmd_get_sg(scst_cmd);
-	cmd->sg_cnt = scst_cmd_get_sg_cnt(scst_cmd);
 	cmd->scsi_status = scst_cmd_get_status(scst_cmd);
 	cmd->trc_flags |= TRC_XFR_RDY;
 
+	/*
+	 * se_cmd::data_length,t_data_sg,t_data_nents used by
+	 * qlt_restore_orig_sg()
+	 */
+	cmd->se_cmd.data_length = cmd->bufflen;
+	cmd->se_cmd.t_data_sg = cmd->sg;
+	cmd->se_cmd.t_data_nents = cmd->sg_cnt;
+	cmd->se_cmd.scsi_status = cmd->scsi_status;
+
 #if QLA_ENABLE_PI
 	if (scst_get_tgt_dif_actions(scst_cmd->cmd_dif_actions)) {
 		cmd->blk_sz    = scst_cmd_get_block_size(scst_cmd);
@@ -1841,7 +1886,9 @@ static void sqa_on_hw_pending_cmd_timeout(struct scst_cmd *scst_cmd)
 	struct qla_tgt_cmd *cmd = scst_cmd_get_tgt_priv(scst_cmd);
 	struct scsi_qla_host *vha = cmd->vha;
 	struct qla_qpair *qpair = cmd->qpair;
+	struct qla_tgt_srr *srr;
 	unsigned long flags;
+	bool advance_cmd = false;
 
 	TRACE_ENTRY();
 
@@ -1872,13 +1919,46 @@ static void sqa_on_hw_pending_cmd_timeout(struct scst_cmd *scst_cmd)
 		break;
 	}
 
-	/* Handle race with normal CTIO completion. */
-	if (!cmd->cmd_sent_to_fw) {
+	srr = cmd->srr;
+	if (srr) {
+		/* Handle race with SRR processing. */
+		if (srr->imm_ntfy_recvd && srr->ctio_recvd) {
+			TRACE_MGMT_DBG(
+			    "sqatgt(%ld/%d): tag %lld: cmd should be scheduled for SRR processing",
+			    vha->host_no, vha->vp_idx,
+			    scst_cmd_get_tag(scst_cmd));
+			goto out_unlock;
+		}
+
 		TRACE_MGMT_DBG(
-		    "sqatgt(%ld/%d): tag %lld: cmd not sent to fw; assuming just completed",
+		    "sqatgt(%ld/%d): tag %lld: timeout waiting for %s SRR",
 		    vha->host_no, vha->vp_idx,
-		    scst_cmd_get_tag(scst_cmd));
-		goto out_unlock;
+		    scst_cmd_get_tag(scst_cmd),
+		    (!srr->imm_ntfy_recvd) ? "IMM" : "CTIO");
+
+		if (srr->ctio_recvd) {
+			/*
+			 * When the SRR CTIO was received, cmd processing was
+			 * delayed to wait for the SRR immediate notify, which
+			 * never arrived. Process the cmd now.
+			 *
+			 * Note that in this case cmd->cmd_sent_to_fw == 0
+			 * so we avoid checking that.
+			 */
+			advance_cmd = true;
+		}
+
+		qlt_srr_abort(cmd, false);
+		srr = NULL; /* srr may have been freed */
+	} else {
+		/* Handle race with normal CTIO completion. */
+		if (!cmd->cmd_sent_to_fw) {
+			TRACE_MGMT_DBG(
+			    "sqatgt(%ld/%d): tag %lld: cmd not sent to fw; assuming just completed",
+			    vha->host_no, vha->vp_idx,
+			    scst_cmd_get_tag(scst_cmd));
+			goto out_unlock;
+		}
 	}
 
 	/* The command should be aborted elsewhere if the ISP was reset. */
@@ -1886,7 +1966,8 @@ static void sqa_on_hw_pending_cmd_timeout(struct scst_cmd *scst_cmd)
 		goto out_unlock;
 
 	/* Reset the ISP if there was a timeout after sending a term exchange. */
-	if (cmd->sent_term_exchg &&
+	if (!advance_cmd &&
+	     cmd->sent_term_exchg &&
 	     time_is_before_jiffies(cmd->jiffies_at_term_exchg +
 				    SQA_MAX_HW_PENDING_TIME * HZ / 2)) {
 		if (!test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags)) {
@@ -1906,18 +1987,46 @@ static void sqa_on_hw_pending_cmd_timeout(struct scst_cmd *scst_cmd)
 	if (!cmd->sent_term_exchg)
 		qlt_send_term_exchange(qpair, cmd, &cmd->atio, 1);
 
-	/*
-	 * Restart the timer so that this function is called again
-	 * after another timeout.  This is similar to
-	 * scst_update_hw_pending_start() except that we also set
-	 * cmd_hw_pending to 1.
-	 *
-	 * IRQs are already OFF.
-	 */
-	spin_lock(&scst_cmd->sess->sess_list_lock);
-	scst_cmd->cmd_hw_pending = 1;
-	scst_cmd->hw_pending_start = jiffies;
-	spin_unlock(&scst_cmd->sess->sess_list_lock);
+	if (advance_cmd) {
+		switch (cmd->state) {
+		case QLA_TGT_STATE_NEED_DATA:
+			TRACE_MGMT_DBG(
+			    "sqatgt(%ld/%d): tag %lld: force rx_data",
+			    vha->host_no, vha->vp_idx,
+			    scst_cmd_get_tag(scst_cmd));
+			cmd->state = QLA_TGT_STATE_DATA_IN;
+			scst_set_cmd_error(scst_cmd,
+			    SCST_LOAD_SENSE(scst_sense_internal_failure));
+			scst_rx_data(scst_cmd, SCST_RX_STATUS_ERROR_SENSE_SET,
+			    SCST_CONTEXT_THREAD);
+			break;
+
+		case QLA_TGT_STATE_PROCESSED:
+			TRACE_MGMT_DBG(
+			    "sqatgt(%ld/%d): tag %lld: force finishing cmd",
+			    vha->host_no, vha->vp_idx,
+			    scst_cmd_get_tag(scst_cmd));
+			scst_set_delivery_status(scst_cmd, SCST_CMD_DELIVERY_FAILED);
+			scst_tgt_cmd_done(scst_cmd, SCST_CONTEXT_THREAD);
+			break;
+
+		default:
+			break;
+		}
+	} else {
+		/*
+		 * Restart the timer so that this function is called again
+		 * after another timeout.  This is similar to
+		 * scst_update_hw_pending_start() except that we also set
+		 * cmd_hw_pending to 1.
+		 *
+		 * IRQs are already OFF.
+		 */
+		spin_lock(&scst_cmd->sess->sess_list_lock);
+		scst_cmd->cmd_hw_pending = 1;
+		scst_cmd->hw_pending_start = jiffies;
+		spin_unlock(&scst_cmd->sess->sess_list_lock);
+	}
 
 out_unlock:
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
@@ -1978,6 +2087,8 @@ static struct qla_tgt_func_tmpl sqa_qla2xxx_template = {
 	.handle_tmr		    = sqa_qla2xxx_handle_tmr,
 	.find_cmd_by_tag	    = sqa_qla2xxx_find_cmd_by_tag,
 	.get_cmd		    = sqa_qla2xxx_get_cmd,
+	.get_cmd_ref		    = sqa_qla2xxx_get_cmd_ref,
+	.put_cmd_ref		    = sqa_qla2xxx_put_cmd_ref,
 	.rel_cmd		    = sqa_qla2xxx_rel_cmd,
 	.free_cmd		    = sqa_qla2xxx_free_cmd,
 	.free_mcmd		    = sqa_qla2xxx_free_mcmd,
-- 
2.43.0



