Return-Path: <target-devel+bounces-531-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B2B49978
	for <lists+target-devel@lfdr.de>; Mon,  8 Sep 2025 21:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 667B14E11F1
	for <lists+target-devel@lfdr.de>; Mon,  8 Sep 2025 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2168239E7D;
	Mon,  8 Sep 2025 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="Z2UhyR5N"
X-Original-To: target-devel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC9238C0F
	for <target-devel@vger.kernel.org>; Mon,  8 Sep 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.71.130.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358658; cv=none; b=A7mTY1A8nhgH5QHZK1Pn5sC5eu+/09e56Z+mUFXwC1GL6HjS2tNlId8AyrN/tMHWASZjPJE8sG24tTLWhB7LzQftpvu3ytNwhsgS3jCQuatrRAqf2D5abCtPy/kI7VLLImt2lgoG/p4gseh1y82gFQD0GOlAXcwlyh+ZvEPxrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358658; c=relaxed/simple;
	bh=ZgtQZz5BU8ZeKWA5ZOYnMaUawJhI9KuzPVXy345n708=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YTWIb2IZ0jPvBTTXExBqi472TOrnkgK0PgD43MzFuB9D02IgN4HJEdVNgeZsnir6FU7pMP8LeYfqLmMYChxTc4bhiQMGVmwkpeKnDMh+yaHC81XxsZh4VNoEE/yRzUKrK6XvXqY7sm+LX2rvTf2NInXcj8TArLu+Hdp16SunLHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=Z2UhyR5N; arc=none smtp.client-ip=173.71.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id AxxV8hzFU0ZO3xxD; Mon, 08 Sep 2025 15:10:53 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=Z/HJt+0VSk2I/X4rIDyFFvOtQLndsiBcAg+g2BQr5ns=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=Z2UhyR5NAY7Pnu98YqbM
	Pw/0aqxmo6xz8xXRZprAqhBF9P9fGVzBU5/sjMifg/K4Q3MNKrfeGAO5T+AAhBduNmAqI7Z4CQytf
	Bm20BnZ43yAOPIRvUMvSxCBmCHmhEngIUCjzonT8qYWZfwhd/IOWospEEih+MgQJCzHs2bnLzI=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14189167; Mon, 08 Sep 2025 15:10:53 -0400
Message-ID: <2cc10189-6953-428e-b34e-b1c714fc0eae@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 8 Sep 2025 15:10:53 -0400
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 14/15] scsi: qla2xxx: add back SRR support
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 14/15] scsi: qla2xxx: add back SRR support
From: Tony Battersby <tonyb@cybernetics.com>
To: Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, target-devel@vger.kernel.org,
 scst-devel@lists.sourceforge.net,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f8977250-638c-4d7d-ac0c-65f742b8d535@cybernetics.com>
In-Reply-To: <f8977250-638c-4d7d-ac0c-65f742b8d535@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1757358653
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 48289
X-ASG-Debug-ID: 1757358653-1cf43947df30c7a0002-W1KF7h

(target mode)

Background: loading qla2xxx with "ql2xtgt_tape_enable=1" enables
Sequence Level Error Recovery (SLER), which is most commonly used for
tape drives.  With SLER enabled, if there is a recoverable I/O error
during a SCSI command, a Sequence Retransmission Request (SRR) will be
used to retry the I/O at a low-level completely within the driver
without propagating the error to the upper levels of the SCSI stack.

SRR support was removed in 2017 by commit 2c39b5ca2a8c ("qla2xxx:
Remove SRR code").  But I need it, so add it back, new and improved.

The old removed SRR code used sequence numbers to correlate the SRR
CTIOs with SRR immediate notify messages.  I don't see how that would
work reliably with MSI-X interrupts and multiple queues.  So instead use
the exchange address to find the command associated with the immediate
notify (qlt_srr_to_cmd).

The old removed SRR code had a function qlt_check_srr_debug() to
simulate a SRR, but it didn't work for me.  Instead I just used fiber
optic attenuators attached to the FC cable to reduce the strength of the
signal and induce errors.  Unfortunately this only worked for inducing
SRRs on Data-Out (write) commands, so that is all I was able to test.

The code to build a new scatterlist for a SRR with nonzero offset
has been improved to reduce memory requirements and has been
well-tested.  However it does not support protection information.

When a single cmd gets multiple SRRs, the old removed SRR code would
restore the data buffer from the values in cmd->se_cmd before processing
the new SRR.  That might be needed if the offset for the new SRR was
lower than the offset for the previous SRR, but I am not sure if that
can happen.  In my testing, when a single cmd gets multiple SRRs, the
SRR offset always increases or stays the same.  But in case it can
decrease, I added the function qlt_restore_orig_sg().  If this is not
supposed to happen then qlt_restore_orig_sg() can be removed to simplify
the code.

I ran into some HBA firmware bugs with QLE2694L firmware 9.06.02 -
9.08.02 where a SRR would cause the HBA to misbehave badly.  Since SRRs
are rare and therefore difficult to test, I figured it would be worth
checking for the buggy firmware and disabling SLER with a warning
instead of letting others run into the same problem on the rare
occasion that they get a SRR.  This turned out to be difficult because
the firmware version isn't known in the normal NVRAM config routine, so
I added a second NVRAM config routine that is called after the firmware
version is known.  It may be necessary to add checks for additional
buggy firmware versions or additional chips that I was not able to
test.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c     |    1 +
 drivers/scsi/qla2xxx/qla_init.c    |    1 +
 drivers/scsi/qla2xxx/qla_target.c  | 1030 ++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_target.h  |   81 +++
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |   15 +
 5 files changed, 1128 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index a19471d51ea5..9f56bec26231 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -58,6 +58,7 @@
  * | Target Mode Management	  |	  0xf09b       | 0xf002		|
  * |                              |                    | 0xf046-0xf049  |
  * | Target Mode Task Management  |	  0x1000d      |		|
+ * | Target Mode SRR		  |	  0x11038      |		|
  * ----------------------------------------------------------------------
  */
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index be211ff22acb..25c1760eac45 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4369,6 +4369,7 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 						ha->max_npiv_vports =
 						    MIN_MULTI_ID_FABRIC - 1;
 				}
+				qlt_config_nvram_with_fw_version(vha);
 				qla2x00_get_resource_cnts(vha);
 				qla_init_iocb_limit(vha);
 
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 028cb41f78be..70e1810d4996 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3216,6 +3216,10 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 	 * first.
 	 */
 
+	/* Begin timer on the first call, not on SRR retry. */
+	if (likely(cmd->jiffies_at_hw_st_entry == 0))
+		cmd->jiffies_at_hw_st_entry = get_jiffies_64();
+
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 
 	if (unlikely(cmd->sent_term_exchg ||
@@ -3359,6 +3363,10 @@ int qlt_rdy_to_xfer(struct qla_tgt_cmd *cmd)
 	int pci_map_res;
 	struct qla_qpair *qpair = cmd->qpair;
 
+	/* Begin timer on the first call, not on SRR retry. */
+	if (likely(cmd->jiffies_at_hw_st_entry == 0))
+		cmd->jiffies_at_hw_st_entry = get_jiffies_64();
+
 	memset(&prm, 0, sizeof(prm));
 	prm.cmd = cmd;
 	prm.tgt = tgt;
@@ -3384,6 +3392,7 @@ int qlt_rdy_to_xfer(struct qla_tgt_cmd *cmd)
 		cmd->aborted = 1;
 		cmd->write_data_transferred = 0;
 		cmd->state = QLA_TGT_STATE_DATA_IN;
+		cmd->jiffies_at_hw_st_entry = 0;
 		vha->hw->tgt.tgt_ops->handle_data(cmd);
 		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 		return 0;
@@ -3431,6 +3440,7 @@ int qlt_rdy_to_xfer(struct qla_tgt_cmd *cmd)
 	return res;
 
 out_unlock_free_unmap:
+	cmd->jiffies_at_hw_st_entry = 0;
 	qlt_unmap_sg(vha, cmd);
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
@@ -3520,6 +3530,7 @@ qlt_handle_dif_error(struct qla_qpair *qpair, struct qla_tgt_cmd *cmd,
 	case QLA_TGT_STATE_NEED_DATA:
 		/* handle_data will load DIF error code  */
 		cmd->state = QLA_TGT_STATE_DATA_IN;
+		cmd->jiffies_at_hw_st_entry = 0;
 		vha->hw->tgt.tgt_ops->handle_data(cmd);
 		break;
 	default:
@@ -3599,6 +3610,62 @@ static void qlt_send_term_imm_notif(struct scsi_qla_host *vha,
 	pr_debug("rc = %d\n", rc);
 }
 
+/*
+ * Handle a SRR that had been previously associated with a command when the
+ * command has been aborted or otherwise cannot process the SRR.
+ *
+ * If reject is true, then attempt to reject the SRR.  Otherwise abort the
+ * immediate notify exchange.
+ */
+void qlt_srr_abort(struct qla_tgt_cmd *cmd, bool reject)
+{
+	struct scsi_qla_host *vha = cmd->vha;
+	struct qla_tgt_srr *srr = cmd->srr;
+
+	if (srr->imm_ntfy_recvd) {
+		if (reject)
+			srr->reject = true;
+		else
+			srr->aborted = true;
+
+		if (srr->ctio_recvd) {
+			/*
+			 * The SRR should already be scheduled for processing,
+			 * and the SRR processing code should see that the cmd
+			 * has been aborted and take appropriate action.  In
+			 * addition, the cmd refcount should have been
+			 * incremented, preventing the cmd from being freed
+			 * until SRR processing is done.
+			 */
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x1102e,
+			    "qla_target(%d): tag %lld: %s: SRR already scheduled\n",
+			    vha->vp_idx, cmd->se_cmd.tag, __func__);
+		} else {
+			struct qla_tgt *tgt = vha->vha_tgt.qla_tgt;
+			unsigned long flags;
+
+			/* Shedule processing for the SRR immediate notify. */
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x1102f,
+			    "qla_target(%d): tag %lld: %s: schedule SRR %s\n",
+			    vha->vp_idx, cmd->se_cmd.tag, __func__,
+			    reject ? "reject" : "abort");
+			cmd->srr = NULL;
+			srr->cmd = NULL;
+			spin_lock_irqsave(&tgt->srr_lock, flags);
+			list_add_tail(&srr->srr_list_entry, &tgt->srr_list);
+			queue_work(qla_tgt_wq, &tgt->srr_work);
+			spin_unlock_irqrestore(&tgt->srr_lock, flags);
+		}
+	} else {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11030,
+		    "qla_target(%d): tag %lld: %s: no IMM SRR; free SRR\n",
+		    vha->vp_idx, cmd->se_cmd.tag, __func__);
+		cmd->srr = NULL;
+		kfree(srr);
+	}
+}
+EXPORT_SYMBOL(qlt_srr_abort);
+
 /*
  * If hardware_lock held on entry, might drop it, then reaquire
  * This function sends the appropriate CTIO to ISP 2xxx or 24xx
@@ -3834,9 +3901,16 @@ void qlt_free_cmd(struct qla_tgt_cmd *cmd)
 		qlt_decr_num_pend_cmds(cmd->vha);
 
 	BUG_ON(cmd->sg_mapped);
+	if (unlikely(cmd->free_sg)) {
+		cmd->free_sg = 0;
+		qlt_free_sg(cmd);
+	}
+	if (unlikely(cmd->srr))
+		qlt_srr_abort(cmd, false);
 
 	if (unlikely(cmd->aborted ||
 		     (cmd->trc_flags & (TRC_CTIO_IGNORED | TRC_CTIO_STRANGE |
+					TRC_SRR_CTIO | TRC_SRR_IMM |
 					TRC_CTIO_ERR)))) {
 		ql_dbg(ql_dbg_tgt_mgt, cmd->vha, 0xe086,
 		    "qla_target(%d): tag %lld: free cmd (trc_flags %x, aborted %u, sent_term_exchg %u, rsp_sent %u)\n",
@@ -3861,6 +3935,62 @@ void qlt_free_cmd(struct qla_tgt_cmd *cmd)
 }
 EXPORT_SYMBOL(qlt_free_cmd);
 
+/*
+ * Process a CTIO response for a SCSI command that failed due to SRR.
+ *
+ * qpair->qp_lock_ptr supposed to be held on entry
+ */
+static int qlt_prepare_srr_ctio(struct qla_qpair *qpair,
+	struct qla_tgt_cmd *cmd)
+{
+	struct scsi_qla_host *vha = cmd->vha;
+	struct qla_tgt *tgt = vha->vha_tgt.qla_tgt;
+	struct qla_tgt_srr *srr;
+
+	cmd->trc_flags |= TRC_SRR_CTIO;
+
+	srr = cmd->srr;
+	if (srr != NULL) {
+		/* qlt_prepare_srr_imm() was called first. */
+
+		WARN_ON(srr->ctio_recvd);
+		WARN_ON(!srr->imm_ntfy_recvd);
+
+		if (vha->hw->tgt.tgt_ops->get_cmd_ref(cmd)) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11037,
+			    "qla_target(%d): tag %lld: unable to get cmd ref for SRR processing\n",
+			    vha->vp_idx, cmd->se_cmd.tag);
+			qlt_srr_abort(cmd, true);
+			return -ESHUTDOWN;
+		}
+
+		srr->ctio_recvd = true;
+
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1100f,
+		    "qla_target(%d): tag %lld: Scheduling SRR work\n",
+		    vha->vp_idx, cmd->se_cmd.tag);
+
+		/* Schedule the srr for processing in qlt_handle_srr(). */
+		/* IRQ is already OFF */
+		spin_lock(&tgt->srr_lock);
+		list_add_tail(&srr->srr_list_entry, &tgt->srr_list);
+		queue_work_on(cmd->se_cmd.cpuid, qla_tgt_wq, &tgt->srr_work);
+		spin_unlock(&tgt->srr_lock);
+		return 0;
+	}
+
+	srr = kzalloc(sizeof(*srr), GFP_ATOMIC);
+	if (!srr)
+		return -ENOMEM;
+
+	/* Expect qlt_prepare_srr_imm() to be called. */
+	srr->ctio_recvd = true;
+	srr->cmd = cmd;
+	srr->reset_count = cmd->reset_count;
+	cmd->srr = srr;
+	return 0;
+}
+
 /* ha->hardware_lock supposed to be held on entry */
 static void *qlt_ctio_to_cmd(struct scsi_qla_host *vha,
 	struct rsp_que *rsp, uint32_t handle, void *ctio)
@@ -4051,6 +4181,17 @@ static void qlt_do_ctio_completion(struct scsi_qla_host *vha,
 			break;
 		}
 
+		case CTIO_SRR_RECEIVED:
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x1100e,
+			    "qla_target(%d): tag %lld, op %x: CTIO with SRR status 0x%x received (state %d, port %8phC, LUN %lld, bufflen %d)\n",
+			    vha->vp_idx, cmd->se_cmd.tag, op, status,
+			    cmd->state, cmd->sess->port_name,
+			    cmd->unpacked_lun, cmd->bufflen);
+
+			if (qlt_prepare_srr_ctio(qpair, cmd) == 0)
+				return;
+			break;
+
 		case CTIO_DIF_ERROR: {
 			struct ctio_crc_from_fw *crc =
 				(struct ctio_crc_from_fw *)ctio;
@@ -4103,6 +4244,15 @@ static void qlt_do_ctio_completion(struct scsi_qla_host *vha,
 			qlt_send_term_exchange(qpair, cmd, &cmd->atio, 1);
 	}
 
+	if (unlikely(cmd->srr != NULL)) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11031,
+		    "qla_target(%d): tag %lld, op %x: expected CTIO with SRR status; got status 0x%x: state %d, bufflen %d\n",
+		    vha->vp_idx, cmd->se_cmd.tag,
+		    cmd->cdb ? cmd->cdb[0] : 0, status, cmd->state,
+		    cmd->bufflen);
+		qlt_srr_abort(cmd, true);
+	}
+
 	if (cmd->state == QLA_TGT_STATE_PROCESSED) {
 		cmd->trc_flags |= TRC_CTIO_DONE;
 
@@ -4115,6 +4265,7 @@ static void qlt_do_ctio_completion(struct scsi_qla_host *vha,
 		if (status == CTIO_SUCCESS)
 			cmd->write_data_transferred = 1;
 
+		cmd->jiffies_at_hw_st_entry = 0;
 		ha->tgt.tgt_ops->handle_data(cmd);
 		return;
 	} else if (cmd->aborted) {
@@ -5015,6 +5166,851 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 	return res;
 }
 
+/*
+ * Return true if the HBA firmware version is known to have bugs that
+ * prevent Sequence Level Error Recovery (SLER) / Sequence Retransmission
+ * Request (SRR) from working.
+ */
+static bool qlt_has_sler_fw_bug(struct qla_hw_data *ha)
+{
+	bool has_sler_fw_bug = false;
+
+	if (IS_QLA2071(ha)) {
+		/*
+		 * QLE2694L known bad firmware:
+		 *   9.06.02
+		 *   9.07.00
+		 *   9.08.02
+		 *   SRRs trigger hundreds of bogus entries in the response
+		 *   queue and various other problems.
+		 *
+		 * QLE2694L known good firmware:
+		 *   8.08.05
+		 *   9.09.00
+		 *
+		 * QLE2694L unknown firmware:
+		 *   9.00.00 - 9.05.xx
+		 */
+		if (ha->fw_major_version == 9 &&
+		    ha->fw_minor_version >= 6 &&
+		    ha->fw_minor_version <= 8)
+			has_sler_fw_bug = true;
+	}
+
+	return has_sler_fw_bug;
+}
+
+/*
+ * Return true and print a message if the HA has been reset since the SRR
+ * immediate notify was received; else return false.
+ */
+static bool qlt_srr_is_chip_reset(struct scsi_qla_host *vha,
+	struct qla_qpair *qpair, struct qla_tgt_srr *srr)
+{
+	if (!vha->flags.online ||
+	    !qpair->fw_started ||
+	    srr->reset_count != qpair->chip_reset) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1100d,
+		    "qla_target(%d): chip reset; discarding IMM SRR\n",
+		    vha->vp_idx);
+		return true;
+	}
+	return false;
+}
+
+/* Find and return the command associated with a SRR immediate notify. */
+static struct qla_tgt_cmd *qlt_srr_to_cmd(struct scsi_qla_host *vha,
+	const struct imm_ntfy_from_isp *iocb)
+{
+	struct qla_hw_data *ha = vha->hw;
+	struct fc_port *sess;
+	struct qla_tgt_cmd *cmd;
+	uint32_t tag = le32_to_cpu(iocb->u.isp24.exchange_address);
+	uint16_t loop_id;
+	be_id_t s_id;
+	unsigned long flags;
+
+	if (tag == ATIO_EXCHANGE_ADDRESS_UNKNOWN) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11009,
+		    "qla_target(%d): IMM SRR with unknown exchange address; reject SRR\n",
+		    vha->vp_idx);
+		return NULL;
+	}
+
+	loop_id = le16_to_cpu(iocb->u.isp24.nport_handle);
+
+	s_id.domain = iocb->u.isp24.port_id[2];
+	s_id.area   = iocb->u.isp24.port_id[1];
+	s_id.al_pa  = iocb->u.isp24.port_id[0];
+
+	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha, s_id);
+	if (!sess)
+		sess = ha->tgt.tgt_ops->find_sess_by_loop_id(vha, loop_id);
+	if (!sess || sess->deleted) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1100a,
+		    "qla_target(%d): could not find session for IMM SRR; reject SRR\n",
+		    vha->vp_idx);
+		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+		return NULL;
+	}
+	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+
+	cmd = ha->tgt.tgt_ops->find_cmd_by_tag(sess, tag);
+	if (!cmd) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1100b,
+		    "qla_target(%d): could not find cmd for IMM SRR; reject SRR\n",
+		    vha->vp_idx);
+	} else {
+		u16 srr_ox_id = le16_to_cpu(iocb->u.isp24.srr_ox_id);
+		u16 cmd_ox_id = be16_to_cpu(cmd->atio.u.isp24.fcp_hdr.ox_id);
+
+		if (srr_ox_id != cmd_ox_id) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x1100c,
+			    "qla_target(%d): tag %lld: IMM SRR: srr_ox_id[%04x] != cmd_ox_id[%04x]; reject SRR\n",
+			    vha->vp_idx, cmd->se_cmd.tag,
+			    srr_ox_id, cmd_ox_id);
+			cmd = NULL;
+		}
+	}
+
+	return cmd;
+}
+
+/*
+ * Handle an immediate notify SRR (Sequence Retransmission Request) message from
+ * the hardware.  The hardware will also send a CTIO with CTIO_SRR_RECEIVED status
+ * for the affected command.
+ *
+ * This may be called a second time for the same immediate notify SRR if
+ * CTIO_SRR_RECEIVED is never received and qlt_srr_abort() is called.
+ *
+ * Process context, no locks
+ */
+static void qlt_handle_srr_imm(struct scsi_qla_host *vha,
+	struct qla_tgt_srr *srr)
+{
+	struct qla_tgt *tgt = vha->vha_tgt.qla_tgt;
+	struct qla_hw_data *ha = vha->hw;
+	struct qla_qpair *qpair;
+	struct qla_tgt_cmd *cmd;
+	uint8_t srr_explain = NOTIFY_ACK_SRR_FLAGS_REJECT_EXPL_NO_EXPL;
+
+	/* handle qlt_srr_abort() */
+	if (srr->aborted) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11004,
+		    "qla_target(%d): IMM SRR: terminating SRR for aborted cmd\n",
+		    vha->vp_idx);
+		spin_lock_irq(&ha->hardware_lock);
+		if (!qlt_srr_is_chip_reset(vha, ha->base_qpair, srr))
+			qlt_send_term_imm_notif(vha, &srr->imm_ntfy, 1);
+		spin_unlock_irq(&ha->hardware_lock);
+		kfree(srr);
+		return;
+	}
+	if (srr->reject) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11005,
+		    "qla_target(%d): IMM SRR: rejecting SRR for unknown cmd\n",
+		    vha->vp_idx);
+		goto out_reject;
+	}
+
+	/* Find the command associated with the SRR. */
+	cmd = qlt_srr_to_cmd(vha, &srr->imm_ntfy);
+	if (cmd == NULL) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11005,
+		    "qla_target(%d): IMM SRR: rejecting SRR for unknown cmd\n",
+		    vha->vp_idx);
+		srr_explain = NOTIFY_ACK_SRR_FLAGS_REJECT_EXPL_INVALID_OX_ID_RX_ID;
+		goto out_reject;
+	}
+
+	if (ha->tgt.tgt_ops->get_cmd_ref(cmd)) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11038,
+		    "qla_target(%d): IMM SRR: unable to get cmd ref; rejecting SRR\n",
+		    vha->vp_idx);
+		cmd = NULL;
+		goto out_reject;
+	}
+
+	qpair = cmd->qpair;
+
+	spin_lock_irq(qpair->qp_lock_ptr);
+
+	if (cmd->reset_count != srr->reset_count) {
+		/* force a miscompare */
+		srr->reset_count = qpair->chip_reset ^ 1;
+	}
+	if (qlt_srr_is_chip_reset(vha, qpair, srr)) {
+		spin_unlock_irq(qpair->qp_lock_ptr);
+		ha->tgt.tgt_ops->put_cmd_ref(cmd);
+		kfree(srr);
+		return;
+	}
+
+	ql_dbg(ql_dbg_tgt_mgt, vha, 0x11001,
+	    "qla_target(%d): tag %lld, op %x: received IMM SRR\n",
+	    vha->vp_idx, cmd->se_cmd.tag, cmd->cdb ? cmd->cdb[0] : 0);
+
+	cmd->trc_flags |= TRC_SRR_IMM;
+
+	if (cmd->srr != NULL) {
+		if (cmd->srr->imm_ntfy_recvd) {
+			/*
+			 * Received another immediate notify SRR message for
+			 * this command before the previous one could be processed
+			 * (not expected to happen).
+			 */
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11006,
+			    "qla_target(%d): tag %lld: received multiple IMM SRR; reject SRR\n",
+			    vha->vp_idx, cmd->se_cmd.tag);
+			spin_unlock_irq(qpair->qp_lock_ptr);
+			ha->tgt.tgt_ops->put_cmd_ref(cmd);
+			goto out_reject;
+		}
+
+		/* qlt_prepare_srr_ctio() was called first. */
+		WARN_ON(!cmd->srr->ctio_recvd);
+
+		/*
+		 * The immediate notify and CTIO handlers both allocated
+		 * separate srr structs; combine them.
+		 */
+		memcpy(&cmd->srr->imm_ntfy, &srr->imm_ntfy,
+		       sizeof(srr->imm_ntfy));
+		kfree(srr);
+		srr = cmd->srr;
+		srr->imm_ntfy_recvd = true;
+
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11002,
+		    "qla_target(%d): tag %lld: schedule SRR work\n",
+		    vha->vp_idx, cmd->se_cmd.tag);
+
+		/* Schedule the srr for processing in qlt_handle_srr(). */
+		spin_lock(&tgt->srr_lock);
+		list_add_tail(&srr->srr_list_entry, &tgt->srr_list);
+		/*
+		 * Already running the work function; no need to schedule
+		 * tgt->srr_work.
+		 */
+		spin_unlock(&tgt->srr_lock);
+		spin_unlock_irq(qpair->qp_lock_ptr);
+		/* return with cmd refcount incremented */
+		return;
+	}
+
+	/* The CTIO SRR for this command has not yet been received. */
+
+	if (cmd->sent_term_exchg) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11007,
+		    "qla_target(%d): tag %lld: IMM SRR: cmd already aborted\n",
+		    vha->vp_idx, cmd->se_cmd.tag);
+		spin_unlock_irq(qpair->qp_lock_ptr);
+		spin_lock_irq(&ha->hardware_lock);
+		if (!qlt_srr_is_chip_reset(vha, ha->base_qpair, srr))
+			qlt_send_term_imm_notif(vha, &srr->imm_ntfy, 1);
+		spin_unlock_irq(&ha->hardware_lock);
+		kfree(srr);
+		ha->tgt.tgt_ops->put_cmd_ref(cmd);
+		return;
+	}
+
+	/* If not expecting a CTIO, then reject IMM SRR. */
+	if (!cmd->cmd_sent_to_fw) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11008,
+		    "qla_target(%d): tag %lld: IMM SRR but !cmd_sent_to_fw (state %d); reject SRR\n",
+		    vha->vp_idx, cmd->se_cmd.tag, cmd->state);
+		spin_unlock_irq(qpair->qp_lock_ptr);
+		ha->tgt.tgt_ops->put_cmd_ref(cmd);
+		goto out_reject;
+	}
+
+	/* Expect qlt_prepare_srr_ctio() to be called. */
+	ql_dbg(ql_dbg_tgt_mgt, vha, 0x11003,
+	    "qla_target(%d): tag %lld: wait for CTIO SRR (state %d)\n",
+	    vha->vp_idx, cmd->se_cmd.tag, cmd->state);
+	srr->cmd = cmd;
+	cmd->srr = srr;
+
+	spin_unlock_irq(qpair->qp_lock_ptr);
+
+	ha->tgt.tgt_ops->put_cmd_ref(cmd);
+	return;
+
+out_reject:
+	qpair = vha->hw->base_qpair;
+	spin_lock_irq(qpair->qp_lock_ptr);
+	if (!qlt_srr_is_chip_reset(vha, qpair, srr))
+		qlt_send_notify_ack(qpair, &srr->imm_ntfy, 0, 0, 0,
+		    NOTIFY_ACK_SRR_FLAGS_REJECT,
+		    NOTIFY_ACK_SRR_REJECT_REASON_UNABLE_TO_PERFORM,
+		    srr_explain);
+	spin_unlock_irq(qpair->qp_lock_ptr);
+	kfree(srr);
+}
+
+/*
+ * Handle an immediate notify SRR (Sequence Retransmission Request) message from
+ * the hardware.  The hardware will also send a CTIO with CTIO_SRR_RECEIVED status
+ * for the affected command.
+ *
+ * ha->hardware_lock supposed to be held on entry
+ */
+static void qlt_prepare_srr_imm(struct scsi_qla_host *vha,
+	struct imm_ntfy_from_isp *iocb)
+{
+	struct qla_tgt *tgt = vha->vha_tgt.qla_tgt;
+	struct qla_tgt_srr *srr;
+
+	ql_log(ql_log_warn, vha, 0x11000, "qla_target(%d): received IMM SRR\n",
+	    vha->vp_idx);
+
+	/*
+	 * Need cmd->qpair->qp_lock_ptr, but have ha->hardware_lock.  Defer
+	 * processing to a workqueue so that the right lock can be acquired
+	 * safely.
+	 */
+
+	srr = kzalloc(sizeof(*srr), GFP_ATOMIC);
+	if (!srr)
+		goto out_reject;
+
+	memcpy(&srr->imm_ntfy, iocb, sizeof(srr->imm_ntfy));
+	srr->imm_ntfy_recvd = true;
+	srr->reset_count = vha->hw->base_qpair->chip_reset;
+	spin_lock(&tgt->srr_lock);
+	list_add_tail(&srr->srr_list_entry, &tgt->srr_list);
+	queue_work(qla_tgt_wq, &tgt->srr_work);
+	spin_unlock(&tgt->srr_lock);
+	/* resume processing in qlt_handle_srr_imm() */
+	return;
+
+out_reject:
+	qlt_send_notify_ack(vha->hw->base_qpair, iocb, 0, 0, 0,
+	    NOTIFY_ACK_SRR_FLAGS_REJECT,
+	    NOTIFY_ACK_SRR_REJECT_REASON_UNABLE_TO_PERFORM,
+	    NOTIFY_ACK_SRR_FLAGS_REJECT_EXPL_NO_EXPL);
+}
+
+/*
+ * If possible, undo the effect of qlt_set_data_offset() and restore the cmd
+ * data buffer back to its full size.
+ */
+static int qlt_restore_orig_sg(struct qla_tgt_cmd *cmd)
+{
+	struct scsi_qla_host *vha = cmd->vha;
+	struct se_cmd *se_cmd = &cmd->se_cmd;
+
+	WARN_ON(cmd->sg_mapped);
+
+	if (cmd->offset == 0) {
+		/* qlt_set_data_offset() has not been called. */
+		return 0;
+	}
+
+	if (se_cmd->t_data_sg == NULL ||
+	    se_cmd->t_data_nents == 0 ||
+	    se_cmd->data_length == 0) {
+		/* The original scatterlist is not available. */
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1102c,
+		    "qla_target(%d): tag %lld: cannot restore original cmd buffer; keep modified buffer at offset %d\n",
+		    vha->vp_idx, cmd->se_cmd.tag, cmd->offset);
+		return -ENOENT;
+	}
+
+	/* Restore the original scatterlist. */
+	ql_dbg(ql_dbg_tgt_mgt, vha, 0x1102d,
+	    "qla_target(%d): tag %lld: restore original cmd buffer: offset %d -> 0\n",
+	    vha->vp_idx, cmd->se_cmd.tag, cmd->offset);
+	if (cmd->free_sg) {
+		cmd->free_sg = 0;
+		qlt_free_sg(cmd);
+	}
+	cmd->offset = 0;
+	cmd->sg = se_cmd->t_data_sg;
+	cmd->sg_cnt = se_cmd->t_data_nents;
+	cmd->bufflen = se_cmd->data_length;
+	return 0;
+}
+
+/*
+ * Adjust the data buffer of the given command to skip over offset bytes from
+ * the beginning while also reducing the length by offset bytes.
+ *
+ * This may be called multiple times for a single command if there are multiple
+ * SRRs, which each call reducing the buffer size further relative to the
+ * previous call.  Note that the buffer may be reset back to its original size
+ * by calling qlt_restore_orig_sg().
+ */
+static int qlt_set_data_offset(struct qla_tgt_cmd *cmd, uint32_t offset)
+{
+	struct scsi_qla_host *vha = cmd->vha;
+	struct scatterlist *sg_srr_start = NULL, *sg;
+	uint32_t first_offset = offset;
+	int sg_srr_cnt, i;
+	int bufflen = 0;
+
+	WARN_ON(cmd->sg_mapped);
+
+	ql_dbg(ql_dbg_tgt, vha, 0x11020,
+	    "qla_target(%d): tag %lld: %s: sg %p sg_cnt %d dir %d cmd->offset %d cmd->bufflen %d add offset %u\n",
+	    vha->vp_idx, cmd->se_cmd.tag, __func__, cmd->sg,
+	    cmd->sg_cnt, cmd->dma_data_direction, cmd->offset, cmd->bufflen,
+	    offset);
+
+	if (cmd->se_cmd.prot_op != TARGET_PROT_NORMAL) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11021,
+		    "qla_target(%d): tag %lld: %s: SRR with protection information at nonzero offset not implemented\n",
+		    vha->vp_idx, cmd->se_cmd.tag, __func__);
+		return -EINVAL;
+	}
+
+	if (!cmd->sg || !cmd->sg_cnt) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11022,
+		    "qla_target(%d): tag %lld: %s: Missing cmd->sg or zero cmd->sg_cnt\n",
+		    vha->vp_idx, cmd->se_cmd.tag, __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * Walk the current cmd->sg list until we locate the new sg_srr_start
+	 */
+	for_each_sg(cmd->sg, sg, cmd->sg_cnt, i) {
+		ql_dbg(ql_dbg_tgt, vha, 0x11023,
+		    "sg[%d]: %p page: %p, length: %d, offset: %d\n",
+		    i, sg, sg_page(sg), sg->length, sg->offset);
+
+		if (first_offset < sg->length) {
+			sg_srr_start = sg;
+			break;
+		}
+		first_offset -= sg->length;
+	}
+
+	if (!sg_srr_start) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11024,
+		    "qla_target(%d): tag %lld: Unable to locate sg_srr_start for offset: %u\n",
+		    vha->vp_idx, cmd->se_cmd.tag, offset);
+		return -EINVAL;
+	}
+
+	ql_dbg(ql_dbg_tgt_mgt, vha, 0x11025,
+	    "qla_target(%d): tag %lld: prepare SRR sgl at sg index %d of %d byte offset %u of %u\n",
+	    vha->vp_idx, cmd->se_cmd.tag, i, cmd->sg_cnt,
+	    first_offset, sg_srr_start->length);
+
+	sg_srr_cnt = cmd->sg_cnt - i;
+
+	if (first_offset == 0 && !cmd->free_sg) {
+		/*
+		 * The offset points to the beginning of a scatterlist element.
+		 * In this case there is no need to modify the first scatterlist
+		 * element, so we can just point directly inside the original
+		 * unmodified scatterlist.
+		 */
+		ql_dbg(ql_dbg_tgt, vha, 0x11026, "point directly to old sgl\n");
+		cmd->sg = sg_srr_start;
+	} else {
+		/*
+		 * Allocate at most 2 new scatterlist elements to reduce memory
+		 * requirements.
+		 */
+		int n_alloc_sg = min(sg_srr_cnt, 2);
+		struct scatterlist *sg_srr =
+			kmalloc_array(n_alloc_sg, sizeof(*sg_srr), GFP_ATOMIC);
+		if (!sg_srr) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11027,
+			    "qla_target(%d): tag %lld: Unable to allocate SRR scatterlist\n",
+			    vha->vp_idx, cmd->se_cmd.tag);
+			return -ENOMEM;
+		}
+		sg_init_table(sg_srr, n_alloc_sg);
+
+		/* Init the first sg element to skip over the unneeded data. */
+		sg_set_page(&sg_srr[0], sg_page(sg_srr_start),
+			    sg_srr_start->length - first_offset,
+			    sg_srr_start->offset + first_offset);
+		if (sg_srr_cnt == 1) {
+			ql_dbg(ql_dbg_tgt, vha, 0x11028,
+			    "single-element array\n");
+		} else if (sg_srr_cnt == 2) {
+			/* Only two elements; copy the last element. */
+			ql_dbg(ql_dbg_tgt, vha, 0x11029,
+			    "complete two-element array\n");
+			sg = sg_next(sg_srr_start);
+			sg_set_page(&sg_srr[1], sg_page(sg), sg->length,
+				    sg->offset);
+		} else {
+			/*
+			 * Three or more elements; chain our newly-allocated
+			 * 2-entry array to the rest of the original
+			 * scatterlist at the splice point.
+			 */
+			ql_dbg(ql_dbg_tgt, vha, 0x1102a,
+			    "chain to original scatterlist\n");
+			sg = sg_next(sg_srr_start);
+			sg_chain(sg_srr, 2, sg);
+		}
+
+		/*
+		 * If the previous scatterlist was allocated here on a previous
+		 * call, then it should be safe to free now.
+		 */
+		if (cmd->free_sg)
+			qlt_free_sg(cmd);
+		cmd->sg = sg_srr;
+		cmd->free_sg = 1;
+	}
+
+	/* Note that sg_cnt doesn't include any extra chain elements. */
+	cmd->sg_cnt = sg_srr_cnt;
+	cmd->offset += offset;
+	cmd->bufflen -= offset;
+
+	/* Check the scatterlist length for consistency. */
+	for_each_sg(cmd->sg, sg, cmd->sg_cnt, i) {
+		bufflen += sg->length;
+	}
+	if (bufflen != cmd->bufflen) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1102b,
+		    "qla_target(%d): tag %lld: %s: bad sgl length: expected %d got %d\n",
+		    vha->vp_idx, cmd->se_cmd.tag, __func__, cmd->bufflen, bufflen);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Given the "SRR relative offset" (offset of data to retry), determine what
+ * needs to be retransmitted (data and/or status) and return the mask in
+ * xmit_type.  If retrying data, adjust the command buffer to point to only the
+ * data that need to be retried, skipping over the data that don't need to be
+ * retried.
+ *
+ * Returns 0 for success or a negative error number.
+ */
+static inline int qlt_srr_adjust_data(struct qla_tgt_cmd *cmd,
+	uint32_t srr_rel_offs, int *xmit_type)
+{
+	struct scsi_qla_host *vha = cmd->vha;
+	int res = 0, rel_offs;
+
+	if (srr_rel_offs < cmd->offset ||
+	    srr_rel_offs > cmd->offset + cmd->bufflen) {
+		*xmit_type = 0;
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1101e,
+		    "qla_target(%d): tag %lld: srr_rel_offs %u outside accepted range %u - %u\n",
+		    vha->vp_idx, cmd->se_cmd.tag, srr_rel_offs,
+		    cmd->offset, cmd->offset + cmd->bufflen);
+		return -EINVAL;
+	}
+
+	/*
+	 * srr_rel_offs is the offset of the data we need from the beginning of
+	 * the *original* buffer.
+	 *
+	 * cmd->offset is the offset of the current cmd scatterlist from the
+	 * beginning of the *original* buffer, which might be nonzero if there
+	 * was a previous SRR and the buffer could not be reset back to its
+	 * original size.
+	 *
+	 * rel_offs is the offset of the data we need from the beginning of the
+	 * current cmd scatterlist.
+	 */
+	rel_offs = srr_rel_offs - cmd->offset;
+
+	ql_dbg(ql_dbg_tgt_mgt, vha, 0x1101f,
+	    "qla_target(%d): tag %lld: current buffer [%u - %u); srr_rel_offs=%d, rel_offs=%d\n",
+	    vha->vp_idx, cmd->se_cmd.tag, cmd->offset,
+	    cmd->offset + cmd->bufflen, srr_rel_offs, rel_offs);
+
+	*xmit_type = QLA_TGT_XMIT_ALL;
+
+	if (rel_offs == cmd->bufflen)
+		*xmit_type = QLA_TGT_XMIT_STATUS;
+	else if (rel_offs > 0)
+		res = qlt_set_data_offset(cmd, rel_offs);
+
+	return res;
+}
+
+/*
+ * Process a SRR (Sequence Retransmission Request) for a SCSI command once both
+ * the immediate notify SRR and CTIO SRR have been received from the hw.
+ *
+ * Process context, no locks
+ */
+static void qlt_handle_srr(struct scsi_qla_host *vha, struct qla_tgt_srr *srr)
+{
+	struct qla_tgt_cmd *cmd = srr->cmd;
+	struct se_cmd *se_cmd = &cmd->se_cmd;
+	struct qla_qpair *qpair = cmd->qpair;
+	struct qla_hw_data *ha = vha->hw;
+	uint8_t op = cmd->cdb ? cmd->cdb[0] : 0;
+	uint32_t srr_rel_offs = le32_to_cpu(srr->imm_ntfy.u.isp24.srr_rel_offs);
+	uint16_t srr_ui = le16_to_cpu(srr->imm_ntfy.u.isp24.srr_ui);
+	int xmit_type = 0;
+	bool xmit_response = false;
+	bool rdy_to_xfer = false;
+	bool did_timeout;
+	bool send_term_exch = false;
+
+	spin_lock_irq(qpair->qp_lock_ptr);
+
+	WARN_ON(cmd->cmd_sent_to_fw);
+
+	cmd->srr = NULL;
+
+	if (qlt_srr_is_chip_reset(vha, qpair, srr))
+		goto out_advance_cmd;
+
+	if (cmd->sent_term_exchg || cmd->sess->deleted || srr->aborted) {
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11010,
+		    "qla_target(%d): tag %lld: IMM SRR: cmd already aborted\n",
+		    vha->vp_idx, cmd->se_cmd.tag);
+
+		spin_unlock_irq(qpair->qp_lock_ptr);
+
+		spin_lock_irq(&ha->hardware_lock);
+		if (!qlt_srr_is_chip_reset(vha, ha->base_qpair, srr))
+			qlt_send_term_imm_notif(vha, &srr->imm_ntfy, 1);
+		spin_unlock_irq(&ha->hardware_lock);
+
+		send_term_exch = true;
+
+		spin_lock_irq(qpair->qp_lock_ptr);
+		goto out_advance_cmd;
+	}
+
+	if (srr->reject)
+		goto out_reject;
+
+	/*
+	 * If we receive multiple SRRs for the same command, place a time limit
+	 * on how long we are willing to retry.  This timeout should be less
+	 * than SQA_MAX_HW_PENDING_TIME in scst_qla2xxx.c.
+	 */
+	did_timeout = time_is_before_jiffies64((cmd->jiffies_at_hw_st_entry ? :
+		cmd->jiffies_at_alloc) + 30 * HZ);
+
+	qlt_restore_orig_sg(cmd);
+
+	switch (srr_ui) {
+	case SRR_IU_STATUS:
+		if (cmd->state != QLA_TGT_STATE_PROCESSED) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11011,
+			    "qla_target(%d): tag %lld, op %x: reject SRR_IU_STATUS due to unexpected state %d\n",
+			    vha->vp_idx, se_cmd->tag, op,
+			    cmd->state);
+			goto out_reject;
+		}
+
+		if (did_timeout) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11033,
+			    "qla_target(%d): tag %lld, op %x: reject SRR_IU_STATUS due to timeout\n",
+			    vha->vp_idx, se_cmd->tag, op);
+			goto out_reject;
+		}
+
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11012,
+		    "qla_target(%d): tag %lld, op %x: accept SRR_IU_STATUS and retransmit scsi_status=%x\n",
+		    vha->vp_idx, se_cmd->tag, op,
+		    se_cmd->scsi_status);
+		xmit_type = QLA_TGT_XMIT_STATUS;
+		xmit_response = true;
+		cmd->trc_flags |= TRC_SRR_RSP;
+		break;
+
+	case SRR_IU_DATA_IN:
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11013,
+		    "qla_target(%d): tag %lld, op %x: process SRR_IU_DATA_IN: bufflen=%d, sg_cnt=%d, offset=%d, srr_offset=%d, scsi_status=%x\n",
+		    vha->vp_idx, se_cmd->tag, op, cmd->bufflen,
+		    cmd->sg_cnt, cmd->offset, srr_rel_offs,
+		    se_cmd->scsi_status);
+
+		if (cmd->state != QLA_TGT_STATE_PROCESSED) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11014,
+			    "qla_target(%d): tag %lld: reject SRR_IU_DATA_IN due to unexpected state %d\n",
+			    vha->vp_idx, se_cmd->tag, cmd->state);
+			goto out_reject;
+		}
+
+		/*
+		 * QLA_TGT_STATE_PROCESSED does not necessarily imply data-in
+		 */
+		if (!qlt_has_data(cmd)) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11015,
+			    "qla_target(%d): tag %lld: reject SRR_IU_DATA_IN because cmd has no data to send\n",
+			    vha->vp_idx, se_cmd->tag);
+			goto out_reject;
+		}
+
+		if (!cmd->sg || !cmd->sg_cnt) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11016,
+			    "qla_target(%d): tag %lld: reject SRR_IU_DATA_IN because buffer is missing\n",
+			    vha->vp_idx, se_cmd->tag);
+			goto out_reject;
+		}
+
+		if (did_timeout) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11034,
+			    "qla_target(%d): tag %lld, op %x: reject SRR_IU_DATA_IN due to timeout\n",
+			    vha->vp_idx, se_cmd->tag, op);
+			goto out_reject;
+		}
+
+		if (qlt_srr_adjust_data(cmd, srr_rel_offs, &xmit_type) != 0)
+			goto out_reject;
+
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11017,
+		    "qla_target(%d): tag %lld: accept SRR_IU_DATA_IN and retransmit data: bufflen=%d, offset=%d\n",
+		    vha->vp_idx, se_cmd->tag, cmd->bufflen,
+		    cmd->offset);
+		xmit_response = true;
+		cmd->trc_flags |= TRC_SRR_RSP;
+		break;
+
+	case SRR_IU_DATA_OUT:
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x11018,
+		    "qla_target(%d): tag %lld, op %x: process SRR_IU_DATA_OUT: bufflen=%d, sg_cnt=%d, offset=%d, srr_offset=%d\n",
+		    vha->vp_idx, se_cmd->tag, op, cmd->bufflen,
+		    cmd->sg_cnt, cmd->offset, srr_rel_offs);
+
+		if (cmd->state != QLA_TGT_STATE_NEED_DATA) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11019,
+			    "qla_target(%d): tag %lld: reject SRR_IU_DATA_OUT due to unexpected state %d\n",
+			    vha->vp_idx, se_cmd->tag, cmd->state);
+			goto out_reject;
+		}
+
+		/*
+		 * QLA_TGT_STATE_NEED_DATA implies there should be data-out
+		 */
+		if (!qlt_has_data(cmd) || !cmd->sg || !cmd->sg_cnt) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x1101a,
+			    "qla_target(%d): tag %lld: reject SRR_IU_DATA_OUT because buffer is missing\n",
+			    vha->vp_idx, se_cmd->tag);
+			goto out_reject;
+		}
+
+		if (did_timeout) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x11035,
+			    "qla_target(%d): tag %lld, op %x: reject SRR_IU_DATA_OUT due to timeout\n",
+			    vha->vp_idx, se_cmd->tag, op);
+			goto out_reject;
+		}
+
+		if (qlt_srr_adjust_data(cmd, srr_rel_offs, &xmit_type) != 0)
+			goto out_reject;
+
+		if (!(xmit_type & QLA_TGT_XMIT_DATA)) {
+			ql_dbg(ql_dbg_tgt_mgt, vha, 0x1101b,
+			    "qla_target(%d): tag %lld: reject SRR_IU_DATA_OUT: bad offset\n",
+			    vha->vp_idx, se_cmd->tag);
+			goto out_reject;
+		}
+
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1101c,
+		    "qla_target(%d): tag %lld: accept SRR_IU_DATA_OUT and receive data again: bufflen=%d, offset=%d\n",
+		    vha->vp_idx, se_cmd->tag, cmd->bufflen,
+		    cmd->offset);
+		cmd->trc_flags |= TRC_SRR_XRDY;
+		rdy_to_xfer = true;
+		break;
+
+	default:
+		ql_dbg(ql_dbg_tgt_mgt, vha, 0x1101d,
+		    "qla_target(%d): tag %lld, op %x: reject unknown srr_ui value 0x%x: state=%d, bufflen=%d, offset=%d, srr_offset=%d\n",
+		    vha->vp_idx, se_cmd->tag, op, srr_ui, cmd->state,
+		    cmd->bufflen, cmd->offset, srr_rel_offs);
+		goto out_reject;
+	}
+
+	qlt_send_notify_ack(qpair, &srr->imm_ntfy, 0, 0, 0,
+		NOTIFY_ACK_SRR_FLAGS_ACCEPT, 0, 0);
+
+	spin_unlock_irq(qpair->qp_lock_ptr);
+
+	if (xmit_response) {
+		/* For status and data-in, retransmit the response. */
+		if (qlt_xmit_response(cmd, xmit_type, se_cmd->scsi_status)) {
+			send_term_exch = true;
+			spin_lock_irq(qpair->qp_lock_ptr);
+			goto out_advance_cmd;
+		}
+	} else if (rdy_to_xfer) {
+		/* For data-out, receive data again. */
+		if (qlt_rdy_to_xfer(cmd)) {
+			send_term_exch = true;
+			spin_lock_irq(qpair->qp_lock_ptr);
+			goto out_advance_cmd;
+		}
+	}
+
+	return;
+
+out_reject:
+	qlt_send_notify_ack(qpair, &srr->imm_ntfy, 0, 0, 0,
+	    NOTIFY_ACK_SRR_FLAGS_REJECT,
+	    NOTIFY_ACK_SRR_REJECT_REASON_UNABLE_TO_PERFORM,
+	    NOTIFY_ACK_SRR_FLAGS_REJECT_EXPL_NO_EXPL);
+
+out_advance_cmd:
+	if (!cmd->sent_term_exchg &&
+	    (send_term_exch || cmd->state != QLA_TGT_STATE_NEED_DATA) &&
+	    !qlt_srr_is_chip_reset(vha, qpair, srr)) {
+		cmd->trc_flags |= TRC_SRR_TERM;
+		qlt_send_term_exchange(qpair, cmd, &cmd->atio, 1);
+	}
+	if (cmd->state == QLA_TGT_STATE_NEED_DATA) {
+		/*
+		 * The initiator should abort the command, but if not, try to
+		 * return an error.
+		 */
+		cmd->srr_failed = 1;
+		cmd->write_data_transferred = 0;
+		cmd->state = QLA_TGT_STATE_DATA_IN;
+		cmd->jiffies_at_hw_st_entry = 0;
+		vha->hw->tgt.tgt_ops->handle_data(cmd);
+	} else {
+		vha->hw->tgt.tgt_ops->free_cmd(cmd);
+	}
+	spin_unlock_irq(qpair->qp_lock_ptr);
+}
+
+/* Workqueue function for processing SRR work in process context. */
+static void qlt_handle_srr_work(struct work_struct *work)
+{
+	struct qla_tgt *tgt = container_of(work, struct qla_tgt, srr_work);
+	struct scsi_qla_host *vha = tgt->vha;
+
+	ql_dbg(ql_dbg_tgt_mgt, vha, 0x11032,
+	    "qla_target(%d): Entering SRR work\n", vha->vp_idx);
+
+	for (;;) {
+		struct qla_tgt_srr *srr;
+
+		spin_lock_irq(&tgt->srr_lock);
+		srr = list_first_entry_or_null(&tgt->srr_list, typeof(*srr),
+			srr_list_entry);
+		if (!srr) {
+			spin_unlock_irq(&tgt->srr_lock);
+			break;
+		}
+		list_del(&srr->srr_list_entry);
+		spin_unlock_irq(&tgt->srr_lock);
+
+		if (!srr->cmd) {
+			qlt_handle_srr_imm(vha, srr);
+		} else {
+			qlt_handle_srr(vha, srr);
+			vha->hw->tgt.tgt_ops->put_cmd_ref(srr->cmd);
+			kfree(srr);
+		}
+	}
+}
+
 /*
  * ha->hardware_lock supposed to be held on entry. Might drop it, then reaquire
  */
@@ -5442,6 +6438,11 @@ static void qlt_handle_imm_notify(struct scsi_qla_host *vha,
 			send_notify_ack = 0;
 		break;
 
+	case IMM_NTFY_SRR:
+		qlt_prepare_srr_imm(vha, iocb);
+		send_notify_ack = 0;
+		break;
+
 	default:
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf06d,
 		    "qla_target(%d): Received unknown immediate "
@@ -6422,6 +7423,9 @@ int qlt_add_target(struct qla_hw_data *ha, struct scsi_qla_host *base_vha)
 	spin_lock_init(&tgt->sess_work_lock);
 	INIT_WORK(&tgt->sess_work, qlt_sess_work_fn);
 	INIT_LIST_HEAD(&tgt->sess_works_list);
+	spin_lock_init(&tgt->srr_lock);
+	INIT_LIST_HEAD(&tgt->srr_list);
+	INIT_WORK(&tgt->srr_work, qlt_handle_srr_work);
 	atomic_set(&tgt->tgt_global_resets_count, 0);
 
 	base_vha->vha_tgt.qla_tgt = tgt;
@@ -7070,6 +8074,32 @@ qlt_81xx_config_nvram_stage2(struct scsi_qla_host *vha,
 	}
 }
 
+/* Update any settings that depend on ha->fw_*_version. */
+void
+qlt_config_nvram_with_fw_version(struct scsi_qla_host *vha)
+{
+	struct qla_hw_data *ha = vha->hw;
+
+	if (!QLA_TGT_MODE_ENABLED())
+		return;
+
+	if (ql2xtgt_tape_enable && qlt_has_sler_fw_bug(ha)) {
+		ql_log(ql_log_warn, vha, 0x11036,
+		    "WARNING: ignoring ql2xtgt_tape_enable due to buggy HBA firmware; please upgrade FW\n");
+
+		/* Disable FC Tape support */
+		if (ha->isp_ops->nvram_config == qla81xx_nvram_config) {
+			struct init_cb_81xx *icb =
+				(struct init_cb_81xx *)ha->init_cb;
+			icb->firmware_options_2 &= cpu_to_le32(~BIT_12);
+		} else {
+			struct init_cb_24xx *icb =
+				(struct init_cb_24xx *)ha->init_cb;
+			icb->firmware_options_2 &= cpu_to_le32(~BIT_12);
+		}
+	}
+}
+
 void
 qlt_modify_vp_config(struct scsi_qla_host *vha,
 	struct vp_config_entry_24xx *vpmod)
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 972a7af1c81c..1351bd3fb55c 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -184,6 +184,7 @@ struct nack_to_isp {
 #define NOTIFY_ACK_SRR_REJECT_REASON_UNABLE_TO_PERFORM	0x9
 
 #define NOTIFY_ACK_SRR_FLAGS_REJECT_EXPL_NO_EXPL		0
+#define NOTIFY_ACK_SRR_FLAGS_REJECT_EXPL_INVALID_OX_ID_RX_ID	0x17
 #define NOTIFY_ACK_SRR_FLAGS_REJECT_EXPL_UNABLE_TO_SUPPLY_DATA	0x2a
 
 #define NOTIFY_ACK_SUCCESS      0x01
@@ -686,6 +687,8 @@ struct qla_tgt_func_tmpl {
 	int (*handle_tmr)(struct qla_tgt_mgmt_cmd *, u64, uint16_t,
 			uint32_t);
 	struct qla_tgt_cmd *(*get_cmd)(struct fc_port *);
+	int (*get_cmd_ref)(struct qla_tgt_cmd *cmd);
+	void (*put_cmd_ref)(struct qla_tgt_cmd *cmd);
 	void (*rel_cmd)(struct qla_tgt_cmd *);
 	void (*free_cmd)(struct qla_tgt_cmd *);
 	void (*free_mcmd)(struct qla_tgt_mgmt_cmd *);
@@ -823,7 +826,13 @@ struct qla_tgt {
 	int notify_ack_expected;
 	int abts_resp_expected;
 	int modify_lun_expected;
+
+	spinlock_t srr_lock;
+	struct list_head srr_list;
+	struct work_struct srr_work;
+
 	atomic_t tgt_global_resets_count;
+
 	struct list_head tgt_list_entry;
 };
 
@@ -862,6 +871,7 @@ enum trace_flags {
 	TRC_ABORT = BIT_19,
 	TRC_DIF_ERR = BIT_20,
 	TRC_CTIO_IGNORED = BIT_21,
+	TRC_SRR_IMM = BIT_22,
 };
 
 struct qla_tgt_cmd {
@@ -882,6 +892,10 @@ struct qla_tgt_cmd {
 
 	unsigned int conf_compl_supported:1;
 	unsigned int sg_mapped:1;
+
+	/* Call qlt_free_sg() if set. */
+	unsigned int free_sg:1;
+
 	unsigned int write_data_transferred:1;
 
 	/* Set if the SCSI status was sent successfully. */
@@ -893,6 +907,9 @@ struct qla_tgt_cmd {
 	unsigned int cmd_in_wq:1;
 	unsigned int edif:1;
 
+	/* Set if a SRR was rejected. */
+	unsigned int srr_failed:1;
+
 	/* Set if the exchange has been terminated. */
 	unsigned int sent_term_exchg:1;
 
@@ -902,6 +919,7 @@ struct qla_tgt_cmd {
 	 */
 	unsigned int aborted:1;
 
+	struct qla_tgt_srr *srr;
 	struct scatterlist *sg;	/* cmd data buffer SG vector */
 	int sg_cnt;		/* SG segments count */
 	int bufflen;		/* cmd buffer length */
@@ -941,6 +959,14 @@ struct qla_tgt_cmd {
 	uint16_t prot_flags;
 
 	unsigned long jiffies_at_term_exchg;
+
+	/*
+	 * jiffies64 when qlt_rdy_to_xfer() or qlt_xmit_response() first
+	 * called, or 0 when not in those states.  Used to limit the number of
+	 * SRR retries.
+	 */
+	uint64_t jiffies_at_hw_st_entry;
+
 	uint64_t jiffies_at_alloc;
 	uint64_t jiffies_at_free;
 
@@ -1002,6 +1028,45 @@ struct qla_tgt_prm {
 	uint16_t tot_dsds;
 };
 
+/*
+ * SRR (Sequence Retransmission Request) - resend or re-receive some or all
+ * data or status to recover from a transient I/O error.
+ */
+struct qla_tgt_srr {
+	/*
+	 * Copy of immediate notify SRR message received from hw; valid only if
+	 * imm_ntfy_recvd is true.
+	 */
+	struct imm_ntfy_from_isp imm_ntfy;
+
+	struct list_head srr_list_entry;
+
+	/* The command affected by this SRR, or NULL if not yet determined. */
+	struct qla_tgt_cmd *cmd;
+
+	/* Used to detect if the HBA has been reset since receiving the SRR. */
+	uint32_t reset_count;
+
+	/*
+	 * The hardware sends two messages for each SRR - an immediate notify
+	 * and a CTIO with CTIO_SRR_RECEIVED status.  These keep track of which
+	 * messages have been received.  The SRR can be processed once both of
+	 * these are true.
+	 */
+	bool imm_ntfy_recvd;
+	bool ctio_recvd;
+
+	/*
+	 * This is set to true if the affected command was aborted (cmd may be
+	 * set to NULL), in which case the immediate notify exchange also needs
+	 * to be aborted.
+	 */
+	bool aborted;
+
+	/* This is set to true to force the SRR to be rejected. */
+	bool reject;
+};
+
 /* Check for Switch reserved address */
 #define IS_SW_RESV_ADDR(_s_id) \
 	((_s_id.b.domain == 0xff) && ((_s_id.b.area & 0xf0) == 0xf0))
@@ -1056,6 +1121,20 @@ static inline uint32_t sid_to_key(const be_id_t s_id)
 		s_id.al_pa;
 }
 
+/*
+ * Free the scatterlist allocated by qlt_set_data_offset().  Call this only if
+ * cmd->free_sg is set.
+ */
+static inline void qlt_free_sg(struct qla_tgt_cmd *cmd)
+{
+	/*
+	 * The scatterlist may be chained to the original scatterlist, but we
+	 * only need to free the first segment here since that is the only part
+	 * allocated by qlt_set_data_offset().
+	 */
+	kfree(cmd->sg);
+}
+
 /*
  * Exported symbols from qla_target.c LLD logic used by qla2xxx code..
  */
@@ -1064,6 +1143,7 @@ extern void qlt_response_pkt_all_vps(struct scsi_qla_host *, struct rsp_que *,
 extern int qlt_rdy_to_xfer(struct qla_tgt_cmd *);
 extern int qlt_xmit_response(struct qla_tgt_cmd *, int, uint8_t);
 extern int qlt_abort_cmd(struct qla_tgt_cmd *);
+void qlt_srr_abort(struct qla_tgt_cmd *cmd, bool reject);
 void qlt_send_term_exchange(struct qla_qpair *qpair,
 	struct qla_tgt_cmd *cmd, struct atio_from_isp *atio, int ha_locked);
 void qlt_unmap_sg(struct scsi_qla_host *vha, struct qla_tgt_cmd *cmd);
@@ -1085,6 +1165,7 @@ extern void qlt_81xx_config_nvram_stage2(struct scsi_qla_host *,
 	struct init_cb_81xx *);
 extern void qlt_81xx_config_nvram_stage1(struct scsi_qla_host *,
 	struct nvram_81xx *);
+void qlt_config_nvram_with_fw_version(struct scsi_qla_host *vha);
 extern void qlt_modify_vp_config(struct scsi_qla_host *,
 	struct vp_config_entry_24xx *);
 extern void qlt_probe_one_stage1(struct scsi_qla_host *, struct qla_hw_data *);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 169219fe47a2..2fff68935338 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -291,6 +291,16 @@ static struct qla_tgt_cmd *tcm_qla2xxx_get_cmd(struct fc_port *sess)
 	return cmd;
 }
 
+static int tcm_qla2xxx_get_cmd_ref(struct qla_tgt_cmd *cmd)
+{
+	return target_get_sess_cmd(&cmd->se_cmd, true);
+}
+
+static void tcm_qla2xxx_put_cmd_ref(struct qla_tgt_cmd *cmd)
+{
+	target_put_sess_cmd(&cmd->se_cmd);
+}
+
 static void tcm_qla2xxx_rel_cmd(struct qla_tgt_cmd *cmd)
 {
 	target_free_tag(cmd->sess->se_sess, &cmd->se_cmd);
@@ -531,6 +541,9 @@ static void tcm_qla2xxx_handle_data_work(struct work_struct *work)
 		if (cmd->se_cmd.pi_err)
 			transport_generic_request_failure(&cmd->se_cmd,
 				cmd->se_cmd.pi_err);
+		else if (cmd->srr_failed)
+			transport_generic_request_failure(&cmd->se_cmd,
+				TCM_SNACK_REJECTED);
 		else
 			transport_generic_request_failure(&cmd->se_cmd,
 				TCM_CHECK_CONDITION_ABORT_CMD);
@@ -1526,6 +1539,8 @@ static const struct qla_tgt_func_tmpl tcm_qla2xxx_template = {
 	.handle_data		= tcm_qla2xxx_handle_data,
 	.handle_tmr		= tcm_qla2xxx_handle_tmr,
 	.get_cmd		= tcm_qla2xxx_get_cmd,
+	.get_cmd_ref		= tcm_qla2xxx_get_cmd_ref,
+	.put_cmd_ref		= tcm_qla2xxx_put_cmd_ref,
 	.rel_cmd		= tcm_qla2xxx_rel_cmd,
 	.free_cmd		= tcm_qla2xxx_free_cmd,
 	.free_mcmd		= tcm_qla2xxx_free_mcmd,
-- 
2.43.0



