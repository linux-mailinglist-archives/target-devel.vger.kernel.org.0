Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944C0432665
	for <lists+target-devel@lfdr.de>; Mon, 18 Oct 2021 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhJRSeK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 18 Oct 2021 14:34:10 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37016 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232589AbhJRSeK (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:34:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id BE87A4124F;
        Mon, 18 Oct 2021 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1634581916; x=1636396317; bh=/rj5xg5PfPR4CyfQ4lRuoYGuvAxxL/3WmOX
        HA9Sbd0o=; b=KBb/oqBnARKcGCWAkmZ0yHf6heODJoxXnpXvRxx5D6gf5HjTHJp
        31bAOS85/WF6OTBDjeVjxizToT+rs92g7ojPRT3OKFoggGsHCQYxuYV44bYw830z
        ybAQ3x60TkqBkLrlvQShZ70VDmRNr8ggIQWqC1IbS0J3fCmvmYIXudOo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iz-uglJxrr3G; Mon, 18 Oct 2021 21:31:56 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A6EF54126D;
        Mon, 18 Oct 2021 21:31:55 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.178.120.180) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 18 Oct 2021 21:31:53 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Mike Christie <michael.christie@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>
Subject: [PATCH v2 1/3] scsi: target: iscsi: Add upcast helpers
Date:   Mon, 18 Oct 2021 21:31:42 +0300
Message-ID: <20211018183144.8428-2-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018183144.8428-1-d.bogdanov@yadro.com>
References: <20211018183144.8428-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.120.180]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

iscsi target is cluttered with open-coded container_of conversions from
se_nacl to iscsi_node_acl. The code could be cleaned by introducing a
helper - to_iscsi_nacl() (similar to other helpers in target core).

While at it, make another iscsi conversion helper consistent
and rename iscsi_tpg() helper to to_iscsi_tpg().

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/iscsi/iscsi_target_configfs.c | 85 +++++++-------------
 drivers/target/iscsi/iscsi_target_nego.c     | 14 ++--
 drivers/target/iscsi/iscsi_target_tpg.c      |  3 +-
 include/target/iscsi/iscsi_target_core.h     | 12 +++
 4 files changed, 50 insertions(+), 64 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index f4a24fa5058e..e3750b64cc0c 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -210,7 +210,7 @@ static struct se_tpg_np *lio_target_call_addnptotpg(
 		return ERR_PTR(ret);
 	}
 
-	tpg = container_of(se_tpg, struct iscsi_portal_group, tpg_se_tpg);
+	tpg = to_iscsi_tpg(se_tpg);
 	ret = iscsit_get_tpg(tpg);
 	if (ret < 0)
 		return ERR_PTR(-EINVAL);
@@ -281,9 +281,7 @@ static ssize_t iscsi_nacl_attrib_##name##_show(struct config_item *item,\
 		char *page)						\
 {									\
 	struct se_node_acl *se_nacl = attrib_to_nacl(item);		\
-	struct iscsi_node_acl *nacl = container_of(se_nacl, struct iscsi_node_acl, \
-					se_node_acl);			\
-									\
+	struct iscsi_node_acl *nacl = to_iscsi_nacl(se_nacl);		\
 	return sprintf(page, "%u\n", nacl->node_attrib.name);		\
 }									\
 									\
@@ -291,8 +289,7 @@ static ssize_t iscsi_nacl_attrib_##name##_store(struct config_item *item,\
 		const char *page, size_t count)				\
 {									\
 	struct se_node_acl *se_nacl = attrib_to_nacl(item);		\
-	struct iscsi_node_acl *nacl = container_of(se_nacl, struct iscsi_node_acl, \
-					se_node_acl);			\
+	struct iscsi_node_acl *nacl = to_iscsi_nacl(se_nacl);		\
 	u32 val;							\
 	int ret;							\
 									\
@@ -377,15 +374,14 @@ static ssize_t iscsi_nacl_auth_##name##_show(struct config_item *item,	\
 		char *page)						\
 {									\
 	struct se_node_acl *nacl = auth_to_nacl(item);			\
-	return __iscsi_nacl_auth_##name##_show(container_of(nacl,	\
-			struct iscsi_node_acl, se_node_acl), page);	\
+	return __iscsi_nacl_auth_##name##_show(to_iscsi_nacl(nacl), page);	\
 }									\
 static ssize_t iscsi_nacl_auth_##name##_store(struct config_item *item,	\
 		const char *page, size_t count)				\
 {									\
 	struct se_node_acl *nacl = auth_to_nacl(item);			\
-	return __iscsi_nacl_auth_##name##_store(container_of(nacl,	\
-			struct iscsi_node_acl, se_node_acl), page, count); \
+	return __iscsi_nacl_auth_##name##_store(to_iscsi_nacl(nacl),	\
+						page, count); \
 }									\
 									\
 CONFIGFS_ATTR(iscsi_nacl_auth_, name)
@@ -417,8 +413,7 @@ static ssize_t iscsi_nacl_auth_##name##_show(struct config_item *item,	\
 		char *page)						\
 {									\
 	struct se_node_acl *nacl = auth_to_nacl(item);			\
-	return __iscsi_nacl_auth_##name##_show(container_of(nacl,	\
-			struct iscsi_node_acl, se_node_acl), page);	\
+	return __iscsi_nacl_auth_##name##_show(to_iscsi_nacl(nacl), page);	\
 }									\
 									\
 CONFIGFS_ATTR_RO(iscsi_nacl_auth_, name)
@@ -623,8 +618,7 @@ static ssize_t lio_target_nacl_cmdsn_depth_store(struct config_item *item,
 {
 	struct se_node_acl *se_nacl = acl_to_nacl(item);
 	struct se_portal_group *se_tpg = se_nacl->se_tpg;
-	struct iscsi_portal_group *tpg = container_of(se_tpg,
-			struct iscsi_portal_group, tpg_se_tpg);
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);
 	struct config_item *acl_ci, *tpg_ci, *wwn_ci;
 	u32 cmdsn_depth = 0;
 	int ret;
@@ -700,8 +694,7 @@ static struct configfs_attribute *lio_target_initiator_attrs[] = {
 static int lio_target_init_nodeacl(struct se_node_acl *se_nacl,
 		const char *name)
 {
-	struct iscsi_node_acl *acl =
-		container_of(se_nacl, struct iscsi_node_acl, se_node_acl);
+	struct iscsi_node_acl *acl = to_iscsi_nacl(se_nacl);
 
 	config_group_init_type_name(&acl->node_stat_grps.iscsi_sess_stats_group,
 			"iscsi_sess_stats", &iscsi_stat_sess_cit);
@@ -720,8 +713,7 @@ static ssize_t iscsi_tpg_attrib_##name##_show(struct config_item *item,	\
 		char *page)						\
 {									\
 	struct se_portal_group *se_tpg = attrib_to_tpg(item);		\
-	struct iscsi_portal_group *tpg = container_of(se_tpg,		\
-			struct iscsi_portal_group, tpg_se_tpg);	\
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);		\
 	ssize_t rb;							\
 									\
 	if (iscsit_get_tpg(tpg) < 0)					\
@@ -736,8 +728,7 @@ static ssize_t iscsi_tpg_attrib_##name##_store(struct config_item *item,\
 		const char *page, size_t count)				\
 {									\
 	struct se_portal_group *se_tpg = attrib_to_tpg(item);		\
-	struct iscsi_portal_group *tpg = container_of(se_tpg,		\
-			struct iscsi_portal_group, tpg_se_tpg);	\
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);		\
 	u32 val;							\
 	int ret;							\
 									\
@@ -800,8 +791,7 @@ static struct configfs_attribute *lio_target_tpg_attrib_attrs[] = {
 static ssize_t __iscsi_##prefix##_##name##_show(struct se_portal_group *se_tpg,	\
 		char *page)							\
 {										\
-	struct iscsi_portal_group *tpg = container_of(se_tpg,			\
-				struct iscsi_portal_group, tpg_se_tpg);		\
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);			\
 	struct iscsi_node_auth *auth = &tpg->tpg_demo_auth;			\
 										\
 	if (!capable(CAP_SYS_ADMIN))						\
@@ -813,8 +803,7 @@ static ssize_t __iscsi_##prefix##_##name##_show(struct se_portal_group *se_tpg,
 static ssize_t __iscsi_##prefix##_##name##_store(struct se_portal_group *se_tpg,\
 		const char *page, size_t count)					\
 {										\
-	struct iscsi_portal_group *tpg = container_of(se_tpg,			\
-				struct iscsi_portal_group, tpg_se_tpg);		\
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);			\
 	struct iscsi_node_auth *auth = &tpg->tpg_demo_auth;			\
 										\
 	if (!capable(CAP_SYS_ADMIN))						\
@@ -861,8 +850,7 @@ DEF_TPG_AUTH_STR(password_mutual, NAF_PASSWORD_IN_SET);
 static ssize_t __iscsi_##prefix##_##name##_show(struct se_portal_group *se_tpg,	\
 		char *page)								\
 {										\
-	struct iscsi_portal_group *tpg = container_of(se_tpg,			\
-				struct iscsi_portal_group, tpg_se_tpg);		\
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);			\
 	struct iscsi_node_auth *auth = &tpg->tpg_demo_auth;			\
 										\
 	if (!capable(CAP_SYS_ADMIN))						\
@@ -900,8 +888,7 @@ static ssize_t iscsi_tpg_param_##name##_show(struct config_item *item,	\
 		char *page)						\
 {									\
 	struct se_portal_group *se_tpg = param_to_tpg(item);		\
-	struct iscsi_portal_group *tpg = container_of(se_tpg,		\
-			struct iscsi_portal_group, tpg_se_tpg);		\
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);		\
 	struct iscsi_param *param;					\
 	ssize_t rb;							\
 									\
@@ -923,8 +910,7 @@ static ssize_t iscsi_tpg_param_##name##_store(struct config_item *item, \
 		const char *page, size_t count)				\
 {									\
 	struct se_portal_group *se_tpg = param_to_tpg(item);		\
-	struct iscsi_portal_group *tpg = container_of(se_tpg,		\
-			struct iscsi_portal_group, tpg_se_tpg);		\
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);		\
 	char *buf;							\
 	int ret, len;							\
 									\
@@ -1008,8 +994,7 @@ static struct configfs_attribute *lio_target_tpg_param_attrs[] = {
 static ssize_t lio_target_tpg_enable_show(struct config_item *item, char *page)
 {
 	struct se_portal_group *se_tpg = to_tpg(item);
-	struct iscsi_portal_group *tpg = container_of(se_tpg,
-			struct iscsi_portal_group, tpg_se_tpg);
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);
 	ssize_t len;
 
 	spin_lock(&tpg->tpg_state_lock);
@@ -1024,8 +1009,7 @@ static ssize_t lio_target_tpg_enable_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct se_portal_group *se_tpg = to_tpg(item);
-	struct iscsi_portal_group *tpg = container_of(se_tpg,
-			struct iscsi_portal_group, tpg_se_tpg);
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);
 	u32 op;
 	int ret;
 
@@ -1134,7 +1118,7 @@ static void lio_target_tiqn_deltpg(struct se_portal_group *se_tpg)
 	struct iscsi_portal_group *tpg;
 	struct iscsi_tiqn *tiqn;
 
-	tpg = container_of(se_tpg, struct iscsi_portal_group, tpg_se_tpg);
+	tpg = to_iscsi_tpg(se_tpg);
 	tiqn = tpg->tpg_tiqn;
 	/*
 	 * iscsit_tpg_del_portal_group() assumes force=1
@@ -1408,46 +1392,41 @@ static void lio_aborted_task(struct se_cmd *se_cmd)
 	cmd->conn->conn_transport->iscsit_aborted_task(cmd->conn, cmd);
 }
 
-static inline struct iscsi_portal_group *iscsi_tpg(struct se_portal_group *se_tpg)
-{
-	return container_of(se_tpg, struct iscsi_portal_group, tpg_se_tpg);
-}
-
 static char *lio_tpg_get_endpoint_wwn(struct se_portal_group *se_tpg)
 {
-	return iscsi_tpg(se_tpg)->tpg_tiqn->tiqn;
+	return to_iscsi_tpg(se_tpg)->tpg_tiqn->tiqn;
 }
 
 static u16 lio_tpg_get_tag(struct se_portal_group *se_tpg)
 {
-	return iscsi_tpg(se_tpg)->tpgt;
+	return to_iscsi_tpg(se_tpg)->tpgt;
 }
 
 static u32 lio_tpg_get_default_depth(struct se_portal_group *se_tpg)
 {
-	return iscsi_tpg(se_tpg)->tpg_attrib.default_cmdsn_depth;
+	return to_iscsi_tpg(se_tpg)->tpg_attrib.default_cmdsn_depth;
 }
 
 static int lio_tpg_check_demo_mode(struct se_portal_group *se_tpg)
 {
-	return iscsi_tpg(se_tpg)->tpg_attrib.generate_node_acls;
+	return to_iscsi_tpg(se_tpg)->tpg_attrib.generate_node_acls;
 }
 
 static int lio_tpg_check_demo_mode_cache(struct se_portal_group *se_tpg)
 {
-	return iscsi_tpg(se_tpg)->tpg_attrib.cache_dynamic_acls;
+	return to_iscsi_tpg(se_tpg)->tpg_attrib.cache_dynamic_acls;
 }
 
 static int lio_tpg_check_demo_mode_write_protect(
 	struct se_portal_group *se_tpg)
 {
-	return iscsi_tpg(se_tpg)->tpg_attrib.demo_mode_write_protect;
+	return to_iscsi_tpg(se_tpg)->tpg_attrib.demo_mode_write_protect;
 }
 
 static int lio_tpg_check_prod_mode_write_protect(
 	struct se_portal_group *se_tpg)
 {
-	return iscsi_tpg(se_tpg)->tpg_attrib.prod_mode_write_protect;
+	return to_iscsi_tpg(se_tpg)->tpg_attrib.prod_mode_write_protect;
 }
 
 static int lio_tpg_check_prot_fabric_only(
@@ -1457,9 +1436,9 @@ static int lio_tpg_check_prot_fabric_only(
 	 * Only report fabric_prot_type if t10_pi has also been enabled
 	 * for incoming ib_isert sessions.
 	 */
-	if (!iscsi_tpg(se_tpg)->tpg_attrib.t10_pi)
+	if (!to_iscsi_tpg(se_tpg)->tpg_attrib.t10_pi)
 		return 0;
-	return iscsi_tpg(se_tpg)->tpg_attrib.fabric_prot_type;
+	return to_iscsi_tpg(se_tpg)->tpg_attrib.fabric_prot_type;
 }
 
 /*
@@ -1496,16 +1475,14 @@ static void lio_tpg_close_session(struct se_session *se_sess)
 
 static u32 lio_tpg_get_inst_index(struct se_portal_group *se_tpg)
 {
-	return iscsi_tpg(se_tpg)->tpg_tiqn->tiqn_index;
+	return to_iscsi_tpg(se_tpg)->tpg_tiqn->tiqn_index;
 }
 
 static void lio_set_default_node_attributes(struct se_node_acl *se_acl)
 {
-	struct iscsi_node_acl *acl = container_of(se_acl, struct iscsi_node_acl,
-				se_node_acl);
+	struct iscsi_node_acl *acl = to_iscsi_nacl(se_acl);
 	struct se_portal_group *se_tpg = se_acl->se_tpg;
-	struct iscsi_portal_group *tpg = container_of(se_tpg,
-				struct iscsi_portal_group, tpg_se_tpg);
+	struct iscsi_portal_group *tpg = to_iscsi_tpg(se_tpg);
 
 	acl->node_attrib.nacl = acl;
 	iscsit_set_default_node_attribues(acl, tpg);
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index c0ed6f8e5c5b..f0769708e4fb 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -104,8 +104,8 @@ static u32 iscsi_handle_authentication(
 {
 	struct iscsi_session *sess = conn->sess;
 	struct iscsi_node_auth *auth;
-	struct iscsi_node_acl *iscsi_nacl;
-	struct iscsi_portal_group *iscsi_tpg;
+	struct iscsi_node_acl *nacl;
+	struct iscsi_portal_group *tpg;
 	struct se_node_acl *se_nacl;
 
 	if (!sess->sess_ops->SessionType) {
@@ -120,15 +120,13 @@ static u32 iscsi_handle_authentication(
 		}
 
 		if (se_nacl->dynamic_node_acl) {
-			iscsi_tpg = container_of(se_nacl->se_tpg,
-					struct iscsi_portal_group, tpg_se_tpg);
+			tpg = to_iscsi_tpg(se_nacl->se_tpg);
 
-			auth = &iscsi_tpg->tpg_demo_auth;
+			auth = &tpg->tpg_demo_auth;
 		} else {
-			iscsi_nacl = container_of(se_nacl, struct iscsi_node_acl,
-						  se_node_acl);
+			nacl = to_iscsi_nacl(se_nacl);
 
-			auth = &iscsi_nacl->node_auth;
+			auth = &nacl->node_auth;
 		}
 	} else {
 		/*
diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index 8075f60fd02c..7410387d52e1 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -394,8 +394,7 @@ struct iscsi_node_attrib *iscsit_tpg_get_node_attrib(
 {
 	struct se_session *se_sess = sess->se_sess;
 	struct se_node_acl *se_nacl = se_sess->se_node_acl;
-	struct iscsi_node_acl *acl = container_of(se_nacl, struct iscsi_node_acl,
-					se_node_acl);
+	struct iscsi_node_acl *acl = to_iscsi_nacl(se_nacl);
 
 	return &acl->node_attrib;
 }
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 1eccb2ac7d02..21c1aaa6dae2 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -757,6 +757,12 @@ struct iscsi_node_acl {
 	struct iscsi_node_stat_grps node_stat_grps;
 };
 
+static inline struct iscsi_node_acl *
+to_iscsi_nacl(struct se_node_acl *se_nacl)
+{
+	return container_of(se_nacl, struct iscsi_node_acl, se_node_acl);
+}
+
 struct iscsi_tpg_attrib {
 	u32			authentication;
 	u32			login_timeout;
@@ -838,6 +844,12 @@ struct iscsi_portal_group {
 	struct list_head	tpg_list;
 } ____cacheline_aligned;
 
+static inline struct iscsi_portal_group *
+to_iscsi_tpg(struct se_portal_group *se_tpg)
+{
+	return container_of(se_tpg, struct iscsi_portal_group, tpg_se_tpg);
+}
+
 struct iscsi_wwn_stat_grps {
 	struct config_group	iscsi_stat_group;
 	struct config_group	iscsi_instance_group;
-- 
2.25.1

