Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCFA5D2EC
	for <lists+target-devel@lfdr.de>; Tue,  2 Jul 2019 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGBPaj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 2 Jul 2019 11:30:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42080 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBPaj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:30:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so4484393pgb.9
        for <target-devel@vger.kernel.org>; Tue, 02 Jul 2019 08:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ul4nyYNUk2KAfGSQ1JouGplC1zKdE4lEcUHNBHmpVWc=;
        b=Kw7kUaxtWYZ84qhDnCYgHfsdYrzm1Jpavip5sD5xh7NL6kHB2Cm0tTj+K8yjMZ4fUA
         TOhuRxYBWBPX02v47R4iZ3ctFVrhDl+MJVE7SUa+yiQsLqDQ0HES3HwvWypJAQhr+nSg
         TGmxdiZoRliXzw97bhpeGRPP6fg4y6QESsLIZ3c+DdOu7vayqCNW6VuagxVRzMnTP87q
         XUeOKjOm4xmlK/RhEPLSTq3X/EJc9dHk8UyMKFxTsYF5f6zxKJMUf/pkZ6PoOYaG8JMO
         dfdQKkwk8HZiWgAnW0uPSaKlrxFxwL7iJ/nCXbjqBNwUBHa2THgfjscj3vMxqeaDN50W
         b1Sg==
X-Gm-Message-State: APjAAAV7vxH+l4hVrgXFaHBjtR+SWkmWTAIzxeY0AAh6oeE0XyxYwrOH
        sPEamHGXJQjYWB8xiqUH6K4=
X-Google-Smtp-Source: APXvYqx6Zng6nsPXIkmWSl8eCIDJT2/8QaDk9Z7DXFYdQdQOaHYfxXkqrfIviGOaK2mekaspegIJ6A==
X-Received: by 2002:a63:211c:: with SMTP id h28mr18442310pgh.438.1562081438660;
        Tue, 02 Jul 2019 08:30:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 4sm13715800pfc.92.2019.07.02.08.30.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 08:30:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Use REQ_OP_WRITE_SAME to implement WRITE SAME
Date:   Tue,  2 Jul 2019 08:30:29 -0700
Message-Id: <20190702153031.3832-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Martin,

The SCSI target iblock backend uses regular writes to implement the SCSI WRITE
SAME command. That is suboptimal for at least SCSI and NVMe SSDs. This patch
series makes the iblock backend use REQ_OP_WRITE_SAME instead. Please consider
these patches for inclusion in the upstream kernel.

Thanks,

Bart.

Bart Van Assche (2):
  block: Add blkdev_submit_write_same()
  target/core: Use REQ_OP_WRITE_SAME to implement WRITE SAME

 block/blk-lib.c                     | 37 ++++++++++++++++++++++++++++-
 drivers/target/target_core_iblock.c | 17 +++++++++++++
 include/linux/blkdev.h              |  3 +++
 3 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

