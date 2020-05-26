Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853A61B15A5
	for <lists+target-devel@lfdr.de>; Mon, 20 Apr 2020 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgDTTPP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 20 Apr 2020 15:15:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36055 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgDTTPO (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587410114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAIVbfHm+qEY9s2DeibNHPiGmnUiKe5hIWTvI0B/Kos=;
        b=OBN4IugwFlPGxx3GF1MAOW5qTYdWX1NAhvijCDeoI2E6wWOFgcjKIkLcVkpo+53NFV3qqI
        pUs2vcsZw9Jfj7ou5CWfwYhCLdSTuUgLN+Du6mT5a8oow4/TqZTiE7nhbaUSRF4ydbYTSP
        o6+8fgX0nafIaL6qAaTf737QPx+xDME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-P6ifLZuLN3a0Wo5Yq_X8Fw-1; Mon, 20 Apr 2020 15:15:10 -0400
X-MC-Unique: P6ifLZuLN3a0Wo5Yq_X8Fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9876F107B11F;
        Mon, 20 Apr 2020 19:15:07 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-118-198.rdu2.redhat.com [10.10.118.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9FE6A188B;
        Mon, 20 Apr 2020 19:15:04 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     jsmart2021@gmail.com, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [RFC PATCH 10/12] target: add target_setup_session sysfs support
Date:   Mon, 20 Apr 2020 14:14:24 -0500
Message-Id: <20200420191426.17055-11-mchristi@redhat.com>
In-Reply-To: <20200420191426.17055-1-mchristi@redhat.com>
References: <20200420191426.17055-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This adds a session dir per session for users of target_setup_session.

TODO:
1. drivers like tcm_qla2xxx allocate resources in the fabric ops
init_session callback, but I have not implemented free_session
callbacks for them yet.

2. Drivers that delete their tpg before the sessions need to
be updated.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/target/target_core_transport.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/targ=
et_core_transport.c
index 7aa830e..fd41f35 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -472,10 +472,24 @@ struct se_session *
 		if (rc)
 			goto free_sess;
 	}
+	/*
+	 * init_session was successful so set the tfo now, because if there
+	 * is a failure going forward we will want to call the free_session
+	 * callback.
+	 */
+	sess->tfo =3D tpg->se_tpg_tfo;
=20
 	transport_register_session(tpg, sess->se_node_acl, sess, private);
+
+	rc =3D target_sysfs_add_session(tpg, sess);
+	if (rc)
+		goto dereg_sess;
+
 	return sess;
=20
+dereg_sess:
+	transport_deregister_session_configfs(sess);
+	transport_deregister_session(sess);
 free_sess:
 	transport_free_session(sess);
 	return ERR_PTR(rc);
@@ -671,6 +685,7 @@ void transport_deregister_session(struct se_session *=
se_sess)
=20
 void target_remove_session(struct se_session *se_sess)
 {
+	target_sysfs_remove_session(se_sess);
 	transport_deregister_session_configfs(se_sess);
 	transport_deregister_session(se_sess);
 }
--=20
1.8.3.1

