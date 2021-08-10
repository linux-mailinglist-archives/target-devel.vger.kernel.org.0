Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E13E01DE
	for <lists+target-devel@lfdr.de>; Wed,  4 Aug 2021 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbhHDNZH (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 4 Aug 2021 09:25:07 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:53642
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238061AbhHDNZG (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:25:06 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1B9AD3F048;
        Wed,  4 Aug 2021 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628083492;
        bh=mNny2UeZ7EC33QeUY4d+BcD45KNxvsJvrlo9CuSGuJM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=M2+wnNjXXnjEIRbvy795fDakdp+JGEWk6fyhvs5o9o8DBiR90N4VJo01gzPSNH6H4
         cu7CHCLaAog7vGmAG5Cp6cxUzt6rvwCt9qYv15MBCzZb5Dx7kwnFOBrh8UBqJveBER
         htSLE7slj2JhnAiKj+vRfTa9OGDhpjot3ZZj+nWDFuyoVCBX3FKvtAW/r0JWf40e7b
         zk2lqLke6WzX3KFmAkLl/12bb/umDuuT7RfEZfoLEsmH4E0nekGBxVQ6sk5LNa41py
         HDdyyVIkjK6hIIBMjNsKUNwfyhGS/KCgRP74yisUzYU2qtOYlSMelhqHD+Y0XxSUda
         pwaSmZZAyQGcQ==
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: elx: efct: Remove redundant initialization of variable ret
Date:   Wed,  4 Aug 2021 14:24:51 +0100
Message-Id: <20210804132451.113086-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/elx/efct/efct_lio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_lio.c b/drivers/scsi/elx/efct/efct_lio.c
index e0d798d6baee..bb3b460dc0bc 100644
--- a/drivers/scsi/elx/efct/efct_lio.c
+++ b/drivers/scsi/elx/efct/efct_lio.c
@@ -780,7 +780,7 @@ efct_lio_npiv_make_nport(struct target_fabric_configfs *tf,
 {
 	struct efct_lio_vport *lio_vport;
 	struct efct *efct;
-	int ret = -1;
+	int ret;
 	u64 p_wwpn, npiv_wwpn, npiv_wwnn;
 	char *p, *pbuf, tmp[128];
 	struct efct_lio_vport_list_t *vport_list;
-- 
2.31.1

