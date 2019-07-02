Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0F5D2ED
	for <lists+target-devel@lfdr.de>; Tue,  2 Jul 2019 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfGBPal (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 2 Jul 2019 11:30:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46290 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBPak (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:30:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id i8so4642610pgm.13
        for <target-devel@vger.kernel.org>; Tue, 02 Jul 2019 08:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdxZDknBCH4Y0pORYGWSEKm4OhG9/jzP3OKwV//agmA=;
        b=tzKjdEouW5N17DlVUD979v3OGMTY0pgf3OiNFEc7vc2pcj+22tGV0QDiucnkE+S7L2
         PxXCkS5McL4DKXCL18KRBGIq85PEY5dLmdnK38dyu5Dkoz/R+R8WuWZ0vryfCUkxNhiu
         1fa0mZo6jqhlG5w1YWzpz6vcArxbxtIYkt7Ra/0Rg7p9kjU3okggCfxhH/lbZFbD+zNr
         GHHplost0+utblfuXuxgHdBDDf6p2SJPxOSwXSvPLBXKwEgBsv/h0hVDdJXwzHkF/+cV
         7BHlBR2mWNdIPMQWIL4sXrAmkogVVUFpHrX4yVN796VxRlAhfY6YoCi4CeXFF5TT/RLP
         B/bQ==
X-Gm-Message-State: APjAAAUE/jmkidaEd+hVucW3S3G52rdiiABmaioCIhh3rqB6OPiTUSVJ
        WGGDfdat9OM3wfF4pg65eYQ=
X-Google-Smtp-Source: APXvYqxUmPjeH4LnkrfEVZq95XdLyxE6+us+zl0iSDE33ixMKmb3kj04Wb5Uf5+KRIjR4AsQmqdavA==
X-Received: by 2002:a65:458d:: with SMTP id o13mr17524934pgq.34.1562081440058;
        Tue, 02 Jul 2019 08:30:40 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 4sm13715800pfc.92.2019.07.02.08.30.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 08:30:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] block: Add blkdev_submit_write_same()
Date:   Tue,  2 Jul 2019 08:30:30 -0700
Message-Id: <20190702153031.3832-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190702153031.3832-1-bvanassche@acm.org>
References: <20190702153031.3832-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Add an asynchronous version of blkdev_issue_write_same().

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-lib.c        | 37 ++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h |  3 +++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..f0cd9400d98a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -187,7 +187,8 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
  * @page:	page containing data
  *
  * Description:
- *    Issue a write same request for the sectors in question.
+ *    Issue a write same request for the sectors in question and wait until it
+ *    has finished.
  */
 int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 				sector_t nr_sects, gfp_t gfp_mask,
@@ -209,6 +210,40 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
+/**
+ * blkdev_submit_write_same - queue a write same operation
+ * @bdev:	target blockdev
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to write
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @page:	page containing data
+ * @bi_end_io:  will be called upon completion
+ * @bi_private: will be stored in the bio->bi_private field of the bio passed
+ *		to @bi_end_io.
+ *
+ * Description:
+ *    Submit a write same request asynchronously for the sectors in question.
+ *    @bi_end_io will be called upon request completion.
+ */
+int blkdev_submit_write_same(struct block_device *bdev, sector_t sector,
+			     sector_t nr_sects, gfp_t gfp_mask,
+			     struct page *page, bio_end_io_t bi_end_io,
+			     void *bi_private)
+{
+	struct bio *bio = NULL;
+	int ret;
+
+	ret = __blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask, page,
+					&bio);
+	if (ret)
+		return ret;
+	bio->bi_end_io = bi_end_io;
+	bio->bi_private = bi_private;
+	submit_bio(bio);
+	return 0;
+}
+EXPORT_SYMBOL(blkdev_submit_write_same);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1aafeb923e7b..3d627e0a72c0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1184,6 +1184,9 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 extern int blkdev_issue_flush(struct block_device *, gfp_t, sector_t *);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
+extern int blkdev_submit_write_same(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct page *page,
+		bio_end_io_t bi_end_io, void *bi_private);
 
 #define BLKDEV_DISCARD_SECURE	(1 << 0)	/* issue a secure erase */
 
-- 
2.22.0.410.gd8fdbe21b5-goog

