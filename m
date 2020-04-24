Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D226B1B6C56
	for <lists+target-devel@lfdr.de>; Fri, 24 Apr 2020 05:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDXD7M (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 23 Apr 2020 23:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbgDXD7M (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:59:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B307EC09B046
        for <target-devel@vger.kernel.org>; Thu, 23 Apr 2020 20:59:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so445015pfx.7
        for <target-devel@vger.kernel.org>; Thu, 23 Apr 2020 20:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aKsqWMMF7XAjoR4qcP662Fe48hXXc7Lfc4rPTQqKh9o=;
        b=j5/WDfoRPCLBn1WQ1c0L6jqcy6WQKwUgIPItCEj01VYZseeyqXJPqHsKczRUkrrm5/
         5xqKigrsIQ/xiEudgVB3vcLyvmFMiloSYZsOb9gLtOJEbPQcsgjWpKrdiGX/Vrs6gUzv
         3BLBcg6NnxizxZuvBFGCtS+jKkq1bJW2t7EbQxtTQ/9v241gNCGko1mKHjkYkgWrmmUt
         4QeuYo0nHVzjyq67PWKGTzD4ubtvwDzxChO/LgXTLbpONFe1sUv/h4tKBTiyFVbQrP2Z
         pp20yse0r33YK7eQSQMp1bhZ1Bm48xQM++/MYbNuURnm5s1IrfuMtYQ8QnWyRfRAGqav
         PDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aKsqWMMF7XAjoR4qcP662Fe48hXXc7Lfc4rPTQqKh9o=;
        b=I9dR1lRESyzk4qFSN6pOIojFig8NgR8z0SojdduZRDKFh+XKZbuYV1TJRiMcXAsxMj
         yT7fcSusV+mTINAqQLn2p5z8HX4dK2CKMgFAXxTuLKRSaC+0D2l4TuyEVD2oaLKik/ug
         HrK+vJOwyWQOsNe0tbqht0gka0uYhm4lVBm1bOtfGxsLet5teXutz5ykFGrNIL6s4Bjv
         07SltmI5GxkKpOkOqQMqPiA98mKoRFaAIqkJK9B6hGJSt1mlHvd8GhO5xDO+JqNxi2nk
         tNZCgVSABrxueuxeP7LxeEj2wUrR87uvLnBqShWamIWAzwKg5AP55DGfJwdp7J8tMHNW
         mP5A==
X-Gm-Message-State: AGi0PuYBtsH3HH/mIP6AIZWeRaGdPrnDW8FQY9elhG0is8kotBE7p7Yh
        gr8+5G28+KIF15/WgFosm60Sgg==
X-Google-Smtp-Source: APiQypKWZLh/0XqqNuuWKjfHAZlWJhkXUX+e2woAMrVxhdNM1AcpFWit0BuA/jGbd3dZQrxSG++WkQ==
X-Received: by 2002:a63:f48:: with SMTP id 8mr7400137pgp.184.1587700750199;
        Thu, 23 Apr 2020 20:59:10 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id h14sm3624577pjc.46.2020.04.23.20.59.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 20:59:09 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     martin.petersen@oracle.com, mchristi@redhat.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH v2 0/2] iscsi-target: fix login error when receiving is too fast
Date:   Thu, 23 Apr 2020 23:58:41 -0400
Message-Id: <20200424035843.5914-1-houpu@bytedance.com>
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

Changes from v2:
* Improve comments in patch #1.
* Change bit possition of login_flags in patch #1.

Hou Pu (2):
  iscsi-target: fix login error when receiving is too fast
  iscsi-target: Fix inconsistent debug message in
    __iscsi_target_sk_check_close

 drivers/target/iscsi/iscsi_target_nego.c | 31 ++++++++++++++++++++++++++-----
 include/target/iscsi/iscsi_target_core.h |  9 +++++----
 2 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.11.0

