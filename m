Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDA957817D
	for <lists+target-devel@lfdr.de>; Mon, 18 Jul 2022 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiGRMDO (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 18 Jul 2022 08:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiGRMDN (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:03:13 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FB1237FD;
        Mon, 18 Jul 2022 05:03:11 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6481541284;
        Mon, 18 Jul 2022 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1658145789; x=
        1659960190; bh=3RtAP2ozx5tUHCqj+o/n4riMN0u+CSxclP4ClJMAGUo=; b=u
        IkOXEkIJqvLZ3vqjzKhtAvJBH9qY1CKGPbeiORFvBnBr3/SRGWXDx82LuVNKT5lt
        /eK+28MeSsElh1SoHwZYIZoGqyGQtSdCowd+4+ZSaUGtquxq9lNRyWqkqJS/c/6F
        GQUtoP3wz9xn8pKtZG1pGb3v1SLbBCc3z3RjG/qsvA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IylcVhPUe7IW; Mon, 18 Jul 2022 15:03:09 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4F64E41237;
        Mon, 18 Jul 2022 15:03:07 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 18 Jul 2022 15:03:07 +0300
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Mon, 18 Jul 2022 15:03:06 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH 0/6] add support of RSOC command
Date:   Mon, 18 Jul 2022 15:01:11 +0300
Message-ID: <20220718120117.4435-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patchset is based on 5.20/scsi-queue.

The patchset adds support of REPORT SUPPORTED OPERATION CODES command
according to SPC4. Including CDB USAGE DATA and timeout descriptors.
Timeout descriptors are zeroed currently, meaning that no time is
indicated, but an encoding of it there is.
Opcode support and Usage Data is dynamically generated.
libiscsi tests for RSOC and tests that uses RSOC command are all PASSED.


Dmitry Bogdanov (6):
  scsi: target: core: add support of RSOC command
  scsi: target: core: add list of opcodes for RSOC
  scsi: target: core: dynamic opcode support in RSOC
  scsi: target: core: add emulate_rsoc attribute
  scsi: target: core: dynamicaly set dpofua in usage_bits
  scsi: target: check emulate_3pc for RECEIVE COPY

 drivers/target/target_core_configfs.c |  20 +
 drivers/target/target_core_device.c   |   1 +
 drivers/target/target_core_spc.c      | 947 ++++++++++++++++++++++++++
 drivers/target/target_core_xcopy.c    |   6 +
 include/scsi/scsi_proto.h             |  10 +
 include/target/target_core_base.h     |  18 +
 6 files changed, 1002 insertions(+)

-- 
2.25.1

