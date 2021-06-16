Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1C3A9D8F
	for <lists+target-devel@lfdr.de>; Wed, 16 Jun 2021 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhFPO25 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 16 Jun 2021 10:28:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42674 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhFPO2r (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:28:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltWV3-0001Qt-Su; Wed, 16 Jun 2021 14:26:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: elx: efct: Fix spelling mistake "Unexected" -> "Unexpected"
Date:   Wed, 16 Jun 2021 15:26:37 +0100
Message-Id: <20210616142637.12706-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a efc_log_info message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/elx/efct/efct_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index 2fa5996fc0d5..eab68fd9337a 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -372,7 +372,7 @@ efct_request_firmware_update(struct efct *efct)
 		efct_fw_reset(efct);
 		break;
 	default:
-		efc_log_info(efct, "Unexected value change_status:%d\n",
+		efc_log_info(efct, "Unexpected value change_status:%d\n",
 			     fw_change_status);
 		break;
 	}
-- 
2.31.1

