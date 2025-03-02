Return-Path: <target-devel+bounces-347-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E57A4B55B
	for <lists+target-devel@lfdr.de>; Sun,  2 Mar 2025 23:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CF5169C01
	for <lists+target-devel@lfdr.de>; Sun,  2 Mar 2025 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047771EF0B0;
	Sun,  2 Mar 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q3ju93UX"
X-Original-To: target-devel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E4A13AF2
	for <target-devel@vger.kernel.org>; Sun,  2 Mar 2025 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740956308; cv=none; b=SO0herEGeMlNNTkOy696HmjrhMUC98ryDF+vdnMXnn7v9fU5aB5obJDa6hNYnKTAHtSnzRvDA8ogEi7XoDiuRZ5dlr+oc20q/4ErQH6YURep3tnzWT5327PHFNyPT2pwQc2T8dH0CmAkxoX5psQ/8tY6eblnOGQAfuQcnsXPT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740956308; c=relaxed/simple;
	bh=tYFixfIY3u81D/Jr0PjpNV7f2Q8NfNfO3Pr54h2gbS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0jsa6HASEolPNOldBqb0DaYvVu2Xd8NztdqYSX6pqGpo5cvbnsC/dl7JvyPWb83TH7hCUYW481rNPXPdStLDEIzMo27v7/lEZSng/BiAn6Hp2FD5xwzbdyR5fOwZwXkjp0U/2aH7WIGKqARRYL72TtxiGhpobFACZtuSxjjwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q3ju93UX; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740956293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jtykvtmmT4SBJVkNfvIH1V/KR8RNUn2kl39LnxHTA7o=;
	b=q3ju93UXezxv/lLOF7wlqHfY97Ijzc1rKEmJ+cmwRSouAAZmrtJyrWTBCaOmHHxtpo6Vlc
	OtYeTYBnFaV6K9fwttSa9jbF6WvWG3cCYUJnl70CIOxHkn1TpC9Ko2aisHjOx4nJbhR8Pl
	RDdRFouZ5t5CrIgxz6DHxBpwyzbivtQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: target: Replace deprecated strncpy() with strscpy()
Date: Sun,  2 Mar 2025 23:56:41 +0100
Message-ID: <20250302225641.245127-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy() instead. The destination buffer db_root is only used with "%s"
format strings and must therefore be NUL-terminated, but not NUL-padded.

Use scnprintf() because snprintf() could return a value >= DB_ROOT_LEN
and lead to an out-of-bounds access. This doesn't happen because count
is explicitly checked against DB_ROOT_LEN before. However, scnprintf()
always returns the number of characters actually written to the string
buffer, which is always within the bounds of db_root_stage, and should
be preferred over snprintf().

The size parameter of strscpy() is optional and since DB_ROOT_LEN is the
size of the destination buffer, it can be removed. Remove it to simplify
the code.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Link: https://github.com/KSPP/linux/issues/105
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Improve the commit message and replace another strncpy() as suggested
  by Kees Cook
- Replace snprintf() with scnprintf()
- Link to v1: https://lore.kernel.org/r/20250226121003.359876-1-thorsten.blum@linux.dev/
---
 drivers/target/target_core_configfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index c40217f44b1b..66804bf1ee32 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -123,7 +123,7 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 		goto unlock;
 	}
 
-	read_bytes = snprintf(db_root_stage, DB_ROOT_LEN, "%s", page);
+	read_bytes = scnprintf(db_root_stage, DB_ROOT_LEN, "%s", page);
 	if (!read_bytes)
 		goto unlock;
 
@@ -143,7 +143,7 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 	}
 	filp_close(fp, NULL);
 
-	strncpy(db_root, db_root_stage, read_bytes);
+	strscpy(db_root, db_root_stage);
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
 
 	r = read_bytes;
@@ -3664,7 +3664,7 @@ static void target_init_dbroot(void)
 	}
 	filp_close(fp, NULL);
 
-	strncpy(db_root, db_root_stage, DB_ROOT_LEN);
+	strscpy(db_root, db_root_stage);
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
 }
 
-- 
2.48.1


