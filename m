Return-Path: <target-devel+bounces-516-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F60B498C9
	for <lists+target-devel@lfdr.de>; Mon,  8 Sep 2025 20:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864E04E2154
	for <lists+target-devel@lfdr.de>; Mon,  8 Sep 2025 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F03F31C594;
	Mon,  8 Sep 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="QQ20AbfK"
X-Original-To: target-devel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5D1799F
	for <target-devel@vger.kernel.org>; Mon,  8 Sep 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357492; cv=none; b=lTdjrRPqO4fDnNaisFt6F88ihSkm4uTBNCrfNVxNk1pu6JpH+FLj5BKrGKe9jvPNHEr7Iwo5UAslOCKe1bz1XrkEfzu4AmOgfuckBZZFRM8ZWvnw5jt4v87B7x9XPuxLly58toBHs+MxD4uws+eWFXd5UwitIfMBCKWXO35qIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357492; c=relaxed/simple;
	bh=3B57ATz3UdD42KSx68Sb8PP+iMlVGiDpmiGvWhdCGyo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=afjPt3BkGX8vTujJ6GvTl9AO++/eTaHXX5q6afrW4axIx4ZDfrDlvsr2KMMFYejDSwBM0YNx9JIiQpz9D4Xea6qaN2g1J0u86rz5O/+FlCreGDJwmTfTOTifS89AVHDLvqRZqBeMJqp4ylvmLWFLb0DAr3n9Y4CbZq/lTkAEjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=QQ20AbfK; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id qfCNNj5fplSnWsK8; Mon, 08 Sep 2025 14:51:28 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=kI5kvHmGz7C9TMJF6aaUpsjVqkrCWX3ZpUSR28Va5/M=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=QQ20AbfK//ewd35yg0N8
	cdf6UgI3TAWZE3af9P+mUcbEWj74kAxaNGQDGiJe6JuKQKDGV6QTVs9GdNxL5Rdr7ll4Vqfu6IXdA
	aEHvdQ/ccQz0JgmRdA5bD0l6CO3NSp8+p4meOoL2XyCKbV12/fp8cutM/bc2qE2nqvrfDBDZbQ=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14189039; Mon, 08 Sep 2025 14:51:28 -0400
Message-ID: <389db3ff-16e4-430f-a69d-dd41d83d83aa@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 8 Sep 2025 14:51:28 -0400
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 04/15] scsi: qla2xxx: use reinit_completion on mbx_intr_comp
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 04/15] scsi: qla2xxx: use reinit_completion on mbx_intr_comp
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
X-Barracuda-Start-Time: 1757357488
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1335
X-ASG-Debug-ID: 1757357488-1cf43947df30c2f0001-W1KF7h

If a mailbox command completes immediately after
wait_for_completion_timeout() times out, ha->mbx_intr_comp could be left
in an inconsistent state, causing the next mailbox command not to wait
for the hardware.  Fix by reinitializing the completion before use.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 32eb0ce8b170..1f01576f044b 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -253,6 +253,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 	/* Issue set host interrupt command to send cmd out. */
 	ha->flags.mbox_int = 0;
 	clear_bit(MBX_INTERRUPT, &ha->mbx_cmd_flags);
+	reinit_completion(&ha->mbx_intr_comp);
 
 	/* Unlock mbx registers and wait for interrupt */
 	ql_dbg(ql_dbg_mbx, vha, 0x100f,
@@ -279,6 +280,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			    "cmd=%x Timeout.\n", command);
 			spin_lock_irqsave(&ha->hardware_lock, flags);
 			clear_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags);
+			reinit_completion(&ha->mbx_intr_comp);
 			spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 			if (chip_reset != ha->chip_reset) {
-- 
2.43.0



