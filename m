Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98615B8CA
	for <lists+target-devel@lfdr.de>; Thu, 13 Feb 2020 06:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgBMFJJ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 13 Feb 2020 00:09:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41242 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgBMFJJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:09:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so2411280pfa.8
        for <target-devel@vger.kernel.org>; Wed, 12 Feb 2020 21:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/IhYIWV0dvN4qg5NIxVcEvKo8VzeM1Sg1SyB58qN0U=;
        b=eNs/v7fUjNFS368M1/KvrJwtOd7D37NXSnz2VC0//Zw7PCUdn6ZgErTKJXT0AEHzkc
         yvMdk2P8n3OK9aGin0BfEUHSrRzshcEe5CqRTuEmv1jtIc2ByQ/ZKIXhZaxpCpyOt99Z
         53nYMIQtMWYF6UmZCM69S9NcccNVmYqkR637ruKmrY+1SFl0Eo6p1jUYpFZe1zGiMeky
         xDnS6L/yYnltAAlrmzWd8DEf7CyR+UtfflW547kHBq6c5DFnKzn4h0Lq7qb8duwpw9zo
         fpfQKj4GyOKGqdKijdiFZ29f8Id6Ie/+IQWyKOu9spSIhhlIqLrd0aFLBCP7qvT59mPQ
         7QKQ==
X-Gm-Message-State: APjAAAXAc3scFhnVFj/TGLnjoR/TZOj867WC5eFpF+dVJ+fnlR5sLfpF
        eNgEVVCZyhkpbYcO+DE/AEk=
X-Google-Smtp-Source: APXvYqyO8W2b/SREbICV3qh//alxBzUpHxuzh7aiRifiPuKdS8Q5clZxnu+XAGqWQqbXdIYQvnp/UA==
X-Received: by 2002:a62:e318:: with SMTP id g24mr11829552pfh.218.1581570548543;
        Wed, 12 Feb 2020 21:09:08 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:a815:f3bb:71b5:79fa])
        by smtp.gmail.com with ESMTPSA id i2sm821994pjs.21.2020.02.12.21.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 21:09:07 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     target-devel@vger.kernel.org,
        Dakshaja Uppalapati <dakshaja@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rahul Kundu <rahul.kundu@chelsio.com>
Subject: [PATCH 2/2] Revert "target: iscsi: Wait for all commands to finish before freeing a session"
Date:   Wed, 12 Feb 2020 21:09:00 -0800
Message-Id: <20200213050900.19094-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213050900.19094-1-bvanassche@acm.org>
References: <20200213050900.19094-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Since commit e9d3009cb936 introduced a regression and since the fix for
that regression was not perfect, revert this commit.

Cc: Rahul Kundu <rahul.kundu@chelsio.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
Fixes: e9d3009cb936 ("scsi: target: iscsi: Wait for all commands to finish before freeing a session")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/iscsi/iscsi_target.c | 10 ++--------
 include/scsi/iscsi_proto.h          |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 7251a87bb576..09e55ea0bf5d 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1165,9 +1165,7 @@ int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 		hdr->cmdsn, be32_to_cpu(hdr->data_length), payload_length,
 		conn->cid);
 
-	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
-		return iscsit_add_reject_cmd(cmd,
-				ISCSI_REASON_WAITING_FOR_LOGOUT, buf);
+	target_get_sess_cmd(&cmd->se_cmd, true);
 
 	cmd->sense_reason = transport_lookup_cmd_lun(&cmd->se_cmd,
 						     scsilun_to_int(&hdr->lun));
@@ -2004,9 +2002,7 @@ iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 			      conn->sess->se_sess, 0, DMA_NONE,
 			      TCM_SIMPLE_TAG, cmd->sense_buffer + 2);
 
-	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
-		return iscsit_add_reject_cmd(cmd,
-				ISCSI_REASON_WAITING_FOR_LOGOUT, buf);
+	target_get_sess_cmd(&cmd->se_cmd, true);
 
 	/*
 	 * TASK_REASSIGN for ERL=2 / connection stays inside of
@@ -4234,8 +4230,6 @@ int iscsit_close_connection(
 	 * must wait until they have completed.
 	 */
 	iscsit_check_conn_usage_count(conn);
-	target_sess_cmd_list_set_waiting(sess->se_sess);
-	target_wait_for_sess_cmds(sess->se_sess);
 
 	ahash_request_free(conn->conn_tx_hash);
 	if (conn->conn_rx_hash) {
diff --git a/include/scsi/iscsi_proto.h b/include/scsi/iscsi_proto.h
index 533f56733ba8..b71b5c4f418c 100644
--- a/include/scsi/iscsi_proto.h
+++ b/include/scsi/iscsi_proto.h
@@ -627,7 +627,6 @@ struct iscsi_reject {
 #define ISCSI_REASON_BOOKMARK_INVALID	9
 #define ISCSI_REASON_BOOKMARK_NO_RESOURCES	10
 #define ISCSI_REASON_NEGOTIATION_RESET	11
-#define ISCSI_REASON_WAITING_FOR_LOGOUT	12
 
 /* Max. number of Key=Value pairs in a text message */
 #define MAX_KEY_VALUE_PAIRS	8192
