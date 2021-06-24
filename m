Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720473B2DB1
	for <lists+target-devel@lfdr.de>; Thu, 24 Jun 2021 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhFXLWs (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Jun 2021 07:22:48 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42262 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232313AbhFXLWr (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:22:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A77AC42C03;
        Thu, 24 Jun 2021 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1624533625; x=
        1626348026; bh=rT4QfqzpJTO57Ycb+gh1lMUeYHUIKC6bJPVUHUTTyEM=; b=Y
        TsxhqfyyeDzEshlPRLNkp45xhmn96HEWBVARbDJRcOGYmj1M2DxsLCWu93Q2EW7m
        tIm553CWVydfN4KrUdJlKXYqkN5a9ECZCZ4k08WFSjrw+8zSovnVrLXF9gsv4Xww
        3zAhmh9dhEqKyJhfHfnvAnyWS1Fh8tlIayNdr201nI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tKFuRvEQ0fZj; Thu, 24 Jun 2021 14:20:25 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A7AC542A83;
        Thu, 24 Jun 2021 14:20:25 +0300 (MSK)
Received: from yadro.com (10.199.0.253) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Jun 2021 14:20:24 +0300
From:   Sergey Samoylenko <s.samoylenko@yadro.com>
To:     <martin.petersen@oracle.com>, <michael.christie@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Sergey Samoylenko <s.samoylenko@yadro.com>
Subject: [PATCH 0/1] scsi: target: core: Fix sense key for invalid XCOPY request
Date:   Thu, 24 Jun 2021 14:19:25 +0300
Message-ID: <20210624111926.63176-1-s.samoylenko@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.253]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

EXTENDED COPY tests in libiscsi [1] show that TCM doesn't
follow SPC4 when detects invalid parameters in a XCOPY
command or IO errors. The replies from TCM contain wrong sense
key or ASCQ for incorrect request.

The series fixes the following tests from libiscsi:

  SCSI.ExtendedCopy.DescrType
  SCSI.ExtendedCopy.DescrLimits
  SCSI.ExtendedCopy.ParamHdr
  SCSI.ExtendedCopy.ValidSegDescr
  SCSI.ExtendedCopy.ValidTgtDescr

1. https://github.com/sahlberg/libiscsi

Sergey Samoylenko (1):
  scsi: target: core: Fix sense key for invalid XCOPY request

 drivers/target/target_core_xcopy.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.25.1

