Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8631496D
	for <lists+target-devel@lfdr.de>; Tue,  9 Feb 2021 08:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBIHYF (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 9 Feb 2021 02:24:05 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:37958 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhBIHYE (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:24:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2FB554127D;
        Tue,  9 Feb 2021 07:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :reply-to:x-mailer:message-id:date:date:subject:subject:from
        :from:received:received:received; s=mta-01; t=1612855401; x=
        1614669802; bh=qQQZD4iqUtJxcZcTg/ZAINrd4STV2CdqUy7qW/C3AWE=; b=p
        I9y6wReOJuw7+lVgWPs5ovJJ94jBwrZXHq4o5FnudBJlPoj3TaYODGDx0HVq9Mrt
        NZjk/XVr6CKEn2aMeTmTc5xq0AY1hd0ZPadZ3OSyBA/5rFb/PPWuKllCMe8zVq07
        1En8V5Yobh093+Nk3Cgfyyj9qmiz38A6W5m20aTEdo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fQl97Kk4JI2y; Tue,  9 Feb 2021 10:23:21 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0DFD541278;
        Tue,  9 Feb 2021 10:23:21 +0300 (MSK)
Received: from localhost (10.199.0.114) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 9 Feb
 2021 10:23:21 +0300
From:   Aleksandr Miloserdov <a.miloserdov@yadro.com>
To:     <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <r.bolshakov@yadro.com>,
        Aleksandr Miloserdov <a.miloserdov@yadro.com>
Subject: [PATCH 0/2] Fix target not properly truncating command data length
Date:   Tue, 9 Feb 2021 10:22:00 +0300
Message-ID: <20210209072202.41154-1-a.miloserdov@yadro.com>
X-Mailer: git-send-email 2.28.0
Reply-To: <a.miloserdov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.114]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

SPC-5 (4.2.5.6 Allocation length) requires to terminate transfers to the
Data In Buffer when the number of bytes or blocks specified by the
ALLOCATION LENGTH field have been transferred or when all available data
have been transferred, whichever is less.

PERSISTENT RESERVE IN service actions in TCM don't follow the clause and
return ALLOCATION LENGTH of data, even if actual number of data in reply
is less (e.g. there are no reservation keys).

That causes an underflow and a failure in libiscsi PrinReadKeys.Simple
that expects Data In Buffer size equal to ADDITIONAL LENGTH + 8.

This patch series fixes this behavior.
It is intended for 5.11/scsi-queue branch.

Aleksandr Miloserdov (2):
  scsi: target: core: Add cmd length set before cmd complete
  scsi: target: core: Prevent underflow for service actions

 drivers/target/target_core_pr.c        |  6 ++++++
 drivers/target/target_core_transport.c | 15 +++++++++++----
 include/target/target_core_backend.h   |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.26.2

