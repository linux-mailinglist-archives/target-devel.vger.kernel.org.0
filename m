Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C53DAD65
	for <lists+target-devel@lfdr.de>; Thu, 29 Jul 2021 22:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhG2UU1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Jul 2021 16:20:27 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:43090 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232774AbhG2UU1 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Jul 2021 16:20:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 473D449DDB;
        Thu, 29 Jul 2021 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1627590021; x=
        1629404422; bh=264q3juc5c+xcvudWMSPkXSYtyd9EeVrunW03hXbCHY=; b=t
        E5ZcR7PbMkCP53Pn8eYHyqoW+fkmXLNbBhv9qJ9xXeVP03KQBpm7uSCU84mRgA0d
        FibnREUrulFMf+weEsrk2yExaxpgzQRHbVKzMk+QboXehK+u0yPtb/mIU1jOBgZB
        JCQtbluaq+JKCC+oOpHHrWiBIUWOKozur0W227ey/g=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FnDG4HKDA1U2; Thu, 29 Jul 2021 23:20:21 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1779549DD9;
        Thu, 29 Jul 2021 23:20:20 +0300 (MSK)
Received: from yadro.com (10.199.0.12) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 29
 Jul 2021 23:20:19 +0300
From:   Sergey Samoylenko <s.samoylenko@yadro.com>
To:     <martin.petersen@oracle.com>, <michael.christie@oracle.com>,
        <ddiss@suse.de>, <bvanassche@acm.org>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Sergey Samoylenko <s.samoylenko@yadro.com>
Subject: [PATCH 0/1] scsi: target: core: Add 8Fh VPD page
Date:   Thu, 29 Jul 2021 23:19:42 +0300
Message-ID: <20210729201943.40222-1-s.samoylenko@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.12]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Continuing to cover the TCM copy manager with tests, there was
a need for the Third-party Copy VPD page.

Sergey Samoylenko (1):
  scsi: target: core: Add 8Fh VPD page

 drivers/target/target_core_spc.c | 230 ++++++++++++++++++++++++++++++-
 1 file changed, 226 insertions(+), 4 deletions(-)

-- 
2.25.1

