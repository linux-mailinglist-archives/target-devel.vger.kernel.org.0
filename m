Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61F41BB64D
	for <lists+target-devel@lfdr.de>; Tue, 28 Apr 2020 08:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgD1GLf (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 28 Apr 2020 02:11:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59937 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726478AbgD1GLc (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588054290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vUqQoAzmdTZEyw5xdjmwsR/6jOSS/EEtWg65SOV7bd0=;
        b=OOWs4eCpb807fGmA1L2ZOD9PT88K6ostL6DEBepL2wXeF2r2nWiUdab6u7NGFOSXN+jD6u
        kps6YsbY7S9EaelINu7SpIJnNXASnmrsqgeXCfjQdTN5oUCqJiLh9RfAyRcst8RqrI00Hy
        KQrgiXKUzpX6+qsOptfQ3wIkfvF+t7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-n6M6Zg1yMDatKSctbZLfsQ-1; Tue, 28 Apr 2020 02:11:26 -0400
X-MC-Unique: n6M6Zg1yMDatKSctbZLfsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B060A45F;
        Tue, 28 Apr 2020 06:11:25 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-116-120.rdu2.redhat.com [10.10.116.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD6D310013D9;
        Tue, 28 Apr 2020 06:11:24 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 10/11] iscsi target: use session sysfs helpers
Date:   Tue, 28 Apr 2020 01:11:08 -0500
Message-Id: <20200428061109.3042-11-mchristi@redhat.com>
In-Reply-To: <20200428061109.3042-1-mchristi@redhat.com>
References: <20200428061109.3042-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The iscsi target login process breaks up session allocation and
registration, so it does not use target_setup_session like every one
else. This converts iscsi to use the session sysfs helpers and drops its
session id to use the common one.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
V3:
- Fix goto use. Actually moved sysfs addition call to after nego
  to avoid sysfs additions when login ends up failing.

 drivers/target/iscsi/iscsi_target.c          |  3 +--
 drivers/target/iscsi/iscsi_target_configfs.c |  4 +---
 drivers/target/iscsi/iscsi_target_login.c    | 16 ++--------------
 drivers/target/iscsi/iscsi_target_nego.c     |  8 ++++++++
 drivers/target/iscsi/iscsi_target_stat.c     |  3 +--
 include/target/iscsi/iscsi_target_core.h     |  2 --
 6 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/i=
scsi_target.c
index 09e55ea..ca0bc26 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -49,7 +49,6 @@
 static DEFINE_MUTEX(np_lock);
=20
 static struct idr tiqn_idr;
-DEFINE_IDA(sess_ida);
 struct mutex auth_id_lock;
=20
 struct iscsit_global *iscsit_global;
@@ -4352,6 +4351,7 @@ int iscsit_close_session(struct iscsi_session *sess=
)
 	iscsit_stop_time2retain_timer(sess);
 	spin_unlock_bh(&se_tpg->session_lock);
=20
+	target_sysfs_remove_session(sess->se_sess);
 	/*
 	 * transport_deregister_session_configfs() will clear the
 	 * struct se_node_acl->nacl_sess pointer now as a iscsi_np process cont=
ext
@@ -4397,7 +4397,6 @@ int iscsit_close_session(struct iscsi_session *sess=
)
 	pr_debug("Decremented number of active iSCSI Sessions on"
 		" iSCSI TPG: %hu to %u\n", tpg->tpgt, tpg->nsessions);
=20
-	ida_free(&sess_ida, sess->session_index);
 	kfree(sess->sess_ops);
 	sess->sess_ops =3D NULL;
 	spin_unlock_bh(&se_tpg->session_lock);
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/targe=
t/iscsi/iscsi_target_configfs.c
index f640e7a..c40cff1 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1344,9 +1344,7 @@ static int iscsi_get_cmd_state(struct se_cmd *se_cm=
d)
=20
 static u32 lio_sess_get_index(struct se_session *se_sess)
 {
-	struct iscsi_session *sess =3D se_sess->fabric_sess_ptr;
-
-	return sess->session_index;
+	return se_sess->sid;
 }
=20
 static int lio_queue_data_in(struct se_cmd *se_cmd)
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/i=
scsi/iscsi_target_login.c
index f533308..a0ea60f 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -257,7 +257,6 @@ static int iscsi_login_zero_tsih_s1(
 {
 	struct iscsi_session *sess =3D NULL;
 	struct iscsi_login_req *pdu =3D (struct iscsi_login_req *)buf;
-	int ret;
=20
 	sess =3D kzalloc(sizeof(struct iscsi_session), GFP_KERNEL);
 	if (!sess) {
@@ -291,15 +290,6 @@ static int iscsi_login_zero_tsih_s1(
 	timer_setup(&sess->time2retain_timer,
 		    iscsit_handle_time2retain_timeout, 0);
=20
-	ret =3D ida_alloc(&sess_ida, GFP_KERNEL);
-	if (ret < 0) {
-		pr_err("Session ID allocation failed %d\n", ret);
-		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
-				ISCSI_LOGIN_STATUS_NO_RESOURCES);
-		goto free_sess;
-	}
-
-	sess->session_index =3D ret;
 	sess->creation_time =3D get_jiffies_64();
 	/*
 	 * The FFP CmdSN window values will be allocated from the TPG's
@@ -313,7 +303,7 @@ static int iscsi_login_zero_tsih_s1(
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
 		pr_err("Unable to allocate memory for"
 				" struct iscsi_sess_ops.\n");
-		goto free_id;
+		goto free_ops;
 	}
=20
 	sess->se_sess =3D transport_alloc_session(TARGET_PROT_NORMAL);
@@ -327,8 +317,6 @@ static int iscsi_login_zero_tsih_s1(
=20
 free_ops:
 	kfree(sess->sess_ops);
-free_id:
-	ida_free(&sess_ida, sess->session_index);
 free_sess:
 	kfree(sess);
 	conn->sess =3D NULL;
@@ -1182,8 +1170,8 @@ void iscsi_target_login_sess_out(struct iscsi_conn =
*conn,
 	if (!zero_tsih || !conn->sess)
 		goto old_sess_out;
=20
+	target_sysfs_remove_session(conn->sess->se_sess);
 	transport_free_session(conn->sess->se_sess);
-	ida_free(&sess_ida, conn->sess->session_index);
 	kfree(conn->sess->sess_ops);
 	kfree(conn->sess);
 	conn->sess =3D NULL;
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/is=
csi/iscsi_target_nego.c
index dce2fe2..298c8a5 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -359,6 +359,13 @@ static int iscsi_target_do_tx_login_io(struct iscsi_=
conn *conn, struct iscsi_log
 					    ISCSI_LOGIN_STATUS_NO_RESOURCES);
 			return -1;
 		}
+
+		if (target_sysfs_add_session(&conn->tpg->tpg_se_tpg,
+					     conn->sess->se_sess)) {
+			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
+					    ISCSI_LOGIN_STATUS_NO_RESOURCES);
+			return -1;
+		}
 	}
=20
 	if (conn->conn_transport->iscsit_put_login_tx(conn, login,
@@ -1281,6 +1288,7 @@ int iscsi_target_locate_portal(
 	ret =3D transport_alloc_session_tags(sess->se_sess, tag_num, tag_size);
 	if (ret < 0)
 		goto return_oom;
+	sess->se_sess->tfo =3D &iscsi_ops;
=20
 	if (conn->tpg !=3D iscsit_global->discovery_tpg) {
 		if (iscsi_setup_i_tpid(sess, i_buf))
diff --git a/drivers/target/iscsi/iscsi_target_stat.c b/drivers/target/is=
csi/iscsi_target_stat.c
index 35e75a3..8167fdc 100644
--- a/drivers/target/iscsi/iscsi_target_stat.c
+++ b/drivers/target/iscsi/iscsi_target_stat.c
@@ -630,8 +630,7 @@ static ssize_t iscsi_stat_sess_indx_show(struct confi=
g_item *item, char *page)
 	if (se_sess) {
 		sess =3D se_sess->fabric_sess_ptr;
 		if (sess)
-			ret =3D snprintf(page, PAGE_SIZE, "%u\n",
-					sess->session_index);
+			ret =3D snprintf(page, PAGE_SIZE, "%u\n", se_sess->sid);
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
=20
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/is=
csi/iscsi_target_core.h
index a49d371..aeabb83 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -657,8 +657,6 @@ struct iscsi_session {
 	/* LIO specific session ID */
 	u32			sid;
 	char			auth_type[8];
-	/* unique within the target */
-	int			session_index;
 	/* Used for session reference counting */
 	int			session_usage_count;
 	int			session_waiting_on_uc;
--=20
1.8.3.1

