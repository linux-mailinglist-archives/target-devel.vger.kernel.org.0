Return-Path: <target-devel+bounces-624-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A39C0C2F1
	for <lists+target-devel@lfdr.de>; Mon, 27 Oct 2025 08:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3C214F0C53
	for <lists+target-devel@lfdr.de>; Mon, 27 Oct 2025 07:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BE2E3703;
	Mon, 27 Oct 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="P49fEwis"
X-Original-To: target-devel@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1402E36E9;
	Mon, 27 Oct 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551407; cv=none; b=Lil4JVIteMms4UmwfkeSygN+LDKjCNZMIjq7zaVCd6wepCJzgKzsunOGxBkvGWFi06PfZ/6F+xGE9xDEI1twYmsGUOEjH1R4ikZWcHt+xhWm6jIqa517+oECIXUoAHxDpKnNO1rxStHPWP6KndW5L1L9YtSqHX6vukRUIGpFiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551407; c=relaxed/simple;
	bh=LoBHsGmeGqpRdc2DqMLx1eBbSSn9xowv31K/JbZQ9D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UG1KgAhxtW0OAp6J/30y8oUwq6exzfUE8W1RnWezyfUifatMsPubnNa/Cd877bc9oLz4Ck1qlvOvqiVK8/egju2Dyqsr98DOO7eU4qUDCsjT9QzoYTLjmyhr4IreT7IY3FhledIzAQOFR8zvLnRRom0vd2IHj+a5TxCwtZaJoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=P49fEwis; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9E260804B3;
	Mon, 27 Oct 2025 10:48:03 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:994::1:8])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 0mW16e1FpuQ0-LqkXLN0L;
	Mon, 27 Oct 2025 10:48:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1761551282;
	bh=0w2fmspoFXzBsApnGldGOaGahnNb+24s0WLPhF3empo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=P49fEwisOYO7W+IztiTmu46vQWxujnBUZ9jVNSUg2xIsZMI4cRkURnjAr1PyHmKlk
	 B500oLyWSwLEUbPIhzm+MhF0HJ1slQ6q8IUpm5so09zCcF2SQ8SR0WMeAB+uaboNQ0
	 InHQ+2k1TujbP5Lpg8Tf60dPKX03bB6Lq/RiGjlA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Troshin <drtrosh@yandex-team.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Troshin <drtrosh@yandex-team.ru>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] scsi: target: target_core_configfs: Add length check to avoid buffer overflow
Date: Mon, 27 Oct 2025 10:48:06 +0300
Message-ID: <20251027074806.2036-1-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Haoran <haoranwangsec@gmail.com>

commit 27e06650a5eafe832a90fd2604f0c5e920857fae upstream.

A buffer overflow arises from the usage of snprintf to write into the
buffer "buf" in target_lu_gp_members_show function located in
/drivers/target/target_core_configfs.c. This buffer is allocated with
size LU_GROUP_NAME_BUF (256 bytes).

snprintf(...) formats multiple strings into buf with the HBA name
(hba->hba_group.cg_item), a slash character, a devicename (dev->
dev_group.cg_item) and a newline character, the total formatted string
length may exceed the buffer size of 256 bytes.

Since snprintf() returns the total number of bytes that would have been
written (the length of %s/%sn ), this value may exceed the buffer length
(256 bytes) passed to memcpy(), this will ultimately cause function
memcpy reporting a buffer overflow error.

An additional check of the return value of snprintf() can avoid this
buffer overflow.

Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Reported-by: ziiiro <yuanmingbuaa@gmail.com>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[Andrey Troshin: patch adaptation for linux-5.10]
Signed-off-by: Andrey Troshin <drtrosh@yandex-team.ru>
---
Backport fix for CVE-2025-39998
Link: https://nvd.nist.gov/vuln/detail/CVE-2025-39998
---
 drivers/target/target_core_configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 4d2fbe1429b6..e6996428c07d 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -2637,7 +2637,7 @@ static ssize_t target_lu_gp_members_show(struct config_item *item, char *page)
 			config_item_name(&dev->dev_group.cg_item));
 		cur_len++; /* Extra byte for NULL terminator */
 
-		if ((cur_len + len) > PAGE_SIZE) {
+		if ((cur_len + len) > PAGE_SIZE || cur_len > LU_GROUP_NAME_BUF) {
 			pr_warn("Ran out of lu_gp_show_attr"
 				"_members buffer\n");
 			break;
-- 
2.34.1


