Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870921679A0
	for <lists+target-devel@lfdr.de>; Fri, 21 Feb 2020 10:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBUJoO (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 21 Feb 2020 04:44:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:38746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgBUJoO (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:44:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3671CAAC2;
        Fri, 21 Feb 2020 09:44:11 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH] scsi: target: use an enum to track emulate_ua_intlck_ctrl
Date:   Fri, 21 Feb 2020 10:44:01 +0100
Message-Id: <20200221094401.32021-1-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The emulate_ua_intlck_ctrl device attribute accepts values of 0, 1 or 2
via ConfigFS, which map to unit attention interlocks control codes in
the MODE SENSE control Mode Page.
Use an enum to track these values so that it's clear that, unlike the
remaining emulate_X attributes, emulate_ua_intlck_ctrl isn't boolean.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/target_core_configfs.c  |  4 +++-
 drivers/target/target_core_device.c    |  2 +-
 drivers/target/target_core_spc.c       | 13 +++++++++++--
 drivers/target/target_core_transport.c |  3 ++-
 drivers/target/target_core_ua.c        |  8 +++++---
 include/target/target_core_base.h      | 11 ++++++++---
 6 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index e6e175597860..ff82b21fdcce 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -684,7 +684,9 @@ static ssize_t emulate_ua_intlck_ctrl_store(struct config_item *item,
 	if (ret < 0)
 		return ret;
 
-	if (val != 0 && val != 1 && val != 2) {
+	if (val != TARGET_UA_INTLCK_CTRL_CLEAR
+	 && val != TARGET_UA_INTLCK_CTRL_NO_CLEAR
+	 && val != TARGET_UA_INTLCK_CTRL_ESTABLISH_UA) {
 		pr_err("Illegal value %d\n", val);
 		return -EINVAL;
 	}
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 2c7ba2f7e13c..4cee1138284b 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -767,7 +767,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	dev->dev_attrib.emulate_fua_write = 1;
 	dev->dev_attrib.emulate_fua_read = 1;
 	dev->dev_attrib.emulate_write_cache = DA_EMULATE_WRITE_CACHE;
-	dev->dev_attrib.emulate_ua_intlck_ctrl = DA_EMULATE_UA_INTLLCK_CTRL;
+	dev->dev_attrib.emulate_ua_intlck_ctrl = TARGET_UA_INTLCK_CTRL_CLEAR;
 	dev->dev_attrib.emulate_tas = DA_EMULATE_TAS;
 	dev->dev_attrib.emulate_tpu = DA_EMULATE_TPU;
 	dev->dev_attrib.emulate_tpws = DA_EMULATE_TPWS;
diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index 6d4cf2643c0a..ca5579ebc81d 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -847,8 +847,17 @@ static int spc_modesense_control(struct se_cmd *cmd, u8 pc, u8 *p)
 	 * for a BUSY, TASK SET FULL, or RESERVATION CONFLICT status regardless
 	 * to the number of commands completed with one of those status codes.
 	 */
-	p[4] = (dev->dev_attrib.emulate_ua_intlck_ctrl == 2) ? 0x30 :
-	       (dev->dev_attrib.emulate_ua_intlck_ctrl == 1) ? 0x20 : 0x00;
+	switch (dev->dev_attrib.emulate_ua_intlck_ctrl) {
+	case TARGET_UA_INTLCK_CTRL_ESTABLISH_UA:
+		p[4] = 0x30;
+		break;
+	case TARGET_UA_INTLCK_CTRL_NO_CLEAR:
+		p[4] = 0x20;
+		break;
+	default:	/* TARGET_UA_INTLCK_CTRL_CLEAR */
+		p[4] = 0x00;
+		break;
+	}
 	/*
 	 * From spc4r17, section 7.4.6 Control mode Page
 	 *
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index ea482d4b1f00..9681d4ba02d7 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1879,7 +1879,8 @@ void transport_generic_request_failure(struct se_cmd *cmd,
 		 * See spc4r17, section 7.4.6 Control Mode Page, Table 349
 		 */
 		if (cmd->se_sess &&
-		    cmd->se_dev->dev_attrib.emulate_ua_intlck_ctrl == 2) {
+		    cmd->se_dev->dev_attrib.emulate_ua_intlck_ctrl
+					== TARGET_UA_INTLCK_CTRL_ESTABLISH_UA) {
 			target_ua_allocate_lun(cmd->se_sess->se_node_acl,
 					       cmd->orig_fe_lun, 0x2C,
 					ASCQ_2CH_PREVIOUS_RESERVATION_CONFLICT_STATUS);
diff --git a/drivers/target/target_core_ua.c b/drivers/target/target_core_ua.c
index 151b56002da5..4276690fb6cb 100644
--- a/drivers/target/target_core_ua.c
+++ b/drivers/target/target_core_ua.c
@@ -199,6 +199,8 @@ bool core_scsi3_ua_for_check_condition(struct se_cmd *cmd, u8 *key, u8 *asc,
 	struct se_node_acl *nacl;
 	struct se_ua *ua = NULL, *ua_p;
 	int head = 1;
+	bool dev_ua_intlck_clear = (dev->dev_attrib.emulate_ua_intlck_ctrl
+						== TARGET_UA_INTLCK_CTRL_CLEAR);
 
 	if (WARN_ON_ONCE(!sess))
 		return false;
@@ -229,7 +231,7 @@ bool core_scsi3_ua_for_check_condition(struct se_cmd *cmd, u8 *key, u8 *asc,
 		 * highest priority UNIT_ATTENTION and ASC/ASCQ without
 		 * clearing it.
 		 */
-		if (dev->dev_attrib.emulate_ua_intlck_ctrl != 0) {
+		if (!dev_ua_intlck_clear) {
 			*asc = ua->ua_asc;
 			*ascq = ua->ua_ascq;
 			break;
@@ -254,8 +256,8 @@ bool core_scsi3_ua_for_check_condition(struct se_cmd *cmd, u8 *key, u8 *asc,
 		" INTLCK_CTRL: %d, mapped LUN: %llu, got CDB: 0x%02x"
 		" reported ASC: 0x%02x, ASCQ: 0x%02x\n",
 		nacl->se_tpg->se_tpg_tfo->fabric_name,
-		(dev->dev_attrib.emulate_ua_intlck_ctrl != 0) ? "Reporting" :
-		"Releasing", dev->dev_attrib.emulate_ua_intlck_ctrl,
+		dev_ua_intlck_clear ? "Releasing" : "Reporting",
+		dev->dev_attrib.emulate_ua_intlck_ctrl,
 		cmd->orig_fe_lun, cmd->t_task_cdb[0], *asc, *ascq);
 
 	return head == 0;
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index bbac0f1c3ba1..6d4a694f6ea7 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -74,8 +74,6 @@
 #define DA_EMULATE_MODEL_ALIAS			0
 /* Emulation for WriteCache and SYNCHRONIZE_CACHE */
 #define DA_EMULATE_WRITE_CACHE			0
-/* Emulation for UNIT ATTENTION Interlock Control */
-#define DA_EMULATE_UA_INTLLCK_CTRL		0
 /* Emulation for TASK_ABORTED status (TAS) by default */
 #define DA_EMULATE_TAS				1
 /* Emulation for Thin Provisioning UNMAP using block/blk-lib.c:blkdev_issue_discard() */
@@ -433,6 +431,13 @@ enum target_prot_type {
 	TARGET_DIF_TYPE3_PROT,
 };
 
+/* Emulation for UNIT ATTENTION Interlock Control */
+enum target_ua_intlck_ctrl {
+	TARGET_UA_INTLCK_CTRL_CLEAR = 0,
+	TARGET_UA_INTLCK_CTRL_NO_CLEAR = 1,
+	TARGET_UA_INTLCK_CTRL_ESTABLISH_UA = 2,
+};
+
 enum target_core_dif_check {
 	TARGET_DIF_CHECK_GUARD  = 0x1 << 0,
 	TARGET_DIF_CHECK_APPTAG = 0x1 << 1,
@@ -668,7 +673,7 @@ struct se_dev_attrib {
 	bool		emulate_fua_write;
 	bool		emulate_fua_read;	/* deprecated */
 	bool		emulate_write_cache;
-	int		emulate_ua_intlck_ctrl;
+	enum target_ua_intlck_ctrl emulate_ua_intlck_ctrl;
 	bool		emulate_tas;
 	bool		emulate_tpu;
 	bool		emulate_tpws;
-- 
2.16.4

