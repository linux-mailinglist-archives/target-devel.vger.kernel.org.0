Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A81A5F648C
	for <lists+target-devel@lfdr.de>; Thu,  6 Oct 2022 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiJFKvR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 6 Oct 2022 06:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiJFKvO (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:51:14 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCFE98CA9;
        Thu,  6 Oct 2022 03:51:11 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1937941237;
        Thu,  6 Oct 2022 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1665053468; x=1666867869; bh=QtcoxKrK5iSu+Hf1MH92sUx0z
        upEuw1wgzabF0cMO24=; b=KPdW0kvuKzY66jgpXj42FyQay735nRaxlpWPmB36+
        LfKojqDzKf9cJ4WOHJAvg4OHnDh2VIQZaF5t9n10kt32FrJ4jEoRZLPWD3y2VrcK
        e0cCgoYirBVJI1quGZF/x7OmxrmCOYkML5Jis/Jc9K9Ckr4Z6t+oe41lVUq+60i3
        OM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QAarznRfCTsU; Thu,  6 Oct 2022 13:51:08 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id B4D7841228;
        Thu,  6 Oct 2022 13:51:08 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 6 Oct 2022 13:51:08 +0300
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Thu, 6 Oct 2022 13:51:07 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Mike Christie <michael.christie@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH v2 3/5] scsi: target: core: Drop device-based RTPI
Date:   Thu, 6 Oct 2022 13:50:55 +0300
Message-ID: <20221006105057.30184-4-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006105057.30184-1-d.bogdanov@yadro.com>
References: <20221006105057.30184-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
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

From: Roman Bolshakov <r.bolshakov@yadro.com>

The code is not needed since target port-based RTPI allocation replaced
it.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/target_core_device.c   | 41 ---------------------------
 drivers/target/target_core_internal.h |  1 -
 drivers/target/target_core_tpg.c      |  6 ----
 include/target/target_core_base.h     |  4 ---
 4 files changed, 52 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index ad83338d6140..2209660261d0 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -460,47 +460,6 @@ void core_clear_lun_from_tpg(struct se_lun *lun, struct se_portal_group *tpg)
 	mutex_unlock(&tpg->acl_node_mutex);
 }
 
-int core_alloc_rtpi(struct se_lun *lun, struct se_device *dev)
-{
-	struct se_lun *tmp;
-
-	spin_lock(&dev->se_port_lock);
-	if (dev->export_count == 0x0000ffff) {
-		pr_warn("Reached dev->dev_port_count =="
-				" 0x0000ffff\n");
-		spin_unlock(&dev->se_port_lock);
-		return -ENOSPC;
-	}
-again:
-	/*
-	 * Allocate the next RELATIVE TARGET PORT IDENTIFIER for this struct se_device
-	 * Here is the table from spc4r17 section 7.7.3.8.
-	 *
-	 *    Table 473 -- RELATIVE TARGET PORT IDENTIFIER field
-	 *
-	 * Code      Description
-	 * 0h        Reserved
-	 * 1h        Relative port 1, historically known as port A
-	 * 2h        Relative port 2, historically known as port B
-	 * 3h to FFFFh    Relative port 3 through 65 535
-	 */
-	lun->lun_rtpi = dev->dev_rpti_counter++;
-	if (!lun->lun_rtpi)
-		goto again;
-
-	list_for_each_entry(tmp, &dev->dev_sep_list, lun_dev_link) {
-		/*
-		 * Make sure RELATIVE TARGET PORT IDENTIFIER is unique
-		 * for 16-bit wrap..
-		 */
-		if (lun->lun_rtpi == tmp->lun_rtpi)
-			goto again;
-	}
-	spin_unlock(&dev->se_port_lock);
-
-	return 0;
-}
-
 static void se_release_vpd_for_dev(struct se_device *dev)
 {
 	struct t10_vpd *vpd, *vpd_tmp;
diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index fb699f336736..4699c078f6f4 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -59,7 +59,6 @@ struct target_fabric_configfs {
 extern struct t10_alua_lu_gp *default_lu_gp;
 
 /* target_core_device.c */
-int	core_alloc_rtpi(struct se_lun *lun, struct se_device *dev);
 struct se_dev_entry *core_get_se_deve_from_rtpi(struct se_node_acl *, u16);
 void	target_pr_kref_release(struct kref *);
 void	core_free_device_list_for_node(struct se_node_acl *,
diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index 572241eca564..5838cd2d8a96 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -615,10 +615,6 @@ int core_tpg_add_lun(
 	if (ret < 0)
 		goto out;
 
-	ret = core_alloc_rtpi(lun, dev);
-	if (ret)
-		goto out_kill_ref;
-
 	if (!(dev->transport_flags & TRANSPORT_FLAG_PASSTHROUGH_ALUA) &&
 	    !(dev->se_hba->hba_flags & HBA_FLAGS_INTERNAL_USE))
 		target_attach_tg_pt_gp(lun, dev->t10_alua.default_tg_pt_gp);
@@ -642,8 +638,6 @@ int core_tpg_add_lun(
 
 	return 0;
 
-out_kill_ref:
-	percpu_ref_exit(&lun->lun_ref);
 out:
 	return ret;
 }
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 261c5f5228de..83b396457ed1 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -733,8 +733,6 @@ struct se_lun {
 	bool			lun_access_ro;
 	u32			lun_index;
 
-	/* RELATIVE TARGET PORT IDENTIFER */
-	u16			lun_rtpi;
 	atomic_t		lun_acl_count;
 	struct se_device __rcu	*lun_se_dev;
 
@@ -786,8 +784,6 @@ struct se_device_queue {
 };
 
 struct se_device {
-	/* RELATIVE TARGET PORT IDENTIFER Counter */
-	u16			dev_rpti_counter;
 	/* Used for SAM Task Attribute ordering */
 	u32			dev_cur_ordered_id;
 	u32			dev_flags;
-- 
2.25.1

