Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3311567ABD0
	for <lists+target-devel@lfdr.de>; Wed, 25 Jan 2023 09:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjAYIdm (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 25 Jan 2023 03:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjAYIdi (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:33:38 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FDE12853;
        Wed, 25 Jan 2023 00:33:28 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id EB3FB341A2F;
        Wed, 25 Jan 2023 11:33:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:message-id:mime-version:reply-to:subject:subject:to
        :to; s=mta-01; bh=z+ELjG6AHk+/akSVuR+Vr/Nfmsx63Zc83HiLhTm9oUM=; b=
        d3l4Led4gVhoo9Gy+ziEaWY5jHOkijRrnfIew4H2ZrcMi1DEkVuN4fdvJWkZehF9
        qcKcbI4R2RgDsOs9q3CYAtqy3CW+EkvVFPZy+vllIC28cGAodd4X+fEGWV5khgL0
        StC7m9ChGTTq5JfYTDyz251+Az6v6+bM4JKOGwwedWE=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id E0437341A0E;
        Wed, 25 Jan 2023 11:33:26 +0300 (MSK)
Received: from NB-591.corp.yadro.com (10.199.18.20) by
 T-EXCH-08.corp.yadro.com (172.17.11.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.9; Wed, 25 Jan 2023 11:33:26 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>
CC:     Forza <forza@tnonline.net>, <linux-scsi@vger.kernel.org>,
        <linux@yadro.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH 0/2] fix iscsi commands when session is freed
Date:   Wed, 25 Jan 2023 11:33:07 +0300
Message-ID: <20230125083309.24678-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The patchset based on 6.3/scsi-queue.

The patchset fixes use-after-free of se_session at commands free.

Dmitry Bogdanov (2):
  target: iscs: reject cmd in closed session
  target: iscsi: free cmds before session free

 drivers/target/iscsi/iscsi_target.c | 14 +++++++++-----
 include/scsi/iscsi_proto.h          |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.25.1


