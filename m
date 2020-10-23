Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7C297891
	for <lists+target-devel@lfdr.de>; Fri, 23 Oct 2020 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465570AbgJWU5h (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 23 Oct 2020 16:57:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755534AbgJWU5g (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:57:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F2D4B24B;
        Fri, 23 Oct 2020 20:57:34 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH 4/5] scsi: target: split out COMPARE AND WRITE memcmp into helper
Date:   Fri, 23 Oct 2020 22:57:22 +0200
Message-Id: <20201023205723.17880-5-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023205723.17880-1-ddiss@suse.de>
References: <20201023205723.17880-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

In preparation for finding and returning the miscompare offset.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/target_core_sbc.c | 117 ++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index 5f77dd95f1b9..79216d0355e7 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -434,20 +434,77 @@ static sense_reason_t compare_and_write_post(struct se_cmd *cmd, bool success,
 	return ret;
 }
 
+/*
+ * compare @cmp_len bytes of @read_sgl with @cmp_sgl. On miscompare return
+ * TCM_MISCOMPARE_VERIFY.
+ */
+static sense_reason_t
+compare_and_write_do_cmp(struct scatterlist *read_sgl, unsigned int read_nents,
+			 struct scatterlist *cmp_sgl, unsigned int cmp_nents,
+			 unsigned int cmp_len)
+{
+	unsigned char *buf = NULL;
+	struct scatterlist *sg;
+	sense_reason_t ret;
+	unsigned int offset;
+	size_t rc;
+	int i;
+
+	buf = kzalloc(cmp_len, GFP_KERNEL);
+	if (!buf) {
+		pr_err("Unable to allocate compare_and_write buf\n");
+		ret = TCM_OUT_OF_RESOURCES;
+		goto out;
+	}
+
+	rc = sg_copy_to_buffer(cmp_sgl, cmp_nents, buf, cmp_len);
+	if (!rc) {
+		pr_err("sg_copy_to_buffer() failed for compare_and_write\n");
+		ret = TCM_OUT_OF_RESOURCES;
+		goto out;
+	}
+	/*
+	 * Compare SCSI READ payload against verify payload
+	 */
+	offset = 0;
+	for_each_sg(read_sgl, sg, read_nents, i) {
+		unsigned int len = min(sg->length, cmp_len);
+		unsigned char *addr = kmap_atomic(sg_page(sg));
+
+		if (memcmp(addr, buf + offset, len)) {
+			pr_warn("Detected MISCOMPARE for addr: %p buf: %p\n",
+				addr, buf + offset);
+			kunmap_atomic(addr);
+			ret = TCM_MISCOMPARE_VERIFY;
+			goto out;
+		}
+		kunmap_atomic(addr);
+
+		offset += len;
+		cmp_len -= len;
+		if (!cmp_len)
+			break;
+	}
+	pr_debug("COMPARE AND WRITE read data matches compare data\n");
+	ret = TCM_NO_SENSE;
+out:
+	kfree(buf);
+	return ret;
+}
+
 static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool success,
 						 int *post_ret)
 {
 	struct se_device *dev = cmd->se_dev;
 	struct sg_table write_tbl = { };
-	struct scatterlist *write_sg, *sg;
-	unsigned char *buf = NULL, *addr;
+	struct scatterlist *write_sg;
 	struct sg_mapping_iter m;
-	unsigned int offset = 0, len;
+	unsigned int len;
 	unsigned int nlbas = cmd->t_task_nolb;
 	unsigned int block_size = dev->dev_attrib.block_size;
 	unsigned int compare_len = (nlbas * block_size);
 	sense_reason_t ret = TCM_NO_SENSE;
-	int rc, i;
+	int i;
 
 	/*
 	 * Handle early failure in transport_generic_request_failure(),
@@ -473,12 +530,13 @@ static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool succes
 		goto out;
 	}
 
-	buf = kzalloc(cmd->data_length, GFP_KERNEL);
-	if (!buf) {
-		pr_err("Unable to allocate compare_and_write buf\n");
-		ret = TCM_OUT_OF_RESOURCES;
+	ret = compare_and_write_do_cmp(cmd->t_bidi_data_sg,
+				       cmd->t_bidi_data_nents,
+				       cmd->t_data_sg,
+				       cmd->t_data_nents,
+				       compare_len);
+	if (ret)
 		goto out;
-	}
 
 	if (sg_alloc_table(&write_tbl, cmd->t_data_nents, GFP_KERNEL) < 0) {
 		pr_err("Unable to allocate compare_and_write sg\n");
@@ -486,41 +544,6 @@ static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool succes
 		goto out;
 	}
 	write_sg = write_tbl.sgl;
-	/*
-	 * Setup verify and write data payloads from total NumberLBAs.
-	 */
-	rc = sg_copy_to_buffer(cmd->t_data_sg, cmd->t_data_nents, buf,
-			       cmd->data_length);
-	if (!rc) {
-		pr_err("sg_copy_to_buffer() failed for compare_and_write\n");
-		ret = TCM_OUT_OF_RESOURCES;
-		goto out;
-	}
-	/*
-	 * Compare against SCSI READ payload against verify payload
-	 */
-	for_each_sg(cmd->t_bidi_data_sg, sg, cmd->t_bidi_data_nents, i) {
-		addr = (unsigned char *)kmap_atomic(sg_page(sg));
-		if (!addr) {
-			ret = TCM_OUT_OF_RESOURCES;
-			goto out;
-		}
-
-		len = min(sg->length, compare_len);
-
-		if (memcmp(addr, buf + offset, len)) {
-			pr_warn("Detected MISCOMPARE for addr: %p buf: %p\n",
-				addr, buf + offset);
-			kunmap_atomic(addr);
-			goto miscompare;
-		}
-		kunmap_atomic(addr);
-
-		offset += len;
-		compare_len -= len;
-		if (!compare_len)
-			break;
-	}
 
 	i = 0;
 	len = cmd->t_task_nolb * block_size;
@@ -568,13 +591,8 @@ static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool succes
 
 	__target_execute_cmd(cmd, false);
 
-	kfree(buf);
 	return ret;
 
-miscompare:
-	pr_warn("Target/%s: Send MISCOMPARE check condition and sense\n",
-		dev->transport->name);
-	ret = TCM_MISCOMPARE_VERIFY;
 out:
 	/*
 	 * In the MISCOMPARE or failure case, unlock ->caw_sem obtained in
@@ -582,7 +600,6 @@ static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool succes
 	 */
 	up(&dev->caw_sem);
 	sg_free_table(&write_tbl);
-	kfree(buf);
 	return ret;
 }
 
-- 
2.26.2

