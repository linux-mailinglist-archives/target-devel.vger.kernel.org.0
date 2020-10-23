Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27144297894
	for <lists+target-devel@lfdr.de>; Fri, 23 Oct 2020 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756462AbgJWU5j (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 23 Oct 2020 16:57:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755497AbgJWU5f (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:57:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E46B3B249;
        Fri, 23 Oct 2020 20:57:33 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/5] scsi: target: rename cmd.bad_sector to cmd.sense_info
Date:   Fri, 23 Oct 2020 22:57:21 +0200
Message-Id: <20201023205723.17880-4-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023205723.17880-1-ddiss@suse.de>
References: <20201023205723.17880-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

cmd.bad_sector currently gets packed into the sense INFORMATION field
for TCM_LOGICAL_BLOCK_{GUARD,APP_TAG,REF_TAG}_CHECK_FAILED errors, which
carry an .add_sector_info flag in the sense_detail_table to ensure this.

In preparation for propagating a byte offset on COMPARE AND WRITE
TCM_MISCOMPARE_VERIFY error, rename cmd.bad_sector to cmd.sense_info
and sense_detail.add_sector_info to sense_detail.add_sense_info so
that it better reflects the sense INFORMATION field destination.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/target_core_sbc.c       |  2 +-
 drivers/target/target_core_transport.c | 12 ++++++------
 include/target/target_core_base.h      |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index 6e8b8d30938f..5f77dd95f1b9 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -1439,7 +1439,7 @@ sbc_dif_verify(struct se_cmd *cmd, sector_t start, unsigned int sectors,
 			if (rc) {
 				kunmap_atomic(daddr - dsg->offset);
 				kunmap_atomic(paddr - psg->offset);
-				cmd->bad_sector = sector;
+				cmd->sense_info = sector;
 				return rc;
 			}
 next:
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index caa3a7b34826..c6f45c12d564 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3098,7 +3098,7 @@ struct sense_detail {
 	u8 key;
 	u8 asc;
 	u8 ascq;
-	bool add_sector_info;
+	bool add_sense_info;
 };
 
 static const struct sense_detail sense_detail_table[] = {
@@ -3201,19 +3201,19 @@ static const struct sense_detail sense_detail_table[] = {
 		.key = ABORTED_COMMAND,
 		.asc = 0x10,
 		.ascq = 0x01, /* LOGICAL BLOCK GUARD CHECK FAILED */
-		.add_sector_info = true,
+		.add_sense_info = true,
 	},
 	[TCM_LOGICAL_BLOCK_APP_TAG_CHECK_FAILED] = {
 		.key = ABORTED_COMMAND,
 		.asc = 0x10,
 		.ascq = 0x02, /* LOGICAL BLOCK APPLICATION TAG CHECK FAILED */
-		.add_sector_info = true,
+		.add_sense_info = true,
 	},
 	[TCM_LOGICAL_BLOCK_REF_TAG_CHECK_FAILED] = {
 		.key = ABORTED_COMMAND,
 		.asc = 0x10,
 		.ascq = 0x03, /* LOGICAL BLOCK REFERENCE TAG CHECK FAILED */
-		.add_sector_info = true,
+		.add_sense_info = true,
 	},
 	[TCM_COPY_TARGET_DEVICE_NOT_REACHABLE] = {
 		.key = COPY_ABORTED,
@@ -3293,10 +3293,10 @@ static void translate_sense_reason(struct se_cmd *cmd, sense_reason_t reason)
 	cmd->scsi_status = SAM_STAT_CHECK_CONDITION;
 	cmd->scsi_sense_length  = TRANSPORT_SENSE_BUFFER;
 	scsi_build_sense_buffer(desc_format, buffer, key, asc, ascq);
-	if (sd->add_sector_info)
+	if (sd->add_sense_info)
 		WARN_ON_ONCE(scsi_set_sense_information(buffer,
 							cmd->scsi_sense_length,
-							cmd->bad_sector) < 0);
+							cmd->sense_info) < 0);
 }
 
 int
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 549947d407cf..7ee2bee46b3a 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -540,7 +540,7 @@ struct se_cmd {
 	struct scatterlist	*t_prot_sg;
 	unsigned int		t_prot_nents;
 	sense_reason_t		pi_err;
-	sector_t		bad_sector;
+	u64			sense_info;
 	int			cpuid;
 };
 
-- 
2.26.2

