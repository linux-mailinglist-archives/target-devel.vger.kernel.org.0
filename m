Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB365D2EE
	for <lists+target-devel@lfdr.de>; Tue,  2 Jul 2019 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGBPam (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 2 Jul 2019 11:30:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43070 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBPam (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:30:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so7850179pgv.10
        for <target-devel@vger.kernel.org>; Tue, 02 Jul 2019 08:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRTEQQZbuuBJxAImOBI/bNHaIZm7d0VoieTYyQhMdh8=;
        b=dKsdeZB/unotGiTcVMfOXGLF3A37xRBi1kRzx2fSvf1/wlfNrg0bdJh6MQsWMggCSp
         AWnMnDlzD7SziFyoA6ScqX+PKdSQK9Wn5mRzDk4vSJg0eZXynAgGhVAn/PlcE9A5aX0Q
         gaa4gftLhvLRWVkh4xQsBOia3oMIMByqpolH4fmeyna1Qd+eugMTNbV3XvR6oZogX/j1
         bsftKkjEUbo8uaxqiI+m0YulWJuqvOejWXgGS/nlgkEDsX/k0OXiyMS1I14p0lmGsFIM
         +PKfFi0+pKqTn2YK+CDl9lhzPGpnUz0w5kF+5oM9LEt6Yj/rRPrHTyPGh15rt3RHDSsF
         1K6g==
X-Gm-Message-State: APjAAAUJW4n4//8943bfHY+IfycfpWmmAdO5xFqTc1A6Dx5pBEG9AMOl
        2tZ42X/JD22UjmZP0L/cMvc=
X-Google-Smtp-Source: APXvYqytW5ZC8/F/1b1Q+/cHKSVebFO5aXPpyChnIwMXlKG7tyiUideQvhb1aGP5fDQ8u5JZD+Uh5g==
X-Received: by 2002:a63:f146:: with SMTP id o6mr30595925pgk.179.1562081441609;
        Tue, 02 Jul 2019 08:30:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 4sm13715800pfc.92.2019.07.02.08.30.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 08:30:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] target/core: Use REQ_OP_WRITE_SAME to implement WRITE SAME
Date:   Tue,  2 Jul 2019 08:30:31 -0700
Message-Id: <20190702153031.3832-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190702153031.3832-1-bvanassche@acm.org>
References: <20190702153031.3832-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Use blkdev_submit_write_same() instead of open-coding it.

Note: as one can see in target_alloc_sgl(), the target core sets the
offset in a scatter/gather list to zero for all allocated pages.

Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_iblock.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index b5ed9c377060..c8e64fe87f7f 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -465,6 +465,8 @@ iblock_execute_write_same(struct se_cmd *cmd)
 	sector_t block_lba = target_to_linux_sector(dev, cmd->t_task_lba);
 	sector_t sectors = target_to_linux_sector(dev,
 					sbc_get_write_same_sectors(cmd));
+	struct blk_plug plug;
+	int ret;
 
 	if (cmd->prot_op) {
 		pr_err("WRITE_SAME: Protection information with IBLOCK"
@@ -481,6 +483,7 @@ iblock_execute_write_same(struct se_cmd *cmd)
 		return TCM_INVALID_CDB_FIELD;
 	}
 
+	/* 1. Use REQ_OP_WRITE_ZEROES if supported and if appropriate. */
 	if (bdev_write_zeroes_sectors(bdev)) {
 		if (!iblock_execute_zero_out(bdev, cmd))
 			return 0;
@@ -491,6 +494,20 @@ iblock_execute_write_same(struct se_cmd *cmd)
 		goto fail;
 	cmd->priv = ibr;
 
+	/* 2. Try REQ_OP_WRITE_SAME. */
+	blk_start_plug(&plug);
+	ret = blkdev_submit_write_same(bdev, block_lba, sectors, GFP_KERNEL,
+				       sg_page(sg), iblock_bio_done, cmd);
+	blk_finish_plug(&plug);
+	if (ret == 0)
+		return 0;
+	if (ret != -EOPNOTSUPP)
+		goto fail;
+
+	/*
+	 * 3. If neither REQ_OP_WRITE_SAME nor REQ_OP_WRITE_ZEROES are
+	 * supported, use REQ_OP_WRITE.
+	 */
 	bio = iblock_get_bio(cmd, block_lba, 1, REQ_OP_WRITE, 0);
 	if (!bio)
 		goto fail_free_ibr;
-- 
2.22.0.410.gd8fdbe21b5-goog

