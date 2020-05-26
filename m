Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2541B7348
	for <lists+target-devel@lfdr.de>; Fri, 24 Apr 2020 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDXLjV (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 24 Apr 2020 07:39:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46559 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgDXLjV (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587728360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xxxLi1TfzeYigzHm669zYEJS2CbEA2mBx6261qZIdqE=;
        b=VN6P31Z7XiGgGPDY7FkvtzDUub+YvwXTKvwju81gmFnbLefsO26TUUpInXeB3q59Wg7Ako
        TR5ljJj2O0EsA42y8Cde83G8WoE0E2/+ThO4+v+Sl5dZ1H21uE7clEikL+A7Xa9wpdlwNs
        nDQyzgJUj9zsYc+15raccYcxtEizHlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-0lCv8dA9MfeVZnUkf7QdLw-1; Fri, 24 Apr 2020 07:39:16 -0400
X-MC-Unique: 0lCv8dA9MfeVZnUkf7QdLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BC8C100AA23;
        Fri, 24 Apr 2020 11:39:15 +0000 (UTC)
Received: from nangaparbat.redhat.com (unknown [10.40.194.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31E3E605CF;
        Fri, 24 Apr 2020 11:39:13 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH] target: iscsi: remove the iscsi_data_count structure
Date:   Fri, 24 Apr 2020 13:39:13 +0200
Message-Id: <20200424113913.17237-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch removes the iscsi_data_count structure and the
iscsit_do_rx_data() function because they are used only by rx_data()

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target_util.c | 30 +++++-------------------
 include/target/iscsi/iscsi_target_core.h | 10 --------
 2 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/is=
csi/iscsi_target_util.c
index fae85bfd790e..25677e2865be 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1236,18 +1236,20 @@ void iscsit_print_session_params(struct iscsi_ses=
sion *sess)
 	iscsi_dump_sess_ops(sess->sess_ops);
 }
=20
-static int iscsit_do_rx_data(
+int rx_data(
 	struct iscsi_conn *conn,
-	struct iscsi_data_count *count)
+	struct kvec *iov,
+	int iov_count,
+	int data)
 {
-	int data =3D count->data_length, rx_loop =3D 0, total_rx =3D 0;
+	int rx_loop =3D 0, total_rx =3D 0;
 	struct msghdr msg;
=20
 	if (!conn || !conn->sock || !conn->conn_ops)
 		return -1;
=20
 	memset(&msg, 0, sizeof(struct msghdr));
-	iov_iter_kvec(&msg.msg_iter, READ, count->iov, count->iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, READ, iov, iov_count, data);
=20
 	while (msg_data_left(&msg)) {
 		rx_loop =3D sock_recvmsg(conn->sock, &msg, MSG_WAITALL);
@@ -1264,26 +1266,6 @@ static int iscsit_do_rx_data(
 	return total_rx;
 }
=20
-int rx_data(
-	struct iscsi_conn *conn,
-	struct kvec *iov,
-	int iov_count,
-	int data)
-{
-	struct iscsi_data_count c;
-
-	if (!conn || !conn->sock || !conn->conn_ops)
-		return -1;
-
-	memset(&c, 0, sizeof(struct iscsi_data_count));
-	c.iov =3D iov;
-	c.iov_count =3D iov_count;
-	c.data_length =3D data;
-	c.type =3D ISCSI_RX_DATA;
-
-	return iscsit_do_rx_data(conn, &c);
-}
-
 int tx_data(
 	struct iscsi_conn *conn,
 	struct kvec *iov,
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/is=
csi/iscsi_target_core.h
index a49d37140a64..c2de9274c57a 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -301,16 +301,6 @@ struct iscsi_queue_req {
 	struct list_head	qr_list;
 };
=20
-struct iscsi_data_count {
-	int			data_length;
-	int			sync_and_steering;
-	enum data_count_type	type;
-	u32			iov_count;
-	u32			ss_iov_count;
-	u32			ss_marker_count;
-	struct kvec		*iov;
-};
-
 struct iscsi_param_list {
 	bool			iser;
 	struct list_head	param_list;
--=20
2.25.3

