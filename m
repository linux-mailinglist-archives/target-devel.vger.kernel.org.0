Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF27DEF4C
	for <lists+target-devel@lfdr.de>; Mon, 21 Oct 2019 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfJUOVC (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 21 Oct 2019 10:21:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJUOVB (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:21:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E5D6C8329DBBDFD2366E;
        Mon, 21 Oct 2019 22:20:56 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 22:20:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kxie@chelsio.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <bvanassche@acm.org>,
        <davem@davemloft.net>, <tglx@linutronix.de>, <info@metux.net>,
        <kstewart@linuxfoundation.org>, <yuehaibing@huawei.com>,
        <varun@chelsio.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <target-devel@vger.kernel.org>
Subject: [PATCH -next] scsi: cxgb4i: remove set but not used variable 'ppmax'
Date:   Mon, 21 Oct 2019 22:20:42 +0800
Message-ID: <20191021142042.30964-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:2076:15:
 warning: variable ppmax set but not used [-Wunused-but-set-variable]
drivers/target/iscsi/cxgbit/cxgbit_ddp.c:300:15:
 warning: variable ppmax set but not used [-Wunused-but-set-variable]

It is not used since commit a248384e6420 ("cxgb4/libcxgb/
cxgb4i/cxgbit: enable eDRAM page pods for iSCSI")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c       | 2 --
 drivers/target/iscsi/cxgbit/cxgbit_ddp.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index da50e87..bc1086a 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -2073,7 +2073,6 @@ static int cxgb4i_ddp_init(struct cxgbi_device *cdev)
 	struct cxgb4_lld_info *lldi = cxgbi_cdev_priv(cdev);
 	struct net_device *ndev = cdev->ports[0];
 	struct cxgbi_tag_format tformat;
-	unsigned int ppmax;
 	int i, err;
 
 	if (!lldi->vr->iscsi.size) {
@@ -2082,7 +2081,6 @@ static int cxgb4i_ddp_init(struct cxgbi_device *cdev)
 	}
 
 	cdev->flags |= CXGBI_FLAG_USE_PPOD_OFLDQ;
-	ppmax = lldi->vr->iscsi.size >> PPOD_SIZE_SHIFT;
 
 	memset(&tformat, 0, sizeof(struct cxgbi_tag_format));
 	for (i = 0; i < 4; i++)
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
index 54bb1eb..af35251 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
@@ -297,7 +297,6 @@ int cxgbit_ddp_init(struct cxgbit_device *cdev)
 	struct cxgb4_lld_info *lldi = &cdev->lldi;
 	struct net_device *ndev = cdev->lldi.ports[0];
 	struct cxgbi_tag_format tformat;
-	unsigned int ppmax;
 	int ret, i;
 
 	if (!lldi->vr->iscsi.size) {
@@ -305,8 +304,6 @@ int cxgbit_ddp_init(struct cxgbit_device *cdev)
 		return -EACCES;
 	}
 
-	ppmax = lldi->vr->iscsi.size >> PPOD_SIZE_SHIFT;
-
 	memset(&tformat, 0, sizeof(struct cxgbi_tag_format));
 	for (i = 0; i < 4; i++)
 		tformat.pgsz_order[i] = (lldi->iscsi_pgsz_order >> (i << 3))
-- 
2.7.4


