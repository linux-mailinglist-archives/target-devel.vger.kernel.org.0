Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC716AD8C2
	for <lists+target-devel@lfdr.de>; Tue,  7 Mar 2023 09:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCGIIz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Mar 2023 03:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCGIIg (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:08:36 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91C125970;
        Tue,  7 Mar 2023 00:08:10 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 75D54341EB8;
        Tue,  7 Mar 2023 11:07:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=3eAU+aIyF6YkjbljD8
        h+LIF0eqC0rHsc6DFVHsIfcxk=; b=gPe10e8w7MK0LAPkhutsuZ+hZDsqGc4pw8
        wecCfgyNCpwUcCSnozBynwYvRFg9fLHgbArhjMYC6ehpkCeARwh27YBhmBHJnRZj
        c+XW4cADtFNBDHPlNZwPE7mGr/5uSc9R7SaEY/dzyIQf5B2iL1EDukQM45nFjlh8
        JmC+gTJ6Q=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 6BB58341E00;
        Tue,  7 Mar 2023 11:07:52 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.20.11) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Tue, 7 Mar 2023 11:07:51 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Chris Boot <bootc@bootc.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Juergen Gross <jgross@suse.com>, <linux-scsi@vger.kernel.org>,
        <linux@yadro.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH v2 04/12] scsi: target: loop: remove default fabric ops callouts
Date:   Tue, 7 Mar 2023 11:07:34 +0300
Message-ID: <20230307080742.24631-5-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307080742.24631-1-d.bogdanov@yadro.com>
References: <20230307080742.24631-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.20.11]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Remove callouts that have the implementation like a
default implementation in TCM Core.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/loopback/tcm_loop.c | 41 ------------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 139031ccb700..5c8646c2d4e9 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -480,30 +480,6 @@ static int tcm_loop_check_demo_mode(struct se_portal_group *se_tpg)
 	return 1;
 }
 
-static int tcm_loop_check_demo_mode_cache(struct se_portal_group *se_tpg)
-{
-	return 0;
-}
-
-/*
- * Allow I_T Nexus full READ-WRITE access without explict Initiator Node ACLs for
- * local virtual Linux/SCSI LLD passthrough into VM hypervisor guest
- */
-static int tcm_loop_check_demo_mode_write_protect(struct se_portal_group *se_tpg)
-{
-	return 0;
-}
-
-/*
- * Because TCM_Loop does not use explict ACLs and MappedLUNs, this will
- * never be called for TCM_Loop by target_core_fabric_configfs.c code.
- * It has been added here as a nop for target_fabric_tf_ops_check()
- */
-static int tcm_loop_check_prod_mode_write_protect(struct se_portal_group *se_tpg)
-{
-	return 0;
-}
-
 static int tcm_loop_check_prot_fabric_only(struct se_portal_group *se_tpg)
 {
 	struct tcm_loop_tpg *tl_tpg = container_of(se_tpg, struct tcm_loop_tpg,
@@ -511,21 +487,11 @@ static int tcm_loop_check_prot_fabric_only(struct se_portal_group *se_tpg)
 	return tl_tpg->tl_fabric_prot_type;
 }
 
-static u32 tcm_loop_get_inst_index(struct se_portal_group *se_tpg)
-{
-	return 1;
-}
-
 static u32 tcm_loop_sess_get_index(struct se_session *se_sess)
 {
 	return 1;
 }
 
-static void tcm_loop_set_default_node_attributes(struct se_node_acl *se_acl)
-{
-	return;
-}
-
 static int tcm_loop_get_cmd_state(struct se_cmd *se_cmd)
 {
 	struct tcm_loop_cmd *tl_cmd = container_of(se_cmd,
@@ -1124,18 +1090,11 @@ static const struct target_core_fabric_ops loop_ops = {
 	.tpg_get_wwn			= tcm_loop_get_endpoint_wwn,
 	.tpg_get_tag			= tcm_loop_get_tag,
 	.tpg_check_demo_mode		= tcm_loop_check_demo_mode,
-	.tpg_check_demo_mode_cache	= tcm_loop_check_demo_mode_cache,
-	.tpg_check_demo_mode_write_protect =
-				tcm_loop_check_demo_mode_write_protect,
-	.tpg_check_prod_mode_write_protect =
-				tcm_loop_check_prod_mode_write_protect,
 	.tpg_check_prot_fabric_only	= tcm_loop_check_prot_fabric_only,
-	.tpg_get_inst_index		= tcm_loop_get_inst_index,
 	.check_stop_free		= tcm_loop_check_stop_free,
 	.release_cmd			= tcm_loop_release_cmd,
 	.sess_get_index			= tcm_loop_sess_get_index,
 	.write_pending			= tcm_loop_write_pending,
-	.set_default_node_attributes	= tcm_loop_set_default_node_attributes,
 	.get_cmd_state			= tcm_loop_get_cmd_state,
 	.queue_data_in			= tcm_loop_queue_data_in,
 	.queue_status			= tcm_loop_queue_status,
-- 
2.25.1


