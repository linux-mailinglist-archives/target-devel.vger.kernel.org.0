Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6933EE96
	for <lists+target-devel@lfdr.de>; Wed, 17 Mar 2021 11:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCQKqj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 17 Mar 2021 06:46:39 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48226 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229943AbhCQKqb (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:46:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 0A0A7412C6;
        Wed, 17 Mar 2021 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1615977989; x=
        1617792390; bh=nb8csPQ8iMIogmDOGg3leOgLRI4ytO+5nOwpnQObBK4=; b=r
        Zgs7ykBUep0P4x9Cg3UpF6HZWc1S5abPCGLVS1dnrC1hS45GWI7SPOxzfJk+WbNO
        mjzeTPpAHw3sqErnFTBYCk66cJdIr6XDQqJecLQTJZx9NTpqWyedvPAU/3w3RefY
        BQTfchYwBxDKpeYO7XbEQlT3tr8mga889bkwzc4aZ8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j4kdlqFoviTy; Wed, 17 Mar 2021 13:46:29 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 53B314124F;
        Wed, 17 Mar 2021 13:46:27 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.0.54) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 17
 Mar 2021 13:46:27 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Nilesh Javali <njavali@marvell.com>,
        Chris Boot <bootc@bootc.net>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH 0/4] target: make tpg/enable attribute
Date:   Wed, 17 Mar 2021 13:46:05 +0300
Message-ID: <20210317104609.25236-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.54]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

All target transport drivers have its own 'tpg/enable' attribute
implementation. This produces unnecessary code duplication.
Also it makes difficult to control that attribute and to depend on that
attribute inside of target core module.

Replace tpg/enable attribute implementation of each transport to a
common implementation for all transports. Move enabling target logic to
a new fabric_ops callback.

This patchset is intended for scsi-queue.

Dmitry Bogdanov (4):
  target: core: add common tpg/enable attribute
  target: iscsi: replace enable attr to ops.enable
  target: qla2xx: replace enable attr to ops.enable
  target: sbp: replace enable attr to ops.enable

 drivers/scsi/qla2xxx/tcm_qla2xxx.c           | 73 +++-------------
 drivers/target/iscsi/iscsi_target_configfs.c | 91 +++++++-------------
 drivers/target/sbp/sbp_target.c              | 30 ++-----
 drivers/target/target_core_configfs.c        |  1 +
 drivers/target/target_core_fabric_configfs.c | 38 +++++++-
 drivers/target/target_core_internal.h        |  1 +
 drivers/target/target_core_tpg.c             | 42 +++++++++
 include/target/target_core_base.h            |  1 +
 include/target/target_core_fabric.h          |  1 +
 9 files changed, 129 insertions(+), 147 deletions(-)

-- 
2.25.1

