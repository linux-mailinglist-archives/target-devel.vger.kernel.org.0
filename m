Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29F4BFA2E
	for <lists+target-devel@lfdr.de>; Tue, 22 Feb 2022 15:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiBVOFb (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Feb 2022 09:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiBVOF2 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:05:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F315F34B;
        Tue, 22 Feb 2022 06:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o/9oISPUFNwuvFRHxwdJlUH49C/JrPmxVa/ABX2XzV0=; b=4lIndbZdadpitMf07F9U9037OJ
        cAG7EEWb2iVVN4ydkh11PeJoWy1ug1u6AxrDSDK/kwG6jNmGok73/677yv6LQRNeZPKsbJOgq20IQ
        KmDeClM/NqqXwuXeNrxVSQRfa/CRt4eDGtPdRklms8H9B8VjfjNCD6dU/olGz1Phm8fMZR5yY2Vr8
        pw9HebjRz16OuXcv7OAXe0VkD0e3QYJcrcySUTWQdvnsKx3bGkksNG0slJNcEc3HDOq7kyeRcz3l0
        43B37rTrnen1lF7gsr7xndWPNvpC6OslNKq1+ChAmOT+YjlyP6fTsIjoEm8MD+6XBqy9bYpKhkHnm
        mShmTe8g==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMVmo-009nUb-63; Tue, 22 Feb 2022 14:05:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH 6/8] scsi: move the resid_len field from struct scsi_request to struct scsi_cmnd
Date:   Tue, 22 Feb 2022 15:04:41 +0100
Message-Id: <20220222140443.589882-7-hch@lst.de>
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

Prepare for removing the scsi_request structure by moving the resid_len
field to struct scsi_cmnd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_bsg.c            | 4 ++--
 drivers/scsi/scsi_error.c          | 6 +++---
 drivers/scsi/scsi_ioctl.c          | 2 +-
 drivers/scsi/scsi_lib.c            | 6 +++---
 drivers/scsi/sg.c                  | 2 +-
 drivers/scsi/st.c                  | 2 +-
 drivers/target/target_core_pscsi.c | 2 +-
 include/scsi/scsi_cmnd.h           | 6 +++---
 include/scsi/scsi_request.h        | 1 -
 9 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 0a6f6140501be..4c697d0ddf1d2 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -88,9 +88,9 @@ static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	}
 
 	if (rq_data_dir(rq) == READ)
-		hdr->din_resid = sreq->resid_len;
+		hdr->din_resid = scmd->resid_len;
 	else
-		hdr->dout_resid = sreq->resid_len;
+		hdr->dout_resid = scmd->resid_len;
 
 	blk_rq_unmap_user(bio);
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 5383139a3de86..cf02d1c503897 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1005,7 +1005,7 @@ void scsi_eh_prep_cmnd(struct scsi_cmnd *scmd, struct scsi_eh_save *ses,
 	ses->data_direction = scmd->sc_data_direction;
 	ses->sdb = scmd->sdb;
 	ses->result = scmd->result;
-	ses->resid_len = scmd->req.resid_len;
+	ses->resid_len = scmd->resid_len;
 	ses->underflow = scmd->underflow;
 	ses->prot_op = scmd->prot_op;
 	ses->eh_eflags = scmd->eh_eflags;
@@ -1016,7 +1016,7 @@ void scsi_eh_prep_cmnd(struct scsi_cmnd *scmd, struct scsi_eh_save *ses,
 	memset(scmd->cmnd, 0, sizeof(scmd->cmnd));
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 	scmd->result = 0;
-	scmd->req.resid_len = 0;
+	scmd->resid_len = 0;
 
 	if (sense_bytes) {
 		scmd->sdb.length = min_t(unsigned, SCSI_SENSE_BUFFERSIZE,
@@ -1069,7 +1069,7 @@ void scsi_eh_restore_cmnd(struct scsi_cmnd* scmd, struct scsi_eh_save *ses)
 	scmd->sc_data_direction = ses->data_direction;
 	scmd->sdb = ses->sdb;
 	scmd->result = ses->result;
-	scmd->req.resid_len = ses->resid_len;
+	scmd->resid_len = ses->resid_len;
 	scmd->underflow = ses->underflow;
 	scmd->prot_op = ses->prot_op;
 	scmd->eh_eflags = ses->eh_eflags;
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 731232e6ee664..546b98321023c 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -386,7 +386,7 @@ static int scsi_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
 	hdr->info = 0;
 	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
 		hdr->info |= SG_INFO_CHECK;
-	hdr->resid = req->resid_len;
+	hdr->resid = scmd->resid_len;
 	hdr->sb_len_wr = 0;
 
 	if (scmd->sense_len && hdr->sbp) {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index db269f1d70b83..c0664f7a86e73 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -251,11 +251,11 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	 * is invalid.  Prevent the garbage from being misinterpreted
 	 * and prevent security leaks by zeroing out the excess data.
 	 */
-	if (unlikely(rq->resid_len > 0 && rq->resid_len <= bufflen))
-		memset(buffer + (bufflen - rq->resid_len), 0, rq->resid_len);
+	if (unlikely(scmd->resid_len > 0 && scmd->resid_len <= bufflen))
+		memset(buffer + bufflen - scmd->resid_len, 0, scmd->resid_len);
 
 	if (resid)
-		*resid = rq->resid_len;
+		*resid = scmd->resid_len;
 	if (sense && scmd->sense_len)
 		memcpy(sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 	if (sshdr)
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0f96c7cde9e51..3eaabfb315e0c 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1346,7 +1346,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 
 	sense = scmd->sense_buffer;
 	result = req->result;
-	resid = req->resid_len;
+	resid = scmd->resid_len;
 
 	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sdp,
 				      "sg_cmd_done: pack_id=%d, res=0x%x\n",
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 9b98e848d78c1..0546d2c84ad16 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -521,7 +521,7 @@ static void st_scsi_execute_end(struct request *req, blk_status_t status)
 	struct bio *tmp;
 
 	STp->buffer->cmdstat.midlevel_result = SRpnt->result = rq->result;
-	STp->buffer->cmdstat.residual = rq->resid_len;
+	STp->buffer->cmdstat.residual = scmd->resid_len;
 
 	st_do_stats(STp, req);
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 9146193d0576a..d5828da3d392a 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1046,7 +1046,7 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 	switch (host_byte(result)) {
 	case DID_OK:
 		target_complete_cmd_with_length(cmd, scsi_status,
-			cmd->data_length - scsi_req(req)->resid_len);
+			cmd->data_length - scmd->resid_len);
 		break;
 	default:
 		pr_debug("PSCSI Host Byte exception at cmd: %p CDB:"
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 47add5b32f460..5ff0a6e8460c3 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -111,7 +111,7 @@ struct scsi_cmnd {
 				   (ie, between disconnect / 
 				   reconnects.   Probably == sector
 				   size */
-
+	unsigned resid_len;	/* residual count */
 	unsigned sense_len;
 	unsigned char *sense_buffer;
 				/* obtained by REQUEST SENSE when
@@ -200,12 +200,12 @@ static inline unsigned scsi_bufflen(struct scsi_cmnd *cmd)
 
 static inline void scsi_set_resid(struct scsi_cmnd *cmd, unsigned int resid)
 {
-	cmd->req.resid_len = resid;
+	cmd->resid_len = resid;
 }
 
 static inline unsigned int scsi_get_resid(struct scsi_cmnd *cmd)
 {
-	return cmd->req.resid_len;
+	return cmd->resid_len;
 }
 
 #define scsi_for_each_sg(cmd, sg, nseg, __i)			\
diff --git a/include/scsi/scsi_request.h b/include/scsi/scsi_request.h
index bed1cc49132ab..74be75336a54d 100644
--- a/include/scsi/scsi_request.h
+++ b/include/scsi/scsi_request.h
@@ -6,7 +6,6 @@
 
 struct scsi_request {
 	int		result;
-	unsigned int	resid_len;	/* residual count */
 	int		retries;
 };
 
-- 
2.30.2

