Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF0162DBE
	for <lists+target-devel@lfdr.de>; Tue, 18 Feb 2020 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgBRSGF (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 18 Feb 2020 13:06:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:43810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgBRSGF (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:06:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E0F4BAAC7;
        Tue, 18 Feb 2020 18:06:03 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH] scsi: target: fix unmap_zeroes_data boolean initialisation
Date:   Tue, 18 Feb 2020 19:05:46 +0100
Message-Id: <20200218180546.21313-1-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The LIO unmap_zeroes_data device attribute is mapped to the LBPRZ flag in
the READ CAPACITY (16) and Thin Provisioning VPD INQUIRY responses.
It's exposed via configfs, where any write value is correctly validated
via strtobool(), defaults to 0. However, when initialised via
target_configure_unmap_from_queue() it takes the value of the device's
max_write_zeroes_sectors queue limit, which is non-boolean.

Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/target_core_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 2d19f0e332b0..2c7ba2f7e13c 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -829,7 +829,7 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
 	attrib->unmap_granularity = q->limits.discard_granularity / block_size;
 	attrib->unmap_granularity_alignment = q->limits.discard_alignment /
 								block_size;
-	attrib->unmap_zeroes_data = (q->limits.max_write_zeroes_sectors);
+	attrib->unmap_zeroes_data = !!(q->limits.max_write_zeroes_sectors);
 	return true;
 }
 EXPORT_SYMBOL(target_configure_unmap_from_queue);
-- 
2.16.4

