Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E2D194B5E
	for <lists+target-devel@lfdr.de>; Thu, 26 Mar 2020 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCZWPN (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 26 Mar 2020 18:15:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgCZWPN (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:15:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C772BADC8;
        Thu, 26 Mar 2020 22:15:11 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 2/5] scsi: target: drop xcopy DISK BLOCK LENGTH debug
Date:   Thu, 26 Mar 2020 23:15:02 +0100
Message-Id: <20200326221505.5303-3-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200326221505.5303-1-ddiss@suse.de>
References: <20200326221505.5303-1-ddiss@suse.de>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The DISK BLOCK LENGTH field is carried with XCOPY target descriptors on
the wire, but is currently unmarshalled during 0x02 segment descriptor
passing. The unmarshalled value is currently unused, so drop it.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_xcopy.c | 5 -----
 drivers/target/target_core_xcopy.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index 7e5b13da0c20..66b68295c50f 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -315,11 +315,6 @@ static int target_xcopy_parse_segdesc_02(struct se_cmd *se_cmd, struct xcopy_op
 		xop->nolb, (unsigned long long)xop->src_lba,
 		(unsigned long long)xop->dst_lba);
 
-	if (dc != 0) {
-		xop->dbl = get_unaligned_be24(&desc[29]);
-
-		pr_debug("XCOPY seg desc 0x02: DC=1 w/ dbl: %u\n", xop->dbl);
-	}
 	return 0;
 }
 
diff --git a/drivers/target/target_core_xcopy.h b/drivers/target/target_core_xcopy.h
index 26ba4c3c9cff..0840b03e8faa 100644
--- a/drivers/target/target_core_xcopy.h
+++ b/drivers/target/target_core_xcopy.h
@@ -35,7 +35,6 @@ struct xcopy_op {
 	unsigned short stdi;
 	unsigned short dtdi;
 	unsigned short nolb;
-	unsigned int dbl;
 
 	struct xcopy_pt_cmd *src_pt_cmd;
 	struct xcopy_pt_cmd *dst_pt_cmd;
-- 
2.16.4

