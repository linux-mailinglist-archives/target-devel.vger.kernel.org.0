Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB9455CEE
	for <lists+target-devel@lfdr.de>; Thu, 18 Nov 2021 14:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhKRNsT (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 18 Nov 2021 08:48:19 -0500
Received: from mail-m17671.qiye.163.com ([59.111.176.71]:36544 "EHLO
        mail-m17671.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhKRNsF (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:48:05 -0500
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Nov 2021 08:48:03 EST
Received: from localhost.localdomain (unknown [14.18.236.70])
        by mail-m17671.qiye.163.com (Hmail) with ESMTPA id AA7522E0062;
        Thu, 18 Nov 2021 21:33:58 +0800 (CST)
From:   Yi Li <yili@winhong.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     yilikernel@gmail.com, yili@winhong.com, axboe@kernel.dk,
        martin.petersen@oracle.com
Subject: [PATCH] use blk_queue_fua() to check QUEUE_FLAG_FUA
Date:   Thu, 18 Nov 2021 21:33:50 +0800
Message-Id: <20211118133350.2716698-1-yili@winhong.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkaHkxWSRkdGU9MGUJOTh
        lIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzI6Ehw*MD4CNiIxNzkWQw0Z
        Th1PCylVSlVKTUhMSU9JT0hCSkxPVTMWGhIXVQISFxI7DBIVExQVHFUYFBZFWVdZEgtZQVlKT1VK
        Q1VJSE1VTEtZV1kIAVlBSUhJTTcG
X-HM-Tid: 0a7d3341051ada56kuwsaa7522e0062
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

We alreday has the interface blk_queue_fua() to check QUEUE_FLAG_FUA flag,
so use it.

Signed-off-by: Yi Li <yili@winhong.com>
---
 block/blk-sysfs.c                   | 2 +-
 drivers/target/target_core_iblock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index cef1f713370b..6a5135b216de 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -544,7 +544,7 @@ static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 
 static ssize_t queue_fua_show(struct request_queue *q, char *page)
 {
-	return sprintf(page, "%u\n", test_bit(QUEUE_FLAG_FUA, &q->queue_flags));
+	return sprintf(page, "%u\n", blk_queue_fua(q));
 }
 
 static ssize_t queue_dax_show(struct request_queue *q, char *page)
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index bf8ae4825a06..683374ddd24d 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -738,7 +738,7 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		 */
 		opf = REQ_OP_WRITE;
 		miter_dir = SG_MITER_TO_SG;
-		if (test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {
+		if (blk_queue_fua(q)) {
 			if (cmd->se_cmd_flags & SCF_FUA)
 				opf |= REQ_FUA;
 			else if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
-- 
2.25.3

