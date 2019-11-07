Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC99F3ACE
	for <lists+target-devel@lfdr.de>; Thu,  7 Nov 2019 22:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKGVzd (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 7 Nov 2019 16:55:33 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35334 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKGVzd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:55:33 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so3269895ilp.2
        for <target-devel@vger.kernel.org>; Thu, 07 Nov 2019 13:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0mwKAeJ4oAmmLHEBcz5l3GSsJ1iFjuiRFDqPdDUHiaM=;
        b=DNHRAWg/QBjfQ3u8oXJVYcpyDpyslG50DgLMdMOwE+K1T8aYaESL1hY0UavZ8/bX8+
         sM5xN4RwoPv/lNYVq92sVTGm6O5kav2qeL9OFr0MV9OnP14h2Zds+90lY+Siony18sVy
         ujiRAXbdPJsrPbMAZASEDRwlhHtiHaEx6Se93M/p+5bRu8b2wm6ee0FNExRaaCejIoSq
         dK6gE2imaxgcKlGPQg/B0erCVoBKiazEW2aFIPynoRDjgzII0JCP4Gf8RvtXeEGWbeuh
         v6ESb5RXUlM6KSRNAeYxigxazu6Orh8V835buQzf/zFEIw+6NeEoLdAXOGUunee33ad8
         SvzA==
X-Gm-Message-State: APjAAAVARAYVtz3VQd424/zwQ2AgFYM4+NNy4j4L0DUufGb2vljf+83n
        VuDkPo1YTYnnSRI9cdMrR5U=
X-Google-Smtp-Source: APXvYqyqkpt0J/HMJ2M9GeF1Ae6K0d6boCXwcCRTLxPbo6VxfzEAjrqFb4bLcd3wdz7bLhmzAxY8sQ==
X-Received: by 2002:a17:902:126:: with SMTP id 35mr6500763plb.105.1573163730958;
        Thu, 07 Nov 2019 13:55:30 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f26sm3364446pgf.22.2019.11.07.13.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 13:55:30 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] target: Fix a pr_debug() argument
Date:   Thu,  7 Nov 2019 13:55:25 -0800
Message-Id: <20191107215525.64415-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Print the string for which conversion failed instead of printing the
function name twice.

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 2650d71e244f ("target: move transport ID handling to the core")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_fabric_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index 3c79411c4cd0..6b4b354c88aa 100644
--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -118,7 +118,7 @@ static int srp_get_pr_transport_id(
 	memset(buf + 8, 0, leading_zero_bytes);
 	rc = hex2bin(buf + 8 + leading_zero_bytes, p, count);
 	if (rc < 0) {
-		pr_debug("hex2bin failed for %s: %d\n", __func__, rc);
+		pr_debug("hex2bin failed for %s: %d\n", p, rc);
 		return rc;
 	}
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

