Return-Path: <target-devel+bounces-528-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660FB49960
	for <lists+target-devel@lfdr.de>; Mon,  8 Sep 2025 21:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FE21890D49
	for <lists+target-devel@lfdr.de>; Mon,  8 Sep 2025 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE0236435;
	Mon,  8 Sep 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="mYx+5oL/"
X-Original-To: target-devel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10747188CB1
	for <target-devel@vger.kernel.org>; Mon,  8 Sep 2025 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358427; cv=none; b=o1Xss0LkiKECdMG0v1ULvJ6iGlMTgPzZK5UU6IxdVJu0ABTeqHBT8ro5ByiD7eN0VXi5Mf2A5A5puLIr3jU4P/Fd2ZPM5uHHLwyX+2jnIusP/9bN+V3uCsk3sw+sfhuoGc57DCurUMibNcCVVYXcQUahA/4CboMeqxsWwFNMIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358427; c=relaxed/simple;
	bh=D4ILVASdY2T/H0ahHTsH3j+adyT2xwErWJjBmNUuFBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bu6hFl5QhZIfNo4XcgQDZ1WRmbV+3AN29HZQZaxTMRCHazyVqBW8Ozjb3UdBYbC94vx44vYX0iEYqru6ULWFibNxciA3/hJWa969gL9cPjolLtiNhWb+UwYlioCOuZQ8cGrK4iM3jeUxRHpuHmgj0l47KzCYhj/Dg1lgubZVBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=mYx+5oL/; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id ssI5BDUJu7CMuLEf; Mon, 08 Sep 2025 15:07:04 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=nnqvvPSsS49UlswJpZjg2l08e48fPD5LMiFVq7yBblc=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=mYx+5oL/FlTSrMGuvx/h
	76HNU+vRxsyJmuEkxAbDOOR/PKyaki4EAenXPI0C94CHkDI1M491gxewL8HRjKMQr+GCICy2M3786
	wse5WjLXgH/qIb97H38LdbjFLsZZHR8Bo/WSpMKIFapo8Sm4W9anL+11jc/izhZLzkHX40C+DQ=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14188080; Mon, 08 Sep 2025 15:07:04 -0400
Message-ID: <366f8fb5-376d-4426-9f27-6bef23a624b2@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 8 Sep 2025 15:07:04 -0400
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 12/15] scsi: qla2xxx: add cmd->rsp_sent
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 12/15] scsi: qla2xxx: add cmd->rsp_sent
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
X-Barracuda-Start-Time: 1757358424
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1501
X-ASG-Debug-ID: 1757358424-1cf43947df30c690001-W1KF7h

(target mode)

Add cmd->rsp_sent to indicate that the SCSI status has been sent
successfully, so that SCST can be informed of any transport errors.
This will also be used for logging in later patches.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 4 ++++
 drivers/scsi/qla2xxx/qla_target.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index eabb891a5528..0ddbf02ebe79 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4067,6 +4067,10 @@ static void qlt_do_ctio_completion(struct scsi_qla_host *vha,
 
 	if (cmd->state == QLA_TGT_STATE_PROCESSED) {
 		cmd->trc_flags |= TRC_CTIO_DONE;
+
+		if (likely(status == CTIO_SUCCESS))
+			cmd->rsp_sent = 1;
+
 	} else if (cmd->state == QLA_TGT_STATE_NEED_DATA) {
 		cmd->state = QLA_TGT_STATE_DATA_IN;
 
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 1931e1dade7a..972a7af1c81c 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -883,6 +883,10 @@ struct qla_tgt_cmd {
 	unsigned int conf_compl_supported:1;
 	unsigned int sg_mapped:1;
 	unsigned int write_data_transferred:1;
+
+	/* Set if the SCSI status was sent successfully. */
+	unsigned int rsp_sent:1;
+
 	unsigned int q_full:1;
 	unsigned int term_exchg:1;
 	unsigned int cmd_sent_to_fw:1;
-- 
2.43.0



