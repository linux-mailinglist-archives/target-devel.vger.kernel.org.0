Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47216A6910
	for <lists+target-devel@lfdr.de>; Wed,  1 Mar 2023 09:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCAIpg (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 1 Mar 2023 03:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCAIpX (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:45:23 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87FF961;
        Wed,  1 Mar 2023 00:45:22 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id DDE15341C53;
        Wed,  1 Mar 2023 11:45:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=6RFLv9E9XXOOlobf2b
        ucWCM8Og0jjTl1urqafYJiZX4=; b=FuKDGjRjtl1kU83UAc1212kmETnGMMUvNi
        d6lvI6NNcCn2eJnk/kME4EGYXfI0O5TvJEuSPNqSrkCao8KP7ZAs1pGd7AfmRzdk
        TfTUV9YFzPcXytslnvjUV73mUh4axJlnDmVinPfUGms2XcXWzA137nN3bt5NjBBo
        RnyUaWufg=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id D29CF341C51;
        Wed,  1 Mar 2023 11:45:20 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.20.11) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Wed, 1 Mar 2023 11:45:20 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Mike Christie <michael.christie@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v5 4/4] scsi: target: core: Add RTPI attribute for target port
Date:   Wed, 1 Mar 2023 11:45:12 +0300
Message-ID: <20230301084512.21956-5-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301084512.21956-1-d.bogdanov@yadro.com>
References: <20230301084512.21956-1-d.bogdanov@yadro.com>
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

RELATIVE TARGET PORT IDENTIFIER can be read and configured via configfs:
$ echo 0x10 > $TARGET/tpgt_N/rtpi

RTPI can be changed only on disabled target ports.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 v5:
    fix casting from config_item to se_tpg
 v4:
    move rtpi file from tpgt_n/attrib to tpgt_n folder
    revert occasional rename of core_tpg_remove_lun

 v3:
    change core_ prefix to target_

 v2:
   do not allow to change RTPI on enabled target port
---
 drivers/target/target_core_fabric_configfs.c | 39 +++++++++++++++++++-
 drivers/target/target_core_tpg.c             | 19 ++++++++--
 include/target/target_core_base.h            |  1 +
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
index 873da49ab704..0ce47e21e0c8 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -844,15 +844,48 @@ static ssize_t target_fabric_tpg_base_enable_store(struct config_item *item,
 		return ret;
 	return count;
 }
+static ssize_t target_fabric_tpg_base_rtpi_show(struct config_item *item, char *page)
+{
+	struct se_portal_group *se_tpg = to_tpg(item);
+
+	return sysfs_emit(page, "%#x\n", se_tpg->tpg_rtpi);
+}
+
+static ssize_t target_fabric_tpg_base_rtpi_store(struct config_item *item,
+				   const char *page, size_t count)
+{
+	struct se_portal_group *se_tpg = to_tpg(item);
+	u16 val;
+	int ret;
+
+	ret = kstrtou16(page, 0, &val);
+	if (ret < 0)
+		return ret;
+	if (val == 0)
+		return -EINVAL;
+
+	if (se_tpg->enabled) {
+		pr_info("%s_TPG[%hu] - Can not change RTPI on enabled TPG",
+			se_tpg->se_tpg_tfo->fabric_name,
+			se_tpg->se_tpg_tfo->tpg_get_tag(se_tpg));
+		return -EINVAL;
+	}
+
+	se_tpg->tpg_rtpi = val;
+	se_tpg->rtpi_manual = true;
+
+	return count;
+}
 
 CONFIGFS_ATTR(target_fabric_tpg_base_, enable);
+CONFIGFS_ATTR(target_fabric_tpg_base_, rtpi);
 
 static int
 target_fabric_setup_tpg_base_cit(struct target_fabric_configfs *tf)
 {
 	struct config_item_type *cit = &tf->tf_tpg_base_cit;
 	struct configfs_attribute **attrs = NULL;
-	size_t nr_attrs = 0;
+	size_t nr_attrs = 1;
 	int i = 0;
 
 	if (tf->tf_ops->tfc_tpg_base_attrs)
@@ -875,7 +908,9 @@ target_fabric_setup_tpg_base_cit(struct target_fabric_configfs *tf)
 			attrs[i] = tf->tf_ops->tfc_tpg_base_attrs[i];
 
 	if (tf->tf_ops->fabric_enable_tpg)
-		attrs[i] = &target_fabric_tpg_base_attr_enable;
+		attrs[i++] = &target_fabric_tpg_base_attr_enable;
+
+	attrs[i++] = &target_fabric_tpg_base_attr_rtpi;
 
 done:
 	cit->ct_item_ops = &target_fabric_tpg_base_item_ops;
diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index b1d9383386ec..2e079c6a8e8c 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -445,10 +445,21 @@ static int target_tpg_register_rtpi(struct se_portal_group *se_tpg)
 	u32 val;
 	int ret;
 
-	ret = xa_alloc(&tpg_xa, &val, se_tpg,
-		       XA_LIMIT(1, USHRT_MAX), GFP_KERNEL);
-	if (!ret)
-		se_tpg->tpg_rtpi = val;
+	if (se_tpg->rtpi_manual) {
+		ret = xa_insert(&tpg_xa, se_tpg->tpg_rtpi, se_tpg, GFP_KERNEL);
+		if (ret) {
+			pr_info("%s_TPG[%hu] - Can not set RTPI %#x, it is already busy",
+				se_tpg->se_tpg_tfo->fabric_name,
+				se_tpg->se_tpg_tfo->tpg_get_tag(se_tpg),
+				se_tpg->tpg_rtpi);
+			return -EINVAL;
+		}
+	} else {
+		ret = xa_alloc(&tpg_xa, &val, se_tpg,
+			       XA_LIMIT(1, USHRT_MAX), GFP_KERNEL);
+		if (!ret)
+			se_tpg->tpg_rtpi = val;
+	}
 
 	return ret;
 }
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 008e0e4500d1..e52d0915b3d8 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -918,6 +918,7 @@ struct se_portal_group {
 	bool			enabled;
 	/* RELATIVE TARGET PORT IDENTIFIER */
 	u16			tpg_rtpi;
+	bool			rtpi_manual;
 	/* Used for PR SPEC_I_PT=1 and REGISTER_AND_MOVE */
 	atomic_t		tpg_pr_ref_count;
 	/* Spinlock for adding/removing ACLed Nodes */
-- 
2.25.1


