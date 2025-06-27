Return-Path: <target-devel+bounces-470-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470A9AEBA8F
	for <lists+target-devel@lfdr.de>; Fri, 27 Jun 2025 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA771886668
	for <lists+target-devel@lfdr.de>; Fri, 27 Jun 2025 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DFE2E7F34;
	Fri, 27 Jun 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nqoh1A9t"
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978522676D9
	for <target-devel@vger.kernel.org>; Fri, 27 Jun 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035993; cv=none; b=j5bdeZIlR/CqdQ2EofMCkULhEw9fuZQnqvU1gaN9KZl+CABjSfR8cOgdtOJs8t3FICQvGAVFImQzf5C2xk+In+JIeBmhYVboLUY9HmxUJKXi8T0QI6COdTM+HSy+pPWDIb66ZNxCJNTmK6KfvbzCBaeghW+pOKrdFXQMzje8dcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035993; c=relaxed/simple;
	bh=YYoUgpXzaUULN3sS3OT8XEVZ8YWy0fRf9VfuxaZv3JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRqS6HkvlLAjCaKKzktBhnC0LTFIDZ4R12J5Si1kO0/QzVYJI6uMaRPaq+QioFIMC+2Jm3D2R1cLFo/fgDRf7pHUZtVE+AupE8TR0uoPqt/wlSG5hWHHNKkJLyE+SkOBon88TDQUMsSCTKn3TzTcD7AKKM8kcwwM8b8CKtVE4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nqoh1A9t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751035989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cCF2vzC+teQ0yG8OomqHLK5Ta7yt4A8a1wedC5aUzlk=;
	b=Nqoh1A9tZNcFbWJfUGWUQH9XsGIMyNxpQAH2b5L0b6Da5bVZ399tK/FBSRTOxXKwlvJm7J
	McVq6FibTx++UFdLwNHgZW3DDWgvDqlfuFz3DOaA+AeW24DGsuBtlreQKcUFQcpeHlIPy5
	UXD8kZlG4zLz97qZuuF38wIabfZ2xn0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-LrtT_Q8bMyOi8T654aGcnA-1; Fri,
 27 Jun 2025 10:53:08 -0400
X-MC-Unique: LrtT_Q8bMyOi8T654aGcnA-1
X-Mimecast-MFC-AGG-ID: LrtT_Q8bMyOi8T654aGcnA_1751035987
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D63D518600CC;
	Fri, 27 Jun 2025 14:52:32 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.42.28.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 078A11800287;
	Fri, 27 Jun 2025 14:52:30 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: martin.petersen@oracle.com
Cc: michael.christie@oracle.com,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	mlombard@bsdbackstore.eu
Subject: [PATCH] target: generate correct string identifiers for PR OUT transport IDs
Date: Fri, 27 Jun 2025 16:52:29 +0200
Message-ID: <20250627145229.286252-1-mlombard@redhat.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix target_parse_pr_out_transport_id() to
return a dynamically allocated string representing the
transport ID in a standardized, human-readable format
(e.g., naa.xxxxxxxx...) for various SCSI protocol types
(SAS, FCP, SRP, SBP).

Previously, the function returned a pointer to the raw binary buffer.
The caller would then compared it to a human-readable string,
which obviously always failed.

Now, the function constructs a string using kasprintf()
based on the protocol's offset and format:

* SAS, FCP, SBP: 64-bit identifier
* SRP: 128-bit identifier
* iSCSI: duplicates the iqn string to match the new allocation behavior

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/target_core_fabric_lib.c | 22 ++++++++++++++++------
 drivers/target/target_core_pr.c         |  7 ++++++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index 43f47e3aa448..a124cf982a4c 100644
--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -390,7 +390,10 @@ int target_get_pr_transport_id(struct se_node_acl *nacl,
 const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
 		char *buf, u32 *out_tid_len, char **port_nexus_ptr)
 {
-	u32 offset;
+	u32 offset = 8;
+	u32 len = 8;
+	char *prefix;
+	char hex[40];
 
 	switch (tpg->proto_id) {
 	case SCSI_PROTOCOL_SAS:
@@ -399,15 +402,21 @@ const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
 		 * for initiator ports using SCSI over SAS Serial SCSI Protocol.
 		 */
 		offset = 4;
+		prefix = "naa";
 		break;
-	case SCSI_PROTOCOL_SBP:
 	case SCSI_PROTOCOL_SRP:
+		prefix = "ib";
+		len = 16;
+		break;
 	case SCSI_PROTOCOL_FCP:
-		offset = 8;
+		prefix = "naa";
+		break;
+	case SCSI_PROTOCOL_SBP:
+		prefix = "eui";
 		break;
 	case SCSI_PROTOCOL_ISCSI:
-		return iscsi_parse_pr_out_transport_id(tpg, buf, out_tid_len,
-					port_nexus_ptr);
+		return kstrdup(iscsi_parse_pr_out_transport_id(tpg, buf,
+				out_tid_len, port_nexus_ptr), GFP_KERNEL);
 	default:
 		pr_err("Unknown proto_id: 0x%02x\n", tpg->proto_id);
 		return NULL;
@@ -415,5 +424,6 @@ const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
 
 	*port_nexus_ptr = NULL;
 	*out_tid_len = 24;
-	return buf + offset;
+	bin2hex(hex, buf + offset, len);
+	return kasprintf(GFP_KERNEL, "%s.%s", prefix, hex);
 }
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 70905805cb17..b9b3adc1657d 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -1571,6 +1571,7 @@ core_scsi3_decode_spec_i_port(
 			dest_rtpi = tmp_lun->lun_tpg->tpg_rtpi;
 
 			iport_ptr = NULL;
+			kfree(i_str);
 			i_str = target_parse_pr_out_transport_id(tmp_tpg,
 					ptr, &tid_len, &iport_ptr);
 			if (!i_str)
@@ -1808,6 +1809,7 @@ core_scsi3_decode_spec_i_port(
 		core_scsi3_tpg_undepend_item(dest_tpg);
 	}
 
+	kfree(i_str);
 	return 0;
 out_unmap:
 	transport_kunmap_data_sg(cmd);
@@ -1852,6 +1854,7 @@ core_scsi3_decode_spec_i_port(
 		core_scsi3_nodeacl_undepend_item(dest_node_acl);
 		core_scsi3_tpg_undepend_item(dest_tpg);
 	}
+	kfree(i_str);
 	return ret;
 }
 
@@ -3153,7 +3156,7 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 	struct t10_pr_registration *pr_reg, *pr_res_holder, *dest_pr_reg;
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
 	unsigned char *buf;
-	const unsigned char *initiator_str;
+	const unsigned char *initiator_str = NULL;
 	char *iport_ptr = NULL, i_buf[PR_REG_ISID_ID_LEN] = { };
 	u32 tid_len, tmp_tid_len;
 	int new_reg = 0, type, scope, matching_iname;
@@ -3526,6 +3529,7 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 	core_scsi3_update_and_write_aptpl(cmd->se_dev, aptpl);
 
 	core_scsi3_put_pr_reg(dest_pr_reg);
+	kfree(initiator_str);
 	return 0;
 out:
 	if (buf)
@@ -3538,6 +3542,7 @@ core_scsi3_emulate_pro_register_and_move(struct se_cmd *cmd, u64 res_key,
 
 out_put_pr_reg:
 	core_scsi3_put_pr_reg(pr_reg);
+	kfree(initiator_str);
 	return ret;
 }
 
-- 
2.47.1


