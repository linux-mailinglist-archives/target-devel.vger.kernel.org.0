Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB32BB34E
	for <lists+target-devel@lfdr.de>; Fri, 20 Nov 2020 19:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgKTSc1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 20 Nov 2020 13:32:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbgKTSc1 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:32:27 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08D42415A;
        Fri, 20 Nov 2020 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897146;
        bh=SBQqZlkrd2b1JjkcNwq92OTC8Nik2c7OdB1adirQvpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvZdi4Q+sycoH/YA+npjg902lEazU2cHKoQb5ZszH5rMofUQbyGod84FowdnS1Vez
         rD7EVJQs/AQt+tUPoYWH+L2IrCN+zDSm8RRvD+UGHjp8D0EQ2CPEb7UqNjysgoBTo4
         tILquiq623nxcpupDfJnhcFd09tVHbsv1Y8fmYC8=
Date:   Fri, 20 Nov 2020 12:32:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 054/141] target: Fix fall-through warnings for Clang
Message-ID: <761d6f755e8a6f8a6daebd1e5c1394167e5c780a.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a break statement and a fallthrough
pseudo-keyword instead of letting the code fall through to the next
case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/target/target_core_iblock.c | 1 +
 drivers/target/target_core_pr.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index f2bd2e207e0b..8ed93fd205c7 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -211,6 +211,7 @@ static unsigned long long iblock_emulate_read_cap_with_block_size(
 			break;
 		case 512:
 			blocks_long <<= 3;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 5f79ea05f9b8..14db5e568f22 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -337,6 +337,7 @@ static int core_scsi3_pr_seq_non_holder(struct se_cmd *cmd, u32 pr_reg_type,
 	switch (pr_reg_type) {
 	case PR_TYPE_WRITE_EXCLUSIVE:
 		we = 1;
+		fallthrough;
 	case PR_TYPE_EXCLUSIVE_ACCESS:
 		/*
 		 * Some commands are only allowed for the persistent reservation
-- 
2.27.0

