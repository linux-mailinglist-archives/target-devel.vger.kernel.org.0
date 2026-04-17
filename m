Return-Path: <target-devel+bounces-1097-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC35FyOU4WkVvAAAu9opvQ
	(envelope-from <target-devel+bounces-1097-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Fri, 17 Apr 2026 04:00:03 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B641618A
	for <lists+target-devel@lfdr.de>; Fri, 17 Apr 2026 04:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FAAA308DDA4
	for <lists+target-devel@lfdr.de>; Fri, 17 Apr 2026 01:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD12DCC1F;
	Fri, 17 Apr 2026 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AFvkSnDU"
X-Original-To: target-devel@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D62D249B
	for <target-devel@vger.kernel.org>; Fri, 17 Apr 2026 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391072; cv=none; b=g+QiFxQxhfPl0ffTdwD2DA/BGHdyrCe2PU+QKXIAiQlellSDuHCC6gfKctW6jzv6EkQiYdT/QDnw7+Y+DdKCnZIftJmUqpXeS+8Un+PnFCBEaio69iRrwP7RPKXQz+dQqtnv9ZecR9GrtuYl5cKZVzOGbgqL30DYpbtpokUFIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391072; c=relaxed/simple;
	bh=D1sF5rCpyJ8v1Q/Gw4hLl9PjXnZwN2O7sQ73iHxyGO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqP3ZK0gzMUxQMh/U1soJBswh2FEJsLRP3Y0R5aAbJcnsWs5Q7Dsvc0x9AuvF15ZriTVU4+/SirSScgyFjjfheaKyG2bKa17IXywegy/IV7yof01Qklhc3YtG69jhcM/SlSpwJjmPUhURznMbOgfBLpQbZuNnaZpKcVyx3iCl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AFvkSnDU; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3597822d6d8so20384a91.3
        for <target-devel@vger.kernel.org>; Thu, 16 Apr 2026 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391062; x=1776995862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=;
        b=AFvkSnDUcK3u1Z91caVhRRC7hPOoHYN5oMUDYLNsn1oapZb2taaVA74MEYy3uy1u2s
         mkA0uFhcwjmNZrN3CJKgLYa05x/RXD/8mvlp48UXaYdGnqNz0HFZs9tH+R9cPrVtmJVi
         R7rwtpxbDoq6HX6DHaNz9/yAOVUvy0r+fLX4LUhYB261yQc5rOV0aswngv945idzpHoN
         5/7DAN5v+81jzxH4wFidWM3vpGVwB2oLYb1BAHkdlTq0yE8PUfJdWcEHQXeweCtbbMrj
         ya+0cEmczxyk9+BV3fWb13UX03yrFNTzRv6/4ixTBeNXVmYkwJBfW/8hQ/y9FxVzd8Rf
         q5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391062; x=1776995862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=;
        b=Rr3hCNE/RJe/HxE7UcWf1rzWr4Cb0Pyjo0PXmPJcsnnUtEFfw3PmCuPWr81w+rX2gU
         X8obSK/S4ITkKeaWyHxN2DoAQXMVWoRXB2FEU/Veuf54fUhF2+IAxHDr0PB7sum8hQ84
         isMzIlC4HE1xTfkMPMgIzaPwdvEnlwK7wYa/0S+N/2z6MBjQVKJbt3T95/NWjZpSD0UL
         wGiJYRg4ctUBP3gQolPndEk+t8Qu7/AHdte4cTp/3lqQX4+53xkO6koxVem2PXKlIIMb
         +NcJdluPm5UiJmZRMwqmzU3NDXBQEjmfV+bBdZCXY3d2drJ8zwkvMw7PJ1P5U8ZbQBId
         MOkw==
X-Forwarded-Encrypted: i=1; AFNElJ/fFPSCnd69oE7R09Jis2yPtn6ZD0MUfUejmR56m8q7b9BetUut+sj6rpQ8nBjOtmO90SZFkHxZy62Euf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQsB1/SHnhQoQrgVhB2zKHKVOjk6m5fzmb4EZq2Ud7LxSvdryJ
	yS2FKwvcqB06nWAiKE0kDhRTcvARAZAd8dJRNRqcD8hY9/ioIR1FKGQIva+nQpPAXettz54MWGs
	XQPN64vx3B25mv8bx1oH20WRyzP+9KRmJaft1
X-Gm-Gg: AeBDies+momSbusU1i5G+bdq83Dh03++mylvEgQez8TrGBhGWEwPX7wu5ujPPa4rfeP
	4DC4vw7ah9tdiyQIiXOVbPDQofO/6VF46uqnwOOFAktfgOWnBYazUitSaNUX/vaD0gG0jXVKJxG
	ybnPhmuOxY3dZMCY99xZYYPSI5gvyaTiOF7M+UY3JVms4wDGnfcVaU5uHv3tz09LImStmKIgOWh
	lSXXz1oll6KaKP5QWfIe4LJThDAWSEbB/M5vnBWLRF4fFKJymRW7PbbCovFODrMX7kccHELegB8
	fYSTqvgvw/+rMGfQB7y7lYaD+xcx3xdG2TMrGBeTPZRVn9n4ZE7hwjY5OZa1PynMj0YYX+qracQ
	PsKLi4sjObf66J+D5LgYYcK/9e+vkHWevYFXmnxCMqveuHupq+h7twpdUCYCOs3oT
X-Received: by 2002:a17:902:b68f:b0:2b2:48a5:45c3 with SMTP id d9443c01a7336-2b5f9eceb6amr2890535ad.1.1776391062085;
        Thu, 16 Apr 2026 18:57:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b5faa0fa70sm233095ad.14.2026.04.16.18.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 658EC3406AA;
	Thu, 16 Apr 2026 19:57:41 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 60208E406BE; Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 5/6] t10-pi: use bio_integrity_intervals() helper
Date: Thu, 16 Apr 2026 19:57:31 -0600
Message-ID: <20260417015732.2692434-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1097-lists,target-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[csander@purestorage.com,target-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A76B641618A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use bio_integrity_intervals() to convert blk_rq_pos(rq) to integrity
intervals to reduce code duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/t10-pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index e58d5eb6cefb..787950dec50a 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -541,11 +541,11 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 
 static void blk_integrity_remap(struct request *rq, unsigned int nr_bytes,
 				bool prep)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	u64 ref = blk_rq_pos(rq) >> (bi->interval_exp - SECTOR_SHIFT);
+	u64 ref = bio_integrity_intervals(bi, blk_rq_pos(rq));
 	unsigned intervals = nr_bytes >> bi->interval_exp;
 	struct bio *bio;
 
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
-- 
2.45.2


