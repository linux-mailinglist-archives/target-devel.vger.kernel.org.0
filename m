Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E580219F27
	for <lists+target-devel@lfdr.de>; Thu,  9 Jul 2020 13:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgGILgj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 9 Jul 2020 07:36:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgGILgj (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:36:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9D89CF2C295F624CC59B;
        Thu,  9 Jul 2020 19:36:36 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Jul 2020 19:36:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>
Subject: [PATCH -next] scsi: target: Remove unused variable 'tpg'
Date:   Thu, 9 Jul 2020 19:46:36 +0800
Message-ID: <20200709114636.69256-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Gcc report warning as follows:

drivers/target/target_core_pr.c:1162:26: warning:
 variable 'tpg' set but not used [-Wunused-but-set-variable]
 1162 |  struct se_portal_group *tpg;
      |                          ^~~

After commit 63c9ffe473d3 ("scsi: target: Check enforce_pr_isids
during registration"), 'tpg' is never used, so removing it to
avoid build warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/target/target_core_pr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 300b03b1b696..8fc88654bff6 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -1159,7 +1159,6 @@ static struct t10_pr_registration *__core_scsi3_locate_pr_reg(
 {
 	struct t10_reservation *pr_tmpl = &dev->t10_pr;
 	struct t10_pr_registration *pr_reg, *pr_reg_tmp;
-	struct se_portal_group *tpg;
 
 	spin_lock(&pr_tmpl->registration_lock);
 	list_for_each_entry_safe(pr_reg, pr_reg_tmp,
@@ -1170,7 +1169,6 @@ static struct t10_pr_registration *__core_scsi3_locate_pr_reg(
 		if (pr_reg->pr_reg_nacl != nacl)
 			continue;
 
-		tpg = pr_reg->pr_reg_nacl->se_tpg;
 		/*
 		 * If this registration does NOT contain a fabric provided
 		 * ISID, then we have found a match.

