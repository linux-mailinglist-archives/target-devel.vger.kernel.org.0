Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF6344015
	for <lists+target-devel@lfdr.de>; Mon, 22 Mar 2021 12:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVLpH (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 22 Mar 2021 07:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhCVLoq (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD98061974;
        Mon, 22 Mar 2021 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616413485;
        bh=bKmCS8aIsW9W0W9EIWXnZu063w0cBmbUMJ4RHWeTFrc=;
        h=From:To:Cc:Subject:Date:From;
        b=o8kKuvhT9if9e6sthkLLZRkS5pHpEHIhZHMlr4uBE4qHDpiEYsoyFXg8J5HFMPWwP
         OQul2/rHFZc5y9WmcznrqZ/sWO5JC0lFHL0zGKzRTwYiSCJUu/4qoQW4SrKSwhcoC/
         8tHn9OUDN9Iz7CN5OCXrLP0QrH9Fiy4VkUsWBbnJxZmewmL5+F8NOkjcJ2r70j847/
         HuJr6ytYrWA1/yYq9iSnZ/hKE/w5i96xeameQzxvmsFn0/EjCUrZ2NxitE4AGwmCm4
         fjigmD/OK/VACv/0b2D2GCLQz+S45NvCwekCofU48wzAlB5GLQeKmC+mNOG3OiUDj2
         hKp/C29pRSfGQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] target: pscsi: avoid Wempty-body warning
Date:   Mon, 22 Mar 2021 12:44:34 +0100
Message-Id: <20210322114441.3479365-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' shows a harmless warning for pscsi:

drivers/target/target_core_pscsi.c: In function 'pscsi_complete_cmd':
drivers/target/target_core_pscsi.c:624:33: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  624 |                                 ; /* XXX: TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE */
      |                                 ^

Rework the coding style as suggested by gcc to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/target/target_core_pscsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 3cbc074992bc..913b092955f6 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -620,8 +620,9 @@ static void pscsi_complete_cmd(struct se_cmd *cmd, u8 scsi_status,
 			unsigned char *buf;
 
 			buf = transport_kmap_data_sg(cmd);
-			if (!buf)
-				; /* XXX: TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE */
+			if (!buf) {
+				/* XXX: TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE */
+			}
 
 			if (cdb[0] == MODE_SENSE_10) {
 				if (!(buf[3] & 0x80))
-- 
2.29.2

