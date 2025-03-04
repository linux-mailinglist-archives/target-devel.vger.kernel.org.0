Return-Path: <target-devel+bounces-350-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4BA4EBA0
	for <lists+target-devel@lfdr.de>; Tue,  4 Mar 2025 19:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B24172873
	for <lists+target-devel@lfdr.de>; Tue,  4 Mar 2025 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8028D09C;
	Tue,  4 Mar 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w8pwDljw"
X-Original-To: target-devel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070512780F2
	for <target-devel@vger.kernel.org>; Tue,  4 Mar 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112076; cv=none; b=c/fd53TWzl2vZkHX5jlsoQh8R4RGeXKyfgf7zZHUC+nhYhQRIzESH2nw2BXmK301VU/No+bl+nEBUOWt/rVJUna0GdLx0CMitmx3Ne3Zyou0QFikZkY914zxyaCH4lAHYZI2smM0da68mHZgFUyhqYvvHXX+N0fTdhVjPAWOzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112076; c=relaxed/simple;
	bh=0BxNCArQS6YXz9VsmCXNHkqDx3pRc8E0K6P//18NTM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfMH1lSg+jissL73xULcNzprZYcNGpmo/q52Mj1d6ANW29z4ANOCs1iT8RIfWXPdg2MZ1+LvpMoMAZ3IpzEY3pZ4RmfyYGJiSl6VO85bpq55PSoAth4yua9lSfjdXlxhI7m8eWqWHZhYYAOLb50bT37lhNHT3C7PJzaAPNWRKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w8pwDljw; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741112062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CI5XJci0mb8S2pl5ASbOYBG4+fIERNXYTJQdDedonSU=;
	b=w8pwDljwAzV2pA5mnEYEewwTLP5iJd/yjKxuoF7il3mxTJCXEqWO1nf6296TYy81jBzdJP
	0USIKCvph+hrYrlCvz9U7at8SlbglWY84XHhIaj32adQ17PJqJI8p3ANInemnxxnrt/uvl
	1HB+Sa8ASDf6T11MhS4oMkz/XW7s9ME=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: target: Remove size arguments when calling strscpy()
Date: Tue,  4 Mar 2025 19:14:00 +0100
Message-ID: <20250304181400.78325-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The size parameter of strscpy() is optional because strscpy() uses
sizeof() to determine the length of the destination buffer if it is not
provided as an argument. Remove it to simplify the code.

Remove some unnecessary curly braces.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/target/target_core_configfs.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index c40217f44b1b..9b2b9786ce2f 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -673,12 +673,10 @@ static ssize_t emulate_model_alias_store(struct config_item *item,
 		return ret;
 
 	BUILD_BUG_ON(sizeof(dev->t10_wwn.model) != INQUIRY_MODEL_LEN + 1);
-	if (flag) {
+	if (flag)
 		dev_set_t10_wwn_model_alias(dev);
-	} else {
-		strscpy(dev->t10_wwn.model, dev->transport->inquiry_prod,
-			sizeof(dev->t10_wwn.model));
-	}
+	else
+		strscpy(dev->t10_wwn.model, dev->transport->inquiry_prod);
 	da->emulate_model_alias = flag;
 	return count;
 }
@@ -1433,7 +1431,7 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
 	ssize_t len;
 	ssize_t ret;
 
-	len = strscpy(buf, page, sizeof(buf));
+	len = strscpy(buf, page);
 	if (len > 0) {
 		/* Strip any newline added from userspace. */
 		stripped = strstrip(buf);
@@ -1464,7 +1462,7 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
 	}
 
 	BUILD_BUG_ON(sizeof(dev->t10_wwn.vendor) != INQUIRY_VENDOR_LEN + 1);
-	strscpy(dev->t10_wwn.vendor, stripped, sizeof(dev->t10_wwn.vendor));
+	strscpy(dev->t10_wwn.vendor, stripped);
 
 	pr_debug("Target_Core_ConfigFS: Set emulated T10 Vendor Identification:"
 		 " %s\n", dev->t10_wwn.vendor);
@@ -1489,7 +1487,7 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
 	ssize_t len;
 	ssize_t ret;
 
-	len = strscpy(buf, page, sizeof(buf));
+	len = strscpy(buf, page);
 	if (len > 0) {
 		/* Strip any newline added from userspace. */
 		stripped = strstrip(buf);
@@ -1520,7 +1518,7 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
 	}
 
 	BUILD_BUG_ON(sizeof(dev->t10_wwn.model) != INQUIRY_MODEL_LEN + 1);
-	strscpy(dev->t10_wwn.model, stripped, sizeof(dev->t10_wwn.model));
+	strscpy(dev->t10_wwn.model, stripped);
 
 	pr_debug("Target_Core_ConfigFS: Set emulated T10 Model Identification: %s\n",
 		 dev->t10_wwn.model);
@@ -1545,7 +1543,7 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
 	ssize_t len;
 	ssize_t ret;
 
-	len = strscpy(buf, page, sizeof(buf));
+	len = strscpy(buf, page);
 	if (len > 0) {
 		/* Strip any newline added from userspace. */
 		stripped = strstrip(buf);
@@ -1576,7 +1574,7 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
 	}
 
 	BUILD_BUG_ON(sizeof(dev->t10_wwn.revision) != INQUIRY_REVISION_LEN + 1);
-	strscpy(dev->t10_wwn.revision, stripped, sizeof(dev->t10_wwn.revision));
+	strscpy(dev->t10_wwn.revision, stripped);
 
 	pr_debug("Target_Core_ConfigFS: Set emulated T10 Revision: %s\n",
 		 dev->t10_wwn.revision);
-- 
2.48.1


