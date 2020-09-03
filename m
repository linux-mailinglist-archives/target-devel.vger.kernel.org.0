Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2B25BA4D
	for <lists+target-devel@lfdr.de>; Thu,  3 Sep 2020 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgICFlW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Sep 2020 01:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgICFlT (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:41:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E38C061245;
        Wed,  2 Sep 2020 22:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PDDS77sAPSIZFArA/0S+VI7w4DI6NJXa0hSpUTbG7Rs=; b=Krxxdk4NvudfjDXcJnPryEm/Q9
        WJDzvGB3HJEsqrbdJUv/Q7RMbq0HHNJ18yBB7qa8ZQUCjotP13wWb9McdzrfDxD4eaeMZQDOhm7qu
        ptCH9VrXv1f8rI1PyG+dfvthCjEn16VkHgXa/YvPWbM3D1dBygpzlcVvxEH0MsP+pJmOnJS/8XxPt
        lQonnNStJ0G41oUbx7y/ejplHnKDLwsRzVKulICM9Q3HHNAqbC68bVVaJPyBNFs0JPMLIk46wIPf5
        Y8mR6Ul/SpgoKf3bdKXiLueOyRu1lu0h7XX1FpK9hj8xiw4yICX6TLodwGHRhri5uqIjv8oLTM44m
        c8CeChjw==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDhzn-0007PA-BQ; Thu, 03 Sep 2020 05:41:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH 9/9] vsprintf: use bd_partno in bdev_name
Date:   Thu,  3 Sep 2020 07:41:04 +0200
Message-Id: <20200903054104.228829-10-hch@lst.de>
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
 lib/vsprintf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index afb9521ddf9197..14c9a6af1b239a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -940,13 +940,13 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 
 	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
-	if (bdev->bd_part->partno) {
+	if (bdev->bd_partno) {
 		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
 			if (buf < end)
 				*buf = 'p';
 			buf++;
 		}
-		buf = number(buf, end, bdev->bd_part->partno, spec);
+		buf = number(buf, end, bdev->bd_partno, spec);
 	}
 	return buf;
 }
-- 
2.28.0

