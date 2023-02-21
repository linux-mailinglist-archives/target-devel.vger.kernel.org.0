Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3BE69E431
	for <lists+target-devel@lfdr.de>; Tue, 21 Feb 2023 17:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjBUQGj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 21 Feb 2023 11:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjBUQGi (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:06:38 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7CF2A9BA;
        Tue, 21 Feb 2023 08:06:36 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 60D8134202F;
        Tue, 21 Feb 2023 19:06:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:message-id:mime-version:reply-to:subject:subject:to
        :to; s=mta-01; bh=gETuOkhfbsraKCtj4kbqFI5ognR3HP+lSM9kNnXI5CU=; b=
        Knp/WYVllEkEV7acolCAiOx+jnzE2JHPmu3Djj6xdBSNZVMSxpRq/j4l/dt2Rqw+
        Zunt86y4vO8ybSwt47Z2q1XEDVRNED4gnuWUxC+NBxolu+DoYnytwIXZUDU7l/0L
        qjGqtYZktmOgshbxa0x16U7ZeK7BTlBAukl6+I3tgFQ=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 56C2E342024;
        Tue, 21 Feb 2023 19:06:34 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.178.114.42) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Tue, 21 Feb 2023 19:06:33 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Mike Christie <michael.christie@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH v4 0/5] scsi: target: make RTPI an TPG identifier
Date:   Tue, 21 Feb 2023 19:06:18 +0300
Message-ID: <20230221160622.7283-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.114.42]
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

The patchset based on 6.3/scsi-queue.

SAM-5 4.6.5.2 (Relative Port Identifier attribute) defines the attribute
as unique across SCSI target ports:
 The Relative Port Identifier attribute identifies a SCSI target port or
 a SCSI initiator port relative to other SCSI ports in a SCSI target
 device and any SCSI initiator devices contained within that SCSI target
 device. A SCSI target device may assign relative port identifiers to
 its SCSI target ports and any SCSI initiator ports. If relative port
 identifiers are assigned, the SCSI target device shall assign each of
 its SCSI target ports and any SCSI initiator ports a unique relative
 port identifier from 1 to 65 535. SCSI target ports and SCSI initiator
 ports share the same number space.

In the current TCM implementation, auto-incremented lun_rtpi weakly
follows the model outlined by SAM-5 and SPC-4. In case of multiple SCSI
target ports (se_portal_group's), which is common to scenario with
multiple HBAs or multiple iSCSI/FC targets, it's possible to have two
backstores (se_device's) with different values of lun_rtpi on the same
SCSI target port.

Similar issue happens during re-export. If a LUN of a backstore is
removed from a target port and added again to the same target port, RTPI
is incremented again and will be different from the first time.

The two issues happen because each se_device increments RTPI for its own
LUNs independently.

The behaviour means that a SCSI application client can't reliably make any
sense of RTPI values reported by a LUN as it's not really related to SCSI
target ports. A conforming target implementation must ensure that RTPI field is
unique per port. The patchset resolves the issue.

Make RTPI be part of se_tpg instead of se_lun. Make it configurable.

Changelog:
  v4:
    move rtpi file from tpg_n/attrib to tpgt_n folder (drop 4th patch)
    use unused variable
    make se_tpg.tpg_rtpi variable u16 again
    revert occasional rename

  v3:
    make variable static
    change core_ prefix to target_
    split to tpg_enable/tpg_disable functions

  v2:
    use XArray for tracking RTPI instead of linked list
    do not allow to change RTPI on enabled target port
    drop not needed patches


Dmitry Bogdanov (2):
  scsi: target: core: Add RTPI field to target port
  scsi: target: core: Add RTPI attribute for target port

Roman Bolshakov (2):
  scsi: target: core: Use RTPI from target port
  scsi: target: core: Drop device-based RTPI

 drivers/target/target_core_alua.c            |  4 +-
 drivers/target/target_core_device.c          | 43 +-----------
 drivers/target/target_core_fabric_configfs.c | 44 ++++++++++--
 drivers/target/target_core_internal.h        |  3 +-
 drivers/target/target_core_pr.c              |  8 +--
 drivers/target/target_core_spc.c             |  2 +-
 drivers/target/target_core_stat.c            |  6 +-
 drivers/target/target_core_tpg.c             | 71 ++++++++++++++++++--
 include/target/target_core_base.h            |  7 +-
 9 files changed, 120 insertions(+), 68 deletions(-)

-- 
2.25.1


