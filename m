Return-Path: <target-devel+bounces-525-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E6FB49941
	for <lists+target-devel@lfdr.de>; Mon,  8 Sep 2025 21:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845C0204783
	for <lists+target-devel@lfdr.de>; Mon,  8 Sep 2025 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF8225409;
	Mon,  8 Sep 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="LmH6QYGZ"
X-Original-To: target-devel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7241E231E
	for <target-devel@vger.kernel.org>; Mon,  8 Sep 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358173; cv=none; b=aru03wPGQ699Fq0n9FlO9vPeFZXf/y1v2ano58QYDpkE14vxoFBmTD6aCCrOr9QYqf1WFBQ1yRXkh3B6skbLEXVBA/1Fidb26/DiVjFDpJUiy4bGNMDxzDYF8UFinz172ooZOjcaOImcKez9QSCUw8Qb95lXbLvPdbx9v31l1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358173; c=relaxed/simple;
	bh=RFHo8YfgvHGQHVv4bNsSc49nUKjMyszsYY0LnWJshlg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DNijjcAPgv0qGg+hNFwjqPwTr0yXLlm65htIc6cK5YzdtHyjJvj1Eus5Uu2xUQMUssI8zqm6jqUMjW9CTWfQ589fpsVVyaqPFWacHZ6EektlKxvpzU++8E/RNIdPcbPpwOUttzE6yzjbka8XJVC9DNF6F993jGvhZGbJ1EI19Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=LmH6QYGZ; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id A7D5S2UZxmI9pypi; Mon, 08 Sep 2025 15:02:49 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=dXHWfaQY+7UKSGl6VoUqEdWo4sqvq0kQ+TbdxxZkXwE=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=LmH6QYGZ4whez3nIyE/z
	RCDHlmC/J7qkVc5cAJERTv30VZC2/BYmiuXI7FATQqm1WI6NrQWG7b2xd/H/SFEwF7LSrZ3hFyRv/
	v0BGEBnLsJIiUV7WRUjl7MKGQSOh+IKQpJDjhThJ4ijLLwusGCAxHU+pSvkL9DxZJzdFODBGLc=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14189092; Mon, 08 Sep 2025 15:02:49 -0400
Message-ID: <f7f93110-bd53-4ebc-9aed-abe5de82028d@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 8 Sep 2025 15:02:49 -0400
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 10/15] scsi: qla2xxx: fix TMR failure handling
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 10/15] scsi: qla2xxx: fix TMR failure handling
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
X-Barracuda-Start-Time: 1757358169
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2397
X-ASG-Debug-ID: 1757358169-1cf43947df30c5a0001-W1KF7h

(target mode)

If handle_tmr() fails (e.g. -ENOMEM):
- qlt_send_busy() makes no sense because it sends a SCSI command
  response instead of a TMR response.
- Calling mempool_free() directly can lead to memory-use-after-free.

Instead just reject the TMR and send the TMR response since that code
path is well-tested.  But be sure to set SCF_SCSI_TMR_CDB in case
core_tmr_alloc_req() returns -ENOMEM; otherwise the wrong function will
be called to free the mcmd.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 33 +++++++------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index da010de9ba8a..7c278f92ff3b 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -2005,7 +2005,6 @@ static void qlt_do_tmr_work(struct work_struct *work)
 	struct qla_hw_data *ha = mcmd->vha->hw;
 	int rc;
 	uint32_t tag;
-	unsigned long flags;
 
 	switch (mcmd->tmr_func) {
 	case QLA_TGT_ABTS:
@@ -2020,34 +2019,16 @@ static void qlt_do_tmr_work(struct work_struct *work)
 	    mcmd->tmr_func, tag);
 
 	if (rc != 0) {
-		spin_lock_irqsave(mcmd->qpair->qp_lock_ptr, flags);
-		switch (mcmd->tmr_func) {
-		case QLA_TGT_ABTS:
-			mcmd->fc_tm_rsp = FCP_TMF_REJECTED;
-			qlt_build_abts_resp_iocb(mcmd);
-			break;
-		case QLA_TGT_LUN_RESET:
-		case QLA_TGT_CLEAR_TS:
-		case QLA_TGT_ABORT_TS:
-		case QLA_TGT_CLEAR_ACA:
-		case QLA_TGT_TARGET_RESET:
-			qlt_send_busy(mcmd->qpair, &mcmd->orig_iocb.atio,
-			    qla_sam_status);
-			break;
-
-		case QLA_TGT_ABORT_ALL:
-		case QLA_TGT_NEXUS_LOSS_SESS:
-		case QLA_TGT_NEXUS_LOSS:
-			qlt_send_notify_ack(mcmd->qpair,
-			    &mcmd->orig_iocb.imm_ntfy, 0, 0, 0, 0, 0, 0);
-			break;
-		}
-		spin_unlock_irqrestore(mcmd->qpair->qp_lock_ptr, flags);
-
 		ql_dbg(ql_dbg_tgt_mgt, mcmd->vha, 0xf052,
 		    "qla_target(%d):  tgt_ops->handle_tmr() failed: %d\n",
 		    mcmd->vha->vp_idx, rc);
-		mempool_free(mcmd, qla_tgt_mgmt_cmd_mempool);
+		/*
+		 * SCF_SCSI_TMR_CDB might not have been set on error, but it
+		 * must be set for the mcmd to be freed properly.
+		 */
+		mcmd->se_cmd.se_cmd_flags |= SCF_SCSI_TMR_CDB;
+		mcmd->fc_tm_rsp = FCP_TMF_REJECTED;
+		qlt_xmit_tm_rsp(mcmd);
 	}
 }
 
-- 
2.43.0



