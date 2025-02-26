Return-Path: <target-devel+bounces-343-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57434A46A46
	for <lists+target-devel@lfdr.de>; Wed, 26 Feb 2025 19:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9FC1889AEF
	for <lists+target-devel@lfdr.de>; Wed, 26 Feb 2025 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BE23717C;
	Wed, 26 Feb 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KGSqJ6pY"
X-Original-To: target-devel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64477237160
	for <target-devel@vger.kernel.org>; Wed, 26 Feb 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596175; cv=none; b=LarvVZ1uHk3BeY1w+AHdgqV2dNGtDI0eivPUHTeQJKoCu41UDSoYiyIkMvKbUw9NYdUMBElBCUc4i5fdSgN9RDuSFXiD5iEHy8qB7CUaXnyehWNdMw0v8Qxg/FfcTJTMKjeLPpr7FB4WRaHaRI/+IG7ujDWSSoWlfe5e3TBjlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596175; c=relaxed/simple;
	bh=GJLG6HT2p/F44pvEf+vdQir4GFIdOm/KN9Mpn40nQZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSL5j8nbynSgaJMdZxmpd9B5sPpxdJRAllmbfiCL3Lyel+0gn19J0mGXMbijesfsFAJ2zJtOdZ7PoOV5Udg1gXcsQ0vGFvOpLLCb8d+2Ub1GQXQFWwCh8pIO5C7RpMupEFWSPu1OgNvLEhcRc+l5mUk9JkiMTui0DqWCjR3shMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KGSqJ6pY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740596161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R4cAkbTSz/JJdoqp8OKkTxMEEUgI6W1GWFWWM9AMUuk=;
	b=KGSqJ6pY9pcbZNl3CC3YM9Y/0xKyMoZuIZo4rAAadNchrEPFIKCH9PHH0jDCmdKmSTPMDv
	bQoWFQeRk95IUq2IyGsw8qkvfSgSiq/+vasAtDvAcM4TpQkKurSyL0gHRaXf4PRkbeP33u
	SJMJVQnn1OCqBRvbSkzs1m91kNDLiJw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: James Smart <james.smart@broadcom.com>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: elx: sli4: Replace deprecated strncpy() with strscpy()
Date: Wed, 26 Feb 2025 19:55:26 +0100
Message-ID: <20250226185531.1092-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy() instead.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/elx/libefc_sli/sli4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index 5e7fb110bc3f..d9a231fc0e0d 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -3804,7 +3804,7 @@ sli_cmd_common_write_object(struct sli4 *sli4, void *buf, u16 noc,
 	wr_obj->desired_write_len_dword = cpu_to_le32(dwflags);
 
 	wr_obj->write_offset = cpu_to_le32(offset);
-	strncpy(wr_obj->object_name, obj_name, sizeof(wr_obj->object_name) - 1);
+	strscpy(wr_obj->object_name, obj_name);
 	wr_obj->host_buffer_descriptor_count = cpu_to_le32(1);
 
 	bde = (struct sli4_bde *)wr_obj->host_buffer_descriptor;
@@ -3833,7 +3833,7 @@ sli_cmd_common_delete_object(struct sli4 *sli4, void *buf, char *obj_name)
 			 SLI4_SUBSYSTEM_COMMON, CMD_V0,
 			 SLI4_RQST_PYLD_LEN(cmn_delete_object));
 
-	strncpy(req->object_name, obj_name, sizeof(req->object_name) - 1);
+	strscpy(req->object_name, obj_name);
 	return 0;
 }
 
@@ -3856,7 +3856,7 @@ sli_cmd_common_read_object(struct sli4 *sli4, void *buf, u32 desired_read_len,
 		cpu_to_le32(desired_read_len & SLI4_REQ_DESIRE_READLEN);
 
 	rd_obj->read_offset = cpu_to_le32(offset);
-	strncpy(rd_obj->object_name, obj_name, sizeof(rd_obj->object_name) - 1);
+	strscpy(rd_obj->object_name, obj_name);
 	rd_obj->host_buffer_descriptor_count = cpu_to_le32(1);
 
 	bde = (struct sli4_bde *)rd_obj->host_buffer_descriptor;
-- 
2.48.1


