Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF176314973
	for <lists+target-devel@lfdr.de>; Tue,  9 Feb 2021 08:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhBIHYh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 9 Feb 2021 02:24:37 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:37990 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230179AbhBIHY2 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:24:28 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id F3EC54128C;
        Tue,  9 Feb 2021 07:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :reply-to:references:in-reply-to:x-mailer:message-id:date:date
        :subject:subject:from:from:received:received:received; s=mta-01;
         t=1612855423; x=1614669824; bh=lgkQvaTcnA9En4xI04uq4efVNNX1qBOu
        oCmnn4ZoQTQ=; b=gWI+A7PhQjiAVY2z/SKfJhgXsHURTzU12f5p3nq3nZL6ngjE
        9exQdcVcFjC3sagPmmuyGzRYMElQQ4681BdIFVopzdGQRUSaoFE1cdyTsbrRk15e
        KdUm3Elux1VCp0gT3qkMtLarCNM7QsoDMfJxWbCBqfdD3L+Nw1i5jdvS0fA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fTG4MMfX0Q8j; Tue,  9 Feb 2021 10:23:43 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C40CD41278;
        Tue,  9 Feb 2021 10:23:43 +0300 (MSK)
Received: from localhost (10.199.0.114) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 9 Feb
 2021 10:23:43 +0300
From:   Aleksandr Miloserdov <a.miloserdov@yadro.com>
To:     <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <r.bolshakov@yadro.com>,
        Aleksandr Miloserdov <a.miloserdov@yadro.com>
Subject: [PATCH 2/2] scsi: target: core: Prevent underflow for service actions
Date:   Tue, 9 Feb 2021 10:22:02 +0300
Message-ID: <20210209072202.41154-3-a.miloserdov@yadro.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210209072202.41154-1-a.miloserdov@yadro.com>
References: <20210209072202.41154-1-a.miloserdov@yadro.com>
Reply-To: <a.miloserdov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.114]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

TCM buffer length doesn't necessarily equal 8 + ADDITIONAL LENGTH which
might be considered an underflow in case of Data-In size being greater than
8 + ADDITIONAL LENGTH. So truncate buffer length to prevent underflow.

Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 drivers/target/target_core_pr.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 14db5e568f22..a13140e95b47 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -3739,6 +3739,7 @@ core_scsi3_pri_read_keys(struct se_cmd *cmd)
 	spin_unlock(&dev->t10_pr.registration_lock);
 
 	put_unaligned_be32(add_len, &buf[4]);
+	target_set_cmd_data_length(cmd, 8 + add_len);
 
 	transport_kunmap_data_sg(cmd);
 
@@ -3757,7 +3758,7 @@ core_scsi3_pri_read_reservation(struct se_cmd *cmd)
 	struct t10_pr_registration *pr_reg;
 	unsigned char *buf;
 	u64 pr_res_key;
-	u32 add_len = 16; /* Hardcoded to 16 when a reservation is held. */
+	u32 add_len = 0;
 
 	if (cmd->data_length < 8) {
 		pr_err("PRIN SA READ_RESERVATIONS SCSI Data Length: %u"
@@ -3775,8 +3776,9 @@ core_scsi3_pri_read_reservation(struct se_cmd *cmd)
 	pr_reg = dev->dev_pr_res_holder;
 	if (pr_reg) {
 		/*
-		 * Set the hardcoded Additional Length
+		 * Set the Additional Length to 16 when a reservation is held
 		 */
+		add_len = 16;
 		put_unaligned_be32(add_len, &buf[4]);
 
 		if (cmd->data_length < 22)
@@ -3812,6 +3814,8 @@ core_scsi3_pri_read_reservation(struct se_cmd *cmd)
 			  (pr_reg->pr_res_type & 0x0f);
 	}
 
+	target_set_cmd_data_length(cmd, 8 + add_len);
+
 err:
 	spin_unlock(&dev->dev_reservation_lock);
 	transport_kunmap_data_sg(cmd);
@@ -3830,7 +3834,7 @@ core_scsi3_pri_report_capabilities(struct se_cmd *cmd)
 	struct se_device *dev = cmd->se_dev;
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
 	unsigned char *buf;
-	u16 add_len = 8; /* Hardcoded to 8. */
+	u16 len = 8; /* Hardcoded to 8. */
 
 	if (cmd->data_length < 6) {
 		pr_err("PRIN SA REPORT_CAPABILITIES SCSI Data Length:"
@@ -3842,7 +3846,7 @@ core_scsi3_pri_report_capabilities(struct se_cmd *cmd)
 	if (!buf)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
-	put_unaligned_be16(add_len, &buf[0]);
+	put_unaligned_be16(len, &buf[0]);
 	buf[2] |= 0x10; /* CRH: Compatible Reservation Hanlding bit. */
 	buf[2] |= 0x08; /* SIP_C: Specify Initiator Ports Capable bit */
 	buf[2] |= 0x04; /* ATP_C: All Target Ports Capable bit */
@@ -3871,6 +3875,8 @@ core_scsi3_pri_report_capabilities(struct se_cmd *cmd)
 	buf[4] |= 0x02; /* PR_TYPE_WRITE_EXCLUSIVE */
 	buf[5] |= 0x01; /* PR_TYPE_EXCLUSIVE_ACCESS_ALLREG */
 
+	target_set_cmd_data_length(cmd, len);
+
 	transport_kunmap_data_sg(cmd);
 
 	return 0;
@@ -4031,6 +4037,7 @@ core_scsi3_pri_read_full_status(struct se_cmd *cmd)
 	 * Set ADDITIONAL_LENGTH
 	 */
 	put_unaligned_be32(add_len, &buf[4]);
+	target_set_cmd_data_length(cmd, 8 + add_len);
 
 	transport_kunmap_data_sg(cmd);
 
-- 
2.28.0

