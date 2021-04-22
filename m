Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68628368402
	for <lists+target-devel@lfdr.de>; Thu, 22 Apr 2021 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhDVPoe (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 22 Apr 2021 11:44:34 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58256 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238547AbhDVPnF (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:43:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9F8C7413F6;
        Thu, 22 Apr 2021 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1619106147; x=
        1620920548; bh=Q90boRhCEYzbIaV+UraTatNsUvrTGS7p7EZog7TKZdI=; b=B
        sxlskXyGN2ZRVtaBiHbFArjbGjSPkYw+TmWBN0XeB43BNpEObGM5KjjgFYSBZKHe
        5atHT/lNlZLAKdeoO9oYkAdrqMx/VPl/mddBNw9az9CpwFfz/FQMXxAuOIkenR6s
        00vEMxVqV9R91jHsTMRGZfwgcg7J7w6RkaQGzAMj5A=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uAsv5-34Ivna; Thu, 22 Apr 2021 18:42:27 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 67BB241580;
        Thu, 22 Apr 2021 18:34:34 +0300 (MSK)
Received: from localhost (172.17.204.113) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 22
 Apr 2021 18:34:34 +0300
From:   Anastasia Kovaleva <a.kovaleva@yadro.com>
To:     <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Anastasia Kovaleva <a.kovaleva@yadro.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH] scsi: qla2xxx: Prevent PRLI in target mode
Date:   Thu, 22 Apr 2021 18:34:14 +0300
Message-ID: <20210422153414.4022-1-a.kovaleva@yadro.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.113]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

In a case when the initiator in P2P mode by some circumstances do not
send PRLI, the target, in a case when the target port’s WWPN is less
than initiator’s one, changes the discovery state in DSC_GNL, and when
gnl completes, it sends PRLI to the initiator.

Usually the initiator in P2P mode always sends PRLI. We catch this issue
on Linux stable v5.4.6 https://www.spinics.net/lists/stable/msg458515.html

The change fixes this particular corner case in the behaviour of the
P2P mod target login state machine.

Fixes: a9ed06d4e640a ("scsi: qla2xxx: Allow PLOGI in target mode")
Signed-off-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index f01f07116bd3..71f79c988fdc 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1194,6 +1194,9 @@ static int qla24xx_post_prli_work(struct scsi_qla_host *vha, fc_port_t *fcport)
 {
 	struct qla_work_evt *e;
 
+	if (vha->host->active_mode == MODE_TARGET)
+                return QLA_FUNCTION_FAILED;
+
 	e = qla2x00_alloc_work(vha, QLA_EVT_PRLI);
 	if (!e)
 		return QLA_FUNCTION_FAILED;
-- 
2.30.2

