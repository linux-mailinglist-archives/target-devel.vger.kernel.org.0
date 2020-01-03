Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A012FD03
	for <lists+target-devel@lfdr.de>; Fri,  3 Jan 2020 20:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgACT11 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 3 Jan 2020 14:27:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36203 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgACT11 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:27:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so18638999plm.3
        for <target-devel@vger.kernel.org>; Fri, 03 Jan 2020 11:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctqoDYfxBXVjg9rqYDbp4Ekxfn7ZbefHTSrM52nYJk8=;
        b=StrZ7m5QpwRhtc6TAt7C00WH12C9voUe+JeW0GdHaCj2st0+wY6uEY3+25vmsbYWNf
         MTjFOaZ0FXEUO6La/mH+vUN3cOUr2Z90i2PaZPIjObRU3+fHk/898mI5OQLjge15la5F
         wmmERDCumqxpCv+1xG3M7xVwG1PnDEoZJBMfLeGqAolSwCYb7JSCPYf80/BopxAcEUeD
         eL4GvThOCqF8ltDtI3xg8epy4jm9ekAs7XiLBIEeevvpHgVTrG6PseMC7bpY6by+FBIm
         D+XiIJiSalPbhql26y76Mkz7+WS0PCzxrAYP4WVyaBLMkaZI6fFZgeCF14kQNdrVkNfQ
         FzVQ==
X-Gm-Message-State: APjAAAUbaEUMd/GF8jtk1Ef/hf0Tpy6jZL+MxSrDRHL63nlZbVWo1YoD
        AA0+1boSV5IvHkjq7DI+yao=
X-Google-Smtp-Source: APXvYqx6gTh9lpyVN83L7Cz1wHApzZkgH35puzSIVu3xJJwS7H2NAlLEzq1FKXAuiwCf6DkcZHrx5w==
X-Received: by 2002:a17:90b:3cc:: with SMTP id go12mr28449263pjb.89.1578079646493;
        Fri, 03 Jan 2020 11:27:26 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a17sm16328927pjv.6.2020.01.03.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 11:27:25 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>
Subject: [PATCH] tcm_qla2xxx: Make qlt_alloc_qfull_cmd() set cmd->se_cmd.map_tag
Date:   Fri,  3 Jan 2020 11:27:19 -0800
Message-Id: <20200103192719.205158-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Reduce code duplication by introducing the tcm_qla2xxx_{get,rel}_cmd()
functions. Introduce these functions in the tcm_qla2xxx.c source files
such that the qla_target.c source file becomes independent of the SCSI
target core header files. This patch fixes a bug, namely by ensuring that
qlt_alloc_qfull_cmd() sets cmd->se_cmd.map_tag.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.c  | 28 ++++++----------------------
 drivers/scsi/qla2xxx/qla_target.h  |  2 ++
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 25 +++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 512041b3163c..bb6a4b7d4134 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -27,8 +27,6 @@
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
-#include <target/target_core_base.h>
-#include <target/target_core_fabric.h>
 
 #include "qla_def.h"
 #include "qla_target.h"
@@ -3819,7 +3817,7 @@ void qlt_free_cmd(struct qla_tgt_cmd *cmd)
 		return;
 	}
 	cmd->jiffies_at_free = get_jiffies_64();
-	target_free_tag(sess->se_sess, &cmd->se_cmd);
+	cmd->vha->hw->tgt.tgt_ops->rel_cmd(cmd);
 }
 EXPORT_SYMBOL(qlt_free_cmd);
 
@@ -4153,7 +4151,7 @@ static void __qlt_do_work(struct qla_tgt_cmd *cmd)
 	qlt_send_term_exchange(qpair, NULL, &cmd->atio, 1, 0);
 
 	qlt_decr_num_pend_cmds(vha);
-	target_free_tag(sess->se_sess, &cmd->se_cmd);
+	cmd->vha->hw->tgt.tgt_ops->rel_cmd(cmd);
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
 	ha->tgt.tgt_ops->put_sess(sess);
@@ -4280,24 +4278,18 @@ static struct qla_tgt_cmd *qlt_get_tag(scsi_qla_host_t *vha,
 				       struct fc_port *sess,
 				       struct atio_from_isp *atio)
 {
-	struct se_session *se_sess = sess->se_sess;
 	struct qla_tgt_cmd *cmd;
-	int tag, cpu;
 
-	tag = sbitmap_queue_get(&se_sess->sess_tag_pool, &cpu);
-	if (tag < 0)
+	cmd = vha->hw->tgt.tgt_ops->get_cmd(sess);
+	if (!cmd)
 		return NULL;
 
-	cmd = &((struct qla_tgt_cmd *)se_sess->sess_cmd_map)[tag];
-	memset(cmd, 0, sizeof(struct qla_tgt_cmd));
 	cmd->cmd_type = TYPE_TGT_CMD;
 	memcpy(&cmd->atio, atio, sizeof(*atio));
 	cmd->state = QLA_TGT_STATE_NEW;
 	cmd->tgt = vha->vha_tgt.qla_tgt;
 	qlt_incr_num_pend_cmds(vha);
 	cmd->vha = vha;
-	cmd->se_cmd.map_tag = tag;
-	cmd->se_cmd.map_cpu = cpu;
 	cmd->sess = sess;
 	cmd->loop_id = sess->loop_id;
 	cmd->conf_compl_supported = sess->conf_compl_supported;
@@ -5355,9 +5347,7 @@ qlt_alloc_qfull_cmd(struct scsi_qla_host *vha,
 	struct qla_tgt *tgt = vha->vha_tgt.qla_tgt;
 	struct qla_hw_data *ha = vha->hw;
 	struct fc_port *sess;
-	struct se_session *se_sess;
 	struct qla_tgt_cmd *cmd;
-	int tag, cpu;
 	unsigned long flags;
 
 	if (unlikely(tgt->tgt_stop)) {
@@ -5387,10 +5377,8 @@ qlt_alloc_qfull_cmd(struct scsi_qla_host *vha,
 	if (!sess)
 		return;
 
-	se_sess = sess->se_sess;
-
-	tag = sbitmap_queue_get(&se_sess->sess_tag_pool, &cpu);
-	if (tag < 0) {
+	cmd = ha->tgt.tgt_ops->get_cmd(sess);
+	if (!cmd) {
 		ql_dbg(ql_dbg_io, vha, 0x3009,
 			"qla_target(%d): %s: Allocation of cmd failed\n",
 			vha->vp_idx, __func__);
@@ -5405,9 +5393,6 @@ qlt_alloc_qfull_cmd(struct scsi_qla_host *vha,
 		return;
 	}
 
-	cmd = &((struct qla_tgt_cmd *)se_sess->sess_cmd_map)[tag];
-	memset(cmd, 0, sizeof(struct qla_tgt_cmd));
-
 	qlt_incr_num_pend_cmds(vha);
 	INIT_LIST_HEAD(&cmd->cmd_list);
 	memcpy(&cmd->atio, atio, sizeof(*atio));
@@ -5417,7 +5402,6 @@ qlt_alloc_qfull_cmd(struct scsi_qla_host *vha,
 	cmd->reset_count = ha->base_qpair->chip_reset;
 	cmd->q_full = 1;
 	cmd->qpair = ha->base_qpair;
-	cmd->se_cmd.map_cpu = cpu;
 
 	if (qfull) {
 		cmd->q_full = 1;
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 4378788f8832..eb176fd9c105 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -671,6 +671,8 @@ struct qla_tgt_func_tmpl {
 	void (*handle_data)(struct qla_tgt_cmd *);
 	int (*handle_tmr)(struct qla_tgt_mgmt_cmd *, u64, uint16_t,
 			uint32_t);
+	struct qla_tgt_cmd *(*get_cmd)(struct fc_port *);
+	void (*rel_cmd)(struct qla_tgt_cmd *);
 	void (*free_cmd)(struct qla_tgt_cmd *);
 	void (*free_mcmd)(struct qla_tgt_mgmt_cmd *);
 	void (*free_session)(struct fc_port *);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 148f8e3645fd..9f7a79aff1ee 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -268,6 +268,29 @@ static void tcm_qla2xxx_complete_free(struct work_struct *work)
 	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
+static struct qla_tgt_cmd *tcm_qla2xxx_get_cmd(struct fc_port *sess)
+{
+	struct se_session *se_sess = sess->se_sess;
+	struct qla_tgt_cmd *cmd;
+	int tag, cpu;
+
+	tag = sbitmap_queue_get(&se_sess->sess_tag_pool, &cpu);
+	if (tag < 0)
+		return NULL;
+
+	cmd = &((struct qla_tgt_cmd *)se_sess->sess_cmd_map)[tag];
+	memset(cmd, 0, sizeof(struct qla_tgt_cmd));
+	cmd->se_cmd.map_tag = tag;
+	cmd->se_cmd.map_cpu = cpu;
+
+	return cmd;
+}
+
+static void tcm_qla2xxx_rel_cmd(struct qla_tgt_cmd *cmd)
+{
+	target_free_tag(cmd->sess->se_sess, &cmd->se_cmd);
+}
+
 /*
  * Called from qla_target_template->free_cmd(), and will call
  * tcm_qla2xxx_release_cmd via normal struct target_core_fabric_ops
@@ -1549,6 +1572,8 @@ static struct qla_tgt_func_tmpl tcm_qla2xxx_template = {
 	.handle_cmd		= tcm_qla2xxx_handle_cmd,
 	.handle_data		= tcm_qla2xxx_handle_data,
 	.handle_tmr		= tcm_qla2xxx_handle_tmr,
+	.get_cmd		= tcm_qla2xxx_get_cmd,
+	.rel_cmd		= tcm_qla2xxx_rel_cmd,
 	.free_cmd		= tcm_qla2xxx_free_cmd,
 	.free_mcmd		= tcm_qla2xxx_free_mcmd,
 	.free_session		= tcm_qla2xxx_free_session,
