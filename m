Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF17E47377
	for <lists+target-devel@lfdr.de>; Sun, 16 Jun 2019 09:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfFPHC1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 16 Jun 2019 03:02:27 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:55747 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfFPHC0 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 16 Jun 2019 03:02:26 -0400
Received: from localhost.localdomain ([86.243.180.47])
        by mwinf5d17 with ME
        id RK2N2000C11lVym03K2NQE; Sun, 16 Jun 2019 09:02:23 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Jun 2019 09:02:23 +0200
X-ME-IP: 86.243.180.47
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: tcmu: Simplify 'tcmu_update_uio_info()'
Date:   Sun, 16 Jun 2019 09:02:20 +0200
Message-Id: <20190616070220.24189-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Use 'kasprintf()' instead of:
   - snprintf(NULL, 0...
   - kmalloc(...
   - snprintf(...

This is less verbose and saves 7 bytes (i.e. the space for '/(null)') if
'udev->dev_config' is NULL.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/target/target_core_user.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index b43d6385a1a0..04eda111920e 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1824,20 +1824,18 @@ static int tcmu_update_uio_info(struct tcmu_dev *udev)
 {
 	struct tcmu_hba *hba = udev->hba->hba_ptr;
 	struct uio_info *info;
-	size_t size, used;
 	char *str;
 
 	info = &udev->uio_info;
-	size = snprintf(NULL, 0, "tcm-user/%u/%s/%s", hba->host_id, udev->name,
-			udev->dev_config);
-	size += 1; /* for \0 */
-	str = kmalloc(size, GFP_KERNEL);
-	if (!str)
-		return -ENOMEM;
 
-	used = snprintf(str, size, "tcm-user/%u/%s", hba->host_id, udev->name);
 	if (udev->dev_config[0])
-		snprintf(str + used, size - used, "/%s", udev->dev_config);
+		str = kasprintf(GFP_KERNEL, "tcm-user/%u/%s/%s", hba->host_id,
+				udev->name, udev->dev_config);
+	else
+		str = kasprintf(GFP_KERNEL, "tcm-user/%u/%s", hba->host_id,
+				udev->name);
+	if (!str)
+		return -ENOMEM;
 
 	/* If the old string exists, free it */
 	kfree(info->name);
-- 
2.20.1

