Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22E43F3F1E
	for <lists+target-devel@lfdr.de>; Sun, 22 Aug 2021 13:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhHVL4T (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 22 Aug 2021 07:56:19 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:59935 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhHVL4S (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:56:18 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d04 with ME
        id kbva2500F3riaq203bva6s; Sun, 22 Aug 2021 13:55:36 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Aug 2021 13:55:36 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: elx: efct: switch from 'pci_' to 'dma_' API
Date:   Sun, 22 Aug 2021 13:55:33 +0200
Message-Id: <3899b1ed4abac581c30845d82f33ec6df8b38976.1629633207.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.

It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
This is less verbose.

It has been compile tested.


@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

This patch has *NOT* been compile tested. (I don't use cross-compiler)
---
 drivers/scsi/elx/efct/efct_driver.c | 6 ++----
 drivers/scsi/elx/efct/efct_lio.c    | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index eab68fd9337a..b2b61bc45f12 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -541,11 +541,9 @@ efct_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, efct);
 
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) != 0 ||
-	    pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0) {
 		dev_warn(&pdev->dev, "trying DMA_BIT_MASK(32)\n");
-		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) != 0 ||
-		    pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)) != 0) {
+		if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
 			dev_err(&pdev->dev, "setting DMA_BIT_MASK failed\n");
 			rc = -1;
 			goto dma_mask_out;
diff --git a/drivers/scsi/elx/efct/efct_lio.c b/drivers/scsi/elx/efct/efct_lio.c
index bb3b460dc0bc..5f61d761258a 100644
--- a/drivers/scsi/elx/efct/efct_lio.c
+++ b/drivers/scsi/elx/efct/efct_lio.c
@@ -382,7 +382,7 @@ efct_lio_sg_map(struct efct_io *io)
 	struct efct_scsi_tgt_io *ocp = &io->tgt_io;
 	struct se_cmd *cmd = &ocp->cmd;
 
-	ocp->seg_map_cnt = pci_map_sg(io->efct->pci, cmd->t_data_sg,
+	ocp->seg_map_cnt = dma_map_sg(&io->efct->pci->dev, cmd->t_data_sg,
 				      cmd->t_data_nents, cmd->data_direction);
 	if (ocp->seg_map_cnt == 0)
 		return -EFAULT;
@@ -398,7 +398,7 @@ efct_lio_sg_unmap(struct efct_io *io)
 	if (WARN_ON(!ocp->seg_map_cnt || !cmd->t_data_sg))
 		return;
 
-	pci_unmap_sg(io->efct->pci, cmd->t_data_sg,
+	dma_unmap_sg(&io->efct->pci->dev, cmd->t_data_sg,
 		     ocp->seg_map_cnt, cmd->data_direction);
 	ocp->seg_map_cnt = 0;
 }
-- 
2.30.2

