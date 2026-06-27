Return-Path: <target-devel+bounces-1236-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9gRBKBxjP2pNSgkAu9opvQ
	(envelope-from <target-devel+bounces-1236-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Sat, 27 Jun 2026 07:43:56 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176236D1357
	for <lists+target-devel@lfdr.de>; Sat, 27 Jun 2026 07:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=IrZ8LMpA;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1236-lists+target-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="target-devel+bounces-1236-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EED653056506
	for <lists+target-devel@lfdr.de>; Sat, 27 Jun 2026 05:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654B938E8D4;
	Sat, 27 Jun 2026 05:42:51 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from mail-wm1-f104.google.com (mail-wm1-f104.google.com [209.85.128.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2F388E7A
	for <target-devel@vger.kernel.org>; Sat, 27 Jun 2026 05:42:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538971; cv=none; b=gqCgzeiyKvWBtwNpdlcLQ3Q29EZLM3zV155ORnWNNMrsuJCGUVYmhhSJKl/sUZ4k8T0wpZAsx4G3/uiEILufXaLgBtxLM+n3Fdz95eJTB9LUdl6FXo0lnx0W3sgFOQAhYHge+z+J0RNEwRP4hNXsvBBgx3rMT+g7cSDSXJF3WtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538971; c=relaxed/simple;
	bh=3m0aj9nfgTpMPyTKR0ZRW5BNaB7D8LtbyalSkO5JWfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXBDdQ+qFBEuEC3UvVfwwNREGQnj6AINTD7eSSQ0dtx4Rxy9D1NHjF9J/KPdGA18+monXJvOkNLZCEaGn8kR5Vfm4tOTfuHi3ikzpQej1R28REnWoVgHVDvQBhN4EifQ+RkmfNAhuUr977w80QOmdv78drkbvRxv+BrvYqPtcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IrZ8LMpA; arc=none smtp.client-ip=209.85.128.104
Received: by mail-wm1-f104.google.com with SMTP id 5b1f17b1804b1-490791a3e92so820235e9.0
        for <target-devel@vger.kernel.org>; Fri, 26 Jun 2026 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538968; x=1783143768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TdMp+kUDXzcCHRaLfP/G+q/ZKBuIsQ8XItHm4El4CqI=;
        b=IrZ8LMpAFf2rtrlm4o1mva2y7IIHa82m7d3kd1p3482zXtCHojgrAA0dfJoktVB8h2
         zh0qwsoUoMs5a7bSGT+yv0kgcxUGK99JWgrHpjPDdoSLAfqWYLHtYv3Zh2kUya5aKlaM
         Bw6diaYQU0iuPmGQxRm7bDC66vT6Ye2LOFyeoYb01P2GzrjcmqVeMOqIu8sTOd2oKNb+
         akYGUbqwpjgE23drOmDhCxjR4fNHfoXpRpkk0JVPDSkhSK/UvwZ8fBd88NqJS4DF6zmP
         pBkkwBKJOTxL03EzDef1AbRPrfT9e1vN3aF1hEYgjOSO7Sawr3bmO12SbaFoFDiBBQpK
         m0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538968; x=1783143768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TdMp+kUDXzcCHRaLfP/G+q/ZKBuIsQ8XItHm4El4CqI=;
        b=XulUc401PuFQKtUEBdTyiS7pU/zevC1eOK+MaeyUY9T4P+rVF92TpGxHyP1GB94mN0
         oQmiKP3MRxPSzoLnYc2HWyNm353kMUIevmJ4VkfULP8S8zyHppqp5BsNRH5YUEnbOKlh
         mS1JHY9ADivU1C1pTVqYm5WQ5GQQ7hG3iSLTeqUa+SzgCOhn2/uuw488s6VUyCvDV2w4
         Ge72i1dO3Mc0Nm8xdgznJcN0MsZUTgt3E5HxSEsH5Q81byIoV8DBZXx1H0Mco+Oeq5Kh
         zhOL6kxpK6KfazVrSgbHLNGZxS6eAexqn0WUjYvPLdCy5kRS8D8k3HVKSBc+Fr8HtDc2
         XNlA==
X-Forwarded-Encrypted: i=1; AFNElJ9YA8NDrof/EEJPffa0M3IgodrkcZKyODuh/p6XUuowRfhfe3GvW0rvp6Jp25GOetTbRgkn9gyXS186n2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFwN5io+wu/TTWuYaMfk4UOKwsbf4u2UcLpt7EHVmbrHOZVIe
	aG5rh2JEX1ZfaPPEbz5OrE98ycWLYNj9lJ7hBgtT4Is+mX+UytpUptNLlj5ZO1gmdnUpgypuFBF
	2xLkCZXS33dg6/uLabW7ezLL12Yc2Gj62t2eb
X-Gm-Gg: AfdE7cmvtabeQIKuGzcdKdix60L5GwZd1wd3FM+NMpzt+3fYaUK9IMDvjOavokiy35+
	HHLTOETB1CwMO+4dYFg/IwBSyAL6s0NJOP7uPnkIWuQtNrQKdlqDD45oYCdrvArWXojTHEqpzG3
	qPIH8pdxlzQp22DKgAnMp7jhUGTriM0wodRNXXmzLodnLpzZKVFEpLuUpIzV2yOYStUvW2alAjL
	6PcEIjB9IDJcgbYy85ocIISuqPE2wAtp77O6gnffyQAa7gf+82h/mwtubWkqVUusNzwsRDH3CEY
	h/RXlEfE8jea3zlANTzRoWKeG189mIBsr+7rfFoQ5FlGw5nP249NCX7qfKKbs0NPXiftrzQ+Ylr
	DMgAR73Po3jWY5yjh6fyVBIq2PJqmiu4mB8ISbZi4nfo=
X-Received: by 2002:a05:600c:c043:b0:492:4708:d73d with SMTP id 5b1f17b1804b1-4926686b471mr48451735e9.1.1782538968091;
        Fri, 26 Jun 2026 22:42:48 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4926902d9b4sm2356335e9.14.2026.06.26.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id B2CB8402B4;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B0913E40712; Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
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
Subject: [PATCH v4 3/5] bio-integrity-fs: use integrity interval instead of sector as seed
Date: Fri, 26 Jun 2026 23:42:18 -0600
Message-ID: <20260627054220.2174166-4-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627054220.2174166-1-csander@purestorage.com>
References: <20260627054220.2174166-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-1236-lists,target-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[csander@purestorage.com,target-devel@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:martin.petersen@oracle.com,m:anuj20.g@samsung.com,m:linux-block@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:csander@purestorage.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[csander@purestorage.com,target-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,purestorage.com:from_mime,samsung.com:email,lst.de:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 176236D1357

bip_iter.bi_sector is meant to be in units of integrity intervals rather
than 512-byte sectors. bio_integrity_verify() doesn't actually use it
currently (it uses the passed in struct bvec_iter's bi_sector instead).
But let's set it to the expected value for consistency.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 9c5fe5fa8f0d..770eacb2220f 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -65,11 +65,11 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
-	bip->bip_iter.bi_sector = sector;
+	bip->bip_iter.bi_sector = bio_integrity_intervals(bi, sector);
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
 	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
-- 
2.54.0


