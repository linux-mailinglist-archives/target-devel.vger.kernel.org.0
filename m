Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E24619FD31
	for <lists+target-devel@lfdr.de>; Mon,  6 Apr 2020 20:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgDFSaJ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 6 Apr 2020 14:30:09 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:62472 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgDFSaI (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1586197806; i=@ts.fujitsu.com;
        bh=VXOi4a3wmRFF9qtPY2CBKqfTIOj6mtDucwluLzCU+nA=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=OUdatAqAUCQUqDxS+Yy+vwlYLLi7VT9XpXLb0+X/UY8rqudrAJqiVt2Hfx7HocELM
         bqqeATAn0WQym4OtOoPVU1+ZxmabI5iqIHvU0DoYV2uMn4J9xY3l8edFMI/7GYXAX/
         t2jnH5vLS3574tKeeGVKEoUjZObj6uITTsZxWm5azqrxggxM0UsEAItp9TCbWOqX/m
         4VrgaH+vMHfoR9SWU+oR1le6+YNMXbw1ybUwESxJtuUAwcl384X2KYXAPdfIkD7csY
         pByDpxfrVxeP+oEELd03EoD1CoOzrwzvJMUG99BWXGtuVCgyBb9KG8G7A9rBC/fP7j
         sgCUx/gSVz6OA==
Received: from [100.113.6.158] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 05/42-46447-E257B8E5; Mon, 06 Apr 2020 18:30:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRWlGSWpSXmKPExsViZ8MRoqtX2h1
  n0PlbwGL58X9MFuuPbGC0aF36lsmB2ePj01ssHu/3XWXz+LxJLoA5ijUzLym/IoE1o+ueUEGT
  YsXOhz+ZGhjPSHUxcnEICUxilLjwvosZwpnOKPFz4jT2LkZODjYBA4kVk+6zgNgiAgoSWz+fA
  7OZBdIlNq5vYwaxhQUsJB7+3QFmswioShzbOp0VxOYVsJPo/nODCcSWEJCX6DgwmWUCI+cCRo
  ZVjJZJRZnpGSW5iZk5uoYGBrqGhsa6JrqGFoZ6iVW6SXqppbrJqXklRYlAWb3E8mK94src5Jw
  UvbzUkk2MQL+nFLJs3cF4ae17vUOMkhxMSqK8bOndcUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQk
  eDcWA+UEi1LTUyvSMnOAIQiTluDgURLhtSwCSvMWFyTmFmemQ6ROMSpKifN+AOkTAElklObBt
  cHC/hKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd4HIFN4MvNK4Ka/AlrMBLT4WhLY4pJEhJ
  RUA1P65oQzlqr6Da8Swyuv5D1uu1l3MSpz+0H7lvX7stO15afkvI6dOIuN9WvV5OO7dJg4q6M
  zGdYZeOVL+xzbsW572CbeiHB/ncyaCZudL+xKftaef8hHpdkncf6tzzY/ZPrXGj89f9fnfuRV
  ztrXNg/T5Bumrfu3LutfT4tMpuC7+U9uP2Y0lWFWLp4vz/a/wdDjyxapDtvWXQbT48Kf+l/on
  GXm+7iClyf27bOtM/kO8MbdOOmk/cN5Zij/yaB1FzpYQ8W/qIskqxkvPLiqyuWCoeeEvNz9JX
  dOq7RveGdSdPaJbWDN9w//K2o/bpz/J6VAN+RXdpTNNav/9QFbj+9Y0czXdO7Rw2kzZyz3PKP
  EUpyRaKjFXFScCAAlAwtK9gIAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-8.tower-238.messagelabs.com!1586197805!2145725!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7690 invoked from network); 6 Apr 2020 18:30:06 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-8.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 6 Apr 2020 18:30:06 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 036ITuBi016082;
        Mon, 6 Apr 2020 19:29:56 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id A6A4B204D8;
        Mon,  6 Apr 2020 20:29:56 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, martin.petersen@oracle.com,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [PATCH] target: pr: fix PR IN, READ FULL STATUS
Date:   Mon,  6 Apr 2020 20:29:51 +0200
Message-Id: <20200406182951.17446-1-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

AFAICS there are some problems in target_core_fabric_lib.c
that afflict PERSISTENT RESERVE IN / READ FULL STATUS command.

1) Creation of the response to READ FULL STATUS fails for FC
   based reservations. Reason is the too high loop limit (< 24)
   in fc_get_pr_transport_id(). The string representation of FC
   WWPN is 23 chars long only ("11:22:33:44:55:66:77:88"). So
   when i is 23, the loop body is executed a last time for the
   ending '\0' of the string and thus hex2bin() reports an error.

2) For iSCSI based reservations that include an ISID, the
   reported TRANSPORT ID is wrong. This has two reasons:
   a) The code inserts an NULL byte between the ISCSI Name and
      the SEPARATOR
   b) Only the first 6 chars of the ISID are appended. AFAIK,
      binary ISID is 48 bits, so 12 chars might be necessary.

The last hunk in this patch fixes a minor flaw that could be
triggered by a PR OUT RESERVE on iSCSI, if TRANSPORT IDs with
and without ISID are used in the same command. I don't know, if
that ever could happen, but with the change the code is cleaner,
I think.

This patch is based on code review only. It compiles fine, but
unfortunately I wasn't able to test.

Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
---
 drivers/target/target_core_fabric_lib.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index 6b4b354c88aa..8a726076ae56 100644
--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -63,7 +63,7 @@ static int fc_get_pr_transport_id(
 	 * encoded TransportID.
 	 */
 	ptr = &se_nacl->initiatorname[0];
-	for (i = 0; i < 24; ) {
+	for (i = 0; i < 23; ) {
 		if (!strncmp(&ptr[i], ":", 1)) {
 			i++;
 			continue;
@@ -148,10 +148,6 @@ static int iscsi_get_pr_transport_id(
 	 */
 	len = sprintf(&buf[off], "%s", se_nacl->initiatorname);
 	/*
-	 * Add Extra byte for NULL terminator
-	 */
-	len++;
-	/*
 	 * If there is ISID present with the registration and *format code == 1
 	 * 1, use iSCSI Initiator port TransportID format.
 	 *
@@ -185,17 +181,15 @@ static int iscsi_get_pr_transport_id(
 		buf[off+len] = 0x30; off++; /* ASCII Character: "0" */
 		buf[off+len] = 0x78; off++; /* ASCII Character: "x" */
 		len += 5;
-		buf[off+len] = pr_reg->pr_reg_isid[0]; off++;
-		buf[off+len] = pr_reg->pr_reg_isid[1]; off++;
-		buf[off+len] = pr_reg->pr_reg_isid[2]; off++;
-		buf[off+len] = pr_reg->pr_reg_isid[3]; off++;
-		buf[off+len] = pr_reg->pr_reg_isid[4]; off++;
-		buf[off+len] = pr_reg->pr_reg_isid[5]; off++;
-		buf[off+len] = '\0'; off++;
-		len += 7;
+		len += snprintf(&buf[off+len], PR_REG_ISID_LEN, "%s",
+		                pr_reg->pr_reg_isid);
 	}
 	spin_unlock_irq(&se_nacl->nacl_sess_lock);
 	/*
+	 * Add Extra byte for NULL terminator
+	 */
+	len++;
+	/*
 	 * The ADDITIONAL LENGTH field specifies the number of bytes that follow
 	 * in the TransportID. The additional length shall be at least 20 and
 	 * shall be a multiple of four.
@@ -224,10 +218,6 @@ static int iscsi_get_pr_transport_id_len(
 	spin_lock_irq(&se_nacl->nacl_sess_lock);
 	len = strlen(se_nacl->initiatorname);
 	/*
-	 * Add extra byte for NULL terminator
-	 */
-	len++;
-	/*
 	 * If there is ISID present with the registration, use format code:
 	 * 01b: iSCSI Initiator port TransportID format
 	 *
@@ -236,12 +226,16 @@ static int iscsi_get_pr_transport_id_len(
 	 */
 	if (pr_reg->isid_present_at_reg) {
 		len += 5; /* For ",i,0x" ASCII separator */
-		len += 7; /* For iSCSI Initiator Session ID + Null terminator */
+		len += strlen(pr_reg->pr_reg_isid); /* Initiator Session ID */
 		*format_code = 1;
 	} else
 		*format_code = 0;
 	spin_unlock_irq(&se_nacl->nacl_sess_lock);
 	/*
+	 * Add extra byte for NULL terminator
+	 */
+	len++;
+	/*
 	 * The ADDITIONAL LENGTH field specifies the number of bytes that follow
 	 * in the TransportID. The additional length shall be at least 20 and
 	 * shall be a multiple of four.
@@ -341,7 +335,8 @@ static char *iscsi_parse_pr_out_transport_id(
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

