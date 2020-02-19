Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0B1644E3
	for <lists+target-devel@lfdr.de>; Wed, 19 Feb 2020 14:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBSNBy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 19 Feb 2020 08:01:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:44134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgBSNBy (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:01:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72651ADAD;
        Wed, 19 Feb 2020 13:01:52 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 1/2] scsi: target: fix unmap_zeroes_data boolean initialisation
Date:   Wed, 19 Feb 2020 14:01:35 +0100
Message-Id: <20200219130136.18946-2-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200219130136.18946-1-ddiss@suse.de>
References: <20200219130136.18946-1-ddiss@suse.de>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The LIO unmap_zeroes_data device attribute is mapped to the LBPRZ flag
in the READ CAPACITY (16) and Thin Provisioning VPD INQUIRY responses.

The unmap_zeroes_data attribute is exposed via configfs, where any write
value is correctly validated via strtobool(). However, when initialised
via target_configure_unmap_from_queue() it takes the value of the
device's max_write_zeroes_sectors queue limit, which is non-boolean.

A non-boolean value can be read from configfs, but attempting to write
the same value back results in -EINVAL, causing problems for configuration
utilities such as targetcli.

Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/target_core_device.c | 2 +-
 include/target/target_core_base.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 1728e883b7b2..35188e64239e 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -682,7 +682,7 @@ struct se_dev_attrib {
 	int		force_pr_aptpl;
 	int		is_nonrot;
 	int		emulate_rest_reord;
-	int		unmap_zeroes_data;
+	bool		unmap_zeroes_data;
 	u32		hw_block_size;
 	u32		block_size;
 	u32		hw_max_sectors;
-- 
2.16.4

