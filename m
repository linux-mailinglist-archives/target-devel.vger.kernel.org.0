Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA625BA54
	for <lists+target-devel@lfdr.de>; Thu,  3 Sep 2020 07:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgICFlb (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Sep 2020 01:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgICFlS (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:41:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3939EC061244;
        Wed,  2 Sep 2020 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xjOqc+Vfodq43UipqqbtBRKcpxkkULzdvtdrdqfm2Bg=; b=WNcNy8nqYOnva0Pe9CYAqbuz0u
        fZksAXJdUo/XKD5zc/Ei+HS3lCUioMsv4CapxLfk3/U2H/3ijZdpScwG6v2iGvwCeVRFo0jML67at
        J8W9xHgDm+AOzhKCYdFHlZefJSaWO34tgo4U3gPRppUjaoabuvs55Ylm2fyAtGXztFA8Ao7iRbznw
        w3OHy0XuJTeco8ABry6a0qtYIeuB5sEdh6oEwNlNVqeVHrWYue1feIOAHtr/hqlf74QugzuMymdmF
        +XVGVVD9p7cOEf39F2EhgxoT/ZWi6WrYyz9ekHwUXNlgls1hw/L63eiL2IccgB2pHAEi08hTlb7m8
        TqWVjPPg==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDhzm-0007P4-AB; Thu, 03 Sep 2020 05:41:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH 8/9] block: use bd_partno in bdevname
Date:   Thu,  3 Sep 2020 07:41:03 +0200
Message-Id: <20200903054104.228829-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903054104.228829-1-hch@lst.de>
References: <20200903054104.228829-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

No need to go through the hd_struct to find the partition number.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 081f1039d9367f..771aa56b1a8c3d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -85,7 +85,7 @@ char *disk_name(struct gendisk *hd, int partno, char *buf)
 
 const char *bdevname(struct block_device *bdev, char *buf)
 {
-	return disk_name(bdev->bd_disk, bdev->bd_part->partno, buf);
+	return disk_name(bdev->bd_disk, bdev->bd_partno, buf);
 }
 EXPORT_SYMBOL(bdevname);
 
-- 
2.28.0

