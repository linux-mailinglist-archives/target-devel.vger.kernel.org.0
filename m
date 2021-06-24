Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A293B2DB8
	for <lists+target-devel@lfdr.de>; Thu, 24 Jun 2021 13:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhFXLW7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Jun 2021 07:22:59 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42300 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232005AbhFXLW4 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:22:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A348F42C08;
        Thu, 24 Jun 2021 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1624533635; x=1626348036; bh=ltpEwS9aHPtc1zOKIjrtGJ53x5c98aniDIW
        BQ4ObvRM=; b=oOIJGfxB+xjw/vcQtttZ+xczQ6cTFoYsUg4dFRIK3XpjhPHi6Ae
        02ie99uRLeSsQVQKN3Q7Pmgv8FkgQb9Z3i9DATjR6AcK+Y6/4wLI1mgBT+SM8d7r
        /wcNfsVpFJfguY82G0tyxEtmvd/+Yru3l4DwIOVbwdJVySk9XWdy7G7s=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hB-Sgf12yFlh; Thu, 24 Jun 2021 14:20:35 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D254F42B95;
        Thu, 24 Jun 2021 14:20:35 +0300 (MSK)
Received: from yadro.com (10.199.0.253) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Jun 2021 14:20:35 +0300
From:   Sergey Samoylenko <s.samoylenko@yadro.com>
To:     <martin.petersen@oracle.com>, <michael.christie@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Sergey Samoylenko <s.samoylenko@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>
Subject: [PATCH 1/1] scsi: target: core: Fix sense key for invalid XCOPY request
Date:   Thu, 24 Jun 2021 14:19:26 +0300
Message-ID: <20210624111926.63176-2-s.samoylenko@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624111926.63176-1-s.samoylenko@yadro.com>
References: <20210624111926.63176-1-s.samoylenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.253]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

TCM fails to pass the following tests in libiscsi:

  SCSI.ExtendedCopy.DescrType
  SCSI.ExtendedCopy.DescrLimits
  SCSI.ExtendedCopy.ParamHdr
  SCSI.ExtendedCopy.ValidSegDescr
  SCSI.ExtendedCopy.ValidTgtDescr

XCOPY always returns the same NOT READY sense key for all
detected errors. It changes a sense key for invalid requests
to ILLEGAL REQUEST sense key, for aborted transferring data
(IO error and etc.) to COPY ABORTED.

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Signed-off-by: Sergey Samoylenko <s.samoylenko@yadro.com>
---
 drivers/target/target_core_xcopy.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index 0f1319336f3e..64baf3e8c079 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -674,12 +674,16 @@ static void target_xcopy_do_work(struct work_struct *work)
 	unsigned int max_sectors;
 	int rc = 0;
 	unsigned short nolb, max_nolb, copied_nolb = 0;
+	sense_reason_t sense_rc;
 
-	if (target_parse_xcopy_cmd(xop) != TCM_NO_SENSE)
+	sense_rc = target_parse_xcopy_cmd(xop);
+	if (sense_rc != TCM_NO_SENSE)
 		goto err_free;
 
-	if (WARN_ON_ONCE(!xop->src_dev) || WARN_ON_ONCE(!xop->dst_dev))
+	if (WARN_ON_ONCE(!xop->src_dev) || WARN_ON_ONCE(!xop->dst_dev)) {
+		sense_rc = TCM_INVALID_PARAMETER_LIST;
 		goto err_free;
+	}
 
 	src_dev = xop->src_dev;
 	dst_dev = xop->dst_dev;
@@ -762,20 +766,20 @@ static void target_xcopy_do_work(struct work_struct *work)
 	return;
 
 out:
+	/*
+	 * The XCOPY command was aborted after some data was transferred.
+	 * Terminate command with CHECK CONDITION status, with the sense key
+	 * set to COPY ABORTED.
+	 */
+	sense_rc = TCM_COPY_TARGET_DEVICE_NOT_REACHABLE;
 	xcopy_pt_undepend_remotedev(xop);
 	target_free_sgl(xop->xop_data_sg, xop->xop_data_nents);
 
 err_free:
 	kfree(xop);
-	/*
-	 * Don't override an error scsi status if it has already been set
-	 */
-	if (ec_cmd->scsi_status == SAM_STAT_GOOD) {
-		pr_warn_ratelimited("target_xcopy_do_work: rc: %d, Setting X-COPY"
-			" CHECK_CONDITION -> sending response\n", rc);
-		ec_cmd->scsi_status = SAM_STAT_CHECK_CONDITION;
-	}
-	target_complete_cmd(ec_cmd, ec_cmd->scsi_status);
+	pr_warn_ratelimited("target_xcopy_do_work: rc: %d, sense: %u,"
+		" XCOPY operation failed\n", rc, sense_rc);
+	target_complete_cmd_with_sense(ec_cmd, sense_rc);
 }
 
 /*
-- 
2.25.1

