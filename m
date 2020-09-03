Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF7F25C073
	for <lists+target-devel@lfdr.de>; Thu,  3 Sep 2020 13:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgICLht (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Sep 2020 07:37:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728716AbgICLhg (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:37:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0AF79D883C5C254F01E4;
        Thu,  3 Sep 2020 19:37:03 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 19:36:54 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] scsi: target: tcmu: add a missing newline when printing parameters
Date:   Thu, 3 Sep 2020 19:29:33 +0800
Message-ID: <1599132573-33818-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

When I cat module paramter 'global_max_data_area_mb' by sysfs, it
displays as follows. It's better to add a newline for easy reading.

root@(none):/# cat /sys/module/target_core_user/parameters/global_max_data_area_mb
2048noneroot@(none):/#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/target/target_core_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 9b75923..9775670 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -242,7 +242,7 @@ static int tcmu_set_global_max_data_area(const char *str,
 static int tcmu_get_global_max_data_area(char *buffer,
 					 const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%d", TCMU_BLOCKS_TO_MBS(tcmu_global_max_blocks));
+	return sprintf(buffer, "%d\n", TCMU_BLOCKS_TO_MBS(tcmu_global_max_blocks));
 }
 
 static const struct kernel_param_ops tcmu_global_max_data_area_op = {
-- 
1.7.12.4

