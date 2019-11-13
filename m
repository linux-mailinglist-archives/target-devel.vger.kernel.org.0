Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC8BFBB57
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 23:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfKMWFQ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 17:05:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36542 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMWFQ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:05:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id d7so1655054pls.3
        for <target-devel@vger.kernel.org>; Wed, 13 Nov 2019 14:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UOD0ojzXZpUYKQlcvOiVEcMeg2yVQT6FEZIEdoEsANY=;
        b=tXxl5frxy8ZJew8twa85elFoRXT+XkBiHBwaJfpKI5TeubVtbYH+huqLGBye9GZxtG
         t9ZAPh6wdaMP58TJovTSi9ZxSWkXjfSi5CR70LwxSq1E5RKmaaANCvH//dcOorUuZKI5
         4MNDCUC5YgHUoXxdccT9Va2DznxOXOh23j33YSkkiooGfHQfQldHlPpgVW/EjJhKPHsq
         GBbfXgYpbF6om805BgOViib/kONGBFCdtRsWXncV/inlIUmoF7zs/RGmPOrqdpet6KBH
         cOmmXl5rsK34u9AblnurZZzy8HptHjNSErvTzfYLa4tSaXrSLmhYVzwZdaTqxDMl8ukv
         IBPw==
X-Gm-Message-State: APjAAAXbniVK5Q63uTFq1qAidc258pLc3kDA8AKNtnhK5qQJ8tO11Ck/
        JFS9bJFH+zWZcJGeqOfwGLo=
X-Google-Smtp-Source: APXvYqxdoWHj6BqDZYRiN55fDnAlafI5yBtwUabepqq2VLdh21iq9vqWc6MCHsUvUtMsHb9UxOfc0g==
X-Received: by 2002:a17:902:aa42:: with SMTP id c2mr6026989plr.311.1573682715091;
        Wed, 13 Nov 2019 14:05:15 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v23sm3843527pfm.175.2019.11.13.14.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 14:05:14 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/2] Two SCSI target reliability improvement patches
Date:   Wed, 13 Nov 2019 14:05:06 -0800
Message-Id: <20191113220508.198257-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Martin,

The two patches in this series fix complaints that are reported when
running the libiscsi test tool against the SCSI target code. I'm not sure why
I hadn't noticed these issues before - maybe new tests have been added to the
test tool. Please consider these patches for Linux kernel version v5.5.

Thanks,

Bart.

Changes compared to v3:
- Left out the target_tmr_work() patch.

Changes compared to v2:
- Changed target_{,un}depend_item() calls into configfs_{get,put}_item() calls.
- Changed ISCSI_REASON_BOOKMARK_NO_RESOURCES into
  ISCSI_REASON_WAITING_FOR_LOGOUT.

Changes compared to v1:
- The patch that declares target_release_reservation() static has been left
  out because a patch in this series introduces a call to that function
  outside the file in which that function has been defined.
- The patch for releasing SPC-2 reservations has been reworked as requested by
  Roman.
- Two new patches have been added.

Bart Van Assche (2):
  target/core: Release SPC-2 reservations when closing a session
  target/iscsi: Wait for all commands to finish before freeing a session

 drivers/target/iscsi/iscsi_target.c    | 10 ++++++++--
 drivers/target/target_core_transport.c | 15 +++++++++++++++
 include/scsi/iscsi_proto.h             |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

