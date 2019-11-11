Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD0F7ACA
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 19:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfKKS3w (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 13:29:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43400 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKKS3w (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:29:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id a18so8114846plm.10
        for <target-devel@vger.kernel.org>; Mon, 11 Nov 2019 10:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FafHSQTeB+oL+1Ea8E3h3fP45BInkUwYj+XvGmzJ0Lc=;
        b=R58z7FPSsCDI0qtQcmbZT1dgxtWzW8Sts7Ebp8/w6QltfnNbWfk/vEpKjesBd8UaWY
         9S/anhwr+TPXXTKoUvAYkabr9F5CoCJ8bYo20gyGoFafXhE3e4qfH5YfsluSEf6c4/tF
         p9hPL/ghU0dxM7kBpXZ0oZqmpd8SOObyQBNJrLRAZwtpsyI/SBXkaU4TcOmcunOzu+Ho
         1CfBu2tAJSJa46rEvCerZhnGxdc40Y9Z7ufh2TbZA2ryHSuKcRyPxNKNJCARrttRcGQH
         5CIPG66Fg7KHBIMQbU0zDNpJNzyKloDJL+Qx9udrxSdRqZZR0kATsCJRoTDagZ8aQTeX
         u5pg==
X-Gm-Message-State: APjAAAWr4/9JsHF9Va598YFj4gySGcOaEjlKd5gartd9s6UrP28XSY0D
        zZWEC0++cC1gsKPPBlK5qv0=
X-Google-Smtp-Source: APXvYqxiLfcgKDwgRDGx7LjJwCqRWxoou1PpELdlm5cV/Nm/jwN221fqQvTf6ZnIUs4+MV/zNJY6EA==
X-Received: by 2002:a17:902:102:: with SMTP id 2mr27662133plb.156.1573496991924;
        Mon, 11 Nov 2019 10:29:51 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z62sm20635925pfz.135.2019.11.11.10.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 10:29:51 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] target/core: Declare target_release_reservation() 'static'
Date:   Mon, 11 Nov 2019 10:29:43 -0800
Message-Id: <20191111182944.191123-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191111182944.191123-1-bvanassche@acm.org>
References: <20191111182944.191123-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Since this function is only used inside the source file in which it has
been defined, declare it 'static'. See also commit fae43461f8f2 ("scsi:
target/core: Rework the SPC-2 reservation handling code").

Cc: Mike Christie <mchristi@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_pr.c | 2 +-
 drivers/target/target_core_pr.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 5e931690e697..6a72b61e0076 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -187,7 +187,7 @@ static int target_check_scsi2_reservation_conflict(struct se_cmd *cmd)
 	return 0;
 }
 
-void target_release_reservation(struct se_device *dev)
+static void target_release_reservation(struct se_device *dev)
 {
 	dev->reservation_holder = NULL;
 	dev->dev_reservation_flags &= ~DRF_SPC2_RESERVATIONS;
diff --git a/drivers/target/target_core_pr.h b/drivers/target/target_core_pr.h
index a31c93e4e19c..198fad5c89dc 100644
--- a/drivers/target/target_core_pr.h
+++ b/drivers/target/target_core_pr.h
@@ -58,7 +58,6 @@ extern struct kmem_cache *t10_pr_reg_cache;
 
 extern void core_pr_dump_initiator_port(struct t10_pr_registration *,
 			char *, u32);
-extern void target_release_reservation(struct se_device *dev);
 extern sense_reason_t target_scsi2_reservation_release(struct se_cmd *);
 extern sense_reason_t target_scsi2_reservation_reserve(struct se_cmd *);
 extern int core_scsi3_alloc_aptpl_registration(
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

