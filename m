Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C06365FB4
	for <lists+target-devel@lfdr.de>; Tue, 20 Apr 2021 20:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhDTSrj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 20 Apr 2021 14:47:39 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52532 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233510AbhDTSri (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:47:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 660E4413A2;
        Tue, 20 Apr 2021 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1618944424; x=1620758825; bh=c1tS4oeh7lbe3X2QVse23nsU2MfIanOAt/b
        YyhlsNbg=; b=OEKsFoY0n9pT+cRCtFL9dXGmbvp69x7T6mIASOn2b7I6lHnPTe4
        Vf7X1NbizX66eTKLXJOfhtsOKdsgJ6f6/v1rxEuWHYv1LhUVx+b1QO9AoqSjXLyj
        4vQyKNR8x+EhE/N+sh3xjHSJx7gSDnE7e/swYtmiQPnvFD8pbaCfGYxo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0qLxWu1XNfv3; Tue, 20 Apr 2021 21:47:04 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2C25341312;
        Tue, 20 Apr 2021 21:47:04 +0300 (MSK)
Received: from yadro.com (10.199.0.227) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 20
 Apr 2021 21:47:03 +0300
From:   Sergey Samoylenko <s.samoylenko@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     David Disseldorp <ddiss@suse.de>,
        Sergey Samoylenko <s.samoylenko@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH 2/2] scsi: target: core: Add IEEE Company ID attribute
Date:   Tue, 20 Apr 2021 21:44:06 +0300
Message-ID: <20210420184406.42127-3-s.samoylenko@yadro.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210420184406.42127-1-s.samoylenko@yadro.com>
References: <20210420184406.42127-1-s.samoylenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.227]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The attribute provides a way to set a company specific WWN
in configfs via:

  target/core/$backstore/$name/wwn/company_id

001405h remains default value for company id.

Signed-off-by: Sergey Samoylenko <s.samoylenko@yadro.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 drivers/target/target_core_configfs.c | 50 +++++++++++++++++++++++++++
 drivers/target/target_core_device.c   |  5 +++
 drivers/target/target_core_spc.c      | 14 ++++----
 include/target/target_core_base.h     |  1 +
 4 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 4b2e49341ad6..d6fd2779355a 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1479,6 +1479,54 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t
+target_wwn_company_id_show(struct config_item *item,
+				char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%#08x\n",
+			to_t10_wwn(item)->company_id);
+}
+
+static ssize_t
+target_wwn_company_id_store(struct config_item *item,
+				 const char *page, size_t count)
+{
+	struct t10_wwn *t10_wwn = to_t10_wwn(item);
+	struct se_device *dev = t10_wwn->t10_dev;
+	u32 val;
+	int ret;
+
+	/*
+	 * The IEEE COMPANY_ID field should contain a 24-bit canonical
+	 * form OUI assigned by the IEEE.
+	 */
+	ret = kstrtou32(page, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val >= 0x1000000)
+		return -EOVERFLOW;
+
+	/*
+	 * Check to see if any active exports exist. If they do exist, fail
+	 * here as changing this information on the fly (underneath the
+	 * initiator side OS dependent multipath code) could cause negative
+	 * effects.
+	 */
+	if (dev->export_count) {
+		pr_err("Unable to set Company ID while %d exports exist\n",
+		       dev->export_count);
+		return -EINVAL;
+	}
+
+	t10_wwn->company_id = val;
+
+	pr_debug("Target_Core_ConfigFS: Set IEEE Company ID: %#08x\n",
+		 t10_wwn->company_id);
+
+	return count;
+}
+
 /*
  * VPD page 0x80 Unit serial
  */
@@ -1625,6 +1673,7 @@ DEF_DEV_WWN_ASSOC_SHOW(vpd_assoc_scsi_target_device, 0x20);
 CONFIGFS_ATTR(target_wwn_, vendor_id);
 CONFIGFS_ATTR(target_wwn_, product_id);
 CONFIGFS_ATTR(target_wwn_, revision);
+CONFIGFS_ATTR(target_wwn_, company_id);
 CONFIGFS_ATTR(target_wwn_, vpd_unit_serial);
 CONFIGFS_ATTR_RO(target_wwn_, vpd_protocol_identifier);
 CONFIGFS_ATTR_RO(target_wwn_, vpd_assoc_logical_unit);
@@ -1635,6 +1684,7 @@ static struct configfs_attribute *target_core_dev_wwn_attrs[] = {
 	&target_wwn_attr_vendor_id,
 	&target_wwn_attr_product_id,
 	&target_wwn_attr_revision,
+	&target_wwn_attr_company_id,
 	&target_wwn_attr_vpd_unit_serial,
 	&target_wwn_attr_vpd_protocol_identifier,
 	&target_wwn_attr_vpd_assoc_logical_unit,
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index a8df9f0a82fa..8cb1fa0c0585 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -773,6 +773,11 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	spin_lock_init(&dev->t10_alua.lba_map_lock);
 
 	dev->t10_wwn.t10_dev = dev;
+	/*
+	 * Use OpenFabrics IEEE Company ID: 00 14 05
+	 */
+	dev->t10_wwn.company_id = 0x001405;
+
 	dev->t10_alua.t10_dev = dev;
 
 	dev->dev_attrib.da_dev = dev;
diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index b2d19493a994..fe5d5ce4099c 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -136,20 +136,20 @@ void spc_gen_naa_6h_vendor_specific(struct se_device *dev,
 				    unsigned char *buf)
 {
 	unsigned char *p = &dev->t10_wwn.unit_serial[0];
+	u32 company_id = dev->t10_wwn.company_id;
 	int cnt, off = 0;
 	bool next = true;
 
 	/*
 	 * Start NAA IEEE Registered Extended Identifier/Designator
 	 */
-	buf[off++] = 0x6 << 4;
+	buf[off] = 0x6 << 4;
 
-	/*
-	 * Use OpenFabrics IEEE Company ID: 00 14 05
-	 */
-	buf[off++] = 0x01;
-	buf[off++] = 0x40;
-	buf[off] = (0x5 << 4);
+	/* IEEE COMPANY_ID */
+	buf[off++] |= (company_id >> 20) & 0xf;
+	buf[off++] = (company_id >> 12) & 0xff;
+	buf[off++] = (company_id >> 4) & 0xff;
+	buf[off] = (company_id & 0xf) << 4;
 
 	/*
 	 * Generate up to 36 bits of VENDOR SPECIFIC IDENTIFIER starting on
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index d1f7d2a45354..85c16c266eac 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -326,6 +326,7 @@ struct t10_wwn {
 	char model[INQUIRY_MODEL_LEN + 1];
 	char revision[INQUIRY_REVISION_LEN + 1];
 	char unit_serial[INQUIRY_VPD_SERIAL_LEN];
+	u32 company_id;
 	spinlock_t t10_vpd_lock;
 	struct se_device *t10_dev;
 	struct config_group t10_wwn_group;
-- 
2.27.0

