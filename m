Return-Path: <target-devel+bounces-29-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6973380E0C3
	for <lists+target-devel@lfdr.de>; Tue, 12 Dec 2023 02:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24B0B20D79
	for <lists+target-devel@lfdr.de>; Tue, 12 Dec 2023 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4A7F7;
	Tue, 12 Dec 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZkSx2ZL"
X-Original-To: target-devel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE45C2
	for <target-devel@vger.kernel.org>; Mon, 11 Dec 2023 17:20:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcad3c1b70so1006779276.0
        for <target-devel@vger.kernel.org>; Mon, 11 Dec 2023 17:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702344021; x=1702948821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1zDhsNUVn4yIMFjkCDRNEin0bHQri3D2G8bRroxp6Us=;
        b=MZkSx2ZLeyolCz4tPy38TJrR4a+Ag4brz0y7/00ZxtexQDrnHg83AFWT9Li9v1I/Da
         mtTd8OWVcx+DKpYfpT6o8vTrxDj10swKS9vFr0N/fnCFtf+2qIk7zX1NFPiBSi0lFtJG
         JbgQY0BzI0am5IlRM4vztZIjcVDd+DY5otYDPH4ukmSp9Cb4TBon6nDdQkB57EWs3PB8
         duDYTeGUSu3XnIqDPUmxrerrKTuOh4Z3FnMmV85pCvxbwivVjAr937sX0PxEVXWpZulo
         6t804Rs+mUVB49kLWJupGRKFLQmCt9VChHSMERrqAk2BArA2NnIkfoPxYfT9VwwPkxue
         8EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702344021; x=1702948821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zDhsNUVn4yIMFjkCDRNEin0bHQri3D2G8bRroxp6Us=;
        b=HOIjawP5we87mO+taEdrYBtrW3xq06pa+xQ61TC4ObnSHRo1M+101f4wt1QUaW12+3
         fWGBhbqY0x8Lq1iZ+INnFXT4zC1S65Bx/mgpSY7SLj3jMU4wcmwsiWCir4Mb2ayWVAvH
         hReI8KuDK7sN4W8CreNsd7CwtOAJDTr619+43Fdiqr15mD88UemVFf1ysSEmTpbBZhN3
         xkd4U/qm/AM1FX1/1az/H+KvjZCFLkNJOc1W5hlrFt7BHlkMcCLOb8PsPUa1ZWNxQpJt
         kQJM4cjmS+UeB1JSk7a/+Nnf6LOAQKF9xq+XfpPoYAYnsiXX6/6LWoUu+nGJ0v2L8+7I
         YHyw==
X-Gm-Message-State: AOJu0Yx4LYIeje2hycgp83aTSZMJU5/ndR3eUo10qOSiHIub751MEXSu
	6HHdLvNZ9HVim5V56tBD0vFiXe+4JT+vJqIuuQ==
X-Google-Smtp-Source: AGHT+IGCZ/3Hm1oGZDJVqOZYRs9LPHOqFGAgnB5x2qnhyF/MXbWlUssASTcKwx82JlkzLEzUYKLzUY5/EHQX7bbR4Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:52f:b0:db5:48c5:302e with
 SMTP id y15-20020a056902052f00b00db548c5302emr45864ybs.4.1702344021701; Mon,
 11 Dec 2023 17:20:21 -0800 (PST)
Date: Tue, 12 Dec 2023 01:20:20 +0000
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFS1d2UC/6WOQQ6CMBREr2K6tqYtFsGV9zDEQPspPxFK+ptGQ
 ri7hZ1rd/NmMW9WRhAQiN1PKwuQkNBPGdT5xMzQTg442sxMCVVIUQhOMUxmXrgNmCAQJ0PIsRv
 THl7RxV8wvGrrzgrQ17IsWZ6dA/T4OZTPJvOAFH1YjgdJ7u0fsiS55JWuO21A6VtvH85794aL8 SNrtm37AnDg44XxAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702344020; l=4467;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9iNx/XHoAbZspBn0RbR1EutQz4ViuX602P3R/36GQ8c=; b=ACnHEmP9avRU458e42EgHVuaVBoRcXII5xatNVn8cssXGucBR8pasyE0oiyg7hd0qGAmlVZEb
 WJGm7jNqDLeDk/nFXjOFe7SEQg4jBctpuaST44ZAsyJIZoqPwCiEGIb
X-Mailer: b4 0.12.3
Message-ID: <20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com>
Subject: [PATCH v2] scsi: ibmvscsi_tgt: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Michael Cyr <mikecyr@linux.ibm.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We don't need the NUL-padding behavior that strncpy() provides as vscsi
is NUL-allocated in ibmvscsis_probe() which proceeds to call
ibmvscsis_adapter_info():
|       vscsi = kzalloc(sizeof(*vscsi), GFP_KERNEL);

ibmvscsis_probe() -> ibmvscsis_handle_crq() -> ibmvscsis_parse_command()
-> ibmvscsis_mad() -> ibmvscsis_process_mad() -> ibmvscsis_adapter_info()

Following the same idea, `partition_name` is defiend as:
|       static char partition_name[PARTITION_NAMELEN] = "UNKNOWN";
... which is NUL-padded already, meaning strscpy() is the best option.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

However, for cap->name and info let's use strscpy_pad as they are
allocated via dma_alloc_coherent():
|       cap = dma_alloc_coherent(&vscsi->dma_dev->dev, olen, &token,
|                                GFP_ATOMIC);
&
|       info = dma_alloc_coherent(&vscsi->dma_dev->dev, sizeof(*info), &token,
|                                 GFP_ATOMIC);

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use strscpy_pad for info->partition_name (thanks Kees)
- rebase onto mainline bee0e7762ad2c602
- Link to v1: https://lore.kernel.org/r/20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v1-1-859b5ce257fd@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 4dc411a58107..6b16020b1f59 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -1551,18 +1551,18 @@ static long ibmvscsis_adapter_info(struct scsi_info *vscsi,
 	if (vscsi->client_data.partition_number == 0)
 		vscsi->client_data.partition_number =
 			be32_to_cpu(info->partition_number);
-	strncpy(vscsi->client_data.srp_version, info->srp_version,
+	strscpy(vscsi->client_data.srp_version, info->srp_version,
 		sizeof(vscsi->client_data.srp_version));
-	strncpy(vscsi->client_data.partition_name, info->partition_name,
+	strscpy(vscsi->client_data.partition_name, info->partition_name,
 		sizeof(vscsi->client_data.partition_name));
 	vscsi->client_data.mad_version = be32_to_cpu(info->mad_version);
 	vscsi->client_data.os_type = be32_to_cpu(info->os_type);
 
 	/* Copy our info */
-	strncpy(info->srp_version, SRP_VERSION,
-		sizeof(info->srp_version));
-	strncpy(info->partition_name, vscsi->dds.partition_name,
-		sizeof(info->partition_name));
+	strscpy_pad(info->srp_version, SRP_VERSION,
+		    sizeof(info->srp_version));
+	strscpy_pad(info->partition_name, vscsi->dds.partition_name,
+		    sizeof(info->partition_name));
 	info->partition_number = cpu_to_be32(vscsi->dds.partition_num);
 	info->mad_version = cpu_to_be32(MAD_VERSION_1);
 	info->os_type = cpu_to_be32(LINUX);
@@ -1645,8 +1645,8 @@ static int ibmvscsis_cap_mad(struct scsi_info *vscsi, struct iu_entry *iue)
 			 be64_to_cpu(mad->buffer),
 			 vscsi->dds.window[LOCAL].liobn, token);
 	if (rc == H_SUCCESS) {
-		strncpy(cap->name, dev_name(&vscsi->dma_dev->dev),
-			SRP_MAX_LOC_LEN);
+		strscpy_pad(cap->name, dev_name(&vscsi->dma_dev->dev),
+			sizeof(cap->name));
 
 		len = olen - min_len;
 		status = VIOSRP_MAD_SUCCESS;
@@ -3650,7 +3650,7 @@ static int ibmvscsis_get_system_info(void)
 
 	name = of_get_property(rootdn, "ibm,partition-name", NULL);
 	if (name)
-		strncpy(partition_name, name, sizeof(partition_name));
+		strscpy(partition_name, name, sizeof(partition_name));
 
 	num = of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (num)

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-8a9bd0e54666

Best regards,
--
Justin Stitt <justinstitt@google.com>


