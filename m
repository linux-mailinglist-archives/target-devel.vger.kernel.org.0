Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C122D69E433
	for <lists+target-devel@lfdr.de>; Tue, 21 Feb 2023 17:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjBUQGk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 21 Feb 2023 11:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjBUQGj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:06:39 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F92B288;
        Tue, 21 Feb 2023 08:06:37 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 1B55E342031;
        Tue, 21 Feb 2023 19:06:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=ofCmB0LA+TgBas53ua
        9VwKa+Nu1ZBpccy+1UTM5kUbc=; b=DZf5dlFnSy2kUBr5ldcxcKksUZ9+JAGKl+
        h/5HzEKmnqka7fIz193ypXiaTToGkUBm31D4Q4vrDxnt1BW9fdU8gJw5g5TQGWrH
        V/B2v8VdVfdbZrqKi07vZxwh9njaggOTo5A79gG8Isfwdgx/sarKEiExoZWL/4hH
        2EuKItw60=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 119ED342024;
        Tue, 21 Feb 2023 19:06:35 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.178.114.42) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Tue, 21 Feb 2023 19:06:34 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Mike Christie <michael.christie@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH v4 1/4] scsi: target: core: Add RTPI field to target port
Date:   Tue, 21 Feb 2023 19:06:19 +0300
Message-ID: <20230221160622.7283-2-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221160622.7283-1-d.bogdanov@yadro.com>
References: <20230221160622.7283-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.114.42]
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

SAM-5 4.6.5.2 (Relative Port Identifier attribute) defines the attribute
as unique across SCSI target ports.

The change introduces RTPI attribute to se_portal group. The value is
unique across all enabled SCSI target ports. It also limits number of
SCSI target ports to 65535.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
  v4:
    use unused variable in target_tpg_disable
    make tpg_rtpi variable u16 again

  v3:
    make variable static
    change core_ prefix to target_
    split to tpg_enable/tpg_disable functions

 v2:
   rewrite using XArray to track usage of RTPI
---
 drivers/target/target_core_fabric_configfs.c |  9 ++--
 drivers/target/target_core_internal.h        |  2 +
 drivers/target/target_core_tpg.c             | 54 ++++++++++++++++++++
 include/target/target_core_base.h            |  2 +
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
index 67b18a67317a..873da49ab704 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -836,13 +836,12 @@ static ssize_t target_fabric_tpg_base_enable_store(struct config_item *item,
 
 	if (se_tpg->enabled == op)
 		return count;
-
-	ret = se_tpg->se_tpg_tfo->fabric_enable_tpg(se_tpg, op);
+	if (op)
+		ret = target_tpg_enable(se_tpg);
+	else
+		ret = target_tpg_disable(se_tpg);
 	if (ret)
 		return ret;
-
-	se_tpg->enabled = op;
-
 	return count;
 }
 
diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index 38a6d08f75b3..82fd5768a662 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -132,6 +132,8 @@ void core_tpg_remove_lun(struct se_portal_group *, struct se_lun *);
 struct se_node_acl *core_tpg_add_initiator_node_acl(struct se_portal_group *tpg,
 		const char *initiatorname);
 void core_tpg_del_initiator_node_acl(struct se_node_acl *acl);
+int target_tpg_enable(struct se_portal_group *se_tpg);
+int target_tpg_disable(struct se_portal_group *se_tpg);
 
 /* target_core_transport.c */
 int	init_se_kmem_caches(void);
diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index 736847c933e5..0de3385b94c5 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -31,6 +31,7 @@
 #include "target_core_ua.h"
 
 extern struct se_device *g_lun0_dev;
+static DEFINE_XARRAY_ALLOC(tpg_xa);
 
 /*	__core_tpg_get_initiator_node_acl():
  *
@@ -439,6 +440,57 @@ static void core_tpg_lun_ref_release(struct percpu_ref *ref)
 	complete(&lun->lun_shutdown_comp);
 }
 
+static int target_tpg_register_rtpi(struct se_portal_group *se_tpg)
+{
+	u32 val;
+	int ret;
+
+	ret = xa_alloc(&tpg_xa, &val, se_tpg,
+		       XA_LIMIT(1, USHRT_MAX), GFP_KERNEL);
+	if (!ret)
+		se_tpg->tpg_rtpi = val;
+
+	return ret;
+}
+
+static void target_tpg_deregister_rtpi(struct se_portal_group *se_tpg)
+{
+	if (se_tpg->tpg_rtpi && se_tpg->enabled)
+		xa_erase(&tpg_xa, se_tpg->tpg_rtpi);
+}
+
+int target_tpg_enable(struct se_portal_group *se_tpg)
+{
+	int ret;
+
+	ret = target_tpg_register_rtpi(se_tpg);
+	if (ret)
+		return ret;
+
+	ret = se_tpg->se_tpg_tfo->fabric_enable_tpg(se_tpg, true);
+	if (ret) {
+		target_tpg_deregister_rtpi(se_tpg);
+		return ret;
+	}
+
+	se_tpg->enabled = true;
+
+	return 0;
+}
+
+int target_tpg_disable(struct se_portal_group *se_tpg)
+{
+	int ret;
+
+	target_tpg_deregister_rtpi(se_tpg);
+
+	ret = se_tpg->se_tpg_tfo->fabric_enable_tpg(se_tpg, false);
+	if (!ret)
+		se_tpg->enabled = false;
+
+	return ret;
+}
+
 /* Does not change se_wwn->priv. */
 int core_tpg_register(
 	struct se_wwn *se_wwn,
@@ -535,6 +587,8 @@ int core_tpg_deregister(struct se_portal_group *se_tpg)
 		kfree_rcu(se_tpg->tpg_virt_lun0, rcu_head);
 	}
 
+	target_tpg_deregister_rtpi(se_tpg);
+
 	return 0;
 }
 EXPORT_SYMBOL(core_tpg_deregister);
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 12c9ba16217e..814edf746395 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -920,6 +920,8 @@ struct se_portal_group {
 	 */
 	int			proto_id;
 	bool			enabled;
+	/* RELATIVE TARGET PORT IDENTIFIER */
+	u16			tpg_rtpi;
 	/* Used for PR SPEC_I_PT=1 and REGISTER_AND_MOVE */
 	atomic_t		tpg_pr_ref_count;
 	/* Spinlock for adding/removing ACLed Nodes */
-- 
2.25.1


