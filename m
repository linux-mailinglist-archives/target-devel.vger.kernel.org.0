Return-Path: <target-devel+bounces-279-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC0BA0051F
	for <lists+target-devel@lfdr.de>; Fri,  3 Jan 2025 08:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361121884078
	for <lists+target-devel@lfdr.de>; Fri,  3 Jan 2025 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C831C878A;
	Fri,  3 Jan 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KhEFc0Tf"
X-Original-To: target-devel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27451C3038;
	Fri,  3 Jan 2025 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889667; cv=none; b=a/fWTIFCzJgcNENbwdbxTCUWj1rcOPXf4125HXQ8rh3AFTYxgsS+It1fmq9aOFxm120xg+6w5u9Qi1auEo0mL9K/UFpXQyq1pHhdC/MYtilYKnFxK/j1PvEumfJWVjtUGZON2Zg+3VhIZF0/OS68EvKQjl0zkUYYaQQUgrN7R7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889667; c=relaxed/simple;
	bh=HLC8+sUa/gaVgHdD8ERRdIIY3pU/x8dMC7eFeb2+uqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApGKVrmpX5Axosrvw706yNyKAgUOqb3cB8asikRi8d7XQK+N/aS/PbbQTsUHMHcZRKd6hwJRVxbipsSLgrNuZJIysVR+0hleexGuMNdju/R8FJZ++8nVDoHnH3nMyDHgd9/Kj+Xubs0RHCefJRfw3tpkEsJ+cdtl8gyhdQGxVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KhEFc0Tf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VVFlNu9bxQTZS7Btz5YwbK8YSvrmLzswqaqg99lMe0k=; b=KhEFc0TfX5GM90I3XpgGENvZb1
	lrNsNgCMUxluVdDs4iOznFoAMJ7ckEpPbCKNGel44ysxYDz21cwqCk+OChwMkmNWTOProz+1VJSIq
	KVW/Fs6RwT+RIwM6CUCBOar39BNaL8cLMg1jCg3gAVGA2U/hvpoJCiwL9S5CEQArm0lQ0Mc08Cs9a
	0mQujB2HSD69bmAhZxl8G6jbvs9sfMM5NUNSVAHGqx7gVuDRHM0T5snJvu7Exuz5SfN8lfn/iqM3d
	JT392usb70vw3UOihKwRFtEyEszr/u7f9yyihHStmZB0J3xUN2DLicHGxth/jpyvY5olKZtdBU6+N
	C2G7WtEw==;
Received: from [2001:4bb8:2dc:484c:63c3:48c7:ceee:8370] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcCN-0000000CM5H-2epI;
	Fri, 03 Jan 2025 07:34:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH 1/2] block: remove bio_add_pc_page
Date: Fri,  3 Jan 2025 08:33:57 +0100
Message-ID: <20250103073417.459715-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250103073417.459715-1-hch@lst.de>
References: <20250103073417.459715-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Lift bio_split_rw_at into blk_rq_append_bio so that it validates the
hardware limits.  With this all passthrough callers can simply add
bio_add_page to build the bio and delay checking for exceeding of limits
to this point instead of doing it for each page.

While this looks like adding a new expensive loop over all bio_vecs,
blk_rq_append_bio is already doing that just to counter the number of
segments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                        | 107 ++------------------------
 block/blk-map.c                    | 118 +++++++----------------------
 block/blk.h                        |   8 --
 drivers/nvme/target/passthru.c     |  18 +++--
 drivers/nvme/target/zns.c          |   3 +-
 drivers/target/target_core_pscsi.c |   6 +-
 include/linux/bio.h                |   2 -
 7 files changed, 48 insertions(+), 214 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d5bdc31d88d3..4e1a27d312c9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -946,8 +946,11 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 
 /*
  * Try to merge a page into a segment, while obeying the hardware segment
- * size limit.  This is not for normal read/write bios, but for passthrough
- * or Zone Append operations that we can't split.
+ * size limit.
+ *
+ * This is kept around for the integrity metadata, which is still tries
+ * to build the initial bio to the hardware limit and doesn't have proper
+ * helpers to split.  Hopefully this will go away soon.
  */
 bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		struct page *page, unsigned len, unsigned offset,
@@ -964,106 +967,6 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 	return bvec_try_merge_page(bv, page, len, offset, same_page);
 }
 
-/**
- * bio_add_hw_page - attempt to add a page to a bio with hw constraints
- * @q: the target queue
- * @bio: destination bio
- * @page: page to add
- * @len: vec entry length
- * @offset: vec entry offset
- * @max_sectors: maximum number of sectors that can be added
- * @same_page: return if the segment has been merged inside the same page
- *
- * Add a page to a bio while respecting the hardware max_sectors, max_segment
- * and gap limitations.
- */
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page)
-{
-	unsigned int max_size = max_sectors << SECTOR_SHIFT;
-
-	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
-		return 0;
-
-	len = min3(len, max_size, queue_max_segment_size(q));
-	if (len > max_size - bio->bi_iter.bi_size)
-		return 0;
-
-	if (bio->bi_vcnt > 0) {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
-				same_page)) {
-			bio->bi_iter.bi_size += len;
-			return len;
-		}
-
-		if (bio->bi_vcnt >=
-		    min(bio->bi_max_vecs, queue_max_segments(q)))
-			return 0;
-
-		/*
-		 * If the queue doesn't support SG gaps and adding this segment
-		 * would create a gap, disallow it.
-		 */
-		if (bvec_gap_to_prev(&q->limits, bv, offset))
-			return 0;
-	}
-
-	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
-	bio->bi_vcnt++;
-	bio->bi_iter.bi_size += len;
-	return len;
-}
-
-/**
- * bio_add_hw_folio - attempt to add a folio to a bio with hw constraints
- * @q: the target queue
- * @bio: destination bio
- * @folio: folio to add
- * @len: vec entry length
- * @offset: vec entry offset in the folio
- * @max_sectors: maximum number of sectors that can be added
- * @same_page: return if the segment has been merged inside the same folio
- *
- * Add a folio to a bio while respecting the hardware max_sectors, max_segment
- * and gap limitations.
- */
-int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
-		struct folio *folio, size_t len, size_t offset,
-		unsigned int max_sectors, bool *same_page)
-{
-	if (len > UINT_MAX || offset > UINT_MAX)
-		return 0;
-	return bio_add_hw_page(q, bio, folio_page(folio, 0), len, offset,
-			       max_sectors, same_page);
-}
-
-/**
- * bio_add_pc_page	- attempt to add page to passthrough bio
- * @q: the target queue
- * @bio: destination bio
- * @page: page to add
- * @len: vec entry length
- * @offset: vec entry offset
- *
- * Attempt to add a page to the bio_vec maplist. This can fail for a
- * number of reasons, such as the bio being full or target block device
- * limitations. The target block device must allow bio's up to PAGE_SIZE,
- * so it is always possible to add a single page to an empty bio.
- *
- * This should only be used by passthrough bios.
- */
-int bio_add_pc_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset)
-{
-	bool same_page = false;
-	return bio_add_hw_page(q, bio, page, len, offset,
-			queue_max_hw_sectors(q), &same_page);
-}
-EXPORT_SYMBOL(bio_add_pc_page);
-
 /**
  * __bio_add_page - add page(s) to a bio in a new segment
  * @bio: destination bio
diff --git a/block/blk-map.c b/block/blk-map.c
index 894009b2d881..67a2da3b7ed9 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -189,7 +189,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 			}
 		}
 
-		if (bio_add_pc_page(rq->q, bio, page, bytes, offset) < bytes) {
+		if (bio_add_page(bio, page, bytes, offset) < bytes) {
 			if (!map_data)
 				__free_page(page);
 			break;
@@ -272,86 +272,27 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		gfp_t gfp_mask)
 {
-	iov_iter_extraction_t extraction_flags = 0;
-	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
 	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
 	struct bio *bio;
 	int ret;
-	int j;
 
 	if (!iov_iter_count(iter))
 		return -EINVAL;
 
 	bio = blk_rq_map_bio_alloc(rq, nr_vecs, gfp_mask);
-	if (bio == NULL)
+	if (!bio)
 		return -ENOMEM;
-
-	if (blk_queue_pci_p2pdma(rq->q))
-		extraction_flags |= ITER_ALLOW_P2PDMA;
-	if (iov_iter_extract_will_pin(iter))
-		bio_set_flag(bio, BIO_PAGE_PINNED);
-
-	while (iov_iter_count(iter)) {
-		struct page *stack_pages[UIO_FASTIOV];
-		struct page **pages = stack_pages;
-		ssize_t bytes;
-		size_t offs;
-		int npages;
-
-		if (nr_vecs > ARRAY_SIZE(stack_pages))
-			pages = NULL;
-
-		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
-					       nr_vecs, extraction_flags, &offs);
-		if (unlikely(bytes <= 0)) {
-			ret = bytes ? bytes : -EFAULT;
-			goto out_unmap;
-		}
-
-		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
-
-		if (unlikely(offs & queue_dma_alignment(rq->q)))
-			j = 0;
-		else {
-			for (j = 0; j < npages; j++) {
-				struct page *page = pages[j];
-				unsigned int n = PAGE_SIZE - offs;
-				bool same_page = false;
-
-				if (n > bytes)
-					n = bytes;
-
-				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page))
-					break;
-
-				if (same_page)
-					bio_release_page(bio, page);
-				bytes -= n;
-				offs = 0;
-			}
-		}
-		/*
-		 * release the pages we didn't map into the bio, if any
-		 */
-		while (j < npages)
-			bio_release_page(bio, pages[j++]);
-		if (pages != stack_pages)
-			kvfree(pages);
-		/* couldn't stuff something into bio? */
-		if (bytes) {
-			iov_iter_revert(iter, bytes);
-			break;
-		}
-	}
-
+	ret = bio_iov_iter_get_pages(bio, iter);
+	if (ret)
+		goto out_put;
 	ret = blk_rq_append_bio(rq, bio);
 	if (ret)
-		goto out_unmap;
+		goto out_release;
 	return 0;
 
- out_unmap:
+out_release:
 	bio_release_pages(bio, false);
+out_put:
 	blk_mq_map_bio_put(bio);
 	return ret;
 }
@@ -422,8 +363,7 @@ static struct bio *bio_map_kern(struct request_queue *q, void *data,
 			page = virt_to_page(data);
 		else
 			page = vmalloc_to_page(data);
-		if (bio_add_pc_page(q, bio, page, bytes,
-				    offset) < bytes) {
+		if (bio_add_page(bio, page, bytes, offset) < bytes) {
 			/* we don't support partial mappings */
 			bio_uninit(bio);
 			kfree(bio);
@@ -507,7 +447,7 @@ static struct bio *bio_copy_kern(struct request_queue *q, void *data,
 		if (!reading)
 			memcpy(page_address(page), p, bytes);
 
-		if (bio_add_pc_page(q, bio, page, bytes, 0) < bytes)
+		if (bio_add_page(bio, page, bytes, 0) < bytes)
 			break;
 
 		len -= bytes;
@@ -536,12 +476,19 @@ static struct bio *bio_copy_kern(struct request_queue *q, void *data,
  */
 int blk_rq_append_bio(struct request *rq, struct bio *bio)
 {
-	struct bvec_iter iter;
-	struct bio_vec bv;
+	const struct queue_limits *lim = &rq->q->limits;
+	unsigned int max_bytes = lim->max_hw_sectors << SECTOR_SHIFT;
 	unsigned int nr_segs = 0;
+	int ret;
 
-	bio_for_each_bvec(bv, bio, iter)
-		nr_segs++;
+	/* check that the data layout matches the hardware restrictions */
+	ret = bio_split_rw_at(bio, lim, &nr_segs, max_bytes);
+	if (ret) {
+		/* if we would have to split the bio, copy instead */
+		if (ret > 0)
+			ret = -EREMOTEIO;
+		return ret;
+	}
 
 	if (!rq->bio) {
 		blk_rq_bio_prep(rq, bio, nr_segs);
@@ -561,9 +508,7 @@ EXPORT_SYMBOL(blk_rq_append_bio);
 /* Prepare bio for passthrough IO given ITER_BVEC iter */
 static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
-	const struct queue_limits *lim = &rq->q->limits;
-	unsigned int max_bytes = lim->max_hw_sectors << SECTOR_SHIFT;
-	unsigned int nsegs;
+	unsigned int max_bytes = rq->q->limits.max_hw_sectors << SECTOR_SHIFT;
 	struct bio *bio;
 	int ret;
 
@@ -576,18 +521,10 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 		return -ENOMEM;
 	bio_iov_bvec_set(bio, iter);
 
-	/* check that the data layout matches the hardware restrictions */
-	ret = bio_split_rw_at(bio, lim, &nsegs, max_bytes);
-	if (ret) {
-		/* if we would have to split the bio, copy instead */
-		if (ret > 0)
-			ret = -EREMOTEIO;
+	ret = blk_rq_append_bio(rq, bio);
+	if (ret)
 		blk_mq_map_bio_put(bio);
-		return ret;
-	}
-
-	blk_rq_bio_prep(rq, bio, nsegs);
-	return 0;
+	return ret;
 }
 
 /**
@@ -644,8 +581,11 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 			ret = bio_copy_user_iov(rq, map_data, &i, gfp_mask);
 		else
 			ret = bio_map_user_iov(rq, &i, gfp_mask);
-		if (ret)
+		if (ret) {
+			if (ret == -EREMOTEIO)
+				ret = -EINVAL;
 			goto unmap_rq;
+		}
 		if (!bio)
 			bio = rq->bio;
 	} while (iov_iter_count(&i));
diff --git a/block/blk.h b/block/blk.h
index cbf6a676ffe9..4904b86d5fec 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -556,14 +556,6 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass);
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
-int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
-		struct folio *folio, size_t len, size_t offset,
-		unsigned int max_sectors, bool *same_page);
-
 /*
  * Clean up a page appropriately, where the page may be pinned, may have a
  * ref taken on it or neither.
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 30b21936b0c6..26e2907ce8bb 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -261,6 +261,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	struct scatterlist *sg;
 	struct bio *bio;
+	int ret = -EINVAL;
 	int i;
 
 	if (req->sg_cnt > BIO_MAX_VECS)
@@ -277,16 +278,19 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	}
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
-		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
-				    sg->offset) < sg->length) {
-			nvmet_req_bio_put(req, bio);
-			return -EINVAL;
-		}
+		if (bio_add_page(bio, sg_page(sg), sg->length, sg->offset) <
+				sg->length)
+			goto out_bio_put;
 	}
 
-	blk_rq_bio_prep(rq, bio, req->sg_cnt);
-
+	ret = blk_rq_append_bio(rq, bio);
+	if (ret)
+		goto out_bio_put;
 	return 0;
+
+out_bio_put:
+	nvmet_req_bio_put(req, bio);
+	return ret;
 }
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 3aef35b05111..29a60fabfcc8 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -586,8 +586,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
 		unsigned int len = sg->length;
 
-		if (bio_add_pc_page(bdev_get_queue(bio->bi_bdev), bio,
-				sg_page(sg), len, sg->offset) != len) {
+		if (bio_add_page(bio, sg_page(sg), len, sg->offset) != len) {
 			status = NVME_SC_INTERNAL;
 			goto out_put_bio;
 		}
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 287ac5b0495f..f991cf759836 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -823,7 +823,6 @@ static sense_reason_t
 pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		struct request *req)
 {
-	struct pscsi_dev_virt *pdv = PSCSI_DEV(cmd->se_dev);
 	struct bio *bio = NULL;
 	struct page *page;
 	struct scatterlist *sg;
@@ -871,12 +870,11 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 					(rw) ? "rw" : "r", nr_vecs);
 			}
 
-			pr_debug("PSCSI: Calling bio_add_pc_page() i: %d"
+			pr_debug("PSCSI: Calling bio_add_page() i: %d"
 				" bio: %p page: %p len: %d off: %d\n", i, bio,
 				page, len, off);
 
-			rc = bio_add_pc_page(pdv->pdv_sd->request_queue,
-					bio, page, bytes, off);
+			rc = bio_add_page(bio, page, bytes, off);
 			pr_debug("PSCSI: bio->bi_vcnt: %d nr_vecs: %d\n",
 				bio_segments(bio), nr_vecs);
 			if (rc != bytes) {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1eec59699100..4b79bf50f4f0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -413,8 +413,6 @@ int __must_check bio_add_page(struct bio *bio, struct page *page, unsigned len,
 			      unsigned off);
 bool __must_check bio_add_folio(struct bio *bio, struct folio *folio,
 				size_t len, size_t off);
-extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
-			   unsigned int, unsigned int);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
-- 
2.45.2


