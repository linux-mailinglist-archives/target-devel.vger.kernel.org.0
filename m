Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB78425BA6B
	for <lists+target-devel@lfdr.de>; Thu,  3 Sep 2020 07:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgICFll (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Sep 2020 01:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgICFlP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:41:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F70C061246;
        Wed,  2 Sep 2020 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JQnCJBON1sn/4yitAjO2mH+MoAGoHyOFDo8QjS0s8n0=; b=j0Hqh/k47lPTcKRnhzTR7dphUz
        AGTjjNl88wFEfqT9P9PN+5atuOJW9p+ZEqU13dNQtha13ugy3vn+qgbwIzJHiXCoHaDaHwkvom7PH
        mtizJ6vHdenvwyo2L3nvaxFlSa5sNGKbs9rshDqjFWNZJdYXJ/sy9zzcdpqTHpzoKsBGZ1b9SgFEi
        S2ugmd+WP+Nwk+NBBgqJ5JI/vgFbH9ht2AdJLC9EPl10N+NkYQvuQ6IquTFxaRF3QXiqatcS82VZR
        qbYdRywI+ZDGnH2XVz4xS5pLDYeiMmx7fWETkKM4LGkiZW9AEiSRklSmG26NIkOIasK2Wjrswn+VY
        ODfMFaoQ==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDhzl-0007Ox-8y; Thu, 03 Sep 2020 05:41:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH 7/9] target/iblock: fix holder printing in iblock_show_configfs_dev_params
Date:   Thu,  3 Sep 2020 07:41:02 +0200
Message-Id: <20200903054104.228829-8-hch@lst.de>
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

bd_contains is never NULL for an open block device.  In addition ibd_bd
is always set to a block device that was exclusively opened by the
target code, so the holder is guranteed to be ib_dev as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_iblock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1c181d31f4c872..f2bd2e207e0b36 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -611,9 +611,8 @@ static ssize_t iblock_show_configfs_dev_params(struct se_device *dev, char *b)
 	bl += sprintf(b + bl, "        ");
 	if (bd) {
 		bl += sprintf(b + bl, "Major: %d Minor: %d  %s\n",
-			MAJOR(bd->bd_dev), MINOR(bd->bd_dev), (!bd->bd_contains) ?
-			"" : (bd->bd_holder == ib_dev) ?
-			"CLAIMED: IBLOCK" : "CLAIMED: OS");
+			MAJOR(bd->bd_dev), MINOR(bd->bd_dev),
+			"CLAIMED: IBLOCK");
 	} else {
 		bl += sprintf(b + bl, "Major: 0 Minor: 0\n");
 	}
-- 
2.28.0

