Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64035F3AC9
	for <lists+target-devel@lfdr.de>; Thu,  7 Nov 2019 22:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKGVzH (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 7 Nov 2019 16:55:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41535 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGVzH (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:55:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so3370468pfq.8
        for <target-devel@vger.kernel.org>; Thu, 07 Nov 2019 13:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OfLYii2jcaU1e220T12M/7YTppl7sapCYknAT8/zEmI=;
        b=RLCecyLzmbcfctp7fYpB3qC21R5TeGKQMquiZo0szVlXPOzMx/j5O5ivq8l5Fc/tSa
         opFATil8VOc5oHcb9VqbpOjRK72zgcgQGgMv282j7sVu68itblMwMnscVx501728lZSa
         2H06pW3lHlpihpOYMbUE4dgMEFOKoUI0w4f8J6TdM8xFr7VJBI9TRAXTCvbKpFJ8e6mA
         DaLRnVxgEnHGjL6wLH+Tsd3P7v/T+STxaM/8tUc7K4r2WogYYevPbnZOsJI1WogJBAyD
         xA5leccYj68NdFs2Fc6+dIUfPynVlrAfXYIx9QnGr1ggV9orniUGOHk3Zsejlh/Puo2o
         AR5Q==
X-Gm-Message-State: APjAAAX9MxJ9ucO+VFNX8IZwMGhl2r0nhYhABGDqyYwWJ8HWN6hqXqqp
        zsaQN4FV7AM1kKKftzt/zpzF6tEB
X-Google-Smtp-Source: APXvYqyuaXl8yP+SgNJZjHs+ogSFNTuwWa9FEXYVYq2QfjS5kBZtzOfPalQ7O1lxpSEl3GVPk7HrRA==
X-Received: by 2002:a63:c55:: with SMTP id 21mr7566547pgm.282.1573163706107;
        Thu, 07 Nov 2019 13:55:06 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id w26sm5605633pfj.123.2019.11.07.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 13:55:05 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH] target/core: Document target_cmd_size_check()
Date:   Thu,  7 Nov 2019 13:54:58 -0800
Message-Id: <20191107215458.64242-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Since it is nontrivial to derive the meaning of the size argument from
the code, add a documentation header above target_cmd_size_check().

Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_transport.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index d7d4004f83f9..ba7a01bcad7c 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1243,6 +1243,19 @@ target_check_max_data_sg_nents(struct se_cmd *cmd, struct se_device *dev,
 	return TCM_NO_SENSE;
 }
 
+/**
+ * target_cmd_size_check - Check whether there will be a residual.
+ * @cmd: SCSI command.
+ * @size: Data buffer size derived from CDB. The data buffer size provided by
+ *   the SCSI transport driver is available in @cmd->data_length.
+ *
+ * Compare the data buffer size from the CDB with the data buffer limit from the transport
+ * header. Set @cmd->residual_count and SCF_OVERFLOW_BIT or SCF_UNDERFLOW_BIT if necessary.
+ *
+ * Note: target drivers set @cmd->data_length by calling transport_init_se_cmd().
+ *
+ * Return: TCM_NO_SENSE
+ */
 sense_reason_t
 target_cmd_size_check(struct se_cmd *cmd, unsigned int size)
 {
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

