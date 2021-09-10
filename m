Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73326406899
	for <lists+target-devel@lfdr.de>; Fri, 10 Sep 2021 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhIJIm4 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 10 Sep 2021 04:42:56 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53566 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231731AbhIJImz (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:42:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 51E304CF5C;
        Fri, 10 Sep 2021 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1631263302; x=
        1633077703; bh=sEqhaX9n4ptRZwQ08tVj41Rn6rCSDvytm6JwP1gdvQs=; b=T
        4ZWz5sWjVjI0jTdLsMcnC1DKtocvRP/wLxvR+VoEVPJPYqyQ+1CRyXIlXghxg6Z0
        qW0XaPWd/nESYzZhD6p9Y3l5yOXsPH0aSc6MThgBZNsRohER6HesYhw1C4hYWaJU
        ebnaWtAsg4R85aNFrc/P1jOWvwtnnpNHKYRGjbIpEk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0owPTN5rMMBw; Fri, 10 Sep 2021 11:41:42 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2944B4B951;
        Fri, 10 Sep 2021 11:41:40 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.0.141) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 10 Sep 2021 11:41:40 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Nilesh Javali <njavali@marvell.com>,
        Chris Boot <bootc@bootc.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitriy Bogdanov <d.bogdanov@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v5 0/7] target: make tpg/enable attribute
Date:   Fri, 10 Sep 2021 11:41:26 +0300
Message-ID: <20210910084133.17956-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.141]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Many fabric modules provide their own implementation of enable
attribute in tpg.
The change set removes the code duplication and automatically adds
"enable" attribute for fabric modules that has an implementation of
fabric_enable_tpg() ops.

This patchset is intended for scsi-queue.

v5:
 rebase on 5.15/scsi-queue
v4:
 fix compilation error and warning
v3:
 refactor tfc_tpg_base_attrs creation
 avoid alloc of attrs if there are no attributes
 fix newlines
 move enable attribute to target_core_fabric_configfs.c
v2:
 create enable atribute only for modules with enable_tpg ops
 add patches for srpt, usb and ibmvscsi

Dmitry Bogdanov (7):
  target: core: add common tpg/enable attribute
  target: iscsi: replace enable attr to ops.enable
  target: qla2xx: replace enable attr to ops.enable
  target: sbp: replace enable attr to ops.enable
  target: srpt replace enable attr to ops.enable
  target: ibm_vscsi: replace enable attr to ops.enable
  target: usb: replace enable attr to ops.enable

 drivers/infiniband/ulp/srpt/ib_srpt.c        | 38 +-------
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c     | 42 +--------
 drivers/scsi/qla2xxx/tcm_qla2xxx.c           | 73 +++-------------
 drivers/target/iscsi/iscsi_target_configfs.c | 91 +++++++-------------
 drivers/target/sbp/sbp_target.c              | 30 ++-----
 drivers/target/target_core_configfs.c        |  1 +
 drivers/target/target_core_fabric_configfs.c | 78 ++++++++++++++++-
 drivers/usb/gadget/function/f_tcm.c          | 31 ++-----
 include/target/target_core_base.h            |  1 +
 include/target/target_core_fabric.h          |  1 +
 10 files changed, 142 insertions(+), 244 deletions(-)

-- 
2.25.1

