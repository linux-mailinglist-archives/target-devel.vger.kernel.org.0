Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FB76E4F17
	for <lists+target-devel@lfdr.de>; Mon, 17 Apr 2023 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjDQRU2 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 17 Apr 2023 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDQRU0 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760C7B77B
        for <target-devel@vger.kernel.org>; Mon, 17 Apr 2023 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681751889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m7QmFPaAoThgqZyiuHv0SggC2spi6M1ntKfQGHx/ahQ=;
        b=D/pmLzgWyN4uDW3oq/mIFOm1VA76rtSc52t5V4sE6Gr/sz7A8MKEes7qzYy1P9ngghBq8J
        WxQ26aXUqMxZrKldrz/y7fLL2aCsrHIu+uAVA2r+MW1wbfeWlJWbFpr6pwlrY9U0X7xaDJ
        yADOI72cANGmVcHIeuos0oodXAVKDpw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-xwNMgBaZONWIX7SD5bcKHg-1; Mon, 17 Apr 2023 13:18:04 -0400
X-MC-Unique: xwNMgBaZONWIX7SD5bcKHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BD2928004E9;
        Mon, 17 Apr 2023 17:18:04 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.35.206.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35AFD4024B77;
        Mon, 17 Apr 2023 17:18:02 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     martin.petersen@oracle.com
Cc:     michael.christie@oracle.com, target-devel@vger.kernel.org
Subject: [PATCH V2 0/3] Fix possible hangs and race conditions during login
Date:   Mon, 17 Apr 2023 19:17:58 +0200
Message-Id: <20230417171801.208122-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

PATCH 1 fixes a possible hang when during a login operation the initiator
stops sending data to the target and the login_work doesn't get scheduled.

PATCH 3 fixes a bug in iscsi_target_locate_portal(), in the error
code path the login semaphore may end up being released even if
no one called down() against it, this may allow
multiple threads to access the semaphore-protected code.

v2: the login timeout of 15 seconds now is relative to the entire
    login operation and not per-PDU.

Maurizio Lombardi (3):
  target: iscsi: fix hang in the iSCSI login code
  target: iscsi: remove unused transport_timer
  target: iscsi: prevent login threads from racing between each other

 drivers/target/iscsi/iscsi_target.c       |  2 -
 drivers/target/iscsi/iscsi_target_login.c | 63 ++------------------
 drivers/target/iscsi/iscsi_target_nego.c  | 72 +++++++++++++----------
 drivers/target/iscsi/iscsi_target_util.c  | 51 ++++++++++++++++
 drivers/target/iscsi/iscsi_target_util.h  |  4 ++
 include/target/iscsi/iscsi_target_core.h  |  7 ++-
 6 files changed, 104 insertions(+), 95 deletions(-)

-- 
2.31.1

