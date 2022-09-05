Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06A85AD87F
	for <lists+target-devel@lfdr.de>; Mon,  5 Sep 2022 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiIERjz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 5 Sep 2022 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiIERju (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:39:50 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CDB17065;
        Mon,  5 Sep 2022 10:39:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D923043B40;
        Mon,  5 Sep 2022 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1662399580; x=1664213981; bh=KJl9Kngx6X1aSopZqjGynBC+O
        3HuaZxcJd7UAdouV44=; b=mmrE3sOYU9y2QVtmWpnGNdSeV1ysXgISM8RAD9kGN
        UvtMXAMJHVq/G73oFSKYaorX0bI6EVgNNGO7BIpf2U1KX7xEClFhh3Eoflf4LDwt
        TfCTxRVWXPTNXE5dVip0QqVF+Ll7KnacP4ORVus/0VdPvaeOZoyOYhyzkcqG2KzP
        yk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jmIr7_Fhz-t5; Mon,  5 Sep 2022 20:39:40 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id DEDA843B57;
        Mon,  5 Sep 2022 20:38:49 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 5 Sep 2022 20:38:47 +0300
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Mon, 5 Sep 2022 20:38:46 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Mike Christie <michael.christie@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v2 5/6] scsi: target: check emulate_3pc for RECEIVE COPY
Date:   Fri, 19 Feb 2021 18:06:50 +0300
Message-ID: <20220905173837.2383-6-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905173837.2383-1-d.bogdanov@yadro.com>
References: <20220905173837.2383-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

RECEIVE COPY RESULTS is an opcode from 3rd party copy command set and
shall be rejected if emulate_3pc attribute is off like EXTENDED COPY

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/target_core_xcopy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index 8713cda0c2fb..edf522208285 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -1009,8 +1009,14 @@ sense_reason_t target_do_receive_copy_results(struct se_cmd *se_cmd)
 {
 	unsigned char *cdb = &se_cmd->t_task_cdb[0];
 	int sa = (cdb[1] & 0x1f), list_id = cdb[2];
+	struct se_device *dev = se_cmd->se_dev;
 	sense_reason_t rc = TCM_NO_SENSE;
 
+	if (!dev->dev_attrib.emulate_3pc) {
+		pr_debug("Third-party copy operations explicitly disabled\n");
+		return TCM_UNSUPPORTED_SCSI_OPCODE;
+	}
+
 	pr_debug("Entering target_do_receive_copy_results: SA: 0x%02x, List ID:"
 		" 0x%02x, AL: %u\n", sa, list_id, se_cmd->data_length);
 
-- 
2.25.1

