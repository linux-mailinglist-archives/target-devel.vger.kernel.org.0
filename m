Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 283B7E7196
	for <lists+target-devel@lfdr.de>; Mon, 28 Oct 2019 13:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbfJ1Mii (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 28 Oct 2019 08:38:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44490 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbfJ1Mii (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572266317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLvLHrbZI5/1diRlzEZRdHc+YFNWmkJY2aZBXThxYiw=;
        b=QO6NAtp/nnpaKqxvhwNAkDvopAaBxMQ9BoBTdVoluSN9sbL2buE17SuFO2dIPGhYqMFGQt
        oJ1HfU6Vf/12M4BexKlphZrn6jeDFdu8/e5QGEM5MUQFiyQ+oGJIiBCtcLa69b7rcsYhnr
        RDb7yphXTOwPPWbuRX+3oQnxCGdSAEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-hhOviapRPYy0HxxZSEa7cw-1; Mon, 28 Oct 2019 08:38:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D88E180491C;
        Mon, 28 Oct 2019 12:38:33 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F275A600C9;
        Mon, 28 Oct 2019 12:38:30 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     cleech@redhat.com
Cc:     mchristi@redhat.com, target-devel@vger.kernel.org,
        hch@infradead.org, martin.petersen@oracle.com
Subject: [PATCH V3 2/3] target-iscsi: tie the challenge length to the hash digest size
Date:   Mon, 28 Oct 2019 13:38:21 +0100
Message-Id: <20191028123822.5864-3-mlombard@redhat.com>
In-Reply-To: <20191028123822.5864-1-mlombard@redhat.com>
References: <20191028123822.5864-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hhOviapRPYy0HxxZSEa7cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The open-iscsi initiator uses the digest size to determine the
length of the challenge values it sends to the target.
This patch modifies the target driver to behave in the same way.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target_auth.c | 37 +++++++++++++++++-------
 drivers/target/iscsi/iscsi_target_auth.h |  4 +--
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscs=
i/iscsi_target_auth.c
index b09f20842e40..f3973ab19da2 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -41,16 +41,21 @@ static int chap_gen_challenge(
 =09unsigned int *c_len)
 {
 =09int ret;
-=09unsigned char challenge_asciihex[CHAP_CHALLENGE_LENGTH * 2 + 1];
+=09unsigned char *challenge_asciihex;
 =09struct iscsi_chap *chap =3D conn->auth_protocol;
=20
-=09memset(challenge_asciihex, 0, CHAP_CHALLENGE_LENGTH * 2 + 1);
+=09challenge_asciihex =3D kzalloc(chap->challenge_len * 2 + 1, GFP_KERNEL)=
;
+=09if (!challenge_asciihex)
+=09=09return -ENOMEM;
=20
-=09ret =3D get_random_bytes_wait(chap->challenge, CHAP_CHALLENGE_LENGTH);
+=09memset(chap->challenge, 0, MAX_CHAP_CHALLENGE_LEN);
+
+=09ret =3D get_random_bytes_wait(chap->challenge, chap->challenge_len);
 =09if (unlikely(ret))
-=09=09return ret;
+=09=09goto out;
+
 =09bin2hex(challenge_asciihex, chap->challenge,
-=09=09=09=09CHAP_CHALLENGE_LENGTH);
+=09=09=09=09chap->challenge_len);
 =09/*
 =09 * Set CHAP_C, and copy the generated challenge into c_str.
 =09 */
@@ -59,7 +64,10 @@ static int chap_gen_challenge(
=20
 =09pr_debug("[%s] Sending CHAP_C=3D0x%s\n\n", (caller) ? "server" : "clien=
t",
 =09=09=09challenge_asciihex);
-=09return 0;
+
+out:
+=09kfree(challenge_asciihex);
+=09return ret;
 }
=20
 static int chap_test_algorithm(const char *name)
@@ -171,6 +179,9 @@ static struct iscsi_chap *chap_server_open(
=20
 =09chap->digest_name =3D chap_get_digest_name(digest_type);
=20
+=09/* Tie the challenge length to the digest size */
+=09chap->challenge_len =3D chap->digest_size;
+
 =09pr_debug("[server] Got CHAP_A=3D%d\n", digest_type);
 =09*aic_len =3D sprintf(aic_str, "CHAP_A=3D%d", digest_type);
 =09*aic_len +=3D 1;
@@ -334,21 +345,23 @@ static int chap_server_compute_hash(
 =09}
=20
 =09ret =3D crypto_shash_finup(desc, chap->challenge,
-=09=09=09=09 CHAP_CHALLENGE_LENGTH, server_digest);
+=09=09=09=09 chap->challenge_len, server_digest);
 =09if (ret < 0) {
 =09=09pr_err("crypto_shash_finup() failed for challenge\n");
 =09=09goto out;
 =09}
=20
 =09bin2hex(response, server_digest, chap->digest_size);
-=09pr_debug("[server] %s Server Digest: %s\n", hash_name, response);
+=09pr_debug("[server] %s Server Digest: %s\n",
+=09=09chap->digest_name, response);
=20
 =09if (memcmp(server_digest, client_digest, chap->digest_size) !=3D 0) {
-=09=09pr_debug("[server] %s Digests do not match!\n\n", hash_name);
+=09=09pr_debug("[server] %s Digests do not match!\n\n",
+=09=09=09chap->digest_name);
 =09=09goto out;
 =09} else
 =09=09pr_debug("[server] %s Digests match, CHAP connection"
-=09=09=09=09" successful.\n\n", hash_name);
+=09=09=09=09" successful.\n\n", chap->digest_name);
 =09/*
 =09 * One way authentication has succeeded, return now if mutual
 =09 * authentication is not enabled.
@@ -414,7 +427,9 @@ static int chap_server_compute_hash(
 =09 * initiator must not match the original CHAP_C generated by
 =09 * the target.
 =09 */
-=09if (!memcmp(challenge_binhex, chap->challenge, CHAP_CHALLENGE_LENGTH)) =
{
+=09if (challenge_len =3D=3D chap->challenge_len &&
+=09=09=09=09!memcmp(challenge_binhex, chap->challenge,
+=09=09=09=09challenge_len)) {
 =09=09pr_err("initiator CHAP_C matches target CHAP_C, failing"
 =09=09       " login attempt\n");
 =09=09goto out;
diff --git a/drivers/target/iscsi/iscsi_target_auth.h b/drivers/target/iscs=
i/iscsi_target_auth.h
index 93db1ab5516c..fc75c1c20e23 100644
--- a/drivers/target/iscsi/iscsi_target_auth.h
+++ b/drivers/target/iscsi/iscsi_target_auth.h
@@ -10,7 +10,7 @@
 #define CHAP_DIGEST_SHA256=097
 #define CHAP_DIGEST_SHA3_256=098
=20
-#define CHAP_CHALLENGE_LENGTH=0916
+#define MAX_CHAP_CHALLENGE_LEN=0932
 #define CHAP_CHALLENGE_STR_LEN=094096
 #define MAX_RESPONSE_LENGTH=09128=09/* sufficient for SHA3 256 */
 #define=09MAX_CHAP_N_SIZE=09=09512
@@ -34,7 +34,7 @@ extern u32 chap_main_loop(struct iscsi_conn *, struct isc=
si_node_auth *, char *,
=20
 struct iscsi_chap {
 =09unsigned char=09id;
-=09unsigned char=09challenge[CHAP_CHALLENGE_LENGTH];
+=09unsigned char=09challenge[MAX_CHAP_CHALLENGE_LEN];
 =09unsigned int=09challenge_len;
 =09unsigned char=09*digest_name;
 =09unsigned int=09digest_size;
--=20
Maurizio Lombardi

