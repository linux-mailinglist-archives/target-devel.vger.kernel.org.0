Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3709C2963B3
	for <lists+target-devel@lfdr.de>; Thu, 22 Oct 2020 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900114AbgJVR3h (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 22 Oct 2020 13:29:37 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35604 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2900087AbgJVR3g (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:29:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 14D54413B0;
        Thu, 22 Oct 2020 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1603387240; x=1605201641; bh=rAheWooUNddIs6GJOBVctKvZXcVa9GTyfpX
        lKwDQ6Lc=; b=lxOX0rnCW1eJqfUEBuR31ktH+URoh/8KEYGmCc8a9bmmvZ6lior
        g5YsrvO0AnjOS7jT9V1IskeomEoxAhsWygKWs/91OH/xSUFWUMQXwal9cUpOazK2
        tdjgQjcWJ+vO75adnn6BgThbEwPxVQGZltCrHufPSEboVEdnJ90zJ7Pc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k7mQcpgwH2yr; Thu, 22 Oct 2020 20:20:40 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 60D1F413A8;
        Thu, 22 Oct 2020 20:20:39 +0300 (MSK)
Received: from localhost (172.17.204.63) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 22
 Oct 2020 20:20:38 +0300
From:   Anastasia Kovaleva <a.kovaleva@yadro.com>
To:     <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Anastasia Kovaleva <a.kovaleva@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH 2/3] scsi: target: core: Signal WRITE residuals
Date:   Thu, 22 Oct 2020 20:20:10 +0300
Message-ID: <20201022172011.42367-3-a.kovaleva@yadro.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201022172011.42367-1-a.kovaleva@yadro.com>
References: <20201022172011.42367-1-a.kovaleva@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.63]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

According to RFC 7143 11.4.5.2.:

  If SPDTL > EDTL for a task, iSCSI Overflow MUST be signaled in the
  SCSI Response PDU as specified in Section 11.4.5.1.  The Residual
  Count MUST be set to the numerical value of (SPDTL - EDTL).

  If SPDTL < EDTL for a task, iSCSI Underflow MUST be signaled in the
  SCSI Response PDU as specified in Section 11.4.5.1.  The Residual
  Count MUST be set to the numerical value of (EDTL - SPDTL).

libiscsi has residual write tests that check residual kind and residual
amount and all of them (Write10Residuals, Write12Residuals,
Write16Residuals) currently fail.

One of the reasons why they fail is because target completes write
commands with INVALID FIELD IN CDB before setting the Overflow/Underflow
bit and residual amount.

Set the Overflow/Underflow bit and the residual amount before failing a
write to comply with RFC 7143.

Signed-off-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 drivers/target/target_core_transport.c | 34 +++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 6d73b453c2cb..8cb3012721d8 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1306,6 +1306,26 @@ target_cmd_size_check(struct se_cmd *cmd, unsigned int size)
 			" %u does not match SCSI CDB Length: %u for SAM Opcode:"
 			" 0x%02x\n", cmd->se_tfo->fabric_name,
 				cmd->data_length, size, cmd->t_task_cdb[0]);
+		/*
+		 * For READ command for the overflow case keep the existing
+		 * fabric provided ->data_length. Otherwise for the underflow
+		 * case, reset ->data_length to the smaller SCSI expected data
+		 * transfer length.
+		 */
+		if (size > cmd->data_length) {
+			cmd->se_cmd_flags |= SCF_OVERFLOW_BIT;
+			cmd->residual_count = (size - cmd->data_length);
+		} else {
+			cmd->se_cmd_flags |= SCF_UNDERFLOW_BIT;
+			cmd->residual_count = (cmd->data_length - size);
+			/*
+			 * Do not truncate ->data_length for WRITE command to
+			 * dump all payload
+			 */
+			if (cmd->data_direction == DMA_FROM_DEVICE) {
+				cmd->data_length = size;
+			}
+		}
 
 		if (cmd->data_direction == DMA_TO_DEVICE) {
 			if (cmd->se_cmd_flags & SCF_SCSI_DATA_CDB) {
@@ -1325,20 +1345,6 @@ target_cmd_size_check(struct se_cmd *cmd, unsigned int size)
 				return TCM_INVALID_CDB_FIELD;
 			}
 		}
-		/*
-		 * For the overflow case keep the existing fabric provided
-		 * ->data_length.  Otherwise for the underflow case, reset
-		 * ->data_length to the smaller SCSI expected data transfer
-		 * length.
-		 */
-		if (size > cmd->data_length) {
-			cmd->se_cmd_flags |= SCF_OVERFLOW_BIT;
-			cmd->residual_count = (size - cmd->data_length);
-		} else {
-			cmd->se_cmd_flags |= SCF_UNDERFLOW_BIT;
-			cmd->residual_count = (cmd->data_length - size);
-			cmd->data_length = size;
-		}
 	}
 
 	return target_check_max_data_sg_nents(cmd, dev, size);
-- 
2.24.3 (Apple Git-128)

