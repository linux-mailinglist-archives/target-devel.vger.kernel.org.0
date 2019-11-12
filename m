Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF2F872F
	for <lists+target-devel@lfdr.de>; Tue, 12 Nov 2019 04:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKLD6B (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 22:58:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36266 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLD6B (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 22:58:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so10943133pgh.3
        for <target-devel@vger.kernel.org>; Mon, 11 Nov 2019 19:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FxvEZJk5TAYZnPCGQIUv+Fzm09hC5kt8hVuppB94/ek=;
        b=uM/C3zvss6bXvKNkG+i/A5xEMvNSTrBKNFUNInizCdgGG3uVuKUEuUR0z8yX+M+dvM
         dl9FrfNmgIXzHwWz8nVwNSpd2i1W7U36FycbkPei5KlEZbVQUuao0Pw323VkEl0mL6H3
         XcrF39XN2SM6JawY+LbK57ZEkUpFzgmTPb93n33jaPo0uHYPlvtWboN8Tyg46NMS3daU
         3KHxXUUkCBe7Q/p3l7ImUuZnabiTqE+S6Vcl2I6GFP0u0mXTrtpUx88gU/64KqLUGDo8
         mA880ifORDKl0tKNhjc5JzoJ3DKMsnWTkTBuvlUXtHcUYd7DFNpyw/dK9FzY4KwRda7Y
         o1IQ==
X-Gm-Message-State: APjAAAWYCC/f2gd6FGh74g0FADzIO+ghQMFnSc9OeogS4WeCj0fM0Tk+
        R75FqSmK2RSwr9ibugRQQYM=
X-Google-Smtp-Source: APXvYqzURjWvzCq4hsr3sHclDoJwiFCEbL2MeDaCp4Aq4KJmsffZ8tnbDZSs9CEfdCMbV1JAq8zQEQ==
X-Received: by 2002:a62:2c43:: with SMTP id s64mr32880464pfs.42.1573531080734;
        Mon, 11 Nov 2019 19:58:00 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:a8:97:b734:6b8f:663c])
        by smtp.gmail.com with ESMTPSA id e5sm784288pjv.29.2019.11.11.19.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 19:58:00 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Three reliability improvements
Date:   Mon, 11 Nov 2019 19:57:49 -0800
Message-Id: <20191112035752.8338-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Martin,

The three patches in this series fix the complaints that were reported while
running the libiscsi test tool against the SCSI target code. I'm not sure why
I hadn't noticed these issues before - maybe new tests have been added to the
test tool. Please consider these patches for Linux kernel version v5.5.

Thanks,

Bart.

Bart Van Assche (3):
  target/core: Release SPC-2 reservations when closing a session
  target/core: Fix a use-after-free in the TMF handling code
  target/iscsi: Wait for all commands to finish before freeing a session

 drivers/target/iscsi/iscsi_target.c    | 10 ++++++++--
 drivers/target/target_core_transport.c | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)
