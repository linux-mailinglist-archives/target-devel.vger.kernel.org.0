Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9B25BA44
	for <lists+target-devel@lfdr.de>; Thu,  3 Sep 2020 07:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgICFlP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Sep 2020 01:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgICFlJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:41:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33960C061245;
        Wed,  2 Sep 2020 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=riJwVtK2AUEGowy/fSK/NSeugqK+94BEz4FUf/LJHss=; b=iOs4ePOHKq0RO554D6Q23NPYpM
        kwtgxb2xzQYHh8cHDRvtLLOM4dAD3ho9sU4MR7rhGZel6Ko+UkaQDih11UE6vIpvieSjfgzD8+vDy
        Ud7bzdIESe2a4ikxe4yX3drmeTge4pTq9s7qQd4BflpUDgFbaPzO7azWHCe9tJ7JdZRa2KydRDCTo
        n/Z2QEqHQvIShl/ZNKqz4ZnSGv6LMmCSsxRqP5bp2GtG5+ocEaPhCOc/HHhvfjKCF4DJrf+wPenIH
        LqwkQ0ylE5E5LkLlLH3rcuAFho96CiQyaoF5EYlJ09nND9cB7hjOLK+Kctrawd838Szt9G0g6IuFt
        MUFZHS2g==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDhzd-0007OB-Dx; Thu, 03 Sep 2020 05:41:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: clean up is partition checks
Date:   Thu,  3 Sep 2020 07:40:55 +0200
Message-Id: <20200903054104.228829-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Jens,

this series add a new helepr to check if a struct block_device represents
a parition, and removes most direct access to ->bd_contained from
drivers.

Diffstat:
 Documentation/userspace-api/ioctl/hdio.rst |   24 ++++++++++++------------
 block/blk-lib.c                            |    2 +-
 block/genhd.c                              |    2 +-
 block/ioctl.c                              |    4 ++--
 block/scsi_ioctl.c                         |    2 +-
 drivers/block/drbd/drbd_main.c             |    2 --
 drivers/block/drbd/drbd_receiver.c         |    2 +-
 drivers/block/drbd/drbd_worker.c           |    2 +-
 drivers/ide/ide-ioctls.c                   |    4 ++--
 drivers/md/dm-table.c                      |    2 +-
 drivers/md/md.c                            |    9 ++++-----
 drivers/md/md.h                            |    2 +-
 drivers/mmc/core/block.c                   |    2 +-
 drivers/s390/block/dasd_ioctl.c            |    8 ++++----
 drivers/target/target_core_iblock.c        |    5 ++---
 fs/nfsd/blocklayout.c                      |    4 ++--
 include/linux/blkdev.h                     |    9 +++++++--
 kernel/trace/blktrace.c                    |    2 +-
 lib/vsprintf.c                             |    4 ++--
 19 files changed, 46 insertions(+), 45 deletions(-)
