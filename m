Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB3FE7195
	for <lists+target-devel@lfdr.de>; Mon, 28 Oct 2019 13:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbfJ1Mig (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 28 Oct 2019 08:38:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51650 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727024AbfJ1Mig (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572266314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3P0oYZTZgAOrjuG9tABEviSh0hLslV9IlxutqV/tko=;
        b=PSTtkd4lV8SD2Eji0fqG+SbJU7Qo/5dspVZJFBaUyoUn6ucZidpbLf/tBnWzDmNK8JaU6c
        tdbFyBmjVq6mniRFExgldd+OuBxAPJA85jSGfTmiJ2RsQZACpbM9mrl0897pWYOXF7QUz6
        iGqBOY+a/mcxEchuylaGWdj5lJIEsfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-MUP44CrvO32ATYDIMx8XaQ-1; Mon, 28 Oct 2019 08:38:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32DE0180491C;
        Mon, 28 Oct 2019 12:38:30 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E171C600C9;
        Mon, 28 Oct 2019 12:38:27 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     cleech@redhat.com
Cc:     mchristi@redhat.com, target-devel@vger.kernel.org,
        hch@infradead.org, martin.petersen@oracle.com
Subject: [PATCH V3 1/3] target-iscsi: CHAP: add support to SHA1, SHA256 and SHA3-256 hash functions
Date:   Mon, 28 Oct 2019 13:38:20 +0100
Message-Id: <20191028123822.5864-2-mlombard@redhat.com>
In-Reply-To: <20191028123822.5864-1-mlombard@redhat.com>
References: <20191028123822.5864-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: MUP44CrvO32ATYDIMx8XaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch modifies the chap_server_compute_hash() function
to make it agnostic to the choice of hash algorithm that is used.
It also adds support to three new hash algorithms: SHA1, SHA256
and SHA3-256.

The chap_got_response() function has been removed because the
digest type validity is already checked by chap_server_open()

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target_auth.c | 169 +++++++++++++++--------
 drivers/target/iscsi/iscsi_target_auth.h |  13 +-
 2 files changed, 120 insertions(+), 62 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscs=
i/iscsi_target_auth.c
index 8fe9b12a07a4..b09f20842e40 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -18,6 +18,22 @@
 #include "iscsi_target_nego.h"
 #include "iscsi_target_auth.h"
=20
+static char *chap_get_digest_name(const int digest_type)
+{
+=09switch (digest_type) {
+=09case CHAP_DIGEST_MD5:
+=09=09return "md5";
+=09case CHAP_DIGEST_SHA1:
+=09=09return "sha1";
+=09case CHAP_DIGEST_SHA256:
+=09=09return "sha256";
+=09case CHAP_DIGEST_SHA3_256:
+=09=09return "sha3-256";
+=09default:
+=09=09return NULL;
+=09}
+}
+
 static int chap_gen_challenge(
 =09struct iscsi_conn *conn,
 =09int caller,
@@ -46,9 +62,23 @@ static int chap_gen_challenge(
 =09return 0;
 }
=20
+static int chap_test_algorithm(const char *name)
+{
+=09struct crypto_shash *tfm;
+
+=09tfm =3D crypto_alloc_shash(name, 0, 0);
+=09if (IS_ERR(tfm))
+=09=09return -1;
+
+=09crypto_free_shash(tfm);
+=09return 0;
+}
+
 static int chap_check_algorithm(const char *a_str)
 {
-=09char *tmp, *orig, *token;
+=09char *tmp, *orig, *token, *digest_name;
+=09long digest_type;
+=09int r =3D CHAP_DIGEST_UNKNOWN;
=20
 =09tmp =3D kstrdup(a_str, GFP_KERNEL);
 =09if (!tmp) {
@@ -70,15 +100,24 @@ static int chap_check_algorithm(const char *a_str)
 =09=09if (!token)
 =09=09=09goto out;
=20
-=09=09if (!strcmp(token, "5")) {
-=09=09=09pr_debug("Selected MD5 Algorithm\n");
-=09=09=09kfree(orig);
-=09=09=09return CHAP_DIGEST_MD5;
+=09=09if (kstrtol(token, 10, &digest_type))
+=09=09=09continue;
+
+=09=09digest_name =3D chap_get_digest_name(digest_type);
+=09=09if (!digest_name)
+=09=09=09continue;
+
+=09=09pr_debug("Selected %s Algorithm\n", digest_name);
+=09=09if (chap_test_algorithm(digest_name) < 0) {
+=09=09=09pr_err("failed to allocate %s algo\n", digest_name);
+=09=09} else {
+=09=09=09r =3D digest_type;
+=09=09=09goto out;
 =09=09}
 =09}
 out:
 =09kfree(orig);
-=09return CHAP_DIGEST_UNKNOWN;
+=09return r;
 }
=20
 static void chap_close(struct iscsi_conn *conn)
@@ -94,7 +133,7 @@ static struct iscsi_chap *chap_server_open(
 =09char *aic_str,
 =09unsigned int *aic_len)
 {
-=09int ret;
+=09int digest_type;
 =09struct iscsi_chap *chap;
=20
 =09if (!(auth->naf_flags & NAF_USERID_SET) ||
@@ -109,17 +148,19 @@ static struct iscsi_chap *chap_server_open(
 =09=09return NULL;
=20
 =09chap =3D conn->auth_protocol;
-=09ret =3D chap_check_algorithm(a_str);
-=09switch (ret) {
+=09digest_type =3D chap_check_algorithm(a_str);
+=09switch (digest_type) {
 =09case CHAP_DIGEST_MD5:
-=09=09pr_debug("[server] Got CHAP_A=3D5\n");
-=09=09/*
-=09=09 * Send back CHAP_A set to MD5.
-=09=09*/
-=09=09*aic_len =3D sprintf(aic_str, "CHAP_A=3D5");
-=09=09*aic_len +=3D 1;
-=09=09chap->digest_type =3D CHAP_DIGEST_MD5;
-=09=09pr_debug("[server] Sending CHAP_A=3D%d\n", chap->digest_type);
+=09=09chap->digest_size =3D MD5_SIGNATURE_SIZE;
+=09=09break;
+=09case CHAP_DIGEST_SHA1:
+=09=09chap->digest_size =3D SHA1_SIGNATURE_SIZE;
+=09=09break;
+=09case CHAP_DIGEST_SHA256:
+=09=09chap->digest_size =3D SHA256_SIGNATURE_SIZE;
+=09=09break;
+=09case CHAP_DIGEST_SHA3_256:
+=09=09chap->digest_size =3D SHA3_256_SIGNATURE_SIZE;
 =09=09break;
 =09case CHAP_DIGEST_UNKNOWN:
 =09default:
@@ -128,6 +169,13 @@ static struct iscsi_chap *chap_server_open(
 =09=09return NULL;
 =09}
=20
+=09chap->digest_name =3D chap_get_digest_name(digest_type);
+
+=09pr_debug("[server] Got CHAP_A=3D%d\n", digest_type);
+=09*aic_len =3D sprintf(aic_str, "CHAP_A=3D%d", digest_type);
+=09*aic_len +=3D 1;
+=09pr_debug("[server] Sending CHAP_A=3D%d\n", digest_type);
+
 =09/*
 =09 * Set Identifier.
 =09 */
@@ -146,7 +194,7 @@ static struct iscsi_chap *chap_server_open(
 =09return chap;
 }
=20
-static int chap_server_compute_md5(
+static int chap_server_compute_hash(
 =09struct iscsi_conn *conn,
 =09struct iscsi_node_auth *auth,
 =09char *nr_in_ptr,
@@ -155,12 +203,13 @@ static int chap_server_compute_md5(
 {
 =09unsigned long id;
 =09unsigned char id_as_uchar;
-=09unsigned char digest[MD5_SIGNATURE_SIZE];
-=09unsigned char type, response[MD5_SIGNATURE_SIZE * 2 + 2];
+=09unsigned char type;
 =09unsigned char identifier[10], *challenge =3D NULL;
 =09unsigned char *challenge_binhex =3D NULL;
-=09unsigned char client_digest[MD5_SIGNATURE_SIZE];
-=09unsigned char server_digest[MD5_SIGNATURE_SIZE];
+=09unsigned char *digest =3D NULL;
+=09unsigned char *response =3D NULL;
+=09unsigned char *client_digest =3D NULL;
+=09unsigned char *server_digest =3D NULL;
 =09unsigned char chap_n[MAX_CHAP_N_SIZE], chap_r[MAX_RESPONSE_LENGTH];
 =09size_t compare_len;
 =09struct iscsi_chap *chap =3D conn->auth_protocol;
@@ -168,13 +217,33 @@ static int chap_server_compute_md5(
 =09struct shash_desc *desc =3D NULL;
 =09int auth_ret =3D -1, ret, challenge_len;
=20
+=09digest =3D kzalloc(chap->digest_size, GFP_KERNEL);
+=09if (!digest) {
+=09=09pr_err("Unable to allocate the digest buffer\n");
+=09=09goto out;
+=09}
+
+=09response =3D kzalloc(chap->digest_size * 2 + 2, GFP_KERNEL);
+=09if (!response) {
+=09=09pr_err("Unable to allocate the response buffer\n");
+=09=09goto out;
+=09}
+
+=09client_digest =3D kzalloc(chap->digest_size, GFP_KERNEL);
+=09if (!client_digest) {
+=09=09pr_err("Unable to allocate the client_digest buffer\n");
+=09=09goto out;
+=09}
+
+=09server_digest =3D kzalloc(chap->digest_size, GFP_KERNEL);
+=09if (!server_digest) {
+=09=09pr_err("Unable to allocate the server_digest buffer\n");
+=09=09goto out;
+=09}
+
 =09memset(identifier, 0, 10);
 =09memset(chap_n, 0, MAX_CHAP_N_SIZE);
 =09memset(chap_r, 0, MAX_RESPONSE_LENGTH);
-=09memset(digest, 0, MD5_SIGNATURE_SIZE);
-=09memset(response, 0, MD5_SIGNATURE_SIZE * 2 + 2);
-=09memset(client_digest, 0, MD5_SIGNATURE_SIZE);
-=09memset(server_digest, 0, MD5_SIGNATURE_SIZE);
=20
 =09challenge =3D kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
 =09if (!challenge) {
@@ -219,18 +288,18 @@ static int chap_server_compute_md5(
 =09=09pr_err("Could not find CHAP_R.\n");
 =09=09goto out;
 =09}
-=09if (strlen(chap_r) !=3D MD5_SIGNATURE_SIZE * 2) {
+=09if (strlen(chap_r) !=3D chap->digest_size * 2) {
 =09=09pr_err("Malformed CHAP_R\n");
 =09=09goto out;
 =09}
-=09if (hex2bin(client_digest, chap_r, MD5_SIGNATURE_SIZE) < 0) {
+=09if (hex2bin(client_digest, chap_r, chap->digest_size) < 0) {
 =09=09pr_err("Malformed CHAP_R\n");
 =09=09goto out;
 =09}
=20
 =09pr_debug("[server] Got CHAP_R=3D%s\n", chap_r);
=20
-=09tfm =3D crypto_alloc_shash("md5", 0, 0);
+=09tfm =3D crypto_alloc_shash(chap->digest_name, 0, 0);
 =09if (IS_ERR(tfm)) {
 =09=09tfm =3D NULL;
 =09=09pr_err("Unable to allocate struct crypto_shash\n");
@@ -271,15 +340,15 @@ static int chap_server_compute_md5(
 =09=09goto out;
 =09}
=20
-=09bin2hex(response, server_digest, MD5_SIGNATURE_SIZE);
-=09pr_debug("[server] MD5 Server Digest: %s\n", response);
+=09bin2hex(response, server_digest, chap->digest_size);
+=09pr_debug("[server] %s Server Digest: %s\n", hash_name, response);
=20
-=09if (memcmp(server_digest, client_digest, MD5_SIGNATURE_SIZE) !=3D 0) {
-=09=09pr_debug("[server] MD5 Digests do not match!\n\n");
+=09if (memcmp(server_digest, client_digest, chap->digest_size) !=3D 0) {
+=09=09pr_debug("[server] %s Digests do not match!\n\n", hash_name);
 =09=09goto out;
 =09} else
-=09=09pr_debug("[server] MD5 Digests match, CHAP connection"
-=09=09=09=09" successful.\n\n");
+=09=09pr_debug("[server] %s Digests match, CHAP connection"
+=09=09=09=09" successful.\n\n", hash_name);
 =09/*
 =09 * One way authentication has succeeded, return now if mutual
 =09 * authentication is not enabled.
@@ -393,7 +462,7 @@ static int chap_server_compute_md5(
 =09/*
 =09 * Convert response from binary hex to ascii hext.
 =09 */
-=09bin2hex(response, digest, MD5_SIGNATURE_SIZE);
+=09bin2hex(response, digest, chap->digest_size);
 =09*nr_out_len +=3D sprintf(nr_out_ptr + *nr_out_len, "CHAP_R=3D0x%s",
 =09=09=09response);
 =09*nr_out_len +=3D 1;
@@ -405,31 +474,13 @@ static int chap_server_compute_md5(
 =09=09crypto_free_shash(tfm);
 =09kfree(challenge);
 =09kfree(challenge_binhex);
+=09kfree(digest);
+=09kfree(response);
+=09kfree(server_digest);
+=09kfree(client_digest);
 =09return auth_ret;
 }
=20
-static int chap_got_response(
-=09struct iscsi_conn *conn,
-=09struct iscsi_node_auth *auth,
-=09char *nr_in_ptr,
-=09char *nr_out_ptr,
-=09unsigned int *nr_out_len)
-{
-=09struct iscsi_chap *chap =3D conn->auth_protocol;
-
-=09switch (chap->digest_type) {
-=09case CHAP_DIGEST_MD5:
-=09=09if (chap_server_compute_md5(conn, auth, nr_in_ptr,
-=09=09=09=09nr_out_ptr, nr_out_len) < 0)
-=09=09=09return -1;
-=09=09return 0;
-=09default:
-=09=09pr_err("Unknown CHAP digest type %d!\n",
-=09=09=09=09chap->digest_type);
-=09=09return -1;
-=09}
-}
-
 u32 chap_main_loop(
 =09struct iscsi_conn *conn,
 =09struct iscsi_node_auth *auth,
@@ -448,7 +499,7 @@ u32 chap_main_loop(
 =09=09return 0;
 =09} else if (chap->chap_state =3D=3D CHAP_STAGE_SERVER_AIC) {
 =09=09convert_null_to_semi(in_text, *in_len);
-=09=09if (chap_got_response(conn, auth, in_text, out_text,
+=09=09if (chap_server_compute_hash(conn, auth, in_text, out_text,
 =09=09=09=09out_len) < 0) {
 =09=09=09chap_close(conn);
 =09=09=09return 2;
diff --git a/drivers/target/iscsi/iscsi_target_auth.h b/drivers/target/iscs=
i/iscsi_target_auth.h
index d5600ac30b53..93db1ab5516c 100644
--- a/drivers/target/iscsi/iscsi_target_auth.h
+++ b/drivers/target/iscsi/iscsi_target_auth.h
@@ -6,14 +6,19 @@
=20
 #define CHAP_DIGEST_UNKNOWN=090
 #define CHAP_DIGEST_MD5=09=095
-#define CHAP_DIGEST_SHA=09=096
+#define CHAP_DIGEST_SHA1=096
+#define CHAP_DIGEST_SHA256=097
+#define CHAP_DIGEST_SHA3_256=098
=20
 #define CHAP_CHALLENGE_LENGTH=0916
 #define CHAP_CHALLENGE_STR_LEN=094096
-#define MAX_RESPONSE_LENGTH=0964=09/* sufficient for MD5 */
+#define MAX_RESPONSE_LENGTH=09128=09/* sufficient for SHA3 256 */
 #define=09MAX_CHAP_N_SIZE=09=09512
=20
 #define MD5_SIGNATURE_SIZE=0916=09/* 16 bytes in a MD5 message digest */
+#define SHA1_SIGNATURE_SIZE=0920=09/* 20 bytes in a SHA1 message digest */
+#define SHA256_SIGNATURE_SIZE=0932=09/* 32 bytes in a SHA256 message diges=
t */
+#define SHA3_256_SIGNATURE_SIZE=0932=09/* 32 bytes in a SHA3 256 message d=
igest */
=20
 #define CHAP_STAGE_CLIENT_A=091
 #define CHAP_STAGE_SERVER_AIC=092
@@ -28,9 +33,11 @@ extern u32 chap_main_loop(struct iscsi_conn *, struct is=
csi_node_auth *, char *,
 =09=09=09=09int *, int *);
=20
 struct iscsi_chap {
-=09unsigned char=09digest_type;
 =09unsigned char=09id;
 =09unsigned char=09challenge[CHAP_CHALLENGE_LENGTH];
+=09unsigned int=09challenge_len;
+=09unsigned char=09*digest_name;
+=09unsigned int=09digest_size;
 =09unsigned int=09authenticate_target;
 =09unsigned int=09chap_state;
 } ____cacheline_aligned;
--=20
Maurizio Lombardi

