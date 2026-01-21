Return-Path: <target-devel+bounces-704-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL6dM8K+cGkRZgAAu9opvQ
	(envelope-from <target-devel+bounces-704-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Wed, 21 Jan 2026 12:55:46 +0100
X-Original-To: lists+target-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1A856567
	for <lists+target-devel@lfdr.de>; Wed, 21 Jan 2026 12:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D87566365E
	for <lists+target-devel@lfdr.de>; Wed, 21 Jan 2026 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE03E9F8B;
	Wed, 21 Jan 2026 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3g7+MjT"
X-Original-To: target-devel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D71E3EF0D8
	for <target-devel@vger.kernel.org>; Wed, 21 Jan 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995953; cv=none; b=OX2CrveXMBh0Fyk4XNkKrO8jcskeAUbYx87KVuOhYL2zR6EI3CK+dMGKJBt4Dt2MW7cMNYB3JSwxnjRZy7R0hFNhHPb3QtgIGeXk6hDGqTL/Vo93SPICRFWCWTicIWjtYISy1c4i8kyPxtJJIIfYl4UWSGzHuQ7FAJxabFsJ37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995953; c=relaxed/simple;
	bh=q0nXYUTVHL7oTpqvqvnHVC0mTJIX7qTvjAnt9fZmCbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Br69t9UmoNCSiz1HoTtC73osNtvbp8cINdJHz0A/WSSRDwTSRnw/oiSobTeGvCYSTnRdjLunpuPBDAUyv+ZwzC7/pzjT8BZVo+sJwiRrmUTtYUXKqmc+/Qq9LWPw9VY/tGw1fw5h5nee0E4ZV6lEEQYfeq9UrOHxRrbgo6RYIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3g7+MjT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0a95200e8so42776855ad.0
        for <target-devel@vger.kernel.org>; Wed, 21 Jan 2026 03:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768995951; x=1769600751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWo+ADtM0PepfwlVMNfkHCoJb3HNoaWfK0fd0LWDbx0=;
        b=b3g7+MjTT0r7X7FV1SjzBQjJzeUnFEtCzPcGem1QNh9qU9pVRM9fXtyzA1oj2/A5Xa
         q8NMzHsFQHjLs2jJjhOaD9eM6MJbO+zg+87r8e76L9hJpjrRKJuWn5IHKCEnE93kPHjH
         wGI3ZIXy5+M15s5WLVKRDdWv6wjbNBa4PYivJ0kC0mrwXkN+sldYPoukhgj/wBnFW5Kg
         cNqRo2XdIyzezoVCVm8kcSpLSX/DO01kiv+B3N4xGML8Tu/nR1DgARpAZ+OaElnOpt+x
         8JuaDntkdMwizzlnww5TdklCqPiJR9MRzQwOMZtSG7P3Ry8NzZplJUp6ktZ67gomFrW8
         3ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768995951; x=1769600751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWo+ADtM0PepfwlVMNfkHCoJb3HNoaWfK0fd0LWDbx0=;
        b=nGb2zmchxCydEKpmZa0rAQAvWuEgXvCpPgMmI4YpcVeOw8+8G/GgpRfAXxBVq0Hzi+
         /MseIT8ZZIEfA36czKRQoBm6o85c5uBSE/tuoKreLoxscheFvXQ76fa0+TK1gDOI+p53
         b9YIGpPZIqSDrG4ww6FCwZ9BksZI+OYGY/d6W0sdVY8Y3qVOcWMcwt/LwwbZgI5KfFnv
         sARC/5y4Z1yJ8XshP4oBcIhkCJdK93SI16hF8KGPtURPt6uPQ9liwDYiNFwfPhc2J0yU
         nXtzAJteW49EpTaasvyKYpAyWqSM/BP018fdTYnwmLuVsxr9d0LcjYwYcCHbifyYObjJ
         oL6A==
X-Forwarded-Encrypted: i=1; AJvYcCUxh0SiSBHjVyMSHXeMONPsSL+TmGWCahXgc6GhFzUHIwutNGbfTHdGym/AFiznnfq+kT+HWDqySQ9N0Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKo0h4cNFlWe6HD8wx5v7le1AbDp7zzqEyD1QHPDXTXOfak57
	KRKws9qxacfoDZZBTF5oCiUYR5nwxFzN3WdmFNiHsjbyXWLyBqb87Bc=
X-Gm-Gg: AZuq6aLJEidN/ns7TIE3ssE+Bj7iitXBtLJlx8pOffTGXaA+qLU54anHXaJT7Qy/AM1
	uQ2bzeI2FUfmUIcRyv+pHW83tlRD3TFZfLlUckM9ej56duDQakJoaH+4fao4KF0j9g3lPriFo2M
	3RGFRjI2a/ydKeFSKolrGnp42jyoi2L1xSp0B/cFfz77nW4z21LJWYwgk4dNcWaTankSSk1Lr9B
	fz054wxVTcomiiduNvnKWhVCKVy+Ffd7F/ELBZJ/DiXYGYL84RK61NSpoQJeZc8v9+USSLDxO4u
	E4v2BjqECRPkZZcpYNrSx3BR9vjFRVmkb82zA43f987j1edh3SAko0Z+/8R3yK+be8WiW/93fcj
	O2I3AmLbyx+4QHmEcVHC1uTNMXEfitt0HaOssO8HWGJn9pUJsOyh3xCvWDLaHh9hTDh5r4nCDE+
	lOWg7XaQD0/IuMV1U=
X-Received: by 2002:a17:902:f689:b0:2a0:a92c:2cb6 with SMTP id d9443c01a7336-2a76ad6bb37mr48689235ad.36.1768995951314;
        Wed, 21 Jan 2026 03:45:51 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a76c5f4fb0sm47054085ad.45.2026.01.21.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 03:45:50 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: bootc@bootc.net,
	martin.petersen@oracle.com
Cc: nab@linux-iscsi.org,
	stefanr@s5r6.in-berlin.de,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] firewire: sbp-target: fix integer type overflow in sbp_make_tpg()
Date: Wed, 21 Jan 2026 19:45:15 +0800
Message-ID: <20260121114515.1829-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-704-lists,target-devel=lfdr.de];
	FREEMAIL_CC(0.00)[linux-iscsi.org,s5r6.in-berlin.de,vger.kernel.org,lists.sourceforge.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qikeyu2017@gmail.com,target-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4D1A856567
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The code in sbp_make_tpg() limits "tpgt" to UINT_MAX but the data type
of "tpg->tport_tpgt" is u16. This causes a type truncation issue.

When a user creates a TPG via configfs mkdir, for example:

    mkdir /sys/kernel/config/target/sbp/<wwn>/tpgt_70000

The value 70000 passes the "tpgt > UINT_MAX" check since 70000 is far
less than 4294967295. However, when assigned to the u16 field
tpg->tport_tpgt, the value is silently truncated to 4464 (70000 &
0xFFFF). This causes the value the user specified to differ from what
is actually stored, leading to confusion and potential unexpected
behavior.

Fix this by changing the type of "tpgt" to u16 and using kstrtou16()
which will properly reject values outside the u16 range.

Fixes: a511ce3397803 ("sbp-target: Initial merge of firewire/ieee-1394 target mode support")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/target/sbp/sbp_target.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index 9f167ff8da7b..09120a538a40 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -1960,12 +1960,12 @@ static struct se_portal_group *sbp_make_tpg(struct se_wwn *wwn,
 		container_of(wwn, struct sbp_tport, tport_wwn);
 
 	struct sbp_tpg *tpg;
-	unsigned long tpgt;
+	u16 tpgt;
 	int ret;
 
 	if (strstr(name, "tpgt_") != name)
 		return ERR_PTR(-EINVAL);
-	if (kstrtoul(name + 5, 10, &tpgt) || tpgt > UINT_MAX)
+	if (kstrtou16(name + 5, 10, &tpgt))
 		return ERR_PTR(-EINVAL);
 
 	if (tport->tpg) {
-- 
2.34.1


