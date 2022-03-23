Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC484E538A
	for <lists+target-devel@lfdr.de>; Wed, 23 Mar 2022 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244512AbiCWNvQ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 23 Mar 2022 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244508AbiCWNvP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:51:15 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590984706A;
        Wed, 23 Mar 2022 06:49:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V80FjZU_1648043382;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V80FjZU_1648043382)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Mar 2022 21:49:43 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, bostroesser@gmail.com
Subject: [PATCH v2 2/3] scsi: target: tcmu: Fix possible data corruption
Date:   Wed, 23 Mar 2022 21:49:39 +0800
Message-Id: <20220323134940.31463-3-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20220323134940.31463-1-xiaoguang.wang@linux.alibaba.com>
References: <20220323134940.31463-1-xiaoguang.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

When tcmu_vma_fault() gets one page successfully, before the current
context completes page fault procedure, find_free_blocks() may run in
and call unmap_mapping_range() to unmap this page. Assume when
find_free_blocks() completes its job firstly, previous page fault
procedure starts to run again and completes, then one truncated page has
beed mapped to use space, but note that tcmu_vma_fault() has gotten one
refcount for this page, so any other subsystem won't use this page,
unless later the use space addr is unmapped.

If another command runs in later and needs to extends dbi_thresh, it may
reuse the corresponding slot to previous page in data_bitmap, then thouth
we'll allocate new page for this slot in data_area, but no page fault will
happen again, because we have a valid map, real request's data will lose.

To fix this issue, when extending dbi_thresh, we'll need to call
unmap_mapping_range() to unmap use space data area which may exist,
which I think it's a simple method.

Filesystem implementations will also run into this issue, but they
ususally lock page when vm_operations_struct->fault gets one page, and
unlock page after finish_fault() completes. In truncate sides, they
lock pages in truncate_inode_pages() to protect race with page fault.
We can also have similar codes like filesystem to fix this issue.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 drivers/target/target_core_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 06a5c4086551..9196188504ec 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -862,6 +862,7 @@ static int tcmu_alloc_data_space(struct tcmu_dev *udev, struct tcmu_cmd *cmd,
 	if (space < cmd->dbi_cnt) {
 		unsigned long blocks_left =
 				(udev->max_blocks - udev->dbi_thresh) + space;
+		loff_t off, len;
 
 		if (blocks_left < cmd->dbi_cnt) {
 			pr_debug("no data space: only %lu available, but ask for %u\n",
@@ -870,6 +871,10 @@ static int tcmu_alloc_data_space(struct tcmu_dev *udev, struct tcmu_cmd *cmd,
 			return -1;
 		}
 
+		off = udev->data_off + (loff_t)udev->dbi_thresh * udev->data_blk_size;
+		len = cmd->dbi_cnt * udev->data_blk_size;
+		unmap_mapping_range(udev->inode->i_mapping, off, len, 1);
+
 		udev->dbi_thresh += cmd->dbi_cnt;
 		if (udev->dbi_thresh > udev->max_blocks)
 			udev->dbi_thresh = udev->max_blocks;
-- 
2.14.4.44.g2045bb6

