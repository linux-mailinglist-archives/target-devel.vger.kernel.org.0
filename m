Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CEC23A90A
	for <lists+target-devel@lfdr.de>; Mon,  3 Aug 2020 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHCPAN (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 3 Aug 2020 11:00:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56096 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbgHCPAL (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:00:11 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with SMTP; 3 Aug 2020 18:00:08 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 073F08HY019034;
        Mon, 3 Aug 2020 18:00:08 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     sagi@grimberg.me, michael.christie@oracle.com,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org
Cc:     oren@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/1] target: make iscsit_register_transport() return void
Date:   Mon,  3 Aug 2020 18:00:08 +0300
Message-Id: <20200803150008.83920-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This function always return 0 now, we can make it return void to
simplify the code. Also, no caller ever check the return value of this
function.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/target/iscsi/iscsi_target_transport.c | 4 +---
 include/target/iscsi/iscsi_transport.h        | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_transport.c b/drivers/target/iscsi/iscsi_target_transport.c
index 0369405..27c85f2 100644
--- a/drivers/target/iscsi/iscsi_target_transport.c
+++ b/drivers/target/iscsi/iscsi_target_transport.c
@@ -31,7 +31,7 @@ void iscsit_put_transport(struct iscsit_transport *t)
 	module_put(t->owner);
 }
 
-int iscsit_register_transport(struct iscsit_transport *t)
+void iscsit_register_transport(struct iscsit_transport *t)
 {
 	INIT_LIST_HEAD(&t->t_node);
 
@@ -40,8 +40,6 @@ int iscsit_register_transport(struct iscsit_transport *t)
 	mutex_unlock(&transport_mutex);
 
 	pr_debug("Registered iSCSI transport: %s\n", t->name);
-
-	return 0;
 }
 EXPORT_SYMBOL(iscsit_register_transport);
 
diff --git a/include/target/iscsi/iscsi_transport.h b/include/target/iscsi/iscsi_transport.h
index 75bee29..b8feba7 100644
--- a/include/target/iscsi/iscsi_transport.h
+++ b/include/target/iscsi/iscsi_transport.h
@@ -43,7 +43,7 @@ static inline void *iscsit_priv_cmd(struct iscsi_cmd *cmd)
  * From iscsi_target_transport.c
  */
 
-extern int iscsit_register_transport(struct iscsit_transport *);
+extern void iscsit_register_transport(struct iscsit_transport *);
 extern void iscsit_unregister_transport(struct iscsit_transport *);
 extern struct iscsit_transport *iscsit_get_transport(int);
 extern void iscsit_put_transport(struct iscsit_transport *);
-- 
1.8.3.1

