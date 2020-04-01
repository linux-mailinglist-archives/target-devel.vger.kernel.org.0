Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0694B19AC9F
	for <lists+target-devel@lfdr.de>; Wed,  1 Apr 2020 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgDANWW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 1 Apr 2020 09:22:22 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:49054 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732490AbgDANWW (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1585747340; i=@ts.fujitsu.com;
        bh=D7UBM6rZxOTppvbktviWUnZ8vu7pnermW7K+lJr/bAE=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=ExatrmzRR3Uw6IsEDQnG735WkBME+alDltQxJwi+f2uGnllT6l7z+CSA+x/bbdeF7
         NKCYSVapze47buqNdSMS2wGa5Ctp3nuE92cq2Ouum8fQT2KxaOS8F8VfcLYJB3IwAs
         cIjM5JWxcrDetb8ivgXMbQKWTnrCLNWMAsD/5sjW1CvKIisOeMIIYkbw2YqIoUuGaG
         PluUM+JoCRd3ci12fQPQH/FjJsyLjdf8yF+oF7q8N9Txd+J2fKKfDgyjdY6EbZEL27
         Mmg091q9O3X0AC5IElbcJ6GUQBS4U++lDpxN4/BXyTE0e6Bbuj3ZHnNXT7WUOfG+ST
         n6O63WJiZ0Q9g==
Received: from [100.112.192.74] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 6A/4E-36773-B85948E5; Wed, 01 Apr 2020 13:22:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeJIrShJLcpLzFFi42Kxs+GYqts9tSX
  O4OglTYuv/6ezWKxcfZTJYvnxf0wW649sYLRoXfqWyYHVY/fNBjaPj09vsXi833eVzWPz6WqP
  z5vkAlijWDPzkvIrElgzZn2ewlqwiLPi9znOBsaZHF2MXBxCApMYJa73/2WDcKYzSnx4fgrI4
  eRgEzCQWDHpPguILSKgILH18zkWkCJmgSZGifObvrGCJIQFAoASi5lAbBYBVYnus41gNq+Anc
  TmFxPAmiUE5CU6DkxmmcDIuYCRYRWjRVJRZnpGSW5iZo6uoYGBrqGhka6hpbGuoZmZXmKVbqJ
  eaqlueWpxia6hXmJ5sV5xZW5yTopeXmrJJkZgcKQUHFy2g3HV2vd6hxglOZiURHl/tbfECfEl
  5adUZiQWZ8QXleakFh9ilOHgUJLg7Z0MlBMsSk1PrUjLzAEGKkxagoNHSYS3fxJQmre4IDG3O
  DMdInWK0ZJj59F5i5g53qxdAiTb7t1dxCzEkpeflyolzis7BahBAKQhozQPbhwsmi4xykoJ8z
  IyMDAI8RSkFuVmlqDKv2IU52BUEuZ1BpnCk5lXArf1FdBBTEAHXa1oBjmoJBEhJdXAxNjK80k
  luzPAm+XJ0TfPXV3uCX+5Lhuv91HS//eF+zaq3C+aDz76eodTTUR629usGiXTS4EpPK8fn+I8
  sdR6f4JyXJXYHZ/I8gfciw7YcwlfYsrgUJq9WurBNY8+t5nHI/asnp3PcLOu1erKrg1ia2yTH
  uw57GOsPSPDOrTU4OFdpZjIZVfr5tyfVqlo6b+162hAsdbOEj110wWfjhdv+hsdunbZRZf9pl
  0qH+KeXd6S/4e1Ju1XnajFtdVPdeee6b/z+2KSedUNDsn33EFz4o8rXf6w/174tA23WDhelRX
  MOfHXUSddX+fgq4w/N2oVK8+vf/KqtTtyygE/g1fSHZ+WmJud9uhYzOy2qN18jRJLcUaioRZz
  UXEiADNVc9shAwAA
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-31.tower-265.messagelabs.com!1585747339!101068!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19535 invoked from network); 1 Apr 2020 13:22:19 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-31.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Apr 2020 13:22:19 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 031DM9dd030987;
        Wed, 1 Apr 2020 14:22:09 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id 96F06203E7;
        Wed,  1 Apr 2020 15:22:09 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     target-devel@vger.kernel.org
Cc:     ddiss@suse.de, mchristi@redhat.com, hch@lst.de,
        martin.petersen@oracle.com,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [PATCH] target: tcmu: add missing pr attributes to passthrough backends
Date:   Wed,  1 Apr 2020 15:21:53 +0200
Message-Id: <20200401132153.23501-1-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

In commit b49d6f7885306ee636d5c1af52170f3069ccf5f7 the new attribute
emulate_pr was added.
passthrough_parse_cdb() uses the attribute's value to distinguish,
whether reservation commands should be rejected or not.
But the new attribute was not added to passthrough_attrib_attrs, so in
pscsi and tcmu - the users of passthrough_parse_cdb() - the attribute
is not available to change parser's behavior.
This patch adds the new attribute as well as the "pr control" attributes
enforce_pr_isids and force_pr_aptpl to passthrough_attrib_attrs.

Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
---
 drivers/target/target_core_configfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index ff82b21fdcce..c5a974c5b31d 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1203,6 +1203,9 @@ struct configfs_attribute *passthrough_attrib_attrs[] = {
 	&attr_hw_block_size,
 	&attr_hw_max_sectors,
 	&attr_hw_queue_depth,
+	&attr_emulate_pr,
+	&attr_enforce_pr_isids,
+	&attr_force_pr_aptpl,
 	&attr_alua_support,
 	&attr_pgr_support,
 	NULL,
-- 
2.12.3

