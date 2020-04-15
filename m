Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B11A95D1
	for <lists+target-devel@lfdr.de>; Wed, 15 Apr 2020 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635626AbgDOIIc (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 15 Apr 2020 04:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635623AbgDOII3 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:08:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F635C061A10
        for <target-devel@vger.kernel.org>; Wed, 15 Apr 2020 01:08:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a13so1190910pfa.2
        for <target-devel@vger.kernel.org>; Wed, 15 Apr 2020 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+bfCUElRvrAPmVBMOIFVDlt70V4vk+GeakY9Soaqik4=;
        b=Mwr3Hvke6qkKUwkMlQdwOAG6l4hEG8IUaQT8lKi9QtS/7ixwoIDtc2/o/EGhm8o1+G
         ffQsggJMg40osVmaehwNNr1jJH3WgruBdIOXIqOPMj/olcmiV3tqlntckVM8+IAIPjob
         tmhBqcecPBM8zZaPNGHlLhJcVbgVHRCiNzsRZs5Y0JB2tMJJlKjSidGoo5f7DHFREfX1
         8tFaLxTTXsNDhMZmCJtYbEiQyKEV7W1ShFtnVmPaKAVwtuEpso+uDwjFPgwRRfF1ldPH
         QjgAfZDiHUl38xmwIdTdQtdquGvI+KVG6GLxsMYMw6vBcvtjNco1Tyr1/XuPmA/Dknq8
         4IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+bfCUElRvrAPmVBMOIFVDlt70V4vk+GeakY9Soaqik4=;
        b=VfIwrEJG3BLhi0t45Rf9hD9geq3YpawAPAdowB+5FwkjYNNPYFwq+MzHj2J7aGija9
         zSpIfpvFvo8raZc6squ+lpEEqjLH8J7tqR1hqjXP25hvAGD76IGLAEyvi5t9BfFar6Tr
         t7ahY06N/tk8nWriLSWy2mdVaWI/mvFM/8ojMGsJGnIXu0BbZJ3B6c41klmHbnMujddl
         nS07VzMn53w/DMyUIG+g7EwQFmfCERjdxd99zhFWf1ftHE3zCi1XJIiSTeQ3GIP0pQ8C
         BVrSFOfeTX7wV169dr5q80gnyqe7rbLpql82i1aWiQpatvDMdcJoF/cg52IFTu73ssCD
         WVEA==
X-Gm-Message-State: AGi0PuYi64Cs9v0kx5ZTaHMLsLJrZlZxRbXQhj1v+XPz3pp89RAlmrLN
        iTPknrxzN6JhYzh0X7gY3/i4ug==
X-Google-Smtp-Source: APiQypLA+zObXCwcyxRLpX0xYKZ0QrTtTQgGwaLvCZmvVMaN7u2DLkzEEmaxprqIkFAH+QdfFH02Og==
X-Received: by 2002:a63:d10f:: with SMTP id k15mr24329834pgg.73.1586938108742;
        Wed, 15 Apr 2020 01:08:28 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id c10sm10020576pfc.23.2020.04.15.01.08.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 01:08:28 -0700 (PDT)
From:   Pu Hou <houpu@bytedance.com>
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, Pu Hou <houpu@bytedance.com>
Subject: [PATCH 0/2] iscsi-target: fix login error when receiving is too fast
Date:   Wed, 15 Apr 2020 04:08:17 -0400
Message-Id: <20200415080819.27327-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,
We encountered "iSCSI Login negotiation failed" several times.
After enable debug log in iscsi_target_nego.c of iSCSI target.
Error shows:
  "Got LOGIN_FLAGS_READ_ACTIVE=1, conn: xxxxxxxxxx >>>>"

Patch 1 is trying to fix this problem. Please see comment in patch 1
for details.

Pu Hou (2):
  iscsi-target: fix login error when receiving is too fast
  iscsi-target: Fix inconsistent debug message in
    __iscsi_target_sk_check_close

 drivers/target/iscsi/iscsi_target_nego.c | 31 ++++++++++++++++++++++++++-----
 include/target/iscsi/iscsi_target_core.h |  1 +
 2 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.11.0

