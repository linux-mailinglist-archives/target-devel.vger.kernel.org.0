Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C562E1D07
	for <lists+target-devel@lfdr.de>; Wed, 23 Dec 2020 15:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgLWOLe (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 23 Dec 2020 09:11:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9985 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgLWOLe (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:11:34 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D1FTX4fNzzhwqd;
        Wed, 23 Dec 2020 22:10:08 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:10:44 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] scsi: target: iscsi: use DEFINE_MUTEX (and mutex_init() had been too late)
Date:   Wed, 23 Dec 2020 22:11:20 +0800
Message-ID: <20201223141120.32346-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/target/iscsi/iscsi_target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 518fac4864cf..b33726229f94 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -50,7 +50,7 @@ static DEFINE_MUTEX(np_lock);
 
 static struct idr tiqn_idr;
 DEFINE_IDA(sess_ida);
-struct mutex auth_id_lock;
+DEFINE_MUTEX(auth_id_lock);
 
 struct iscsit_global *iscsit_global;
 
@@ -690,7 +690,6 @@ static int __init iscsi_target_init_module(void)
 		return -1;
 
 	spin_lock_init(&iscsit_global->ts_bitmap_lock);
-	mutex_init(&auth_id_lock);
 	idr_init(&tiqn_idr);
 
 	ret = target_register_template(&iscsi_ops);
-- 
2.22.0

