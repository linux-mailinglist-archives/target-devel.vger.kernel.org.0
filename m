Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2553F56964B
	for <lists+target-devel@lfdr.de>; Thu,  7 Jul 2022 01:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiGFXhz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 6 Jul 2022 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiGFXhv (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:37:51 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E918C2CDD6;
        Wed,  6 Jul 2022 16:37:50 -0700 (PDT)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C9EEB4077F;
        Wed,  6 Jul 2022 23:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657150670; bh=/RISCmRz56QKvQJvxjK6Y26DGM4C3D1LuInOMKo9zn4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=M7QxtFtdGy77qti38DJ7WK7Gx7L+vk5ieLKMa2UeeCm/nTwC015NXztbpgAiehzAq
         ssqyQBoMZYXMwLJbGq/KcSjhpm0i6T7yp6my0tvJa8UdV9NGpUicn3mZeav0ZW+ETk
         PaZBjG+nSLqqTHbfpMWJDbX7I8MDuNZo/Cr0xl/fja7EVzky9VtvwyqQBe2z9Eo90m
         /xJoBJgFd+cwOZDUX+U0pGqJjX1Dn5FW/pWjD/cuC354sG5qsTbNQIChz8aduQXUlh
         DWj0UkeBcGsVl+LOf2vdEpcbUCoEopDCsXfujw1vNi5CPCCHbd7yT1AqlfbGLDXPwn
         JtjqIil6GI/wg==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id A666EA0096;
        Wed,  6 Jul 2022 23:37:49 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Wed, 06 Jul 2022 16:37:49 -0700
Date:   Wed, 06 Jul 2022 16:37:49 -0700
Message-Id: <dd92182df64263810cc05683f20c31590244715d.1657149962.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 33/36] usb: gadget: f_tcm: Save CPU ID per command
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

Normally we don't care about the CPU id, but if we ever use
TARGET_SCF_USE_CPUID, then we need to save the cpuid.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index fb9b71158c4b..c13aa61d82aa 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1082,6 +1082,7 @@ static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->se_cmd.map_tag = tag;
 	cmd->se_cmd.map_cpu = cpu;
+	cmd->se_cmd.cpuid = cpu;
 	cmd->se_cmd.tag = cmd->tag = scsi_tag;
 	cmd->fu = fu;
 
-- 
2.28.0

