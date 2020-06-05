Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C631F0159
	for <lists+target-devel@lfdr.de>; Fri,  5 Jun 2020 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgFEVMn (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 5 Jun 2020 17:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgFEVMm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:12:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED869C08C5C5
        for <target-devel@vger.kernel.org>; Fri,  5 Jun 2020 14:12:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so4188515plr.4
        for <target-devel@vger.kernel.org>; Fri, 05 Jun 2020 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphix.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=AA4FCdrXxFCKHgy1r/N7KBvOfXji8W/T0Pq1Thwmj5o=;
        b=KA0MK3PIK3T9Iww1rzslY3fqzBzT+o5Tfch7PaOOgAXlywZdsMWNxtSIwJCQnYEvGO
         vpZqbYUlV9T42ETuAUH4wxfC+WVEhtCAE1kdUm3rmuLdH3bdmW3R3QQNHEsGWSe20u1S
         Jirdo5fkKTax6qI5Iqz2zi1QAL+M3iO40oweQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=AA4FCdrXxFCKHgy1r/N7KBvOfXji8W/T0Pq1Thwmj5o=;
        b=XEaA0VkA6Zpot23tIbRVQG62OuaxrmF7rrdZKNEyrsY96dPUuX11vZw/MhYOZISGw7
         e2W/T4t9PA1AMDhvLx3jo2iMTbcXtoB4eoCW2nueN/Zly6Bh222px78S1oBKA9jXN4gp
         KObLhTSbVRvuy59fqrmK4/Fszije51C5D8m67JbQjZhP4Cc4HCXR0HKTrLNgVMcc0XK2
         vg5eZgsBbAfuoTD6Xhez2zCU83zNKjcgmpQu1SHHu59eBcAns7tvOwSjdi11py0ewbHh
         R7X0RfVJPtz+ieKiVB3fnZCNCUWJ8FeMaP10rbZQxHP2etk56gD9u2Q1JF+pA2hEQ9zH
         oLwQ==
X-Gm-Message-State: AOAM532l2Umap6guroalw4EQej1p9fnxHd8OT6x03lGCUTU/qX6S8eOA
        /DM/vQsLs4vR5ZBdv5p9OFZP+w==
X-Google-Smtp-Source: ABdhPJwLSj3Q3fbtYSN5w6vTQU5YRC/PR3Gh/Cu6J89wNJ6H0CGOt9pLLaTcL7aV3I43SWvoGhnu4Q==
X-Received: by 2002:a17:90b:895:: with SMTP id bj21mr85437pjb.148.1591391560243;
        Fri, 05 Jun 2020 14:12:40 -0700 (PDT)
Received: from [192.168.0.105] (modemcable127.167-81-70.mc.videotron.ca. [70.81.167.127])
        by smtp.gmail.com with ESMTPSA id e124sm442362pfh.140.2020.06.05.14.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2020 14:12:39 -0700 (PDT)
From:   Pavel Zakharov <pavel.zakharov@delphix.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: iscsi-target: hang if connection closed when processing LUN resets
Message-Id: <21949F25-9DA7-4A5C-829E-B730365414AB@delphix.com>
Date:   Fri, 5 Jun 2020 17:12:37 -0400
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Maurizio Lombardi <mlombard@redhat.com>,
        David Disseldorp <ddiss@suse.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This issue can be reproduced when running with a Windows initiator and =
is triggered by a 60 second disk IO timeout in Windows.

This happens when the device that backs the backstore is extremely slow =
for a short period of time. =46rom my observation, if an iSCSI request =
takes more than 60 seconds, Windows will send a LUN RESET command to the =
target, followed by an iSCSI Login command 20 seconds later. If the LUN =
RESET has not completed by the time the iSCSI Login is received (due to =
very slow backend IO), there=E2=80=99s a very high chance this bug will =
be hit.

When an iSCSI Login request is received, the existing connection is =
closed, and so iscsit_release_commands_from_conn() is called. The logic =
for freeing commands in iscsit_release_commands_from_conn() will free an =
aborted command despite the command still being in the drain_tmr_list of =
core_tmr_drain_tmr_list(). When this command is finally processed by =
core_tmr_drain_tmr_list(), its cmd_kref is already at 0, so =
target_put_cmd_and_wait() will bring its cmd_kref to -1 and the function =
will never return. iscsit_release_commands_from_conn() will then be =
stuck waiting for the LUN reset command to be freed, and so the iSCSI =
connection will never be closed nor re-established.

When this issue is hit, we can see 3 hung tasks. I=E2=80=99ve inserted =
some functions in the stack as they were inlined by the compiler.

INFO: task kworker/0:2:93 blocked for more than 120 seconds.
      Tainted: P        W  OE     5.0.0-1020-azure #21~18.04.1-Ubuntu
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this=20
kworker/0:2     D    0    93      2 0x80000000
Workqueue: events target_tmr_work [target_core_mod]
Call Trace:
 __schedule+0x2a2/0x870
 schedule+0x2c/0x70
 schedule_timeout+0x1db/0x360
 ? do_invalid_op+0x3b/0x50
 ? target_core_exit_configfs+0x136/0xaa1 [target_core_mod]
 ? invalid_op+0x14/0x20
 wait_for_completion+0xb4/0x130
 ? wake_up_q+0x80/0x80
 target_put_cmd_and_wait+0x72/0xa0 [target_core_mod]
 (core_tmr_drain_state_list)
 core_tmr_lun_reset+0x2fd/0x6b0 [target_core_mod]
 target_tmr_work+0xa8/0xf0 [target_core_mod]
 process_one_work+0x1f7/0x3f0
 worker_thread+0x34/0x400
 kthread+0x121/0x140
 ? process_one_work+0x3f0/0x3f0
 ? kthread_park+0x90/0x90
 ret_from_fork+0x1f/0x40


INFO: task kworker/4:1:210 blocked for more than 120 seconds.
      Tainted: P        W  OE     5.0.0-1020-azure #21~18.04.1-Ubuntu
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this=20
kworker/4:1     D    0   210      2 0x80000000
Workqueue: events iscsi_target_do_login_rx [iscsi_target_mod]
Call Trace:
 __schedule+0x2a2/0x870
 schedule+0x2c/0x70
 schedule_timeout+0x1db/0x360
 wait_for_completion+0xb4/0x130
 ? wake_up_q+0x80/0x80
 iscsit_stop_session+0x185/0x1a0 [iscsi_target_mod]
 iscsi_check_for_session_reinstatement+0x1d2/0x280 [iscsi_target_mod]
 iscsi_target_check_for_existing_instances+0x2f/0x40 [
 iscsi_target_do_login+0x2e6/0x5e0 [iscsi_target_mod]
 iscsi_target_do_login_rx+0x268/0x330 [iscsi_target_mod]
 ? iscsi_target_restore_sock_callbacks+0xd0/0xd0 [iscsi_target_mod]
 process_one_work+0x1f7/0x3f0
 worker_thread+0x34/0x400
 kthread+0x121/0x140
 ? process_one_work+0x3f0/0x3f0
 ? kthread_park+0x90/0x90
 ret_from_fork+0x1f/0x40


INFO: task iscsi_ttx:10910 blocked for more than 120 seconds.
      Tainted: P        W  OE     5.0.0-1020-azure #21~18.04.1-Ubuntu
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this=20
iscsi_ttx       D    0 10910      2 0x80000084
Call Trace:
 __schedule+0x2a2/0x870
 schedule+0x2c/0x70
 schedule_timeout+0x1db/0x360
 ? iscsit_release_cmd+0x91/0xe0 [iscsi_target_mod]
 ? kfree+0x169/0x180
 wait_for_completion+0xb4/0x130
 ? wake_up_q+0x80/0x80
 transport_generic_free_cmd+0x8e/0x160 [target_core_mod]
 iscsit_free_cmd+0x43/0x90 [iscsi_target_mod]
 (iscsit_release_commands_from_conn)
 iscsit_close_connection+0x4f5/0x850 [iscsi_target_mod]
 iscsit_take_action_for_connection_exit+0x7f/0x110 [iscsi_target_mod]
 iscsi_target_tx_thread+0x166/0x1f0 [iscsi_target_mod]
 ? wait_woken+0x80/0x80
 kthread+0x121/0x140
 ? iscsit_thread_get_cpumask+0xb0/0xb0 [iscsi_target_mod]
 ? kthread_park+0x90/0x90
 ret_from_fork+0x1f/0x40

Given that the thread that is re-establishing the connection is stuck, =
but the initiator keeps attempting to establish a connection we=E2=80=99ll=
 see the following messages printed every 20 seconds:
iSCSI Login timeout on Network Portal 0.0.0.0:3260
iSCSI Login negotiation failed.

It also generated a bunch of warnings. I=E2=80=99ve included the actual =
warning that was hit.

WARNING: CPU: 10 PID: 223 at =
/build/linux-azure-9v78ef/linux-azure-5.0.0/drivers/target/target_core_tra=
nsport.c:790 target_handle_abort+0xe0/0x1a0 [target_core_mod]
WARN_ON_ONCE(target_put_sess_cmd(cmd) !=3D 0);
Call Trace:
 target_abort_work+0x15/0x20 [target_core_mod]
 process_one_work+0x1f7/0x3f0
 worker_thread+0x34/0x400
 kthread+0x121/0x140
 ? process_one_work+0x3f0/0x3f0
 ? kthread_park+0x90/0x90
 ret_from_fork+0x1f/0x40

WARNING: CPU: 2 PID: 280 at =
/build/linux-azure-9v78ef/linux-azure-5.0.0/drivers/target/target_core_tra=
nsport.c:798 target_handle_abort+0xe7/0x1a0 [target_core_mod]
WARN_ON_ONCE(kref_read(&cmd->cmd_kref) =3D=3D 0);
Call Trace:
 target_abort_work+0x15/0x20 [target_core_mod]
 process_one_work+0x1f7/0x3f0
 worker_thread+0x34/0x400
 kthread+0x121/0x140
 ? process_one_work+0x3f0/0x3f0
 ? kthread_park+0x90/0x90
 ret_from_fork+0x1f/0x40

WARNING: CPU: 13 PID: 221 at =
/build/linux-azure-9v78ef/linux-azure-5.0.0/drivers/target/iscsi/iscsi_tar=
get_util.c:751 __iscsit_free_cmd+0x22a/0x270 [iscsi_target_mod]
WARN_ON(!list_empty(&cmd->i_conn_node));
Workqueue: target_completion target_abort_work [target_core_mod]
Call Trace:
 iscsit_aborted_task+0x72/0x80 [iscsi_target_mod]
 lio_aborted_task+0x2a/0x30 [iscsi_target_mod]
 target_handle_abort+0x4a/0x1a0 [target_core_mod]
 target_abort_work+0x15/0x20 [target_core_mod]
 process_one_work+0x1f7/0x3f0
 worker_thread+0x34/0x400
 kthread+0x121/0x140
 ? process_one_work+0x3f0/0x3f0
 ? kthread_park+0x90/0x90
 ret_from_fork+0x1f/0x40

WARNING: CPU: 1 PID: 95 at =
/build/linux-azure-9v78ef/linux-azure-5.0.0/drivers/target/iscsi/iscsi_tar=
get_util.c:727 iscsit_release_cmd+0xd4/0xe0 [iscsi_target_mod]
WARN_ON(!list_empty(&cmd->i_conn_node));
Workqueue: events target_tmr_work [target_core_mod]
Call Trace:
 lio_release_cmd+0x1e/0x50 [iscsi_target_mod]
 target_release_cmd_kref+0xfe/0x240 [target_core_mod]
 target_put_cmd_and_wait+0x6a/0xa0 [target_core_mod]
 core_tmr_lun_reset+0x2fd/0x6b0 [target_core_mod]
 target_tmr_work+0xa8/0xf0 [target_core_mod]
 process_one_work+0x1f7/0x3f0
 worker_thread+0x34/0x400
 kthread+0x121/0x140
 ? process_one_work+0x3f0/0x3f0
 ? kthread_park+0x90/0x90
 ret_from_fork+0x1f/0x40

Note that some of those warnings are generated in a slightly different =
scenario, where the command is first processed by =
core_tmr_drain_tmr_list(), and then later is freed by =
iscsit_release_commands_from_conn(), at which point the cmd_kref will =
also be at -1, but no hang would occur. When multiple commands are =
aborted by LUN RESET, we=E2=80=99ll often see a combination of both =
scenarios at the same time, depending on how the commands are ordered in =
the 2 lists.

I=E2=80=99ve got a tentative fix for this issue, which seems to solve =
that problem, but I haven=E2=80=99t yet tested a few scenarios:
1. I=E2=80=99ve been running with ERL=3D0. ERL=3D2 might behave somewhat =
differently.
2. I=E2=80=99m not sure what would happen if there=E2=80=99s several LUN =
RESETS /ABORT TASKS happening at the same time, or if there are multiple =
LUNs being reset.
3. I haven=E2=80=99t tested with persistent reservation.
4. Although I have emulate_tas=3D1, CMD_T_TAS is not set because of a =
condition in __target_check_io_state() that also checks for tmr_sess !=3D =
se_cmd->se_sess which returned false in my tests.

In the meanwhile, I=E2=80=99d like to know what folks think about the =
tentative fix:

=46rom ebb0af5b1d71944ae98e6589cadd98af2fb15904 Mon Sep 17 00:00:00 2001
From: Pavel Zakharov <pavel.zakharov@delphix.com>
Date: Fri, 5 Jun 2020 16:02:17 -0400
Subject: [PATCH] cmd_kref leak prevents reestablishing iSCSI connection

When a LUN_RESET TMR is being processed and an iSCSI connection is =
closed
at the same time, cmd_kref goes to -1 causing multiple issues, that
culminate in several threads hanging, which prevents the closed iSCSI
connection from being re-established.

Signed-off-by: Pavel Zakharov <pavel.zakharov@delphix.com>
---
 drivers/target/iscsi/iscsi_target.c | 46 ++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c =
b/drivers/target/iscsi/iscsi_target.c
index 59379d662626..68806e8f3d43 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -483,9 +483,7 @@ EXPORT_SYMBOL(iscsit_queue_rsp);
 void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsi_cmd =
*cmd)
 {
 	spin_lock_bh(&conn->cmd_lock);
-	if (!list_empty(&cmd->i_conn_node) &&
-	    !(cmd->se_cmd.transport_state & CMD_T_FABRIC_STOP))
-		list_del_init(&cmd->i_conn_node);
+	list_del_init(&cmd->i_conn_node);
 	spin_unlock_bh(&conn->cmd_lock);
=20
 	__iscsit_free_cmd(cmd, true);
@@ -4056,7 +4054,8 @@ int iscsi_target_rx_thread(void *arg)
=20
 static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 {
-	LIST_HEAD(tmp_list);
+	LIST_HEAD(tmp_cmd_list);
+	LIST_HEAD(tmp_tmr_list);
 	struct iscsi_cmd *cmd =3D NULL, *cmd_tmp =3D NULL;
 	struct iscsi_session *sess =3D conn->sess;
 	/*
@@ -4065,9 +4064,9 @@ static void =
iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 	 * has been reset -> returned sleeping pre-handler state.
 	 */
 	spin_lock_bh(&conn->cmd_lock);
-	list_splice_init(&conn->conn_cmd_list, &tmp_list);
+	list_splice_init(&conn->conn_cmd_list, &tmp_cmd_list);
=20
-	list_for_each_entry(cmd, &tmp_list, i_conn_node) {
+	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_cmd_list, =
i_conn_node) {
 		struct se_cmd *se_cmd =3D &cmd->se_cmd;
=20
 		if (se_cmd->se_tfo !=3D NULL) {
@@ -4075,11 +4074,44 @@ static void =
iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 			se_cmd->transport_state |=3D CMD_T_FABRIC_STOP;
 			spin_unlock_irq(&se_cmd->t_state_lock);
 		}
+
+		if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB)
+			list_move_tail(&cmd->i_conn_node, =
&tmp_tmr_list);
 	}
 	spin_unlock_bh(&conn->cmd_lock);
=20
-	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_list, i_conn_node) {
+	/*
+	 * We must wait for TMRs to be processed first. Any commands =
that were
+	 * aborted by those TMRs will have been freed and removed from =
the
+	 * tmp_cmd_list once we have finished traversing tmp_tmr_list.
+	 */
+	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_tmr_list, =
i_conn_node) {
+		struct se_cmd *se_cmd =3D &cmd->se_cmd;
+
+		spin_lock_bh(&conn->cmd_lock);
 		list_del_init(&cmd->i_conn_node);
+		spin_unlock_bh(&conn->cmd_lock);
+
+		iscsit_increment_maxcmdsn(cmd, sess);
+		iscsit_free_cmd(cmd, true);
+	}
+
+	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_cmd_list, =
i_conn_node) {
+		struct se_cmd *se_cmd =3D &cmd->se_cmd;
+
+		/*
+		 * We shouldn't be freeing any aborted commands here. =
Those
+		 * commands should be freed by iscsit_aborted_task, and =
the
+		 * last reference will be released by =
target_put_cmd_and_wait,
+		 * called from core_tmr_drain_tmr_list or =
core_tmr_abort_task.
+		 */
+		spin_lock_irq(&se_cmd->t_state_lock);
+		WARN_ON(se_cmd->transport_state & CMD_T_ABORTED);
+		spin_unlock_irq(&se_cmd->t_state_lock);
+
+		spin_lock_bh(&conn->cmd_lock);
+		list_del_init(&cmd->i_conn_node);
+		spin_unlock_bh(&conn->cmd_lock);
=20
 		iscsit_increment_maxcmdsn(cmd, sess);
 		iscsit_free_cmd(cmd, true);
--=20
2.21.1 (Apple Git-122.3)



