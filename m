Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C153270E3
	for <lists+target-devel@lfdr.de>; Sun, 28 Feb 2021 06:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhB1F7a (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 28 Feb 2021 00:59:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6288 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhB1F73 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 28 Feb 2021 00:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614491969; x=1646027969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ggGVfWhUsAWpR7HSNj5OQYt9h5d0O6rKV8fQJdazerE=;
  b=lioYjNoLMs25H2k5l5KJoaBDpPDaSfM9o68S4w8nMAb6Mv9AyjduNxzg
   ACtmCR6pUVPwlajK84e7qiWwsjR27Llnbvbf84RrPcdD0M+JTYuXADNs4
   34GId1h9LIEc21apWXTkjpAgDSmhvdlcc0Vz2I3JM3lxPOnO+jN9q0kHE
   2EVS/kLT71er8omNAZZwIF3NBmlPzLIzeCKdguRUrTMSMgVJIeZ3AGuDJ
   SkAqQ1AGmNxwNASeimgKeQ5+rXUPewwm3DdaNoQDF3rxfyrPTXkPwB8yM
   t0xsL/bHyxB96cwFOx9Bbt8r4dsHZNtl9bB18w4uIEMoBfnxdSdXBb357
   g==;
IronPort-SDR: BSo9/aigVaLyJUgLlOv9HUaSBHGWxQF+YcD6Qz744J6mg1klXrMXLkgz6DYNRB3VB2wxmoBz0T
 kaIERH8q8sCUpA1Zv3Fr3o3GX4bAZmblUjfkvwt/+nvKBy1g5bh+BoLwBcdlQdPmoYIXSu0YHF
 lVXKBNfxM5JL0U3w+FopcPxKmeMazhXzOb43pvAzk7a9e4wAzLpRQ39wyCfxoENSIe5ZxZqZDR
 F5bPcoEPEswpolHLos76dxW3tfawTQRoO4aRRKU0COl5PSExVxL/eb7WPUUD+MwUaqoDaJsoiz
 toM=
X-IronPort-AV: E=Sophos;i="5.81,211,1610380800"; 
   d="scan'208";a="165466155"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2021 13:58:23 +0800
IronPort-SDR: AlfMhnUBDEtnNvoDY4/klQfnDpuKFw6Vzr93fVyGjyHMNhbedlt0ilp5SWQRvt6M6tv9B7QL6z
 Aq+Zc1L8mCx5VAM5Rfks07DQG5rnnaoBiI8WvnOo/FFYIfHDKodWeGj/IhTU+ayUb7Hh8Vn/+X
 rBV+P9xattpBtoPI2MABjCrV7rIHXIUCAnFl2bRVeg9Of+jKbyGzCKMlt05KB+UDoi9B8arY26
 dMPaeKImv6KEKAB5djc+GY7mOQagwe/cSnMozUFN75FIPrGzTIknaj5g8H80PDcF4pZDHgWFIk
 GBWwLITwjqhVee0PtEahOj44
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 21:41:33 -0800
IronPort-SDR: Pk0drcTuIsNgzB7Y5pRnML6EjQW+I+8odG3oGhfM7uUPu++ndvmrOHa+wsGsSVN32moqqk/VrK
 6d9DUW6EwJnX4auBn1EQovCqZQY2p662U1DWCdyXcHBV1zEZZzqKFFUQrlMRG0Aqm554aMs66H
 hAP1/6p9dBykrRnTN+g7ZjyZSE/bGlTRGadltwerI5OqvnNCjNN9tOzyqoHGPaSRElSx1H33cq
 EWA42u09nW6fOyYfsy5olrzPyHTlp/MPmbhr2RdCzc+KQDEycTC8pTiVEu/uF18LBFXtagU3Tv
 Y+o=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Feb 2021 21:58:23 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, hare@suse.de, jejb@linux.ibm.com,
        mlombard@redhat.com, michael.christie@oracle.com,
        bvanassche@acm.org, houpu@bytedance.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 09/23] target/stat: remove unsed macro
Date:   Sat, 27 Feb 2021 21:56:31 -0800
Message-Id: <20210228055645.22253-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210228055645.22253-1-chaitanya.kulkarni@wdc.com>
References: <20210228055645.22253-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Remove the unused macro that fixes the following compilation warning:-

drivers/target//iscsi/iscsi_target_stat.c:31: warning: macro "ISCSI_INST_LAST_FAILURE_TYPE" is not used [-Wunused-macros]
#define ISCSI_INST_LAST_FAILURE_TYPE 0

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/target/iscsi/iscsi_target_stat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_stat.c b/drivers/target/iscsi/iscsi_target_stat.c
index 35e75a3569c9..cce3a827059e 100644
--- a/drivers/target/iscsi/iscsi_target_stat.c
+++ b/drivers/target/iscsi/iscsi_target_stat.c
@@ -28,7 +28,6 @@
 /* Instance Attributes Table */
 #define ISCSI_INST_NUM_NODES		1
 #define ISCSI_INST_DESCR		"Storage Engine Target"
-#define ISCSI_INST_LAST_FAILURE_TYPE	0
 #define ISCSI_DISCONTINUITY_TIME	0
 
 #define ISCSI_NODE_INDEX		1
-- 
2.22.1

