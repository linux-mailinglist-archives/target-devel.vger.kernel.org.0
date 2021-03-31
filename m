Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4226B346B04
	for <lists+target-devel@lfdr.de>; Tue, 23 Mar 2021 22:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhCWVZB (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 23 Mar 2021 17:25:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:48588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233537AbhCWVYt (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:24:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616534688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tb9DUv24f1dUzGNk1qYsdtnBS4ySB3TMrZJ4ucwL8W8=;
        b=qM5m7Waw7Y9EHCNeAYU2ul6cqPAgZOviXnZlo8uDNTBHzqzME2HTod/Q7vLChPIrKaYtX5
        pL26uqCevja2JirZT/6cwMUQ5Y2uxU6ZqVMd3uICxGI3d5skela2HptT7dzFPa/llYjix4
        rvC/sZKtYF9wq8J+lgguePPOrUuAMLU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB816ACBF;
        Tue, 23 Mar 2021 21:24:47 +0000 (UTC)
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        David Disseldorp <ddiss@suse.com>,
        =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 2/2] target: pscsi: cleanup after failure in pscsi_map_sg()
Date:   Tue, 23 Mar 2021 22:24:31 +0100
Message-Id: <20210323212431.15306-2-mwilck@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210323212431.15306-1-mwilck@suse.com>
References: <20210323212431.15306-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

If pscsi_map_sg() fails, make sure to drop references to already
allocated bios.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/target/target_core_pscsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 977362d..1c9aeab 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -937,6 +937,14 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 
 	return 0;
 fail:
+	if (bio)
+		bio_put(bio);
+	while (req->bio) {
+		bio = req->bio;
+		req->bio = bio->bi_next;
+		bio_put(bio);
+	}
+	req->biotail = NULL;
 	return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 }
 
-- 
2.26.2

