Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2339429453A
	for <lists+target-devel@lfdr.de>; Wed, 21 Oct 2020 00:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390849AbgJTWpK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 20 Oct 2020 18:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390682AbgJTWpK (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 20 Oct 2020 18:45:10 -0400
Received: from mail-vs1-xe62.google.com (mail-vs1-xe62.google.com [IPv6:2607:f8b0:4864:20::e62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84044C0613CE
        for <target-devel@vger.kernel.org>; Tue, 20 Oct 2020 15:45:10 -0700 (PDT)
Received: by mail-vs1-xe62.google.com with SMTP id b3so138110vsc.5
        for <target-devel@vger.kernel.org>; Tue, 20 Oct 2020 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drivescale-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vu/SY2Qr1rdX8tIeYe5kvtn7fudITRq310kc75Nadl8=;
        b=cPeqg9bWi0Cy9jfpVjasC0cSoKnklIgRIisdMAHG73UvP/ihpyEYu7dJVtUhFmp7VB
         RpQQGB6wfxwaXCvTUGAGKWFSo2LQnQ40g5OKDYAzom8hOsPvbX/2XM2JTv6+WmIDIrGM
         BorF80PBCLwCltKw9lnQJ8sxAHNxnA0j/1wfl1GqXpSTBvQqza4qwf1VYcO1HmDayKhv
         wV2CWFP+Uet+8f8xNjG/ZbeTuLSvf9cgr6jOfPLSuhuj9UfEOkggS2HGLJorNIFBqCxc
         j+Rf3E++WSFT9pza27CU5QZ3jKAV3ux1P4EVF8PHxE23vjDZuNNjs5QTW3ZVrlY7Lt+6
         aBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vu/SY2Qr1rdX8tIeYe5kvtn7fudITRq310kc75Nadl8=;
        b=DP5LHrL1txtKZKqFZuBha33zcWJtY0667B1DOXn+obrr2pNxkGaFBw/FhRgtAk2JJG
         I9XxNRMPgeiB5Bu5SZ/ha9GX+MX5An/pH8SuYKf0R73V1MRWXUKVUYTX6bypls/7OjUW
         yOiRRS++BbzgYZfeu+vuAMGM4pwD8GXi5E5MqUIahNBLwG2hqQVJXbz80UMJTJPecRLh
         haSIZbmFTz4Dv+VSGf2hsWElE02XaaueSpSLgdOfcNmluA2WQJLlXmsbZlA2XmHkpp0O
         +3aaLklADMoP+P4WrROI6mpfv0UNtpMSE/tMt0ZatGoEQ8OO7JI/07JYAeoH63Peh57+
         fqRg==
X-Gm-Message-State: AOAM531bZPeANQiHX+PboJM0OeCDQYkg8fBUQwQ05jnQZ3A5Qx4h5slA
        KqB5emSNQL8F9iwOS0PpW8zV7m36y7cEOp/Mj9l3iuXT6SiTPA==
X-Google-Smtp-Source: ABdhPJwSWUnLQkAm1FUUWyL13+1LjlHF723EwctfDY1st2x4mI03xMfDIjoH2ouDuy3d0sL0n6thGQLsLJkn
X-Received: by 2002:a67:de18:: with SMTP id q24mr40599vsk.54.1603233909650;
        Tue, 20 Oct 2020 15:45:09 -0700 (PDT)
Received: from dcs.hq.drivescale.com ([68.74.115.3])
        by smtp-relay.gmail.com with ESMTP id h12sm45993uar.2.2020.10.20.15.45.09;
        Tue, 20 Oct 2020 15:45:09 -0700 (PDT)
X-Relaying-Domain: drivescale.com
Received: from localhost.localdomain (gw1-dc.hq.drivescale.com [192.168.33.175])
        by dcs.hq.drivescale.com (Postfix) with ESMTP id 85ED6420CB;
        Tue, 20 Oct 2020 22:45:08 +0000 (UTC)
From:   Christopher Unkel <cunkel@drivescale.com>
To:     target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christopher Unkel <cunkel@drivescale.com>
Subject: [PATCH] scsi: target/iblock: compute lbppbe relative to advertised pb size
Date:   Tue, 20 Oct 2020 15:44:55 -0700
Message-Id: <20201020224455.10949-1-cunkel@drivescale.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch fixes a bug where adjusting the offered (logical) block size
of a target incorrectly increases the advertised phyiscal block size by
the same factor.  For example, if the underlying device has 512 byte
logical block size and 4k physical block size, setting block_size in
configfs to 4096 results in the initiator seeing a device with 4k
physical block size and 32k logical block size, instead of 4k for both.

---
The physical block size is passed to the client as a shift relative to
the logical block size.  The iblock target was computing this relative
to the underlying hardware block size, while the client can only
interpret it relative to the advertised logical block size.  If the
block_size attribute is set to be different than the default value of
hw_block_size, the advertised physical block size is wrong.

Instead compute lbppbe relative to the block_size attribute.

Signed-off-by: Christopher Unkel <cunkel@drivescale.com>
---
 drivers/target/target_core_iblock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index f2bd2e207e0b..6940d2acc609 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -815,8 +815,16 @@ static unsigned int iblock_get_lbppbe(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 	struct block_device *bd = ib_dev->ibd_bd;
-	int logs_per_phys = bdev_physical_block_size(bd) / bdev_logical_block_size(bd);
+	unsigned int pbsz = bdev_physical_block_size(bd);
 
+	/* compute relative to advertised block size as that is how
+	 * the other end will interpret it
+	 */
+	unsigned int lbsz = dev->dev_attrib.block_size;
+	int logs_per_phys = pbsz / lbsz;
+
+	if (!logs_per_phys)
+		return 0;
 	return ilog2(logs_per_phys);
 }
 
-- 
2.17.1

