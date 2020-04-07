Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B2E1A1015
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgDGPVb (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Apr 2020 11:21:31 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:51334 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728306AbgDGPVb (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1586272888; i=@ts.fujitsu.com;
        bh=hj3KyWtrKww1tJ63UWW4tST618c2ILSBLf2oQGL2vxY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=BqcIZeeblOjzJ0ab5lkMKPlpNgF3Pmf++uW4Qruwlwxs5LFUicsP1SV8bwoKNdwtk
         lZlFMckKmZ1Ma+G1pxFroCOYBHZJbApNCU0sQOcZSeTq8X454Ysqg/A2eHza7gRwVI
         Tx3d7iufdHK7AXfzB4kVvuhFW0/r8hxaDMEEN5xQiz2IzLPsMofAVAcTN1lkS6ST7y
         y5ljhZa7hfM+DXFgTb8W4R1iOlZfwWWdMyHD2tTN9iXvZUOh/Km0Fq55nBxLlSRpP1
         zRORLijwuiY9E0PrHYpDfW7hEJyJN+B/3YED5o2btND97pu6TJHSmpaR3DjGIXD9fg
         w0ybQ0Mx+r6Cw==
Received: from [100.112.195.73] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id F1/D2-36772-87A9C8E5; Tue, 07 Apr 2020 15:21:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRWlGSWpSXmKPExsViZ8MxVbd8Vk+
  cwd1fbBbLj/9jslh/ZAOjRevSt0wOzB4fn95i8Xi/7yqbx+dNcgHMUayZeUn5FQmsGe8/XWcr
  eMBe0dK2ka2B8TBbFyMXh5DAJEaJz0s3M0M40xklGm/2sXcxcnKwCRhIrJh0nwXEFhFQkNj6+
  RyYzSyQLrFxfRsziC0s4CBxfe90NhCbRUBVYsG+3UwgNq+AncSHvbvBaiQE5CU6DkwG6+UUsJ
  fY93YZWFwIqGb1q/vsExi5FzAyrGK0SCrKTM8oyU3MzNE1NDDQNTQ00jW0NNE1tDDUS6zSTdR
  LLdUtTy0u0QVyy4v1iitzk3NS9PJSSzYxAsMkpeDQ1h2MW+a/1zvEKMnBpCTKe7i6J06ILyk/
  pTIjsTgjvqg0J7X4EKMMB4eSBK/vDKCcYFFqempFWmYOMGRh0hIcPEoivMzTgdK8xQWJucWZ6
  RCpU4yKUuK8qTOBEgIgiYzSPLg2WJxcYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTM+xFkO0
  9mXgnc9FdAi5mAFl9L6gZZXJKIkJJqYOrs2y/E8yF1slq9lKLhRYEfT9hKZyl0vuHN9+c/ofC
  CudKhMvH0HKWNXx/ZzV7XdeNE7vetPqv6pLN+u0okyEzUbLhnsXGX+jMHL012hrwzXWcL9l5U
  /RrlpZhw7PIXv7uSMm839IYw363d+fdH35HDjw8Ya75n/fQm9Owulmy7vhva5cfPbuztT3DY8
  li9/M/dCfdWmFyONvBaylHJWJhndfSTzf3QyvNam6dGKxmv4D810T+sct4esdA5krGZd4/Jvl
  kVG7lB4kvbUTPb5bIauucnTLI63jDje7Th/o3/jTeanGFoUlC7/SBp+1fNjap7jr9fa/VJMrp
  1wsH8om+MG+9vyNGwMPZxdvFbE6rEUpyRaKjFXFScCAD69dxMDgMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-29.tower-265.messagelabs.com!1586272886!630011!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12105 invoked from network); 7 Apr 2020 15:21:27 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-29.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2020 15:21:27 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 037FLQ4E032295;
        Tue, 7 Apr 2020 16:21:26 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id 7E13E206B2;
        Tue,  7 Apr 2020 17:21:23 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, martin.petersen@oracle.com,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [PATCH 2/2] target: fix PR IN / READ FULL STATUS for FC
Date:   Tue,  7 Apr 2020 17:21:19 +0200
Message-Id: <20200407152119.29042-3-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20200407152119.29042-1-bstroesser@ts.fujitsu.com>
References: <20200407152119.29042-1-bstroesser@ts.fujitsu.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Creation of the response to READ FULL STATUS fails for FC
based reservations. Reason is the too high loop limit (< 24)
in fc_get_pr_transport_id(). The string representation of FC
WWPN is 23 chars long only ("11:22:33:44:55:66:77:88"). So
when i is 23, the loop body is executed a last time for the
ending '\0' of the string and thus hex2bin() reports an error.

Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
---
 drivers/target/target_core_fabric_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index f5f673e128ef..1e031d81e59e 100644
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
-- 
2.12.3

