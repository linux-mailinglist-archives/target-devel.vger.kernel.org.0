Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836D4569621
	for <lists+target-devel@lfdr.de>; Thu,  7 Jul 2022 01:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiGFXgT (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 6 Jul 2022 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiGFXgS (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:36:18 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4F32CCB1;
        Wed,  6 Jul 2022 16:36:17 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0D030C06E8;
        Wed,  6 Jul 2022 23:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657150577; bh=ID+KNbEF1qrOBaTI4FRkar7KOfJ0VQUCqvZyNnmVmF4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=I6w3zyy8CinvsvJflrUFt8d0Yck8DvLE/GyyYYb+dP637KteO0D71zqyUdoQJ0g3u
         Ll+jpeb81WnRiM5jezzBizEzWy45oMDmQCTR/3qZqhZmF9hSYuZ0ypdZF7zprQ2E0U
         j7hq9eeMQivTqIuAZukFdRX7Sm8u+CAhMRli+t5fX4Wa44PWpB7FfLT88TzO6ylnZR
         FEm0CCC2/IfzaupwDYZh6+93qJK6jLierf6+kz1qSLvzD30LYwtJV0Gh5LTyNvMbzY
         rhR1i3G+4jrGWbsE+ktLEueEfowkRBCNpWrA9tPojffOJHU07+ephV6Rezn1y1riVJ
         RnbY+WrtE8qAg==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id C0F56A006F;
        Wed,  6 Jul 2022 23:36:15 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Wed, 06 Jul 2022 16:36:15 -0700
Date:   Wed, 06 Jul 2022 16:36:15 -0700
Message-Id: <d9863f8d7065cd9d5f6923ce002a86f6ee6509a9.1657149962.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 18/36] usb: gadget: f_tcm: Don't set static stream_id
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Host can assign stream ID value greater than number of streams
allocated. The tcm function needs to keep track of which stream is
available to assign the stream ID. This patch doesn't track that, but at
least it makes sure that there's no Oops if the host send tag with a
value greater than the number of supported streams.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 32 +++++------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 270ec631481d..7721216dc9bc 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -532,6 +532,7 @@ static int uasp_prepare_r_request(struct usbg_cmd *cmd)
 	}
 
 	stream->req_in->is_last = 1;
+	stream->req_in->stream_id = cmd->tag;
 	stream->req_in->complete = uasp_status_data_cmpl;
 	stream->req_in->length = se_cmd->data_length;
 	stream->req_in->context = cmd;
@@ -556,6 +557,7 @@ static void uasp_prepare_status(struct usbg_cmd *cmd)
 	iu->len = cpu_to_be16(se_cmd->scsi_sense_length);
 	iu->status = se_cmd->scsi_status;
 	stream->req_status->is_last = 1;
+	stream->req_status->stream_id = cmd->tag;
 	stream->req_status->context = cmd;
 	stream->req_status->length = se_cmd->scsi_sense_length + 16;
 	stream->req_status->buf = iu;
@@ -786,19 +788,6 @@ static int uasp_alloc_cmd(struct f_uas *fu)
 	return -ENOMEM;
 }
 
-static void uasp_setup_stream_res(struct f_uas *fu, int max_streams)
-{
-	int i;
-
-	for (i = 0; i < max_streams; i++) {
-		struct uas_stream *s = &fu->stream[i];
-
-		s->req_in->stream_id = i + 1;
-		s->req_out->stream_id = i + 1;
-		s->req_status->stream_id = i + 1;
-	}
-}
-
 static int uasp_prepare_reqs(struct f_uas *fu)
 {
 	int ret;
@@ -819,7 +808,6 @@ static int uasp_prepare_reqs(struct f_uas *fu)
 	ret = uasp_alloc_cmd(fu);
 	if (ret)
 		goto err_free_stream;
-	uasp_setup_stream_res(fu, max_streams);
 
 	ret = usb_ep_queue(fu->ep_cmd, fu->cmd.req, GFP_ATOMIC);
 	if (ret)
@@ -995,6 +983,7 @@ static int usbg_prepare_w_request(struct usbg_cmd *cmd, struct usb_request *req)
 	}
 
 	req->is_last = 1;
+	req->stream_id = cmd->tag;
 	req->complete = usbg_data_write_cmpl;
 	req->length = se_cmd->data_length;
 	req->context = cmd;
@@ -1125,16 +1114,8 @@ static int usbg_submit_command(struct f_uas *fu,
 	}
 	memcpy(cmd->cmd_buf, cmd_iu->cdb, cmd_len);
 
-	if (fu->flags & USBG_USE_STREAMS) {
-		if (cmd->tag > UASP_SS_EP_COMP_NUM_STREAMS)
-			goto err;
-		if (!cmd->tag)
-			cmd->stream = &fu->stream[0];
-		else
-			cmd->stream = &fu->stream[cmd->tag - 1];
-	} else {
-		cmd->stream = &fu->stream[0];
-	}
+	cmd->stream = &fu->stream[cmd->tag %
+		UASP_SS_EP_COMP_NUM_STREAMS];
 
 	switch (cmd_iu->prio_attr & 0x7) {
 	case UAS_HEAD_TAG:
@@ -1161,9 +1142,6 @@ static int usbg_submit_command(struct f_uas *fu,
 	queue_work(tpg->workqueue, &cmd->work);
 
 	return 0;
-err:
-	usbg_release_cmd(&cmd->se_cmd);
-	return -EINVAL;
 }
 
 static void bot_cmd_work(struct work_struct *work)
-- 
2.28.0

