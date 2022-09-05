Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E995AD970
	for <lists+target-devel@lfdr.de>; Mon,  5 Sep 2022 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiIETNL (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 5 Sep 2022 15:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIETNK (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:13:10 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1552D3719C;
        Mon,  5 Sep 2022 12:13:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id AB87744AB8;
        Mon,  5 Sep 2022 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1662405186; x=
        1664219587; bh=BKc/e2IBxlGsSoQLXTxX0s+zvYDvnyxpjcYaKmUaYLU=; b=U
        RSMQ3lkqz3ebJISYsN5e+jC+9Tr4c7ZSMegoVJVr1eYcl4+iU51/dSgQzzlG0tJb
        owlop1e+rOV5FOTr57xEX78qHUKo2WDyE7U/N+34SLp5kzXnyQsjv/1hMhmwR+bZ
        3SG/dS0iqTNFtE+t5S8Z9pVnlRbyRMf8gcOecemLPQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S2lJAsb4BCjl; Mon,  5 Sep 2022 22:13:06 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 5FABB44ACB;
        Mon,  5 Sep 2022 22:07:37 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 5 Sep 2022 22:07:37 +0300
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Mon, 5 Sep 2022 22:07:36 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH] scsi: target: core: Add a way to hide a port group
Date:   Sat, 4 Apr 2020 13:48:52 +0300
Message-ID: <20220905190731.16992-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

From: Roman Bolshakov <r.bolshakov@yadro.com>

Default target port group is always returned in the list of port groups,
even if the behaviour is unwanted, i.e. it has no members and
non-default port groups are primary port groups.

A new port group attribute - "hidden" can be used to hide empty port
groups with no ports in REPORT TARGET PORT GROUPS, including default
target port group:

  echo 1 > $DEVICE/alua/default_tg_pt_gp/hidden

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---

The patch is intended for 6.1/scsi-queue branch.

---
 drivers/target/target_core_alua.c     |  8 ++++++++
 drivers/target/target_core_configfs.c | 29 +++++++++++++++++++++++++++
 include/target/target_core_base.h     |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index fb91423a4e2e..dbf9a950d01b 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -164,6 +164,8 @@ target_emulate_report_target_port_groups(struct se_cmd *cmd)
 	spin_lock(&dev->t10_alua.tg_pt_gps_lock);
 	list_for_each_entry(tg_pt_gp, &dev->t10_alua.tg_pt_gps_list,
 			tg_pt_gp_list) {
+		if (tg_pt_gp->tg_pt_gp_hidden && !tg_pt_gp->tg_pt_gp_members)
+			continue;
 		/*
 		 * Check if the Target port group and Target port descriptor list
 		 * based on tg_pt_gp_members count will fit into the response payload.
@@ -308,6 +310,12 @@ target_emulate_set_target_port_groups(struct se_cmd *cmd)
 		rc = TCM_UNSUPPORTED_SCSI_OPCODE;
 		goto out;
 	}
+	if (l_tg_pt_gp->tg_pt_gp_hidden && !tg_pt_gp->tg_pt_gp_members) {
+		spin_unlock(&l_lun->lun_tg_pt_gp_lock);
+		pr_err("Unable to change state for hidden port group with no members\n");
+		rc = TCM_INVALID_CDB_FIELD;
+		goto out;
+	}
 	valid_states = l_tg_pt_gp->tg_pt_gp_alua_supported_states;
 	rcu_read_unlock();
 
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 416514c5c7ac..7c0e42e782de 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3029,6 +3029,33 @@ static ssize_t target_tg_pt_gp_preferred_store(struct config_item *item,
 	return core_alua_store_preferred_bit(to_tg_pt_gp(item), page, count);
 }
 
+static ssize_t target_tg_pt_gp_hidden_show(struct config_item *item,
+					   char *page)
+{
+	return sysfs_emit(page, "%d\n", to_tg_pt_gp(item)->tg_pt_gp_hidden);
+}
+
+static ssize_t target_tg_pt_gp_hidden_store(struct config_item *item,
+					    const char *page, size_t count)
+{
+	struct t10_alua_tg_pt_gp *tg_pt_gp = to_tg_pt_gp(item);
+	int tmp, ret;
+
+	ret = kstrtoint(page, 0, &tmp);
+	if (ret < 0) {
+		pr_err("Unable to extract hidden flag: %d\n", ret);
+		return ret;
+	}
+
+	if (tmp != 0 && tmp != 1) {
+		pr_err("Illegal value for hidden flag: %d\n", tmp);
+		return -EINVAL;
+	}
+	tg_pt_gp->tg_pt_gp_hidden = tmp;
+
+	return count;
+}
+
 static ssize_t target_tg_pt_gp_tg_pt_gp_id_show(struct config_item *item,
 		char *page)
 {
@@ -3115,6 +3142,7 @@ CONFIGFS_ATTR(target_tg_pt_gp_, alua_support_standby);
 CONFIGFS_ATTR(target_tg_pt_gp_, alua_support_active_optimized);
 CONFIGFS_ATTR(target_tg_pt_gp_, alua_support_active_nonoptimized);
 CONFIGFS_ATTR(target_tg_pt_gp_, alua_write_metadata);
+CONFIGFS_ATTR(target_tg_pt_gp_, hidden);
 CONFIGFS_ATTR(target_tg_pt_gp_, nonop_delay_msecs);
 CONFIGFS_ATTR(target_tg_pt_gp_, trans_delay_msecs);
 CONFIGFS_ATTR(target_tg_pt_gp_, implicit_trans_secs);
@@ -3138,6 +3166,7 @@ static struct configfs_attribute *target_core_alua_tg_pt_gp_attrs[] = {
 	&target_tg_pt_gp_attr_trans_delay_msecs,
 	&target_tg_pt_gp_attr_implicit_trans_secs,
 	&target_tg_pt_gp_attr_preferred,
+	&target_tg_pt_gp_attr_hidden,
 	&target_tg_pt_gp_attr_tg_pt_gp_id,
 	&target_tg_pt_gp_attr_members,
 	NULL,
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 8c920456edd9..28cce4ed3f0e 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -297,6 +297,7 @@ struct t10_alua_tg_pt_gp {
 	int	tg_pt_gp_trans_delay_msecs;
 	int	tg_pt_gp_implicit_trans_secs;
 	int	tg_pt_gp_pref;
+	int	tg_pt_gp_hidden;
 	int	tg_pt_gp_write_metadata;
 	u32	tg_pt_gp_members;
 	int	tg_pt_gp_alua_access_state;
-- 
2.25.1

