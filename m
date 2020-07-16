Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29670222032
	for <lists+target-devel@lfdr.de>; Thu, 16 Jul 2020 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgGPKC2 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 16 Jul 2020 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgGPKC2 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:02:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB6CC061755
        for <target-devel@vger.kernel.org>; Thu, 16 Jul 2020 03:02:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so3638061plm.10
        for <target-devel@vger.kernel.org>; Thu, 16 Jul 2020 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8KCEDyzuLkbcpVZGfySB4y96ddeEQZ8RPghp3Jsi0n4=;
        b=oqio3hkpZbKMI2Ip0c8zg1hoFsfRNWVeX64ngQlRsxOj2TnPHThhbDiUquuNg80J9O
         zwlzcOkSmaAd90L8qA258025pCUTCRzupUwJ7jluAcZhHxKHfLBP9ljLtPmF8w90bf/g
         45I/scLSkJi67PouSzjQGwIJtnFuOMw76b6JfRIa966LGLGuhsjzH6BeExG4+t/sRmtd
         ok6WLZGPnsHer//EKIUPLHIMAGZjQd96l9a/l7IYcNCCHsyDBbv9p8IypmR+dcjup2rC
         F+yDiBWiv8Pdzj6EE/12Dec7w8shr3US7aVqHBYlrGloTdQVffNOLQUvMwKS1GnAtLET
         pBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8KCEDyzuLkbcpVZGfySB4y96ddeEQZ8RPghp3Jsi0n4=;
        b=mKpqWMCQZ8/RQHoQvvRttUJKP8mRg1cAO0ms2k84znbsGj5USagXiLAkFMnOkNwBgi
         M6NKsaiiZ/sxwwTwG46xb1rX+dO2o/5KyWKaCo173/tjSABcydlGyikg5ga4kDZE7ZMe
         p7pEB254MGjXPnEFEulHMKBK+LcJeh7s713JIe7tr2n4YZW8tS6+HKzkwq3Yl/xgChld
         IxcUSlzdguidwcHe5MP96metOGVNRR9o6mfRb8KaI1rUvTns1HDYHpfj1xddDQ4c4u1P
         OhwJBXEleKjTh1KF2EV7A9JQBVCWnaPlWiOA+onPxV7Mb3IUv2iTrQJdkSHWQX7CEguG
         9IGQ==
X-Gm-Message-State: AOAM530Ko3T8odDdAQDEygCvNOLtfy+bPPK6nuXge8UVRd975BEJdelZ
        fMa9nG0lHisMtojMfwUxE0TVKw==
X-Google-Smtp-Source: ABdhPJzf7RTvVZ3bTaAkFTBdRQ3PV5WtK18zb3uZ+3jccUiVH2Kx5D/ZYva+Itx7uIR6phl1fMZn4Q==
X-Received: by 2002:a17:902:d685:: with SMTP id v5mr2936547ply.117.1594893747632;
        Thu, 16 Jul 2020 03:02:27 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id f29sm4602477pga.59.2020.07.16.03.02.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2020 03:02:26 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, Hou Pu <houpu@bytedance.com>
Subject: [PATCH v4 0/2] iscsi-target: fix login error when receiving is too fast
Date:   Thu, 16 Jul 2020 06:02:10 -0400
Message-Id: <20200716100212.4237-1-houpu@bytedance.com>
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

Sorry for delay of v4. Version 3 of this patchset could be found here[1].

Changes from v4:
* In iscsi_target_do_login_rx(), call cancel_delayed_work() if it is final
  login pdu. Also call cancel_delayed_work() if current negotiation is failed.
  This is advised by Mike Christie. See below[1] for more details.

Changes from v3:
* Fix style problem found by checkpatch.pl.

Changes from v2:
* Improve comments in patch #1.
* Change bit possition of login_flags in patch #1.


[1]:
https://www.spinics.net/lists/target-devel/msg18281.html

Hou Pu (2):
  iscsi-target: fix login error when receiving is too fast
  iscsi-target: Fix inconsistent debug message in
    __iscsi_target_sk_check_close

 drivers/target/iscsi/iscsi_target_nego.c | 36 +++++++++++++++++++++++++++-----
 include/target/iscsi/iscsi_target_core.h |  9 ++++----
 2 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.11.0

