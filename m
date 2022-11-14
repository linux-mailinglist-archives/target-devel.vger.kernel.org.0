Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4730C628450
	for <lists+target-devel@lfdr.de>; Mon, 14 Nov 2022 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiKNPra (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 14 Nov 2022 10:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiKNPr3 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:47:29 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4412D33;
        Mon, 14 Nov 2022 07:47:27 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N9tsH0kLfzJnhs;
        Mon, 14 Nov 2022 23:44:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 23:47:25 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 23:47:25 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <target-devel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <martin.petersen@oracle.com>, <hch@lst.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH] scsi: target: tcm_loop: fix possible name leak in tcm_loop_setup_hba_bus()
Date:   Mon, 14 Nov 2022 23:45:56 +0800
Message-ID: <20221114154556.2985745-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

If tcm_loop_setup_hba_bus() returns error, the name allocated by
dev_set_name() need be freed. As comment of device_register()
says, it should use put_device() to give up the reference in the
error path. So fix this by calling put_device(), then the name
can be freed in kobject_cleanup(). The 'tl_hba' will be freed in
tcm_loop_release_adapter(), so it don't need goto error label in
this case.

Fixes: 3703b2c5d041 ("[SCSI] tcm_loop: Add multi-fabric Linux/SCSI LLD fabric module")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/target/loopback/tcm_loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 4407b56aa6d1..d3277993ce17 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -1072,8 +1072,10 @@ static struct se_wwn *tcm_loop_make_scsi_hba(
 	 * device_register() callbacks in tcm_loop_driver_probe()
 	 */
 	ret = tcm_loop_setup_hba_bus(tl_hba, tcm_loop_hba_no_cnt);
-	if (ret)
-		goto out;
+	if (ret) {
+		put_device(&tl_hba->dev);
+		return ERR_PTR(ret);
+	}
 
 	sh = tl_hba->sh;
 	tcm_loop_hba_no_cnt++;
-- 
2.25.1

