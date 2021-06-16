Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734D13AA216
	for <lists+target-devel@lfdr.de>; Wed, 16 Jun 2021 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhFPRGd (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 16 Jun 2021 13:06:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48305 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhFPRGR (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:06:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltYxO-0006KD-6q; Wed, 16 Jun 2021 17:04:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: elx: libefc: Fix less than zero comparison of a unsigned int
Date:   Wed, 16 Jun 2021 18:04:01 +0100
Message-Id: <20210616170401.15831-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparison of the u32 variable rc to less than zero always
false because it is unsigned. Fix this by making it an int.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 202bfdffae27 ("scsi: elx: libefc: FC node ELS and state handling")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/elx/libefc/efc_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/libefc/efc_device.c b/drivers/scsi/elx/libefc/efc_device.c
index 31a688bce6e9..725ca2a23fb2 100644
--- a/drivers/scsi/elx/libefc/efc_device.c
+++ b/drivers/scsi/elx/libefc/efc_device.c
@@ -15,7 +15,7 @@
 void
 efc_d_send_prli_rsp(struct efc_node *node, u16 ox_id)
 {
-	u32 rc = EFC_SCSI_CALL_COMPLETE;
+	int rc = EFC_SCSI_CALL_COMPLETE;
 	struct efc *efc = node->efc;
 
 	node->ls_acc_oxid = ox_id;
-- 
2.31.1

