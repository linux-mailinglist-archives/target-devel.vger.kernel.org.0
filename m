Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ADD286195
	for <lists+target-devel@lfdr.de>; Wed,  7 Oct 2020 16:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgJGOx4 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 7 Oct 2020 10:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728679AbgJGOxy (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602082433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odS/FADxguwMdYrBZ1VHdSAflMyHx/SE0+n5W31X5qs=;
        b=cVZ8XSb9HkGfAmkoUOCWkAeeq0qUixRoS5YjK0OC8mvt06lCDE4FkUsVnuoleJdClFG7+Y
        99C8sbGSeDKENf5IJXaO4X4n8VTq40/udNe596Tl1FUwHWwjQ87CYJGAWPLi9oUivZo12G
        Q5Vw4Nj++tDiGwK77kb6+HMXxFSh5fI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-FH9_0ImGN--dthyhol7aEQ-1; Wed, 07 Oct 2020 10:53:52 -0400
X-MC-Unique: FH9_0ImGN--dthyhol7aEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C76E890E7A;
        Wed,  7 Oct 2020 14:53:32 +0000 (UTC)
Received: from nangaparbat.redhat.com (unknown [10.35.206.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 173E560BEC;
        Wed,  7 Oct 2020 14:53:29 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        bvanassche@acm.org, michael.christie@oracle.com
Subject: [PATCH 1/2] target: iscsi: prevent a race condition in iscsit_unmap_cmd()
Date:   Wed,  7 Oct 2020 16:53:25 +0200
Message-Id: <20201007145326.56850-2-mlombard@redhat.com>
In-Reply-To: <20201007145326.56850-1-mlombard@redhat.com>
References: <20201007145326.56850-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

A potential race condition may occur in iscsit_unmap_cmd() if the
__iscsit_free_cmd() function is called by two different threads.

This patch adds a spinlock to serialize the calls to
iscsit_unmap_cmd()

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target_login.c | 1 +
 drivers/target/iscsi/iscsi_target_util.c  | 5 ++++-
 include/target/iscsi/iscsi_target_core.h  | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 893d1b406c29..e16ceee87bba 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -1110,6 +1110,7 @@ static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
 	spin_lock_init(&conn->nopin_timer_lock);
 	spin_lock_init(&conn->response_queue_lock);
 	spin_lock_init(&conn->state_lock);
+	spin_lock_init(&conn->unmap_cmd_lock);
 
 	timer_setup(&conn->nopin_response_timer,
 		    iscsit_handle_nopin_response_timeout, 0);
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 45ba07c6ec27..3082f5bde9fa 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -755,8 +755,11 @@ void __iscsit_free_cmd(struct iscsi_cmd *cmd, bool check_queues)
 		iscsit_remove_cmd_from_response_queue(cmd, conn);
 	}
 
-	if (conn && conn->conn_transport->iscsit_unmap_cmd)
+	if (conn && conn->conn_transport->iscsit_unmap_cmd) {
+		spin_lock(&conn->unmap_cmd_lock);
 		conn->conn_transport->iscsit_unmap_cmd(conn, cmd);
+		spin_unlock(&conn->unmap_cmd_lock);
+	}
 }
 
 void iscsit_free_cmd(struct iscsi_cmd *cmd, bool shutdown)
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 1eccb2ac7d02..ae7ac0134c8c 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -575,6 +575,7 @@ struct iscsi_conn {
 	spinlock_t		nopin_timer_lock;
 	spinlock_t		response_queue_lock;
 	spinlock_t		state_lock;
+	spinlock_t		unmap_cmd_lock;
 	/* libcrypto RX and TX contexts for crc32c */
 	struct ahash_request	*conn_rx_hash;
 	struct ahash_request	*conn_tx_hash;
-- 
2.26.2

