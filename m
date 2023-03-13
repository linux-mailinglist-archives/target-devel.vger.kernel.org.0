Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9094A6B8004
	for <lists+target-devel@lfdr.de>; Mon, 13 Mar 2023 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCMSL0 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 13 Mar 2023 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCMSLZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:11:25 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831E26923B;
        Mon, 13 Mar 2023 11:11:19 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id D85B834214C;
        Mon, 13 Mar 2023 21:11:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=d5NpFgk/odjS1rUJmA
        7AcC2xftoy2oCWQyNfpUpzt4M=; b=dy1HRgdIbyv1UlaJeDWF5vQdLmiE5kmwt9
        /XnQhRObVkfvvWTyiTzBjtQMAdG0G1aOEyIVvTjvlkEDdhZeBuyC8EFuzEL450bC
        LWqVV3uqiyCStDG2QfRifZeMRUV1yxnXTtlr8HKrjk4a8Tsle8MRfY/cliKivQ+A
        BT0zxqo/U=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id CEA81342145;
        Mon, 13 Mar 2023 21:11:17 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.20.11) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Mon, 13 Mar 2023 21:11:17 +0300
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
Subject: [PATCH v3 01/12] scsi: target: add default fabric ops callaouts
Date:   Mon, 13 Mar 2023 21:10:59 +0300
Message-ID: <20230313181110.20566-2-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313181110.20566-1-d.bogdanov@yadro.com>
References: <20230313181110.20566-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.20.11]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

There are several callout in target fabric ops that most of fabric
drivers fills with a function returning the same value.

Stop requiring such callaouts to exist in the ops, fill them in
TCM Core.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/target_core_configfs.c | 94 +++++++++++++++++----------
 1 file changed, 61 insertions(+), 33 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 611b0424e305..74b67c346dfe 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -335,6 +335,29 @@ EXPORT_SYMBOL(target_undepend_item);
 /*##############################################################################
 // Start functions called by external Target Fabrics Modules
 //############################################################################*/
+static int target_disable_feature(struct se_portal_group *se_tpg)
+{
+	return 0;
+}
+
+static u32 target_default_get_inst_index(struct se_portal_group *se_tpg)
+{
+	return 1;
+}
+
+static u32 target_default_sess_get_index(struct se_session *se_sess)
+{
+	return 0;
+}
+
+static void target_set_default_node_attributes(struct se_node_acl *se_acl)
+{
+}
+
+static int target_default_get_cmd_state(struct se_cmd *se_cmd)
+{
+	return 0;
+}
 
 static int target_fabric_tf_ops_check(const struct target_core_fabric_ops *tfo)
 {
@@ -362,46 +385,14 @@ static int target_fabric_tf_ops_check(const struct target_core_fabric_ops *tfo)
 		pr_err("Missing tfo->tpg_get_tag()\n");
 		return -EINVAL;
 	}
-	if (!tfo->tpg_check_demo_mode) {
-		pr_err("Missing tfo->tpg_check_demo_mode()\n");
-		return -EINVAL;
-	}
-	if (!tfo->tpg_check_demo_mode_cache) {
-		pr_err("Missing tfo->tpg_check_demo_mode_cache()\n");
-		return -EINVAL;
-	}
-	if (!tfo->tpg_check_demo_mode_write_protect) {
-		pr_err("Missing tfo->tpg_check_demo_mode_write_protect()\n");
-		return -EINVAL;
-	}
-	if (!tfo->tpg_check_prod_mode_write_protect) {
-		pr_err("Missing tfo->tpg_check_prod_mode_write_protect()\n");
-		return -EINVAL;
-	}
-	if (!tfo->tpg_get_inst_index) {
-		pr_err("Missing tfo->tpg_get_inst_index()\n");
-		return -EINVAL;
-	}
 	if (!tfo->release_cmd) {
 		pr_err("Missing tfo->release_cmd()\n");
 		return -EINVAL;
 	}
-	if (!tfo->sess_get_index) {
-		pr_err("Missing tfo->sess_get_index()\n");
-		return -EINVAL;
-	}
 	if (!tfo->write_pending) {
 		pr_err("Missing tfo->write_pending()\n");
 		return -EINVAL;
 	}
-	if (!tfo->set_default_node_attributes) {
-		pr_err("Missing tfo->set_default_node_attributes()\n");
-		return -EINVAL;
-	}
-	if (!tfo->get_cmd_state) {
-		pr_err("Missing tfo->get_cmd_state()\n");
-		return -EINVAL;
-	}
 	if (!tfo->queue_data_in) {
 		pr_err("Missing tfo->queue_data_in()\n");
 		return -EINVAL;
@@ -447,8 +438,36 @@ static int target_fabric_tf_ops_check(const struct target_core_fabric_ops *tfo)
 	return 0;
 }
 
+static void target_set_default_ops(struct target_core_fabric_ops *tfo)
+{
+	if (!tfo->tpg_check_demo_mode)
+		tfo->tpg_check_demo_mode = target_disable_feature;
+
+	if (!tfo->tpg_check_demo_mode_cache)
+		tfo->tpg_check_demo_mode_cache = target_disable_feature;
+
+	if (!tfo->tpg_check_demo_mode_write_protect)
+		tfo->tpg_check_demo_mode_write_protect = target_disable_feature;
+
+	if (!tfo->tpg_check_prod_mode_write_protect)
+		tfo->tpg_check_prod_mode_write_protect = target_disable_feature;
+
+	if (!tfo->tpg_get_inst_index)
+		tfo->tpg_get_inst_index = target_default_get_inst_index;
+
+	if (!tfo->sess_get_index)
+		tfo->sess_get_index = target_default_sess_get_index;
+
+	if (!tfo->set_default_node_attributes)
+		tfo->set_default_node_attributes = target_set_default_node_attributes;
+
+	if (!tfo->get_cmd_state)
+		tfo->get_cmd_state = target_default_get_cmd_state;
+}
+
 int target_register_template(const struct target_core_fabric_ops *fo)
 {
+	struct target_core_fabric_ops *tfo;
 	struct target_fabric_configfs *tf;
 	int ret;
 
@@ -461,10 +480,18 @@ int target_register_template(const struct target_core_fabric_ops *fo)
 		pr_err("%s: could not allocate memory!\n", __func__);
 		return -ENOMEM;
 	}
+	tfo = kzalloc(sizeof(struct target_core_fabric_ops), GFP_KERNEL);
+	if (!tfo) {
+		kfree(tf);
+		pr_err("%s: could not allocate memory!\n", __func__);
+		return -ENOMEM;
+	}
+	memcpy(tfo, fo, sizeof(*tfo));
+	target_set_default_ops(tfo);
 
 	INIT_LIST_HEAD(&tf->tf_list);
 	atomic_set(&tf->tf_access_cnt, 0);
-	tf->tf_ops = fo;
+	tf->tf_ops = tfo;
 	target_fabric_setup_cits(tf);
 
 	mutex_lock(&g_tf_lock);
@@ -492,6 +519,7 @@ void target_unregister_template(const struct target_core_fabric_ops *fo)
 			 */
 			rcu_barrier();
 			kfree(t->tf_tpg_base_cit.ct_attrs);
+			kfree(t->tf_ops);
 			kfree(t);
 			return;
 		}
-- 
2.25.1


