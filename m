Return-Path: <target-devel+bounces-592-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D0BA9AC4
	for <lists+target-devel@lfdr.de>; Mon, 29 Sep 2025 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A36A171004
	for <lists+target-devel@lfdr.de>; Mon, 29 Sep 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FA1F1517;
	Mon, 29 Sep 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="iY9SCM+Q"
X-Original-To: target-devel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC51DF751
	for <target-devel@vger.kernel.org>; Mon, 29 Sep 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157234; cv=none; b=pr7F6PRwFd51lXVqkLzll8BpMWcsWKgfgviwb1+IYAwZZtR08Bw0XGU0AdioR6wCWxd933moLpk/4pRyUMDwp7iwCFR+2lwvqSe+aiDPDliqH+VPmmHYnlIAqELZkp9W4CUJ/RVK1lPVANsnNDzX+9NZJJTAnCQdEd8xj8tgXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157234; c=relaxed/simple;
	bh=jVoikybKP7RmibG5xaLGAtNNqbPxJDjmUaqsDXxDIxo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a8PummA5+hzYOls3PBSr+DXdTt5wa28a+66DhLIhMak0VaY1Jcnd3VPv8qjJ/lSiGLglXhKtN0LRPacizNdaVPRFkMjrKDkTlPc16/qpDmiMaidtr8m+JdZy+fmgX6Y+QASh4kUGZVww50C/ut78HZzZ0yaySDEzRx8YWCO6Qaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=iY9SCM+Q; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id Nbm0SwG6HAc2Eodc; Mon, 29 Sep 2025 10:47:10 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=NpHzPYTnecE6gB7oKqgxL9cO0QWnBcpfDnyapRvX5Lk=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=iY9SCM+Qks86DZLYqmIv
	TivBt8C1Rri0BZotJzb/BrrKsXshgpeS7ElscTlLONkLqEf/YlUoDapKDWTQrQgTRXyzvgmdLjM66
	Dj4dezffp3PZ1+2wQHOtOHqNvvaOt9RHBREdshNgRP6HNk8pZ5OdF7QKPxFO5+y7eewb/uKcYg=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14216651; Mon, 29 Sep 2025 10:47:10 -0400
Message-ID: <a87efa80-b76c-4165-be57-775f73ba9a2c@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 29 Sep 2025 10:47:10 -0400
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 13/16] scsi: qla2xxx: add cmd->rsp_sent
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v2 13/16] scsi: qla2xxx: add cmd->rsp_sent
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
In-Reply-To: <e95ee7d0-3580-4124-b854-7f73ca3a3a84@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1759157230
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1527
X-ASG-Debug-ID: 1759157230-1cf43947df3c04f0001-W1KF7h

(target mode)

Add cmd->rsp_sent to indicate that the SCSI status has been sent
successfully, so that SCST can be informed of any transport errors.
This will also be used for logging in later patches.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

v1 -> v2: no changes

 drivers/scsi/qla2xxx/qla_target.c | 4 ++++
 drivers/scsi/qla2xxx/qla_target.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index c2876b442a08..a71000b122ce 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4075,6 +4075,10 @@ static void qlt_do_ctio_completion(struct scsi_qla_host *vha,
 
 	if (cmd->state == QLA_TGT_STATE_PROCESSED) {
 		cmd->trc_flags |= TRC_CTIO_DONE;
+
+		if (likely(status == CTIO_SUCCESS))
+			cmd->rsp_sent = 1;
+
 	} else if (cmd->state == QLA_TGT_STATE_NEED_DATA) {
 		cmd->state = QLA_TGT_STATE_DATA_IN;
 
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 97aa6d9cfc27..ab2285c40573 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -882,6 +882,10 @@ struct qla_tgt_cmd {
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



