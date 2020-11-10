Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA82AE1C0
	for <lists+target-devel@lfdr.de>; Tue, 10 Nov 2020 22:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgKJV3p (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 10 Nov 2020 16:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbgKJV3p (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605043783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kc+ZhU9ws//7PzGXJeqUYAOEvQWX0tFw9KDWrcTSRo=;
        b=eXAj6VsBGESFPYItDxVsa65D3VMOA9wtljnaZR/4Z/bVX3DY/1mjbRe3BLI1htnUzgWcpG
        E+7UgngdLaPwOM6N3EOyVzk6J/o4NeDzziaJOOXL/QRDTvh9ch8yixBS0gEyp9+j9maYXM
        jXSMHq+JbqGPU0GDeLd4WtcXuEY7ROo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-UXVzcuCMMjG4dwGD7vqdmg-1; Tue, 10 Nov 2020 16:29:39 -0500
X-MC-Unique: UXVzcuCMMjG4dwGD7vqdmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2D3359;
        Tue, 10 Nov 2020 21:29:37 +0000 (UTC)
Received: from [10.35.206.163] (unknown [10.35.206.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 736285B4A0;
        Tue, 10 Nov 2020 21:29:35 +0000 (UTC)
Subject: Re: [PATCH 2/2] target: iscsi: fix a race condition when aborting a
 task
To:     Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        bvanassche@acm.org, m.lombardi85@gmail.com
References: <20201007145326.56850-1-mlombard@redhat.com>
 <20201007145326.56850-3-mlombard@redhat.com>
 <20daa17d-08e7-a412-4d33-bcf75587eca6@oracle.com>
 <1852a8bd-3edc-5c49-fa51-9afe52f125a8@redhat.com>
 <184667b1-032b-c36f-d1e7-5cfef961c763@oracle.com>
 <71691FED-C164-482C-B629-A8B89B81E566@oracle.com>
 <a936cc4e-1610-5201-5960-107689b81820@redhat.com>
 <d7107857-ef7a-3c88-8146-a5e7abce5ce6@oracle.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <840cb2fe-5642-78d0-e700-d3652021cb5d@redhat.com>
Date:   Tue, 10 Nov 2020 22:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d7107857-ef7a-3c88-8146-a5e7abce5ce6@oracle.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



Dne 28. 10. 20 v 21:37 Mike Christie napsal(a):
>>
>> Possible solutions that I can think of:
>>
>> - Make iscsit_release_commands_from_conn() wait for the abort task to finish
> 
> Yeah you could set a completion in there then have aborted_task do the complete() call maybe?
> 

We could do something like this, what do you think?

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 067074ef50818..ffd3dbc53a42f 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -490,13 +490,16 @@ EXPORT_SYMBOL(iscsit_queue_rsp);
 
 void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
 {
+	struct se_cmd *se_cmd = cmd->se_cmd.se_tfo ? &cmd->se_cmd : NULL;
+
 	spin_lock_bh(&conn->cmd_lock);
-	if (!list_empty(&cmd->i_conn_node) &&
-	    !(cmd->se_cmd.transport_state & CMD_T_FABRIC_STOP))
+	if (!list_empty(&cmd->i_conn_node))
 		list_del_init(&cmd->i_conn_node);
 	spin_unlock_bh(&conn->cmd_lock);
 
 	__iscsit_free_cmd(cmd, true);
+	if (se_cmd && se_cmd->abrt_task_compl)
+		complete(se_cmd->abrt_task_compl);
 }
 EXPORT_SYMBOL(iscsit_aborted_task);
 
@@ -4080,6 +4083,7 @@ int iscsi_target_rx_thread(void *arg)
 
 static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 {
+	DECLARE_COMPLETION_ONSTACK(compl);
 	LIST_HEAD(tmp_list);
 	struct iscsi_cmd *cmd = NULL, *cmd_tmp = NULL;
 	struct iscsi_session *sess = conn->sess;
@@ -4096,8 +4100,24 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 
 		if (se_cmd->se_tfo != NULL) {
 			spin_lock_irq(&se_cmd->t_state_lock);
+			if (se_cmd->transport_state & CMD_T_ABORTED) {
+				/*
+				 * LIO's abort path owns the cleanup for this,
+				 * so put it back on the list and let
+				 * aborted_task handle it.
+				 */
+				list_move_tail(&cmd->i_conn_node, &conn->conn_cmd_list);
+				WARN_ON_ONCE(se_cmd->abrt_task_compl);
+				se_cmd->abrt_task_compl = &compl;
+			}
 			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
 			spin_unlock_irq(&se_cmd->t_state_lock);
+
+			if (se_cmd->abrt_task_compl) {
+				spin_unlock_bh(&conn->cmd_lock);
+				wait_for_completion(&compl);
+				spin_lock_bh(&conn->cmd_lock);
+			}
 		}
 	}
 	spin_unlock_bh(&conn->cmd_lock);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index db53a0d649da7..5611e6c00f18c 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1391,6 +1391,7 @@ void transport_init_se_cmd(
 	init_completion(&cmd->t_transport_stop_comp);
 	cmd->free_compl = NULL;
 	cmd->abrt_compl = NULL;
+	cmd->abrt_task_compl = NULL;
 	spin_lock_init(&cmd->t_state_lock);
 	INIT_WORK(&cmd->work, NULL);
 	kref_init(&cmd->cmd_kref);
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 549947d407cfd..25cc451930281 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -491,6 +491,7 @@ struct se_cmd {
 	struct list_head	se_cmd_list;
 	struct completion	*free_compl;
 	struct completion	*abrt_compl;
+	struct completion	*abrt_task_compl;
 	const struct target_core_fabric_ops *se_tfo;
 	sense_reason_t		(*execute_cmd)(struct se_cmd *);
 	sense_reason_t (*transport_complete_callback)(struct se_cmd *, bool, int *);
-- 
2.26.2

