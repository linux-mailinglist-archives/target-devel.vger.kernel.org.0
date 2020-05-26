Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0421F1CCE55
	for <lists+target-devel@lfdr.de>; Sun, 10 May 2020 23:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgEJV6D (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 10 May 2020 17:58:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53280 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727771AbgEJV6D (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 10 May 2020 17:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589147881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsyvH9GitKHUxBhaxtCpGLpGmekg1oe8CYsiLYGkx9Q=;
        b=EDbpQlQ8Qrqy/nWKE5DM3lc7eg5wlYCvOZCFMnxzZs1tMaSi55sQvAFNxHfTvBKtZ9j/OA
        MfdJtGj5GkEueycKSFRDcc6ndIr5QWoFsXZgmfYXMwdA89Ggj0lYM7ML4/jCKsIbZogKQd
        4VuPo/HnG5VAYW1MlFsxKAyVl4cULqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-x_WjqQOcOJeKH2ozsvan9Q-1; Sun, 10 May 2020 17:57:59 -0400
X-MC-Unique: x_WjqQOcOJeKH2ozsvan9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39BE8100A68C;
        Sun, 10 May 2020 21:57:58 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-113-0.rdu2.redhat.com [10.10.113.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 606E31002387;
        Sun, 10 May 2020 21:57:57 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 04/15] tcm loop: use target_parse_emulated_name
Date:   Sun, 10 May 2020 16:57:33 -0500
Message-Id: <20200510215744.21999-5-mchristi@redhat.com>
In-Reply-To: <20200510215744.21999-1-mchristi@redhat.com>
References: <20200510215744.21999-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Use target_parse_emulated_name so the acl and SCSI names are properly
formatted.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/target/loopback/tcm_loop.c | 65 ++++++--------------------------------
 1 file changed, 10 insertions(+), 55 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 74aded7..64e5f1f 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -725,7 +725,8 @@ static int tcm_loop_alloc_sess_cb(struct se_portal_group *se_tpg,
 
 static int tcm_loop_make_nexus(
 	struct tcm_loop_tpg *tl_tpg,
-	const char *name)
+	const char *tpt_id_name,
+	const char *acl_name)
 {
 	struct tcm_loop_hba *tl_hba = tl_tpg->tl_hba;
 	struct tcm_loop_nexus *tl_nexus;
@@ -742,7 +743,7 @@ static int tcm_loop_make_nexus(
 
 	tl_nexus->se_sess = target_setup_session(&tl_tpg->tl_se_tpg, 0, 0,
 					TARGET_PROT_DIN_PASS | TARGET_PROT_DOUT_PASS,
-					name, name, tl_nexus,
+					tpt_id_name, acl_name, tl_nexus,
 					tcm_loop_alloc_sess_cb);
 	if (IS_ERR(tl_nexus->se_sess)) {
 		ret = PTR_ERR(tl_nexus->se_sess);
@@ -751,7 +752,7 @@ static int tcm_loop_make_nexus(
 	}
 
 	pr_debug("TCM_Loop_ConfigFS: Established I_T Nexus to emulated %s Initiator Port: %s\n",
-		 tcm_loop_dump_proto_id(tl_hba), name);
+		 tcm_loop_dump_proto_id(tl_hba), acl_name);
 	return 0;
 }
 
@@ -814,7 +815,7 @@ static ssize_t tcm_loop_tpg_nexus_store(struct config_item *item,
 	struct tcm_loop_tpg *tl_tpg = container_of(se_tpg,
 			struct tcm_loop_tpg, tl_se_tpg);
 	struct tcm_loop_hba *tl_hba = tl_tpg->tl_hba;
-	unsigned char i_port[TL_WWN_ADDR_LEN], *ptr, *port_ptr;
+	unsigned char i_port[TL_WWN_ADDR_LEN], *tpt_id_name;
 	int ret;
 	/*
 	 * Shutdown the active I_T nexus if 'NULL' is passed..
@@ -823,59 +824,13 @@ static ssize_t tcm_loop_tpg_nexus_store(struct config_item *item,
 		ret = tcm_loop_drop_nexus(tl_tpg);
 		return (!ret) ? count : ret;
 	}
-	/*
-	 * Otherwise make sure the passed virtual Initiator port WWN matches
-	 * the fabric protocol_id set in tcm_loop_make_scsi_hba(), and call
-	 * tcm_loop_make_nexus()
-	 */
-	if (strlen(page) >= TL_WWN_ADDR_LEN) {
-		pr_err("Emulated NAA Sas Address: %s, exceeds max: %d\n",
-		       page, TL_WWN_ADDR_LEN);
-		return -EINVAL;
-	}
-	snprintf(&i_port[0], TL_WWN_ADDR_LEN, "%s", page);
 
-	ptr = strstr(i_port, "naa.");
-	if (ptr) {
-		if (tl_hba->tl_proto_id != SCSI_PROTOCOL_SAS) {
-			pr_err("Passed SAS Initiator Port %s does not match target port protoid: %s\n",
-			       i_port, tcm_loop_dump_proto_id(tl_hba));
-			return -EINVAL;
-		}
-		port_ptr = &i_port[0];
-		goto check_newline;
-	}
-	ptr = strstr(i_port, "fc.");
-	if (ptr) {
-		if (tl_hba->tl_proto_id != SCSI_PROTOCOL_FCP) {
-			pr_err("Passed FCP Initiator Port %s does not match target port protoid: %s\n",
-			       i_port, tcm_loop_dump_proto_id(tl_hba));
-			return -EINVAL;
-		}
-		port_ptr = &i_port[3]; /* Skip over "fc." */
-		goto check_newline;
-	}
-	ptr = strstr(i_port, "iqn.");
-	if (ptr) {
-		if (tl_hba->tl_proto_id != SCSI_PROTOCOL_ISCSI) {
-			pr_err("Passed iSCSI Initiator Port %s does not match target port protoid: %s\n",
-			       i_port, tcm_loop_dump_proto_id(tl_hba));
-			return -EINVAL;
-		}
-		port_ptr = &i_port[0];
-		goto check_newline;
-	}
-	pr_err("Unable to locate prefix for emulated Initiator Port: %s\n",
-	       i_port);
-	return -EINVAL;
-	/*
-	 * Clear any trailing newline for the NAA WWN
-	 */
-check_newline:
-	if (i_port[strlen(i_port)-1] == '\n')
-		i_port[strlen(i_port)-1] = '\0';
+	ret = target_parse_emulated_name(tl_hba->tl_proto_id, page, i_port,
+					 TL_WWN_ADDR_LEN, &tpt_id_name);
+	if (ret)
+		return ret;
 
-	ret = tcm_loop_make_nexus(tl_tpg, port_ptr);
+	ret = tcm_loop_make_nexus(tl_tpg, tpt_id_name, i_port);
 	if (ret < 0)
 		return ret;
 
-- 
1.8.3.1

