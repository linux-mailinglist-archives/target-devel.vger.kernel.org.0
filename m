Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD074AEC56
	for <lists+target-devel@lfdr.de>; Wed,  9 Feb 2022 09:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbiBII2u (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 9 Feb 2022 03:28:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiBII2s (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:28:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7DFC05CBA9;
        Wed,  9 Feb 2022 00:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/bt+Oy/BcFTxmfplM5PxJCE5IpUeX2/8fHWE4Zg7BxI=; b=3q5Kzgsf8lajnI+rgsdp8Bdhhy
        R3u48noc4rOlPQv3T17Kthhn822+iL9Ug3fUyvErnt6I3e1tRAHq6Ej2M+Olpso38aKV7kmCPzm4m
        0QiDdTXPpqoJIxNUy3hv0nuJtCGrTvhwjb49BiFQxWv2nYHY8RSv38UFWxULReIujLXU9GxwZ2u/R
        OQ9ZEaCgZKZZuNsn5BR6kmR5/e5n5DOna3lxiuX6AnC7uuicm2GL2iu1PKH1BkqGWzIBTDeygrAug
        cRzzQDOC5YaCNqomXeqCSV2aJQ3s5IFqNyirPJ4/1RckSdJlbyL+oXoTu9R15787kLs9MQgcInPNO
        4NH1UPEw==;
Received: from [2001:4bb8:188:3efc:ea2:7599:7eeb:4b5a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHiLJ-00GcFP-5b; Wed, 09 Feb 2022 08:28:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        target-devel@vger.kernel.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, manoj@linux.ibm.com, mrochs@linux.ibm.com,
        ukrishn@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        drbd-dev@lists.linbit.com, dm-devel@redhat.com
Subject: [PATCH 5/7] md: drop WRITE_SAME support
Date:   Wed,  9 Feb 2022 09:28:26 +0100
Message-Id: <20220209082828.2629273-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209082828.2629273-1-hch@lst.de>
References: <20220209082828.2629273-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

There are no more end-users of REQ_OP_WRITE_SAME left, so we can start
deleting it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-linear.c    | 1 -
 drivers/md/md-multipath.c | 1 -
 drivers/md/md.h           | 7 -------
 drivers/md/raid0.c        | 2 --
 drivers/md/raid1.c        | 4 +---
 drivers/md/raid10.c       | 1 -
 drivers/md/raid5.c        | 1 -
 7 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 1ff51647a6822..0f55b079371b1 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -259,7 +259,6 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		if (mddev->gendisk)
 			trace_block_bio_remap(bio, disk_devt(mddev->gendisk),
 					      bio_sector);
-		mddev_check_writesame(mddev, bio);
 		mddev_check_write_zeroes(mddev, bio);
 		submit_bio_noacct(bio);
 	}
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 97fb948e3e741..68dec76694d53 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -127,7 +127,6 @@ static bool multipath_make_request(struct mddev *mddev, struct bio * bio)
 	mp_bh->bio.bi_opf |= REQ_FAILFAST_TRANSPORT;
 	mp_bh->bio.bi_end_io = multipath_end_request;
 	mp_bh->bio.bi_private = mp_bh;
-	mddev_check_writesame(mddev, &mp_bh->bio);
 	mddev_check_write_zeroes(mddev, &mp_bh->bio);
 	submit_bio_noacct(&mp_bh->bio);
 	return true;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index f1bf3625ef4c9..6ac2838645336 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -797,13 +797,6 @@ static inline void mddev_clear_unsupported_flags(struct mddev *mddev,
 	mddev->flags &= ~unsupported_flags;
 }
 
-static inline void mddev_check_writesame(struct mddev *mddev, struct bio *bio)
-{
-	if (bio_op(bio) == REQ_OP_WRITE_SAME &&
-	    !bio->bi_bdev->bd_disk->queue->limits.max_write_same_sectors)
-		mddev->queue->limits.max_write_same_sectors = 0;
-}
-
 static inline void mddev_check_write_zeroes(struct mddev *mddev, struct bio *bio)
 {
 	if (bio_op(bio) == REQ_OP_WRITE_ZEROES &&
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index b59a77b31b90d..b21e101183f44 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -402,7 +402,6 @@ static int raid0_run(struct mddev *mddev)
 		bool discard_supported = false;
 
 		blk_queue_max_hw_sectors(mddev->queue, mddev->chunk_sectors);
-		blk_queue_max_write_same_sectors(mddev->queue, mddev->chunk_sectors);
 		blk_queue_max_write_zeroes_sectors(mddev->queue, mddev->chunk_sectors);
 		blk_queue_max_discard_sectors(mddev->queue, UINT_MAX);
 
@@ -594,7 +593,6 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 	if (mddev->gendisk)
 		trace_block_bio_remap(bio, disk_devt(mddev->gendisk),
 				      bio_sector);
-	mddev_check_writesame(mddev, bio);
 	mddev_check_write_zeroes(mddev, bio);
 	submit_bio_noacct(bio);
 	return true;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index c3288d46948de..9cec48d335065 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3147,10 +3147,8 @@ static int raid1_run(struct mddev *mddev)
 	if (IS_ERR(conf))
 		return PTR_ERR(conf);
 
-	if (mddev->queue) {
-		blk_queue_max_write_same_sectors(mddev->queue, 0);
+	if (mddev->queue)
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
-	}
 
 	rdev_for_each(rdev, mddev) {
 		if (!mddev->gendisk)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5dd2e17e1d0ea..764ca020b7a40 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4113,7 +4113,6 @@ static int raid10_run(struct mddev *mddev)
 	if (mddev->queue) {
 		blk_queue_max_discard_sectors(mddev->queue,
 					      UINT_MAX);
-		blk_queue_max_write_same_sectors(mddev->queue, 0);
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
 		blk_queue_io_min(mddev->queue, mddev->chunk_sectors << 9);
 		raid10_set_io_opt(conf);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8891aaba65964..f5f36fdd37336 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7767,7 +7767,6 @@ static int raid5_run(struct mddev *mddev)
 		mddev->queue->limits.discard_alignment = stripe;
 		mddev->queue->limits.discard_granularity = stripe;
 
-		blk_queue_max_write_same_sectors(mddev->queue, 0);
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
 
 		rdev_for_each(rdev, mddev) {
-- 
2.30.2

