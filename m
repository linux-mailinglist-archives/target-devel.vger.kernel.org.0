Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F95C184C1D
	for <lists+target-devel@lfdr.de>; Fri, 13 Mar 2020 17:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgCMQNL (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 13 Mar 2020 12:13:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47220 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgCMQNL (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584115990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCRu2uO7JRNFqZuuAU7FJwrFZSO6JRc5fYwy5NacvU4=;
        b=WOu0H4YcfHAobWBgvMO4U18eRM68SkhGECvtWUKMTRibM6x8in7ar75u+323zL85g6KccW
        rvGfLwWhWUd2PY/p1ilnyRjMFwS1Plpa2oFEYoUNDzk/6qiIGsOL2S8UpqrvH+jtt7jVkf
        QL98xVS7cJzfkJ9IQwjrIWQKaI7Cc3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-hrilo333Okuhb-YtY6KUDg-1; Fri, 13 Mar 2020 12:13:05 -0400
X-MC-Unique: hrilo333Okuhb-YtY6KUDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C81B8010F2;
        Fri, 13 Mar 2020 16:13:04 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-206-24.brq.redhat.com [10.40.206.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 858DD1001B34;
        Fri, 13 Mar 2020 16:13:02 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, bvanassche@acm.org, ddiss@suse.de,
        mcoleman@datto.com
Subject: [PATCH 3/3] iscsi target: calling iscsit_stop_session() inside iscsit_close_session() has no effect
Date:   Fri, 13 Mar 2020 17:12:53 +0100
Message-Id: <20200313161253.5507-4-mlombard@redhat.com>
In-Reply-To: <20200313161253.5507-1-mlombard@redhat.com>
References: <20200313161253.5507-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

iscsit_close_session() can only be called when nconn is zero (otherwise
a kernel panic is triggered); if nconn is zero then
iscsit_stop_session() does nothing and exits, so calling it
makes no sense.

We still need to call iscsit_check_session_usage_count() because
this function will sleep if the session's refcount is not zero and
we don't want to destroy the session structure if
it's still being referenced.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/i=
scsi_target.c
index 9e90edc875f1..14f4842e3517 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4385,8 +4385,7 @@ int iscsit_close_session(struct iscsi_session *sess=
)
 	 * restart the timer and exit.
 	 */
 	if (!in_interrupt()) {
-		if (iscsit_check_session_usage_count(sess) =3D=3D 1)
-			iscsit_stop_session(sess, 1, 1);
+		iscsit_check_session_usage_count(sess);
 	} else {
 		if (iscsit_check_session_usage_count(sess) =3D=3D 2) {
 			atomic_set(&sess->session_logout, 0);
--=20
2.21.0

