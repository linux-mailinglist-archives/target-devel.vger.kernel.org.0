Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74315569657
	for <lists+target-devel@lfdr.de>; Thu,  7 Jul 2022 01:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiGFXhv (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 6 Jul 2022 19:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiGFXhp (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:37:45 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99B2CDE3;
        Wed,  6 Jul 2022 16:37:45 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C4F57C06E8;
        Wed,  6 Jul 2022 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657150664; bh=sozJ++cXeSxQ4ZCq/1PovSLzC4Dfvr8b/qzLB5n6zPs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=GE4LD9+iU2DLHLLCgJ0lTg/NM263EvJFUlDUhEkcKkHBMfnKNuXZA9xKh8iXrFFjN
         iZwX/CUIgRISX5ygBlRvlMeRLVrvDRO1kWIUjJcqhry7hPDawRtWMag41BgvLPIVIX
         3FPkQamOSnbxqDXHd12akxGKOjMuwXxre7cE55PmJ2mgDgCDXgNXQ2ctGbIsXDYjan
         HrDiDI2hMhVdi1XIWEhxpq7wp+L/85AQIPsOcH0VdIjbc93UFMg4heHDSMK9Ratn7O
         BvhH/xOBT2rLs8HkGXHisAcFOVrrDUpkdxLofTmui2272sFlgvKlAGJVLGay++FMOr
         9taZLv2VZk55g==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 7E6DAA006F;
        Wed,  6 Jul 2022 23:37:43 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Wed, 06 Jul 2022 16:37:43 -0700
Date:   Wed, 06 Jul 2022 16:37:43 -0700
Message-Id: <ce84775a1364314625f366d1bf5f71befb1ca335.1657149962.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 32/36] usb: gadget: f_tcm: Send sense reason
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

If there's a failure, report it back to the host with a sense reason.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 7162be5fdf2f..fb9b71158c4b 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -669,6 +669,9 @@ static int uasp_send_read_response(struct usbg_cmd *cmd)
 			pr_err("%s(%d) => %d\n", __func__, __LINE__, ret);
 	}
 out:
+	if (ret)
+		transport_send_check_condition_and_sense(&cmd->se_cmd,
+				TCM_CHECK_CONDITION_UNIT_ATTENTION, 0);
 	return ret;
 }
 
@@ -711,6 +714,9 @@ static int uasp_send_write_request(struct usbg_cmd *cmd)
 	}
 
 cleanup:
+	if (ret)
+		transport_send_check_condition_and_sense(&cmd->se_cmd,
+				TCM_CHECK_CONDITION_UNIT_ATTENTION, 0);
 	return ret;
 }
 
@@ -955,7 +961,15 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 	return;
 
 cleanup:
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
+	/* Command was aborted */
+	if (cmd->state == UASP_QUEUE_COMMAND) {
+		transport_generic_free_cmd(se_cmd, 0);
+		return;
+	}
+
+	cmd->state = UASP_QUEUE_COMMAND;
+	transport_send_check_condition_and_sense(se_cmd,
+			TCM_CHECK_CONDITION_UNIT_ATTENTION, 0);
 }
 
 static int usbg_prepare_w_request(struct usbg_cmd *cmd, struct usb_request *req)
-- 
2.28.0

