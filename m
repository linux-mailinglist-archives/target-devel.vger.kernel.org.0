Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0681958D2
	for <lists+target-devel@lfdr.de>; Fri, 27 Mar 2020 15:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgC0OUO (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 27 Mar 2020 10:20:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbgC0OUO (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:20:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9EE14AF22;
        Fri, 27 Mar 2020 14:20:12 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 2/5] scsi: target: drop xcopy DISK BLOCK LENGTH debug
Date:   Fri, 27 Mar 2020 15:19:51 +0100
Message-Id: <20200327141954.955-3-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200327141954.955-1-ddiss@suse.de>
References: <20200327141954.955-1-ddiss@suse.de>
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

