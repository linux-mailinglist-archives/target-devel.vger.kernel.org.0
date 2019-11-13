Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB300FB6A0
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 18:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKMRws (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 12:52:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34968 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfKMRws (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:52:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id q22so1840428pgk.2
        for <target-devel@vger.kernel.org>; Wed, 13 Nov 2019 09:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hU78liIpa1e+s8jFbPez9OPQgPpKrnMyQon9QgInxe4=;
        b=XXqbmO4UXQqV4eCArLMcX/K+8WwonB5kGJufGSBqr2DaquS8cKsx18PhD8utgsx+E4
         WzSIdXFm+OuPTQFzgGT7VcocVH9A92ZvOCgq4qZNPh81+5uf1W9hCLGNxoB07kcSj1aw
         kcW8yPiOiSyrBJITFYm9ELPnvT1SRHatVVqE0uo/iap2qNyEoizFt5b6qGq9aQzzVup5
         ZNcCbTdEFEkk0CDQsW5G6pQoNoDBAeGhbB1EkhTYtMUolFI469lk3T9ryZTD2wq2zCeQ
         YkeLBbHe5sZRokZo9WTpKqN9BuQ2PlStPCkfnNT1UAT5qIog1wm5WjcFZltcKhpM2c25
         fpHw==
X-Gm-Message-State: APjAAAUHf+jFgtwdql/kIY4r2KJYnThQrT97essTwkq3gtqMHIGYt1Wm
        yWuJhytztf1EN1LVR664oj0=
X-Google-Smtp-Source: APXvYqzbTNioUVa03d36CfMkPSiF1VNqKn/h7PTnl22jV9bARf1HY+uOU4NgmDb0zwaNEy4Tc0HvMA==
X-Received: by 2002:a17:90a:1f0a:: with SMTP id u10mr3595211pja.49.1573667566340;
        Wed, 13 Nov 2019 09:52:46 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u36sm4166557pgn.29.2019.11.13.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 09:52:45 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/3] Three SCSI target reliability improvements
Date:   Wed, 13 Nov 2019 09:52:36 -0800
Message-Id: <20191113175239.147389-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Martin,

The three patches in this series fix complaints that were reported while
running the libiscsi test tool against the SCSI target code. I'm not sure why
I hadn't noticed these issues before - maybe new tests have been added to the
test tool. Please consider these patches for Linux kernel version v5.5.

Thanks,

Bart.

Changes compared to v2:
- Changed target_{,un}depend_item() calls into configfs_{get,put}_item() calls.
- Changed ISCSI_REASON_BOOKMARK_NO_RESOURCES into
  ISCSI_REASON_WAITING_FOR_LOGOUT.

Changes compared to v1:
- The patch that declares target_release_reservation() static has been left out because a patch in this series introduces a call to that function outside the file in which that function has been defined.
- The patch for releasing SPC-2 reservations has been reworked as requested by Roman.
- Two new patches have been added.

Bart Van Assche (3):
  target/core: Release SPC-2 reservations when closing a session
  target/core: Fix a use-after-free in the TMF handling code
  target/iscsi: Wait for all commands to finish before freeing a session

 drivers/target/iscsi/iscsi_target.c    | 10 ++++++++--
 drivers/target/target_core_transport.c | 21 +++++++++++++++++++++
 include/scsi/iscsi_proto.h             |  1 +
 3 files changed, 30 insertions(+), 2 deletions(-)

