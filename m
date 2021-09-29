Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B7341C3C2
	for <lists+target-devel@lfdr.de>; Wed, 29 Sep 2021 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbhI2Lw0 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 29 Sep 2021 07:52:26 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:34484 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240310AbhI2LwV (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:52:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 76AFB43DAA;
        Wed, 29 Sep 2021 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1632916238; x=
        1634730639; bh=eCbuluwhdBl5PGqQkbmadL6bY6rhma2+bSCODGA4v7Q=; b=B
        MU2e8lWEvGMLriwiF10q4uqd70aXOlok/IJyy3tUM59qPPDvSdc4VDdWPFh2NwBq
        VP3NfD8rZ0Q+/7lyVjgNi5hi1D5bHM8lcNtJBFRPX5TzOi5LjMY1VWV/kjCGgIZ9
        KbjEkGfkBjtUDuJZHKMGoQ0rcIK+eAy7hC8QEJxNk8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KdCxkYeqDjct; Wed, 29 Sep 2021 14:50:38 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 66F0C4177A;
        Wed, 29 Sep 2021 14:50:38 +0300 (MSK)
Received: from yadro.com (10.178.21.26) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Sep 2021 14:50:37 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH] scsi: target: core: Make logs less verbose
Date:   Wed, 29 Sep 2021 14:50:00 +0300
Message-ID: <20210929114959.705852-1-k.shelekhin@yadro.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.21.26]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Change the log level of the following message to debug:

	Unsupported SCSI Opcode 0xXX, sending CHECK_CONDITION.

This message is mostly helpful during debugging sessions in order to
understand errors on the initiator side. But most of the time it's just
useless and makes reading logs much harder.

It gets particularly annoying if there are many initiators that come and
go or if an initiator runs a program that does not care whether the
command is supported and just keeps sending it.

Signed-off-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 drivers/target/target_core_transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 14c6f2bb1b01..4a0055ab9151 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1511,10 +1511,10 @@ target_cmd_parse_cdb(struct se_cmd *cmd)
 
 	ret = dev->transport->parse_cdb(cmd);
 	if (ret == TCM_UNSUPPORTED_SCSI_OPCODE)
-		pr_warn_ratelimited("%s/%s: Unsupported SCSI Opcode 0x%02x, sending CHECK_CONDITION.\n",
-				    cmd->se_tfo->fabric_name,
-				    cmd->se_sess->se_node_acl->initiatorname,
-				    cmd->t_task_cdb[0]);
+		pr_debug_ratelimited("%s/%s: Unsupported SCSI Opcode 0x%02x, sending CHECK_CONDITION.\n",
+				     cmd->se_tfo->fabric_name,
+				     cmd->se_sess->se_node_acl->initiatorname,
+				     cmd->t_task_cdb[0]);
 	if (ret)
 		return ret;
 
-- 
2.33.0

