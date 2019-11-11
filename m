Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC3F7AC9
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 19:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKKS3v (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 13:29:51 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:34247 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKKS3v (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:29:51 -0500
Received: by mail-pl1-f181.google.com with SMTP id h13so2756324plr.1
        for <target-devel@vger.kernel.org>; Mon, 11 Nov 2019 10:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J+Qjal23FBOXqsq+/Z95oUKH7OpCgzauSdM0pWBHhDc=;
        b=EvZeKaiqaskMCXDC463EtwcGa6t0YSKpvnOHjgF4f5xO+P42FLwu8jZiuPiVQQuM/R
         cWCrOcJ+4rkR8VE7YVGkg7jUs4yOx7zxwkSQcWjTsZvzn36BFLYJhKx4c78hk0HBQzm8
         fb51oBEHcw5XiqbhlpfuWu2hd/AEJyCBy/gat8awkFqYPyVQ+xsq4ACuRC4XqPQ5maIa
         TUBKu0YhTIXlFTgJAJnDlxOk8mEjDgiUnRPZAxOPNKJ5YNkOpdcl8mcKG6Ob+LsbWDHf
         UUT6uQBEER0n2ivm6ufC2VCQPHq6YGrGS3lPp8TW0tVtsiw+pFxo7b26Kf7KzrnHIFzX
         YYfQ==
X-Gm-Message-State: APjAAAVT+ffFMP7N7khf9x3fVNcXTRHux/YRa0XD+b2HZ6fsddo5kjMO
        0JgalX4aNA8SBsABZ0anF/A=
X-Google-Smtp-Source: APXvYqzYVqSi5DQA7lDxSCHtmlMj2BRfz7tqH9z7JwTWI/C7jghv4j89XNFMsixtHAR8Ki+EuIGsGA==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7mr26513737plb.181.1573496990620;
        Mon, 11 Nov 2019 10:29:50 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z62sm20635925pfz.135.2019.11.11.10.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 10:29:49 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Improve SPC-2 reservation support
Date:   Mon, 11 Nov 2019 10:29:42 -0800
Message-Id: <20191111182944.191123-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Martin,

This patch series improves support for SPC-2 reservations in the SCSI target
code. Please consider these patches for inclusion in the v5.5 kernel.

Thanks,

Bart.

Bart Van Assche (2):
  target/core: Declare target_release_reservation() 'static'
  target/iscsi: Fix a use-after-free while closing a session

 drivers/target/target_core_pr.c        |  2 +-
 drivers/target/target_core_pr.h        |  1 -
 drivers/target/target_core_transport.c | 11 +++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)
