Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0643F483B4
	for <lists+target-devel@lfdr.de>; Mon, 17 Jun 2019 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFQNR6 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 17 Jun 2019 09:17:58 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:28441 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNR6 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:17:58 -0400
Received: from fcoe-test11.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x5HDHpv8018550;
        Mon, 17 Jun 2019 06:17:52 -0700
From:   Varun Prakash <varun@chelsio.com>
To:     martin.petersen@oracle.com
Cc:     target-devel@vger.kernel.org, dt@chelsio.com, indranil@chelsio.com,
        ganji.aravind@chelsio.com, varun@chelsio.com
Subject: [PATCH] scsi: target: cxgbit: add support for IEEE_8021QAZ_APP_SEL_STREAM selector
Date:   Mon, 17 Jun 2019 18:47:45 +0530
Message-Id: <1560777465-5343-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

IEEE_8021QAZ_APP_SEL_STREAM is a valid selector
for iSCSI connections, so add code to use
IEEE_8021QAZ_APP_SEL_STREAM selector to get priority
mask.

Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c   | 8 +++++---
 drivers/target/iscsi/cxgbit/cxgbit_main.c | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index dab09b6..9d0ed93 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -878,10 +878,12 @@ static u8 cxgbit_get_iscsi_dcb_priority(struct net_device *ndev, u16 local_port)
 		return 0;
 
 	if (caps & DCB_CAP_DCBX_VER_IEEE) {
-		iscsi_dcb_app.selector = IEEE_8021QAZ_APP_SEL_ANY;
-
+		iscsi_dcb_app.selector = IEEE_8021QAZ_APP_SEL_STREAM;
 		ret = dcb_ieee_getapp_mask(ndev, &iscsi_dcb_app);
-
+		if (!ret) {
+			iscsi_dcb_app.selector = IEEE_8021QAZ_APP_SEL_ANY;
+			ret = dcb_ieee_getapp_mask(ndev, &iscsi_dcb_app);
+		}
 	} else if (caps & DCB_CAP_DCBX_VER_CEE) {
 		iscsi_dcb_app.selector = DCB_APP_IDTYPE_PORTNUM;
 
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_main.c b/drivers/target/iscsi/cxgbit/cxgbit_main.c
index 4a7bb0b..4cd63c0 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_main.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_main.c
@@ -592,7 +592,8 @@ static void cxgbit_dcb_workfn(struct work_struct *work)
 	iscsi_app = &dcb_work->dcb_app;
 
 	if (iscsi_app->dcbx & DCB_CAP_DCBX_VER_IEEE) {
-		if (iscsi_app->app.selector != IEEE_8021QAZ_APP_SEL_ANY)
+		if ((iscsi_app->app.selector != IEEE_8021QAZ_APP_SEL_STREAM) &&
+		    (iscsi_app->app.selector != IEEE_8021QAZ_APP_SEL_ANY))
 			goto out;
 
 		priority = iscsi_app->app.priority;
-- 
2.0.2

