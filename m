Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC0340255
	for <lists+target-devel@lfdr.de>; Thu, 18 Mar 2021 10:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCRJqz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 18 Mar 2021 05:46:55 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58580 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229785AbhCRJqd (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:46:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3FE0C4139D;
        Thu, 18 Mar 2021 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1616060791; x=
        1617875192; bh=zfdGDthEaEk9NA6wBLkTzRGaAS3tetMN4i7pXY6/qUk=; b=K
        79Q1qdjdWQxz/yWV0sTdZFHYDDZs6mpYH3z9Ak2KR+jj+H92eqdGxWbUPWPYYTMs
        KEG0HxPqFUwwLmaJTCPyZH1WRdP6tPyJYlauQ2beNNES6+CIYIU3G+o1oBJ8MNSK
        y3hyZdfVU1+4ClVbIxauQvMlYwfLMNvxTeNIe9HV04=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7vZpPoDFbtM1; Thu, 18 Mar 2021 12:46:31 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 66A2941308;
        Thu, 18 Mar 2021 12:44:17 +0300 (MSK)
Received: from yadro.com (10.199.0.137) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 18
 Mar 2021 12:44:17 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux@yadro.com>, <linux-scsi@vger.kernel.org>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>
Subject: [PATCH 0/2] target: Introduce dummy devices
Date:   Thu, 18 Mar 2021 12:42:23 +0300
Message-ID: <20210318094224.17524-1-k.shelekhin@yadro.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.137]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch series (inspired by SCST) adds support for the dummy devices
via the new DUMMY flag of rd_mcp. The rationale behind the change is to
give a user the ability to create conifgurable devices for LUN 0 with
custom WWN values (like vendor, product or revision) as some tools like
QConvergeGUI use LUN 0 to identify the whole storage.

The advantage over simply creating a NULLIO rd_mcp device is that the
DUMMY device will not be seen as a block device, hence less confusion
for the system administrator.

Konstantin Shelekhin (2):
  target: Add the DUMMY flag to rd_mcp
  target: Make the virtual LUN 0 device dummy

 drivers/target/target_core_device.c |  2 +-
 drivers/target/target_core_rd.c     | 27 +++++++++++++++++++++++----
 drivers/target/target_core_rd.h     |  1 +
 drivers/target/target_core_spc.c    |  6 +-----
 4 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.30.2

