Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA922518A2
	for <lists+target-devel@lfdr.de>; Tue, 25 Aug 2020 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHYMfo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 25 Aug 2020 08:35:44 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:2264 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHYMfo (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:35:44 -0400
Received: from fcoe-test11.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 07PCZM4e019264;
        Tue, 25 Aug 2020 05:35:23 -0700
From:   Varun Prakash <varun@chelsio.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        michael.christie@oracle.com, bvanassche@acm.org,
        nab@linux-iscsi.org, varun@chelsio.com, <stable@vger.kernel.org>
Subject: [PATCH] scsi: target: iscsi: Fix data digest calculation
Date:   Tue, 25 Aug 2020 18:05:10 +0530
Message-Id: <1598358910-3052-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Current code does not consider 'page_off' in data digest
calculation, to fix this add a local variable 'first_sg' and
set first_sg.offset to sg->offset + page_off.

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Cc: <stable@vger.kernel.org>
Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/target/iscsi/iscsi_target.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index c968961..2ec778e 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1389,14 +1389,27 @@ static u32 iscsit_do_crypto_hash_sg(
 	sg = cmd->first_data_sg;
 	page_off = cmd->first_data_sg_off;
 
+	if (data_length && page_off) {
+		struct scatterlist first_sg;
+		u32 len = min_t(u32, data_length, sg->length - page_off);
+
+		sg_init_table(&first_sg, 1);
+		sg_set_page(&first_sg, sg_page(sg), len, sg->offset + page_off);
+
+		ahash_request_set_crypt(hash, &first_sg, NULL, len);
+		crypto_ahash_update(hash);
+
+		data_length -= len;
+		sg = sg_next(sg);
+	}
+
 	while (data_length) {
-		u32 cur_len = min_t(u32, data_length, (sg->length - page_off));
+		u32 cur_len = min_t(u32, data_length, sg->length);
 
 		ahash_request_set_crypt(hash, sg, NULL, cur_len);
 		crypto_ahash_update(hash);
 
 		data_length -= cur_len;
-		page_off = 0;
 		/* iscsit_map_iovec has already checked for invalid sg pointers */
 		sg = sg_next(sg);
 	}
-- 
2.0.2

