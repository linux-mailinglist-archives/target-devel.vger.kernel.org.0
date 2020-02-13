Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9915B8CB
	for <lists+target-devel@lfdr.de>; Thu, 13 Feb 2020 06:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgBMFJJ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 13 Feb 2020 00:09:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50408 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgBMFJJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:09:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so1848291pjb.0
        for <target-devel@vger.kernel.org>; Wed, 12 Feb 2020 21:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbHafbCA5zTo4T6UNbio+bK6idFQUDAk25CROjCMSvw=;
        b=LIYysUYY+f+qrtD670uz9hyvTq+6ZBAzFd8pL+7UODci9uOuI3jSXQ7ncX8zbZe8Fm
         joAxYLBqeGx0KKI7wnM9x09peQGvGoMrJGqsMcI3tEcxXaXdA8pQTBDSb66V+MDeifWl
         7T/4q0w9x0PFr1pSNbJjT1prnIFzfXDW+VGXM4HwF2Qy2tUZZx4AzyJZtvemelhlS8zU
         8IKIu2NPg/LLZ1YlMQnT5/o6ZIDnqGZa0hCh8WACHOAmvbqQxbrcdqLe9nV/SkdPZtNW
         mK3whMSaHHlSkn2sMPb3A8BNURlm4Xpwf9MEcEjZinJ1B0cTL3yjB85WRup/ToHMjQIi
         XU0A==
X-Gm-Message-State: APjAAAWq06sGMegBJjquEHaNOAc99QrgQ4ChDEHZQ8RtYYFo5JRkpBmC
        d5p1iTbc3oNLYj4zJk4k52Q=
X-Google-Smtp-Source: APXvYqzJce63MzV1cq04rgN8xLfpXZyTgc2A6DGbz7gSlcREsAtqI9LEvbBosHR/F7w1WLBZPUEqoQ==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr3000787pjb.47.1581570547075;
        Wed, 12 Feb 2020 21:09:07 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:a815:f3bb:71b5:79fa])
        by smtp.gmail.com with ESMTPSA id i2sm821994pjs.21.2020.02.12.21.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 21:09:05 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     target-devel@vger.kernel.org,
        Dakshaja Uppalapati <dakshaja@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rahul Kundu <rahul.kundu@chelsio.com>
Subject: [PATCH 1/2] Revert "RDMA/isert: Fix a recently introduced regression related to logout"
Date:   Wed, 12 Feb 2020 21:08:59 -0800
Message-Id: <20200213050900.19094-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Since commit 04060db41178 introduces soft lockups when toggling network
interfaces, revert it.

Cc: Rahul Kundu <rahul.kundu@chelsio.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
Fixes: 04060db41178 ("scsi: RDMA/isert: Fix a recently introduced regression related to logout")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 12 ++++++++++++
 drivers/target/iscsi/iscsi_target.c     |  6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b273e421e910..a1a035270cab 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2575,6 +2575,17 @@ isert_wait4logout(struct isert_conn *isert_conn)
 	}
 }
 
+static void
+isert_wait4cmds(struct iscsi_conn *conn)
+{
+	isert_info("iscsi_conn %p\n", conn);
+
+	if (conn->sess) {
+		target_sess_cmd_list_set_waiting(conn->sess->se_sess);
+		target_wait_for_sess_cmds(conn->sess->se_sess);
+	}
+}
+
 /**
  * isert_put_unsol_pending_cmds() - Drop commands waiting for
  *     unsolicitate dataout
@@ -2622,6 +2633,7 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 
 	ib_drain_qp(isert_conn->qp);
 	isert_put_unsol_pending_cmds(conn);
+	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
 
 	queue_work(isert_release_wq, &isert_conn->release_work);
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index b94ed4e30770..7251a87bb576 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4149,6 +4149,9 @@ int iscsit_close_connection(
 	iscsit_stop_nopin_response_timer(conn);
 	iscsit_stop_nopin_timer(conn);
 
+	if (conn->conn_transport->iscsit_wait_conn)
+		conn->conn_transport->iscsit_wait_conn(conn);
+
 	/*
 	 * During Connection recovery drop unacknowledged out of order
 	 * commands for this connection, and prepare the other commands
@@ -4234,9 +4237,6 @@ int iscsit_close_connection(
 	target_sess_cmd_list_set_waiting(sess->se_sess);
 	target_wait_for_sess_cmds(sess->se_sess);
 
-	if (conn->conn_transport->iscsit_wait_conn)
-		conn->conn_transport->iscsit_wait_conn(conn);
-
 	ahash_request_free(conn->conn_tx_hash);
 	if (conn->conn_rx_hash) {
 		struct crypto_ahash *tfm;
