Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DC4BFA1E
	for <lists+target-devel@lfdr.de>; Tue, 22 Feb 2022 15:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiBVOFR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Feb 2022 09:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiBVOFR (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:05:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC74715F0BC;
        Tue, 22 Feb 2022 06:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZkZQA+7eEA1SPtr9YEx1gUKQct/AwJ+pYWtdJAH61iw=; b=dRp/Fw8wxy96Sx/y4dVhbVrjNz
        dZ+l6vUoF5Qtivp5aBFBJSv8hDf+tlXl6UFRSgXW7VMeIfX49uTv5nw/290VdX4bZce31SzoWjhdO
        A4h+9dEkLi4Z5Ex1zGU44hj5b+zOk7wLsja2AxbRdRxU81zDYPg7TsDw3JffnTqCc64rIllX5++cM
        uabu55LXpgCIJ2w/00Ni3U+6Jq0dtyDnHEjXwsOLJqDQOJ5c4iWdSpzTa4+IGn4kBu2VUcv9MCW0f
        5SkXR6rMghC5LuhiF37vKQBIf/EfDx00RboQ8ShA1FrZpqFBWAAD+t0qAUMXltq8b5/6rWYFWTzrj
        94wBhk9w==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMVmd-009nPg-2l; Tue, 22 Feb 2022 14:04:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH 2/8] target/pscsi: remove struct pscsi_plugin_task
Date:   Tue, 22 Feb 2022 15:04:37 +0100
Message-Id: <20220222140443.589882-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222140443.589882-1-hch@lst.de>
References: <20220222140443.589882-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Copy directly from the se_cmd CDB to the one in the scsi_request.  This
temporarily limits the pscsi backend to supporting only up to 16 byte
CDBs, but this restriction will be lifted later in this series.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_pscsi.c | 51 ++++++++++--------------------
 drivers/target/target_core_pscsi.h |  4 ---
 2 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 807d06ecadee2..622158ed5d9ce 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -593,16 +593,14 @@ static void pscsi_complete_cmd(struct se_cmd *cmd, u8 scsi_status,
 {
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(cmd->se_dev);
 	struct scsi_device *sd = pdv->pdv_sd;
-	struct pscsi_plugin_task *pt = cmd->priv;
-	unsigned char *cdb;
+	unsigned char *cdb = cmd->priv;
+
 	/*
-	 * Special case for REPORT_LUNs handling where pscsi_plugin_task has
-	 * not been allocated because TCM is handling the emulation directly.
+	 * Special case for REPORT_LUNs which is emulated and not passed on.
 	 */
-	if (!pt)
+	if (!cdb)
 		return;
 
-	cdb = &pt->pscsi_cdb[0];
 	/*
 	 * Hack to make sure that Write-Protect modepage is set if R/O mode is
 	 * forced.
@@ -963,30 +961,14 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 	struct scatterlist *sgl = cmd->t_data_sg;
 	u32 sgl_nents = cmd->t_data_nents;
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(cmd->se_dev);
-	struct pscsi_plugin_task *pt;
 	struct request *req;
 	sense_reason_t ret;
 
-	/*
-	 * Dynamically alloc cdb space, since it may be larger than
-	 * TCM_MAX_COMMAND_SIZE
-	 */
-	pt = kzalloc(sizeof(*pt) + scsi_command_size(cmd->t_task_cdb), GFP_KERNEL);
-	if (!pt) {
-		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
-	}
-	cmd->priv = pt;
-
-	memcpy(pt->pscsi_cdb, cmd->t_task_cdb,
-		scsi_command_size(cmd->t_task_cdb));
-
 	req = scsi_alloc_request(pdv->pdv_sd->request_queue,
 			cmd->data_direction == DMA_TO_DEVICE ?
 			REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
-	if (IS_ERR(req)) {
-		ret = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
-		goto fail;
-	}
+	if (IS_ERR(req))
+		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
 	if (sgl) {
 		ret = pscsi_map_sg(cmd, sgl, sgl_nents, req);
@@ -996,8 +978,12 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 
 	req->end_io = pscsi_req_done;
 	req->end_io_data = cmd;
-	scsi_req(req)->cmd_len = scsi_command_size(pt->pscsi_cdb);
-	scsi_req(req)->cmd = &pt->pscsi_cdb[0];
+	scsi_req(req)->cmd_len = scsi_command_size(cmd->t_task_cdb);
+	if (scsi_req(req)->cmd_len > BLK_MAX_CDB) {
+		ret = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
+		goto fail_put_request;
+	}
+	memcpy(scsi_req(req)->cmd, cmd->t_task_cdb, scsi_req(req)->cmd_len);
 	if (pdv->pdv_sd->type == TYPE_DISK ||
 	    pdv->pdv_sd->type == TYPE_ZBC)
 		req->timeout = PS_TIMEOUT_DISK;
@@ -1005,6 +991,8 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 		req->timeout = PS_TIMEOUT_OTHER;
 	scsi_req(req)->retries = PS_RETRY;
 
+	cmd->priv = scsi_req(req)->cmd;
+
 	blk_execute_rq_nowait(req, cmd->sam_task_attr == TCM_HEAD_TAG,
 			pscsi_req_done);
 
@@ -1012,8 +1000,6 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 
 fail_put_request:
 	blk_mq_free_request(req);
-fail:
-	kfree(pt);
 	return ret;
 }
 
@@ -1041,14 +1027,13 @@ static sector_t pscsi_get_blocks(struct se_device *dev)
 static void pscsi_req_done(struct request *req, blk_status_t status)
 {
 	struct se_cmd *cmd = req->end_io_data;
-	struct pscsi_plugin_task *pt = cmd->priv;
 	int result = scsi_req(req)->result;
 	enum sam_status scsi_status = result & 0xff;
+	u8 *cdb = cmd->priv;
 
 	if (scsi_status != SAM_STAT_GOOD) {
 		pr_debug("PSCSI Status Byte exception at cmd: %p CDB:"
-			" 0x%02x Result: 0x%08x\n", cmd, pt->pscsi_cdb[0],
-			result);
+			" 0x%02x Result: 0x%08x\n", cmd, cdb[0], result);
 	}
 
 	pscsi_complete_cmd(cmd, scsi_status, scsi_req(req)->sense);
@@ -1060,14 +1045,12 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 		break;
 	default:
 		pr_debug("PSCSI Host Byte exception at cmd: %p CDB:"
-			" 0x%02x Result: 0x%08x\n", cmd, pt->pscsi_cdb[0],
-			result);
+			" 0x%02x Result: 0x%08x\n", cmd, cdb[0], result);
 		target_complete_cmd(cmd, SAM_STAT_CHECK_CONDITION);
 		break;
 	}
 
 	blk_mq_free_request(req);
-	kfree(pt);
 }
 
 static const struct target_backend_ops pscsi_ops = {
diff --git a/drivers/target/target_core_pscsi.h b/drivers/target/target_core_pscsi.h
index e8458b5e85c92..23d9a6e340d41 100644
--- a/drivers/target/target_core_pscsi.h
+++ b/drivers/target/target_core_pscsi.h
@@ -23,10 +23,6 @@ struct block_device;
 struct scsi_device;
 struct Scsi_Host;
 
-struct pscsi_plugin_task {
-	unsigned char pscsi_cdb[0];
-} ____cacheline_aligned;
-
 #define PDF_HAS_CHANNEL_ID	0x01
 #define PDF_HAS_TARGET_ID	0x02
 #define PDF_HAS_LUN_ID		0x04
-- 
2.30.2

