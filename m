Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307215B65AC
	for <lists+target-devel@lfdr.de>; Tue, 13 Sep 2022 04:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIMChb (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 12 Sep 2022 22:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIMCh3 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:37:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251014331D;
        Mon, 12 Sep 2022 19:37:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRSFN60bbzlVxJ;
        Tue, 13 Sep 2022 10:33:28 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 10:37:24 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <andrew.vasquez@qlogic.com>, <James.Bottomley@SteelEye.com>,
        <giridhar.malavali@qlogic.com>, <James.Bottomley@suse.de>,
        <James.Bottomley@HansenPartnership.com>, <quinn.tran@cavium.com>,
        <himanshu.madhani@cavium.com>, <bart.vanassche@sandisk.com>,
        <nab@linux-iscsi.org>, <cuigaosheng1@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>
Subject: [PATCH 2/2] scsi: target: remove unused se_tmr_req_cache declaration
Date:   Tue, 13 Sep 2022 10:37:22 +0800
Message-ID: <20220913023722.547249-3-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913023722.547249-1-cuigaosheng1@huawei.com>
References: <20220913023722.547249-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

se_tmr_req_cache has been removed since
commit c8e31f26feeb ("target: Add SCF_SCSI_TMR_CDB usage
and drop se_tmr_req_cache"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/target/target_core_internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index a889a6237d9c..30fcf69e1a1d 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -133,8 +133,6 @@ struct se_node_acl *core_tpg_add_initiator_node_acl(struct se_portal_group *tpg,
 void core_tpg_del_initiator_node_acl(struct se_node_acl *acl);
 
 /* target_core_transport.c */
-extern struct kmem_cache *se_tmr_req_cache;
-
 int	init_se_kmem_caches(void);
 void	release_se_kmem_caches(void);
 u32	scsi_get_new_index(scsi_index_t);
-- 
2.25.1

