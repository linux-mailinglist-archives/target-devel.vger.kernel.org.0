Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A35E7197
	for <lists+target-devel@lfdr.de>; Mon, 28 Oct 2019 13:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfJ1Mil (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 28 Oct 2019 08:38:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41201 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbfJ1Mil (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572266319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uTXmcDggs9arSmYol0p3kqWQyviimG5Qsl31yFm8+WA=;
        b=XLHni5J7FFXj//65J+XGaRQXDhaJeSLRot4tNfHYS9+66UJSMcf1wiA6OQ2LOhOihnWpEF
        T3qM3lKo/diAk4GBH3QG/TzS1hBHg+UemPBVXsueisOT9bQRHhw4DNAs3hLTiWxo2L3sQP
        40rbVYiOPiNZXxXu3EFfn/gyuepiriA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-04R8wVCSPb6LUdIR-LVYHg-1; Mon, 28 Oct 2019 08:38:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CBCF180491C;
        Mon, 28 Oct 2019 12:38:36 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F26D600C9;
        Mon, 28 Oct 2019 12:38:33 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     cleech@redhat.com
Cc:     mchristi@redhat.com, target-devel@vger.kernel.org,
        hch@infradead.org, martin.petersen@oracle.com
Subject: [PATCH V3 3/3] target-iscsi: rename some variables to avoid confusion.
Date:   Mon, 28 Oct 2019 13:38:22 +0100
Message-Id: <20191028123822.5864-4-mlombard@redhat.com>
In-Reply-To: <20191028123822.5864-1-mlombard@redhat.com>
References: <20191028123822.5864-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 04R8wVCSPb6LUdIR-LVYHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch renames some variables in chap_server_compute_hash()
to avoid confusing the initiator's challenge with
the target's challenge when the mutual chap authentication is used.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target_auth.c | 43 ++++++++++++------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscs=
i/iscsi_target_auth.c
index f3973ab19da2..09c6bde0a978 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -215,8 +215,8 @@ static int chap_server_compute_hash(
 =09unsigned long id;
 =09unsigned char id_as_uchar;
 =09unsigned char type;
-=09unsigned char identifier[10], *challenge =3D NULL;
-=09unsigned char *challenge_binhex =3D NULL;
+=09unsigned char identifier[10], *client_challenge =3D NULL;
+=09unsigned char *client_challenge_binhex =3D NULL;
 =09unsigned char *digest =3D NULL;
 =09unsigned char *response =3D NULL;
 =09unsigned char *client_digest =3D NULL;
@@ -226,7 +226,7 @@ static int chap_server_compute_hash(
 =09struct iscsi_chap *chap =3D conn->auth_protocol;
 =09struct crypto_shash *tfm =3D NULL;
 =09struct shash_desc *desc =3D NULL;
-=09int auth_ret =3D -1, ret, challenge_len;
+=09int auth_ret =3D -1, ret, client_challenge_len;
=20
 =09digest =3D kzalloc(chap->digest_size, GFP_KERNEL);
 =09if (!digest) {
@@ -256,15 +256,15 @@ static int chap_server_compute_hash(
 =09memset(chap_n, 0, MAX_CHAP_N_SIZE);
 =09memset(chap_r, 0, MAX_RESPONSE_LENGTH);
=20
-=09challenge =3D kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
-=09if (!challenge) {
+=09client_challenge =3D kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
+=09if (!client_challenge) {
 =09=09pr_err("Unable to allocate challenge buffer\n");
 =09=09goto out;
 =09}
=20
-=09challenge_binhex =3D kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
-=09if (!challenge_binhex) {
-=09=09pr_err("Unable to allocate challenge_binhex buffer\n");
+=09client_challenge_binhex =3D kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL)=
;
+=09if (!client_challenge_binhex) {
+=09=09pr_err("Unable to allocate client_challenge_binhex buffer\n");
 =09=09goto out;
 =09}
 =09/*
@@ -399,7 +399,7 @@ static int chap_server_compute_hash(
 =09 * Get CHAP_C.
 =09 */
 =09if (extract_param(nr_in_ptr, "CHAP_C", CHAP_CHALLENGE_STR_LEN,
-=09=09=09challenge, &type) < 0) {
+=09=09=09client_challenge, &type) < 0) {
 =09=09pr_err("Could not find CHAP_C.\n");
 =09=09goto out;
 =09}
@@ -408,28 +408,29 @@ static int chap_server_compute_hash(
 =09=09pr_err("Could not find CHAP_C.\n");
 =09=09goto out;
 =09}
-=09challenge_len =3D DIV_ROUND_UP(strlen(challenge), 2);
-=09if (!challenge_len) {
+=09client_challenge_len =3D DIV_ROUND_UP(strlen(client_challenge), 2);
+=09if (!client_challenge_len) {
 =09=09pr_err("Unable to convert incoming challenge\n");
 =09=09goto out;
 =09}
-=09if (challenge_len > 1024) {
+=09if (client_challenge_len > 1024) {
 =09=09pr_err("CHAP_C exceeds maximum binary size of 1024 bytes\n");
 =09=09goto out;
 =09}
-=09if (hex2bin(challenge_binhex, challenge, challenge_len) < 0) {
+=09if (hex2bin(client_challenge_binhex, client_challenge,
+=09=09    client_challenge_len) < 0) {
 =09=09pr_err("Malformed CHAP_C\n");
 =09=09goto out;
 =09}
-=09pr_debug("[server] Got CHAP_C=3D%s\n", challenge);
+=09pr_debug("[server] Got CHAP_C=3D%s\n", client_challenge);
 =09/*
 =09 * During mutual authentication, the CHAP_C generated by the
 =09 * initiator must not match the original CHAP_C generated by
 =09 * the target.
 =09 */
-=09if (challenge_len =3D=3D chap->challenge_len &&
-=09=09=09=09!memcmp(challenge_binhex, chap->challenge,
-=09=09=09=09challenge_len)) {
+=09if (client_challenge_len =3D=3D chap->challenge_len &&
+=09=09=09=09!memcmp(client_challenge_binhex,
+=09=09=09=09chap->challenge, client_challenge_len)) {
 =09=09pr_err("initiator CHAP_C matches target CHAP_C, failing"
 =09=09       " login attempt\n");
 =09=09goto out;
@@ -461,8 +462,8 @@ static int chap_server_compute_hash(
 =09/*
 =09 * Convert received challenge to binary hex.
 =09 */
-=09ret =3D crypto_shash_finup(desc, challenge_binhex, challenge_len,
-=09=09=09=09 digest);
+=09ret =3D crypto_shash_finup(desc, client_challenge_binhex,
+=09=09=09=09 client_challenge_len, digest);
 =09if (ret < 0) {
 =09=09pr_err("crypto_shash_finup() failed for ma challenge\n");
 =09=09goto out;
@@ -487,8 +488,8 @@ static int chap_server_compute_hash(
 =09kzfree(desc);
 =09if (tfm)
 =09=09crypto_free_shash(tfm);
-=09kfree(challenge);
-=09kfree(challenge_binhex);
+=09kfree(client_challenge);
+=09kfree(client_challenge_binhex);
 =09kfree(digest);
 =09kfree(response);
 =09kfree(server_digest);
--=20
Maurizio Lombardi

