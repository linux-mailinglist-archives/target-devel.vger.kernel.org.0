Return-Path: <target-devel+bounces-1234-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zsz4DO5iP2o9SgkAu9opvQ
	(envelope-from <target-devel+bounces-1234-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Sat, 27 Jun 2026 07:43:10 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F58C6D1336
	for <lists+target-devel@lfdr.de>; Sat, 27 Jun 2026 07:43:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=CWCUvefa;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1234-lists+target-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="target-devel+bounces-1234-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EDC1301440E
	for <lists+target-devel@lfdr.de>; Sat, 27 Jun 2026 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF43815F0;
	Sat, 27 Jun 2026 05:42:50 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from mail-pj1-f102.google.com (mail-pj1-f102.google.com [209.85.216.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D305331EC3
	for <target-devel@vger.kernel.org>; Sat, 27 Jun 2026 05:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538970; cv=none; b=eoxrh3UvswdQ4L9IeXkde7GSGyg/3ms29SprAIRUKIvgnNOGkMIEmcpUc4R7aZWhgEccTrraqVW75OqDBx/khCe8gU1tXOR/pa6bSxbooVOEbyQxcjq1vtVztnSVLxaSaE6dtwItxR8FRJwR4BQpln7zhEuLuVSTPRSZ1d5DLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538970; c=relaxed/simple;
	bh=ibHZUitqlYEsZVyxLJ8fClmaaZMHceqKSYFgEU/W9Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6mzMqjcco3iL1oW6cSOCPysKPO4YZZ/PI7H+1aAYKxWzJk8OKJX8fRq/DVuS8CXAv+6cNtfZgtyiDZZo/Hy/YN0lCXzGiXqOnRU/ty79B5GvHln0M7c2ZzcUgJ4VN/D5S0Y+pjeI2Kxh/Sf8EXymUChMF26SEG7MhKY8vJFr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CWCUvefa; arc=none smtp.client-ip=209.85.216.102
Received: by mail-pj1-f102.google.com with SMTP id 98e67ed59e1d1-37e203c7deeso77341a91.3
        for <target-devel@vger.kernel.org>; Fri, 26 Jun 2026 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538967; x=1783143767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LBI2TZBBdvnIGwxDwxfcA0X2DAXeqtxaRyAM5YR83X8=;
        b=CWCUvefaDDQch/+W35Qc+2rLWEJHBY9EPbsKXfHAsoZBU+Y/jlJPlY1axXuRB0uZNo
         NgmRAQ4S1Vaoi1w1KsL3hhe0LDWfMvcb9uk46rKBuJeMZPL6eveSY05tVaGmTA5liGpA
         +wDfqNs3pdsdjA2cK/EHSfKkJ6S1cYoVa7q/QsWvlaNsKbBki4h+fiOl5LKy+4LvEHZe
         hIdyZOoTIkhqKWkxd9ZK63LgQA06dr/xondc4LzkUvtIXuO0MI5yRXSISHWXf/uwfEHq
         sSUHiuRvZkN2W//7VOX+q7FMBwHjSBXydMp9fydZfhGvuQqrHVOj1Eo1P2g5PHsiU+o5
         U6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538967; x=1783143767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBI2TZBBdvnIGwxDwxfcA0X2DAXeqtxaRyAM5YR83X8=;
        b=X0/CRC5JdlSIpVOzZuIJqI8LigLJ8PK45PLXMCjRAA0U/W0srRlqb9kTiuqyDF8GMg
         nGF7AfdkTwC/TtGAUOzE/3yw1I8cmO19UVl8NLlVB4Bzhr/cjMeTvzUzc844M4UjD3HG
         /nI1jmFIu7ualAxqviLniUUdsa/2zb6eGYla5KUDKu7pDTvxwrhWuLAn2DsO/sZqZa8P
         GxJgGLRYFGOg67IdYCrdhQCxKpwuR9ej+Ze8v5bqj/fX5bGB9AUbZI/Eyx8SLZ5kfg+8
         xdaty9i9gUQdLw5cexWpmv+xIuT5O5IqCjVQ9B76u19rvYLTP7qru5fqjdH6/jHeQydv
         r25A==
X-Forwarded-Encrypted: i=1; AHgh+RoyOxquMl/qPwPfoWSlpar6fGKKX0KbmspPYQeZF9wIQG5zeGG0ukX2eIIRUj6Mqiln5lTmgt9tG9ltga0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj39TJ8aLsdZCS4OptBHLGW5zFmcQoxECqHLgCeTL8jxHkMoJu
	RHecc+aYGpG9Yx+J4mwMmDhmipmn7fOP2IqKqPVqyVHfLVI/KPFKusRuNff0x71L1nZ7SVS1yuw
	9Umv8WbB1OtGfB0CZ4yLUOP+sI3/FIoPKjl1WiHIv5uGLSEfJ7Udx
X-Gm-Gg: AfdE7cnXkW72mJnX+X1EA4T6Rn03rvMHsRfJZipKK0CKoy5YX7jzjUNt7Yp6329CtXZ
	wlFgG22kVe3hROJP+REHQRnfIPh5RPQM4cKrGTM7uvzDDS53a/R5BFQnNzgkNHalxgrTvSYAMrj
	x/xVjCSjYn6JiB13I/aEzHl1Zr7xwcCf3Wn2LMdboncokZb0QHOnkS2ElVOUzNIGNN/yLvGwiHj
	KUYZH11ZrbDbBh7ltOfUz3HH8KkzIzZjCTnpnonMCNcnFZ9RUoQOuIKWuh/mjbF54eW9ZRurN2Q
	4wGZoTLx+hFM4+wCy2wpT/66HpxMwkkT7x/glAvwyOf0DjzdTKcLIOS27jrt5azpIPADp6cQvLC
	UJobleeb219yXTYYBmh99AVcq7RAY
X-Received: by 2002:a17:90b:5207:b0:364:be8f:1d86 with SMTP id 98e67ed59e1d1-37dfa223d7dmr4789320a91.8.1782538966692;
        Fri, 26 Jun 2026 22:42:46 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-37fb11c60c1sm166693a91.3.2026.06.26.22.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 0809840146;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F351FE40712; Fri, 26 Jun 2026 23:42:45 -0600 (MDT)
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
Subject: [PATCH v4 0/5] block: use integrity interval instead of sector as seed
Date: Fri, 26 Jun 2026 23:42:15 -0600
Message-ID: <20260627054220.2174166-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
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
	TAGGED_FROM(0.00)[bounces-1234-lists,target-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,purestorage.com:dkim,purestorage.com:mid,purestorage.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F58C6D1336

The block integrity layer currently sets the integrity seed (initial
reference tag) in units of 512-byte sectors. However, Type 1 and Type 2
ref tags are actually in units of integrity intervals. On devices with
integrity interval size > 512 bytes, ref tags are seeded incorrectly.

Ref tag "remapping" in blk_integrity_{prepare,complete}() covers up this
ref tag seed discrepancy by offsetting all ref tags in each bio to
convert to/from the absolute integrity interval numbers. But
REQ_OP_ZONE_APPEND operations don't have their ref tags remapped, so the
ref tags using units of sectors will be stored to the device. As future
optimizations, the ref tag remapping could be avoided entirely on NVMe
and some SCSI devices by passing the ref tag seed instead of the
absolute integrity interval as the expected initial ref tag.

So avoid relying on remapping to convert between the ref tag seed in
units of sectors and stored ref tags in units of integrity intervals.
Initialize the ref tag seed as the integrity interval, not sector.

The subsequent commits clean up the integrity ref tag seed code a bit.

v4:
- Drop patch already applied

v3: https://lore.kernel.org/linux-block/20260417015732.2692434-1-csander@purestorage.com/T/
- Drop bi and bip arguments to bip_set_seed() (Christoph)

v2:
- Reorder fixes before refactoring commits
- Use u64, SECTOR_SHIFT (Christoph)
- Don't take sector_t in bip_set_seed() (Christoph)

Caleb Sander Mateos (5):
  block: use integrity interval instead of sector as seed
  blk-integrity: take u64 in bio_integrity_intervals()
  bio-integrity-fs: use integrity interval instead of sector as seed
  t10-pi: use bio_integrity_intervals() helper
  blk-integrity: avoid sector_t in bip_{get,set}_seed()

 block/bio-integrity-fs.c            |  2 +-
 block/bio-integrity.c               |  4 ++--
 block/t10-pi.c                      |  7 ++++---
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 27 ++++++++++++++++++++-------
 include/linux/bvec.h                |  1 +
 8 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.54.0


