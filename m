Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB68365FAA
	for <lists+target-devel@lfdr.de>; Tue, 20 Apr 2021 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhDTSqr (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 20 Apr 2021 14:46:47 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52488 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233498AbhDTSqr (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:46:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7934741399;
        Tue, 20 Apr 2021 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1618944373; x=
        1620758774; bh=mBFonvNyfhwXdP0YxwKa9464TvbOOHPM9Cs3w/vkPaU=; b=T
        fDhS4qyQvsiYCTsAkAgtVpDQvagJY1oW9oDUZd9LpHC7KpHAPC1fMEZh/g+CMcX6
        +mn9Bbu3aspqfeGMV0oGisBxwFFLHJxDEnJOLF6DLMM4gmoTIVCAvCMyTcjtCRXV
        79UYsf6Rs5V7xZlfQxmXQKG6hy5HnAodzzNS+J0+hM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ofo1oWfrbc5K; Tue, 20 Apr 2021 21:46:13 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 770DC41312;
        Tue, 20 Apr 2021 21:46:13 +0300 (MSK)
Received: from yadro.com (10.199.0.227) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 20
 Apr 2021 21:46:12 +0300
From:   Sergey Samoylenko <s.samoylenko@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     David Disseldorp <ddiss@suse.de>,
        Sergey Samoylenko <s.samoylenko@yadro.com>
Subject: [PATCH 0/2] scsi: target: user configurable IEEE Company ID
Date:   Tue, 20 Apr 2021 21:44:04 +0300
Message-ID: <20210420184406.42127-1-s.samoylenko@yadro.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.227]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The series allows to change IEEE Company ID component
of NAA LUN identifier returned on the SCSI INQUIRY VPD
page (aka WWID). Company ID can be changed via the
target/core/$backstore/$name/wwn/company_id ConfigFS path.

Sergey Samoylenko (2):
  scsi: target: core: Unify NAA identifer generation
  scsi: target: core: Add IEEE Company ID attribute

 drivers/target/target_core_configfs.c | 50 +++++++++++++++++++++++++++
 drivers/target/target_core_device.c   |  5 +++
 drivers/target/target_core_pr.h       |  2 +-
 drivers/target/target_core_spc.c      | 47 ++++++++++++-------------
 drivers/target/target_core_xcopy.c    | 17 ++-------
 include/target/target_core_base.h     |  1 +
 6 files changed, 82 insertions(+), 40 deletions(-)

-- 
2.27.0

