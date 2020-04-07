Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF0A1A1017
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgDGPVd (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Apr 2020 11:21:33 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:59845 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729120AbgDGPVd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1586272890; i=@ts.fujitsu.com;
        bh=93ZfEJS04jwBgFKo1w/rvNzIHYLnCOqCuQQV27pOb/Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=iOYud1OlgHPwoQNbgKkgXgvOz+kLerASwylKH58ITldtLh2/M42l08yVA3pMR5oBW
         yeDIKvv2M3F3AOadfMzaPDCulLFy6/dLKnJMbOOULaD2XmpjmTJFSwh7qBIUn8qftC
         M4p7deQytsM/EnldEjrt3p8Nvex/UuIiXOWId7Ihx9qSWQyXvLYmGR7dEtvaehd9Sb
         W2jOtGbmFG2BsJzGifJaTeRxoXzU4xaToIy/aK+pmvSVkE0UHHR+sRmEsWLHt0Hzkz
         zYaWk1y6tE5/2pKLbowaBaQ4hDb73QSzsMcYF+qBT1D/6xh/4oqUU8LKJyayjoZzIH
         joQy6AhXEbnUQ==
Received: from [100.113.5.88] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id F6/6A-35964-A7A9C8E5; Tue, 07 Apr 2020 15:21:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRWlGSWpSXmKPExsViZ8MxRbdqVk+
  cQcMuZovlx/8xWaw/soHRonXpWyYHZo+PT2+xeLzfd5XN4/MmuQDmKNbMvKT8igTWjOe7V7AX
  rGKvWHJrFnMD43S2LkYuDiGBSYwSh9dNZYdwpjNKrF30irWLkZODTcBAYsWk+ywgtoiAgsTWz
  +fAbGaBdImN69uYQWxhAVeJhmPLwOpZBFQljtxewwhi8wrYSRxtuMEGYksIyEt0HJgM1sspYC
  +x7+0ysF4hoJrVr+6zT2DkXsDIsIrRMqkoMz2jJDcxM0fX0MBA19DQWNcUyDLXS6zSTdJLLdV
  NTs0rKUoEyuollhfrFVfmJuek6OWllmxiBAZKSiFr9g7GrfPf6x1ilORgUhLlPVzdEyfEl5Sf
  UpmRWJwRX1Sak1p8iFGGg0NJgtd3BlBOsCg1PbUiLTMHGLQwaQkOHiURXubpQGne4oLE3OLMd
  IjUKUZFKXHe1JlACQGQREZpHlwbLFIuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLm/QiynS
  czrwRu+iugxUxAi68ldYMsLklESEk1MM1a+OSGSPlDl35V9fNCK2cec1HId42X13BbvbJ5Q5u
  91zmdG89CQkuFv67fdkI3YcWczQI2b7n4PA8G59hOeue4XvSw/93nvTaHLyXsjZ/ozMWz5vb3
  X5dUgm3v/j3222DKsq4OnqSAZr9DDj03zprLST52P2T8glVv0uVZKydMn1ocHmG2fFH446++J
  xmkhdl/7awMtTQX6l2jZKD+Oj/e8frzOEeJpO3XnyrGR9zny5hXfDt0t23UL5sEE6H7dk8/z8
  l7GiNpEKy7rYh19ZHjD7s2BxzhySs+76bsVyL4xvTah0cxxcGJXwtN5yk0rf070ZT95Im3Ky6
  JqGjoy/05fYiT42u3L9vWW3HeT5VYijMSDbWYi4oTAUj3vVIPAwAA
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-20.tower-248.messagelabs.com!1586272888!469871!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 661 invoked from network); 7 Apr 2020 15:21:30 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-20.tower-248.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2020 15:21:30 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 037FLPYd016889;
        Tue, 7 Apr 2020 16:21:25 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id D9F9520699;
        Tue,  7 Apr 2020 17:21:22 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, martin.petersen@oracle.com,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [PATCH 1/2] target: Write NULL to *port_nexus_ptr if no ISID
Date:   Tue,  7 Apr 2020 17:21:18 +0200
Message-Id: <20200407152119.29042-2-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20200407152119.29042-1-bstroesser@ts.fujitsu.com>
References: <20200407152119.29042-1-bstroesser@ts.fujitsu.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch fixes a minor flaw that could be triggered by
a PR OUT RESERVE on iSCSI, if TRANSPORT IDs with and without ISID
are used in the same command.
In case an ISCSI Transport ID has no ISID, port_nexus_ptr was not
used to write NULL, so value from previous call might persist.
I don't know, if that ever could happen, but with the change the
code is cleaner, I think.

Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
---
 drivers/target/target_core_fabric_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index 6b4b354c88aa..f5f673e128ef 100644
--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -341,7 +341,8 @@ static char *iscsi_parse_pr_out_transport_id(
 			*p = tolower(*p);
 			p++;
 		}
-	}
+	} else
+		*port_nexus_ptr = NULL;
 
 	return &buf[4];
 }
-- 
2.12.3

