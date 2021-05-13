Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8227D37FE1C
	for <lists+target-devel@lfdr.de>; Thu, 13 May 2021 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhEMT3o (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 13 May 2021 15:29:44 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:44466 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230443AbhEMT3m (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 13 May 2021 15:29:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C49FD4131A;
        Thu, 13 May 2021 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1620934109; x=1622748510; bh=obpYstGgMhx5SLeLt1lJ0+M/S2e+YRCNb4/
        3QmwAoZU=; b=iGt6xftdkPi67GyO/kndVZfwqAN4WE8KSGIbyDYFeJPq5NfmdBG
        HCPL0svfD07UmsFlf46Tf89zoDxj+mC6vKu40T6ARvNl3uCaoUZTV70VIXqI6eoS
        JWHrVMHrLYCL5B2duRCKcjjGJZBke9rVvZ8ZwT15AZ3gQSOAZIwNPnbY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tmOmJbTtrJEt; Thu, 13 May 2021 22:28:29 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1855E4131F;
        Thu, 13 May 2021 22:28:29 +0300 (MSK)
Received: from yadro.com (10.199.0.46) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 13
 May 2021 22:28:28 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH 2/2] scsi: target: Add the VERSION DESCRIPTOR fields to the INQUIRY data
Date:   Thu, 13 May 2021 22:28:04 +0300
Message-ID: <20210513192804.1252142-3-k.shelekhin@yadro.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513192804.1252142-1-k.shelekhin@yadro.com>
References: <20210513192804.1252142-1-k.shelekhin@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.46]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Extend the standard INQUIRY data to 96 bytes and fill in the VERSION
DESCRIPTOR fields.

The layout follows SPC-4:

  SCSI architecture standard
  SCSI transport protocol standard
  SCSI primary command set standard
  SCSI device type command set standard

All version descriptor values are defined as "unclaimed" because some
initiators fail to recognize anything else.

Signed-off-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 drivers/target/target_core_spc.c | 34 +++++++++++++++++++++++++++++++-
 include/scsi/scsi_proto.h        | 12 +++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index c42a954ce641..d3b2f3d075bf 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -47,10 +47,32 @@ static void spc_fill_alua_data(struct se_lun *lun, unsigned char *buf)
 	spin_unlock(&lun->lun_tg_pt_gp_lock);
 }
 
+static u16
+spc_find_scsi_transport_vd(int proto_id)
+{
+	switch (proto_id) {
+	case SCSI_PROTOCOL_FCP:
+		return SCSI_VERSION_DESCRIPTOR_FCP4;
+	case SCSI_PROTOCOL_ISCSI:
+		return SCSI_VERSION_DESCRIPTOR_ISCSI;
+	case SCSI_PROTOCOL_SAS:
+		return SCSI_VERSION_DESCRIPTOR_SAS3;
+	case SCSI_PROTOCOL_SBP:
+		return SCSI_VERSION_DESCRIPTOR_SBP3;
+	case SCSI_PROTOCOL_SRP:
+		return SCSI_VERSION_DESCRIPTOR_SRP;
+	default:
+		pr_warn("Cannot find VERSION DESCRIPTOR value for unknown SCSI"
+		        " transport PROTOCOL IDENTIFIER %#x\n", proto_id);
+		return 0;
+	}
+}
+
 sense_reason_t
 spc_emulate_inquiry_std(struct se_cmd *cmd, unsigned char *buf)
 {
 	struct se_lun *lun = cmd->se_lun;
+	struct se_portal_group *tpg = lun->lun_tpg;
 	struct se_device *dev = cmd->se_dev;
 	struct se_session *sess = cmd->se_sess;
 
@@ -108,7 +130,17 @@ spc_emulate_inquiry_std(struct se_cmd *cmd, unsigned char *buf)
 	       strnlen(dev->t10_wwn.model, INQUIRY_MODEL_LEN));
 	memcpy(&buf[32], dev->t10_wwn.revision,
 	       strnlen(dev->t10_wwn.revision, INQUIRY_REVISION_LEN));
-	buf[4] = 31; /* Set additional length to 31 */
+
+	/*
+	 * Set the VERSION DESCRIPTOR fields
+	 */
+	put_unaligned_be16(SCSI_VERSION_DESCRIPTOR_SAM5, &buf[58]);
+	put_unaligned_be16(spc_find_scsi_transport_vd(tpg->proto_id), &buf[60]);
+	put_unaligned_be16(SCSI_VERSION_DESCRIPTOR_SPC4, &buf[62]);
+	if (cmd->se_dev->transport->get_device_type(dev) == TYPE_DISK)
+		put_unaligned_be16(SCSI_VERSION_DESCRIPTOR_SBC3, &buf[64]);
+
+	buf[4] = 91; /* Set additional length to 91 */
 
 	return 0;
 }
diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index c36860111932..5c106c4f249e 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -341,4 +341,16 @@ enum zbc_zone_cond {
 	ZBC_ZONE_COND_OFFLINE		= 0xf,
 };
 
+/* Version descriptor values for INQUIRY */
+enum scsi_version_descriptor {
+	SCSI_VERSION_DESCRIPTOR_FCP4	= 0x0a40,
+	SCSI_VERSION_DESCRIPTOR_ISCSI	= 0x0960,
+	SCSI_VERSION_DESCRIPTOR_SAM5	= 0x00a0,
+	SCSI_VERSION_DESCRIPTOR_SAS3	= 0x0c60,
+	SCSI_VERSION_DESCRIPTOR_SBC3	= 0x04c0,
+	SCSI_VERSION_DESCRIPTOR_SBP3	= 0x0980,
+	SCSI_VERSION_DESCRIPTOR_SPC4	= 0x0460,
+	SCSI_VERSION_DESCRIPTOR_SRP	= 0x0940
+};
+
 #endif /* _SCSI_PROTO_H_ */
-- 
2.31.1

