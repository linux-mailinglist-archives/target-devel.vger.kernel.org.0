Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885DE530D51
	for <lists+target-devel@lfdr.de>; Mon, 23 May 2022 12:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiEWJ73 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 23 May 2022 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiEWJ70 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 23 May 2022 05:59:26 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48D419BC;
        Mon, 23 May 2022 02:59:21 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 738B947EBC;
        Mon, 23 May 2022 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1653299959; x=1655114360; bh=bcNI/UuwqqCwNl9cavrywRdYX
        1ykCzngqidteYX67bw=; b=e+KUfBlrIk1bCepciUikBdgqJNLbErvBr/PU8iXvC
        2gAMtqBc3i1Wb0AfjVScD/2Cup77KAIxVNFrjxaAVcUIy3faP+oH7OBG1qhMWBuW
        Gg5SsQkCUyZcnzRf7v0P9n1z1s+xrtP4fGlra4gYtEipmDn6M6CM9r/Ji3tWc8qm
        qE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 24-UUCRchDSR; Mon, 23 May 2022 12:59:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9088248303;
        Mon, 23 May 2022 12:59:18 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 23 May 2022 12:59:18 +0300
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-09.corp.yadro.com (172.17.11.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.986.22; Mon, 23 May 2022 12:59:17 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Mike Christie <michael.christie@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>
Subject: [PATCH v5 2/3] scsi: target: iscsi: extract auth functions
Date:   Mon, 23 May 2022 12:59:04 +0300
Message-ID: <20220523095905.26070-3-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523095905.26070-1-d.bogdanov@yadro.com>
References: <20220523095905.26070-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Create functions that answers simple questions:
whether authentication is required, what credentials, whether
connection is autenticated.

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/iscsi/iscsi_target_nego.c | 140 +++++++++++++++--------
 1 file changed, 92 insertions(+), 48 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index d853bacf1cfc..f06f16d63fe6 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -94,6 +94,31 @@ int extract_param(
 	return 0;
 }
 
+static struct iscsi_node_auth *iscsi_get_node_auth(struct iscsit_conn *conn)
+{
+	struct iscsi_portal_group *tpg;
+	struct iscsi_node_acl *nacl;
+	struct se_node_acl *se_nacl;
+
+	if (conn->sess->sess_ops->SessionType)
+		return &iscsit_global->discovery_acl.node_auth;
+
+	se_nacl = conn->sess->se_sess->se_node_acl;
+	if (!se_nacl) {
+		pr_err("Unable to locate struct se_node_acl for CHAP auth\n");
+		return NULL;
+	}
+
+	if (se_nacl->dynamic_node_acl) {
+		tpg = to_iscsi_tpg(se_nacl->se_tpg);
+		return &tpg->tpg_demo_auth;
+	}
+
+	nacl = to_iscsi_nacl(se_nacl);
+
+	return &nacl->node_auth;
+}
+
 static u32 iscsi_handle_authentication(
 	struct iscsit_conn *conn,
 	char *in_buf,
@@ -102,38 +127,11 @@ static u32 iscsi_handle_authentication(
 	int *out_length,
 	unsigned char *authtype)
 {
-	struct iscsit_session *sess = conn->sess;
 	struct iscsi_node_auth *auth;
-	struct iscsi_node_acl *nacl;
-	struct iscsi_portal_group *tpg;
-	struct se_node_acl *se_nacl;
-
-	if (!sess->sess_ops->SessionType) {
-		/*
-		 * For SessionType=Normal
-		 */
-		se_nacl = conn->sess->se_sess->se_node_acl;
-		if (!se_nacl) {
-			pr_err("Unable to locate struct se_node_acl for"
-					" CHAP auth\n");
-			return -1;
-		}
-
-		if (se_nacl->dynamic_node_acl) {
-			tpg = to_iscsi_tpg(se_nacl->se_tpg);
-
-			auth = &tpg->tpg_demo_auth;
-		} else {
-			nacl = to_iscsi_nacl(se_nacl);
 
-			auth = &nacl->node_auth;
-		}
-	} else {
-		/*
-		 * For SessionType=Discovery
-		 */
-		auth = &iscsit_global->discovery_acl.node_auth;
-	}
+	auth = iscsi_get_node_auth(conn);
+	if (!auth)
+		return -1;
 
 	if (strstr("CHAP", authtype))
 		strcpy(conn->sess->auth_type, "CHAP");
@@ -813,6 +811,37 @@ static int iscsi_target_do_authentication(
 	return 0;
 }
 
+static bool iscsi_conn_auth_required(struct iscsit_conn *conn)
+{
+	struct se_node_acl *se_nacl;
+
+	if (conn->sess->sess_ops->SessionType) {
+		/*
+		 * For SessionType=Discovery
+		 */
+		return conn->tpg->tpg_attrib.authentication;
+	}
+	/*
+	 * For SessionType=Normal
+	 */
+	se_nacl = conn->sess->se_sess->se_node_acl;
+	if (!se_nacl) {
+		pr_debug("Unknown ACL %s is trying to connect\n",
+			 se_nacl->initiatorname);
+		return true;
+	}
+
+	if (se_nacl->dynamic_node_acl) {
+		pr_debug("Dynamic ACL %s is trying to connect\n",
+			 se_nacl->initiatorname);
+		return conn->tpg->tpg_attrib.authentication;
+	}
+
+	pr_debug("Known ACL %s is trying to connect\n",
+		 se_nacl->initiatorname);
+	return conn->tpg->tpg_attrib.authentication;
+}
+
 static int iscsi_target_handle_csg_zero(
 	struct iscsit_conn *conn,
 	struct iscsi_login *login)
@@ -874,22 +903,26 @@ static int iscsi_target_handle_csg_zero(
 		return -1;
 
 	if (!iscsi_check_negotiated_keys(conn->param_list)) {
-		if (conn->tpg->tpg_attrib.authentication &&
-		    !strncmp(param->value, NONE, 4)) {
-			pr_err("Initiator sent AuthMethod=None but"
-				" Target is enforcing iSCSI Authentication,"
-					" login failed.\n");
-			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_INITIATOR_ERR,
-					ISCSI_LOGIN_STATUS_AUTH_FAILED);
-			return -1;
-		}
+		bool auth_required = iscsi_conn_auth_required(conn);
+
+		if (auth_required) {
+			if (!strncmp(param->value, NONE, 4)) {
+				pr_err("Initiator sent AuthMethod=None but"
+				       " Target is enforcing iSCSI Authentication,"
+				       " login failed.\n");
+				iscsit_tx_login_rsp(conn,
+						ISCSI_STATUS_CLS_INITIATOR_ERR,
+						ISCSI_LOGIN_STATUS_AUTH_FAILED);
+				return -1;
+			}
 
-		if (conn->tpg->tpg_attrib.authentication &&
-		    !login->auth_complete)
-			return 0;
+			if (!login->auth_complete)
+				return 0;
 
-		if (strncmp(param->value, NONE, 4) && !login->auth_complete)
-			return 0;
+			if (strncmp(param->value, NONE, 4) &&
+			    !login->auth_complete)
+				return 0;
+		}
 
 		if ((login_req->flags & ISCSI_FLAG_LOGIN_NEXT_STAGE1) &&
 		    (login_req->flags & ISCSI_FLAG_LOGIN_TRANSIT)) {
@@ -904,6 +937,18 @@ static int iscsi_target_handle_csg_zero(
 	return iscsi_target_do_authentication(conn, login);
 }
 
+static bool iscsi_conn_authenticated(struct iscsit_conn *conn,
+				     struct iscsi_login *login)
+{
+	if (!iscsi_conn_auth_required(conn))
+		return true;
+
+	if (login->auth_complete)
+		return true;
+
+	return false;
+}
+
 static int iscsi_target_handle_csg_one(struct iscsit_conn *conn, struct iscsi_login *login)
 {
 	int ret;
@@ -947,11 +992,10 @@ static int iscsi_target_handle_csg_one(struct iscsit_conn *conn, struct iscsi_lo
 		return -1;
 	}
 
-	if (!login->auth_complete &&
-	     conn->tpg->tpg_attrib.authentication) {
+	if (!iscsi_conn_authenticated(conn, login)) {
 		pr_err("Initiator is requesting CSG: 1, has not been"
-			 " successfully authenticated, and the Target is"
-			" enforcing iSCSI Authentication, login failed.\n");
+		       " successfully authenticated, and the Target is"
+		       " enforcing iSCSI Authentication, login failed.\n");
 		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_INITIATOR_ERR,
 				ISCSI_LOGIN_STATUS_AUTH_FAILED);
 		return -1;
-- 
2.25.1

