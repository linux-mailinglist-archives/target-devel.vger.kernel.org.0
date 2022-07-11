Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D896A56962C
	for <lists+target-devel@lfdr.de>; Thu,  7 Jul 2022 01:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiGFXgq (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 6 Jul 2022 19:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiGFXgm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:36:42 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A750C2CCA8;
        Wed,  6 Jul 2022 16:36:41 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8263340CAF;
        Wed,  6 Jul 2022 23:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657150601; bh=bAS8o77Z1Y+tMzGOThOXTs6nCn/UzEd3nCbgY2zNJnA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=PamxDTt/zxJOTIpaGJgHyUYsZvb+vRoUVGHQCiBW0CIcGh9r5QcTC46XukSFsLGkd
         dJphZBwReCoydzIL5nxf5MkXu0CEO+YHoCu4Lz+ptKzIXPuyKJRfkIeWbc+bDqtoCG
         Z7s4k1SGTks+ODWip2zoQrkl/bBQKd0KDumt2ULmDRPYphMt+5nUDG2fRu06VGGaUo
         EJeSrZGkbkNSBOj6qM8ejdi9y7UWHFetqaz7fMzNQRrNZh3RsoxCMjos+sdiWy1abt
         15TGk2cSvAdtk2SbxKYUlYsSLJLfUk071A6eNntMZGXWf8Om3DJgfyPynB3FuWa97q
         yUoZZLDm8Srdw==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 659F1A006F;
        Wed,  6 Jul 2022 23:36:40 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Wed, 06 Jul 2022 16:36:40 -0700
Date:   Wed, 06 Jul 2022 16:36:40 -0700
Message-Id: <c37cabb26020f051388500db9fe1a34587e4c76d.1657149962.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 22/36] usb: gadget: f_tcm: Use extra number of commands
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

To properly respond to host sending more commands than the number of
streams the device advertises, the device needs to be able to reject the
command with a response. Allocate an extra request to handle 1 more
command than the number of streams.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/tcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index df768559fb60..c7e6d36afd3a 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -16,7 +16,7 @@
 #define UASP_SS_EP_COMP_LOG_STREAMS 5
 #define UASP_SS_EP_COMP_NUM_STREAMS (1 << UASP_SS_EP_COMP_LOG_STREAMS)
 
-#define USBG_NUM_CMDS		UASP_SS_EP_COMP_NUM_STREAMS
+#define USBG_NUM_CMDS		(UASP_SS_EP_COMP_NUM_STREAMS + 1)
 
 enum {
 	USB_G_STR_INT_UAS = 0,
-- 
2.28.0

