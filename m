Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E8532A32
	for <lists+target-devel@lfdr.de>; Tue, 24 May 2022 14:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiEXMPq (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 24 May 2022 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiEXMPn (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 24 May 2022 08:15:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58DE6F492;
        Tue, 24 May 2022 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wkPIZIVONU9b1z8+CgUJJnawZaRvDYyKffX5i5LuXls=; b=GsYgvdN5lRo7GL4z9QDx1AVWyG
        x08pzwUka71bFxAFQNhE312o9+P1LhlhtwGmIBlTTek5uMfkzUaRzmwOT62pXlhY7WdcMEFFIC/tv
        6EQP5RNVXrx8Sz6KwT3zoDIhLGer3yTVxQSXLLMy979td38LQAzI3vqn9X3g32ARqax9c1hXPmiyr
        GSPOopOzWnLsSWK2RYBaisuM338FlcEPSl8iMifDCKqfpNA+nqFMGUD1GzYqfTSc8cwws0U2kFKKD
        0BgHQc5sxeriuuBm2sKJxU1bmlokxJyzzM7lI9Y6N/Q+KXTyMPgvmisCuM663cqsQaw/QGuvkYkcm
        gw51PaYw==;
Received: from [2001:4bb8:18c:7298:91b6:63de:2998:b8b2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntTRr-007wbx-Pg; Tue, 24 May 2022 12:15:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 3/3] blk-mq: remove the done argument to blk_execute_rq_nowait
Date:   Tue, 24 May 2022 14:15:30 +0200
Message-Id: <20220524121530.943123-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220524121530.943123-1-hch@lst.de>
References: <20220524121530.943123-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Let the caller set it together with the end_io_data instead of passing
a pointless argument.  Note the the target code did in fact already
set it and then just overrode it again by calling blk_execute_rq_nowait.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-mq.c                     |  5 +----
 drivers/block/sx8.c                |  4 ++--
 drivers/nvme/host/core.c           |  3 ++-
 drivers/nvme/host/ioctl.c          |  3 ++-
 drivers/nvme/host/pci.c            | 10 +++++++---
 drivers/nvme/target/passthru.c     |  3 ++-
 drivers/scsi/scsi_error.c          |  5 +++--
 drivers/scsi/sg.c                  |  3 ++-
 drivers/scsi/st.c                  |  3 ++-
 drivers/scsi/ufs/ufshpb.c          |  6 ++++--
 drivers/target/target_core_pscsi.c |  3 +--
 include/linux/blk-mq.h             |  3 +--
 12 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28b3e6db98499..8e7860268f614 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1189,7 +1189,6 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  * blk_execute_rq_nowait - insert a request to I/O scheduler for execution
  * @rq:		request to insert
  * @at_head:    insert request at head or tail of queue
- * @done:	I/O completion handler
  *
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler queue
@@ -1198,13 +1197,11 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  * Note:
  *    This function will invoke @done directly if the queue is dead.
  */
-void blk_execute_rq_nowait(struct request *rq, bool at_head, rq_end_io_fn *done)
+void blk_execute_rq_nowait(struct request *rq, bool at_head)
 {
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
 
-	rq->end_io = done;
-
 	blk_account_io_start(rq);
 	if (current->plug)
 		blk_add_rq_to_plug(current->plug, rq);
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index b361583944b94..63b4f6431d2e6 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -540,7 +540,7 @@ static int carm_array_info (struct carm_host *host, unsigned int array_idx)
 	spin_unlock_irq(&host->lock);
 
 	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(rq, true, NULL);
+	blk_execute_rq_nowait(rq, true);
 
 	return 0;
 
@@ -579,7 +579,7 @@ static int carm_send_special (struct carm_host *host, carm_sspc_t func)
 	crq->msg_bucket = (u32) rc;
 
 	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(rq, true, NULL);
+	blk_execute_rq_nowait(rq, true);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72f7c955c7078..727c12cbe3272 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1206,9 +1206,10 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
+	rq->end_io = nvme_keep_alive_end_io;
 	rq->end_io_data = ctrl;
 	rq->rq_flags |= RQF_QUIET;
-	blk_execute_rq_nowait(rq, false, nvme_keep_alive_end_io);
+	blk_execute_rq_nowait(rq, false);
 }
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 096b1b47d750e..a2e89db1cd639 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -453,6 +453,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	req->end_io = nvme_uring_cmd_end_io;
 	req->end_io_data = ioucmd;
 
 	/* to free bio on completion, as req->bio will be null at that time */
@@ -461,7 +462,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	pdu->meta_buffer = nvme_to_user_ptr(d.metadata);
 	pdu->meta_len = d.metadata_len;
 
-	blk_execute_rq_nowait(req, 0, nvme_uring_cmd_end_io);
+	blk_execute_rq_nowait(req, false);
 	return -EIOCBQUEUED;
 }
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a98a7de09642..0403b6d10bb48 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1438,9 +1438,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 	nvme_init_request(abort_req, &cmd);
 
+	abort_req->end_io = abort_endio;
 	abort_req->end_io_data = NULL;
 	abort_req->rq_flags |= RQF_QUIET;
-	blk_execute_rq_nowait(abort_req, false, abort_endio);
+	blk_execute_rq_nowait(abort_req, false);
 
 	/*
 	 * The aborted req will be completed on receiving the abort req.
@@ -2485,12 +2486,15 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 		return PTR_ERR(req);
 	nvme_init_request(req, &cmd);
 
+	if (opcode == nvme_admin_delete_cq)
+		req->end_io = nvme_del_cq_end;
+	else
+		req->end_io = nvme_del_queue_end;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
 	req->rq_flags |= RQF_QUIET;
-	blk_execute_rq_nowait(req, false, opcode == nvme_admin_delete_cq ?
-			nvme_del_cq_end : nvme_del_queue_end);
+	blk_execute_rq_nowait(req, false);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 5247c24538eba..3cc4d6709c93c 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -285,8 +285,9 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		req->p.rq = rq;
 		queue_work(nvmet_wq, &req->p.work);
 	} else {
+		rq->end_io = nvmet_passthru_req_done;
 		rq->end_io_data = req;
-		blk_execute_rq_nowait(rq, false, nvmet_passthru_req_done);
+		blk_execute_rq_nowait(rq, false);
 	}
 
 	if (ns)
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index cdaca13ac1f1c..49ef864df5816 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2039,12 +2039,13 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
 	scmd->cmnd[4] = SCSI_REMOVAL_PREVENT;
 	scmd->cmnd[5] = 0;
 	scmd->cmd_len = COMMAND_SIZE(scmd->cmnd[0]);
+	scmd->allowed = 5;
 
 	req->rq_flags |= RQF_QUIET;
 	req->timeout = 10 * HZ;
-	scmd->allowed = 5;
+	req->end_io = eh_lock_door_done;
 
-	blk_execute_rq_nowait(req, true, eh_lock_door_done);
+	blk_execute_rq_nowait(req, true);
 }
 
 /**
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index cbffa712b9f3e..118c7b4a8af2c 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -831,7 +831,8 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 
 	srp->rq->timeout = timeout;
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
-	blk_execute_rq_nowait(srp->rq, at_head, sg_rq_end_io);
+	srp->rq->end_io = sg_rq_end_io;
+	blk_execute_rq_nowait(srp->rq, at_head);
 	return 0;
 }
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 56a093a90b922..850172a2b8f14 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -579,9 +579,10 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 	memcpy(scmd->cmnd, cmd, scmd->cmd_len);
 	req->timeout = timeout;
 	scmd->allowed = retries;
+	req->end_io = st_scsi_execute_end;
 	req->end_io_data = SRpnt;
 
-	blk_execute_rq_nowait(req, true, st_scsi_execute_end);
+	blk_execute_rq_nowait(req, true);
 	return 0;
 }
 
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 588c0329b80ca..8a7809b9728df 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -671,11 +671,12 @@ static void ufshpb_execute_umap_req(struct ufshpb_lu *hpb,
 
 	req->timeout = 0;
 	req->end_io_data = umap_req;
+	req->end_io = ufshpb_umap_req_compl_fn;
 
 	ufshpb_set_unmap_cmd(scmd->cmnd, rgn);
 	scmd->cmd_len = HPB_WRITE_BUFFER_CMD_LENGTH;
 
-	blk_execute_rq_nowait(req, true, ufshpb_umap_req_compl_fn);
+	blk_execute_rq_nowait(req, true);
 
 	hpb->stats.umap_req_cnt++;
 }
@@ -707,6 +708,7 @@ static int ufshpb_execute_map_req(struct ufshpb_lu *hpb,
 	blk_rq_append_bio(req, map_req->bio);
 
 	req->end_io_data = map_req;
+	req->end_io = ufshpb_map_req_compl_fn;
 
 	if (unlikely(last))
 		mem_size = hpb->last_srgn_entries * HPB_ENTRY_SIZE;
@@ -716,7 +718,7 @@ static int ufshpb_execute_map_req(struct ufshpb_lu *hpb,
 				map_req->rb.srgn_idx, mem_size);
 	scmd->cmd_len = HPB_READ_BUFFER_CMD_LENGTH;
 
-	blk_execute_rq_nowait(req, true, ufshpb_map_req_compl_fn);
+	blk_execute_rq_nowait(req, true);
 
 	hpb->stats.map_req_cnt++;
 	return 0;
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index bb3fb18b2316d..e6a967ddc08ce 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -972,8 +972,7 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 
 	cmd->priv = scmd->cmnd;
 
-	blk_execute_rq_nowait(req, cmd->sam_task_attr == TCM_HEAD_TAG,
-			pscsi_req_done);
+	blk_execute_rq_nowait(req, cmd->sam_task_attr == TCM_HEAD_TAG);
 
 	return 0;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9f07061418db0..e2d9daf7e8dd0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -969,8 +969,7 @@ int blk_rq_unmap_user(struct bio *);
 int blk_rq_map_kern(struct request_queue *, struct request *, void *,
 		unsigned int, gfp_t);
 int blk_rq_append_bio(struct request *rq, struct bio *bio);
-void blk_execute_rq_nowait(struct request *rq, bool at_head,
-		rq_end_io_fn *end_io);
+void blk_execute_rq_nowait(struct request *rq, bool at_head);
 blk_status_t blk_execute_rq(struct request *rq, bool at_head);
 
 struct req_iterator {
-- 
2.30.2

