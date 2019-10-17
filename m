Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 514D1DADF1
	for <lists+target-devel@lfdr.de>; Thu, 17 Oct 2019 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394296AbfJQNKp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 17 Oct 2019 09:10:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfJQNKo (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:10:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16FF1C059758;
        Thu, 17 Oct 2019 13:10:44 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-199.brq.redhat.com [10.40.204.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6871600C4;
        Thu, 17 Oct 2019 13:10:42 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     cleech@redhat.com
Cc:     mchristi@redhat.com, target-devel@vger.kernel.org,
        hch@infradead.org
Subject: [PATCH V2 1/3] target-iscsi: CHAP: add support to SHA1, SHA256 and SHA3-256 hash functions
Date:   Thu, 17 Oct 2019 15:10:35 +0200
Message-Id: <20191017131037.9903-2-mlombard@redhat.com>
In-Reply-To: <20191017131037.9903-1-mlombard@redhat.com>
References: <20191017131037.9903-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 17 Oct 2019 13:10:44 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patches modifies the chap_server_compute_hash() function
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

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index 51ddca2033e0..b09f20842e40 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -18,6 +18,22 @@
 #include "iscsi_target_nego.h"
 #include "iscsi_target_auth.h"
 
+static char *chap_get_digest_name(const int digest_type)
+{
+	switch (digest_type) {
+	case CHAP_DIGEST_MD5:
+		return "md5";
+	case CHAP_DIGEST_SHA1:
+		return "sha1";
+	case CHAP_DIGEST_SHA256:
+		return "sha256";
+	case CHAP_DIGEST_SHA3_256:
+		return "sha3-256";
+	default:
+		return NULL;
+	}
+}
+
 static int chap_gen_challenge(
 	struct iscsi_conn *conn,
 	int caller,
@@ -46,9 +62,23 @@ static int chap_gen_challenge(
 	return 0;
 }
 
+static int chap_test_algorithm(const char *name)
+{
+	struct crypto_shash *tfm;
+
+	tfm = crypto_alloc_shash(name, 0, 0);
+	if (IS_ERR(tfm))
+		return -1;
+
+	crypto_free_shash(tfm);
+	return 0;
+}
+
 static int chap_check_algorithm(const char *a_str)
 {
-	char *tmp, *orig, *token;
+	char *tmp, *orig, *token, *digest_name;
+	long digest_type;
+	int r = CHAP_DIGEST_UNKNOWN;
 
 	tmp = kstrdup(a_str, GFP_KERNEL);
 	if (!tmp) {
@@ -70,15 +100,24 @@ static int chap_check_algorithm(const char *a_str)
 		if (!token)
 			goto out;
 
-		if (!strncmp(token, "5", 1)) {
-			pr_debug("Selected MD5 Algorithm\n");
-			kfree(orig);
-			return CHAP_DIGEST_MD5;
+		if (kstrtol(token, 10, &digest_type))
+			continue;
+
+		digest_name = chap_get_digest_name(digest_type);
+		if (!digest_name)
+			continue;
+
+		pr_debug("Selected %s Algorithm\n", digest_name);
+		if (chap_test_algorithm(digest_name) < 0) {
+			pr_err("failed to allocate %s algo\n", digest_name);
+		} else {
+			r = digest_type;
+			goto out;
 		}
 	}
 out:
 	kfree(orig);
-	return CHAP_DIGEST_UNKNOWN;
+	return r;
 }
 
 static void chap_close(struct iscsi_conn *conn)
@@ -94,7 +133,7 @@ static struct iscsi_chap *chap_server_open(
 	char *aic_str,
 	unsigned int *aic_len)
 {
-	int ret;
+	int digest_type;
 	struct iscsi_chap *chap;
 
 	if (!(auth->naf_flags & NAF_USERID_SET) ||
@@ -109,17 +148,19 @@ static struct iscsi_chap *chap_server_open(
 		return NULL;
 
 	chap = conn->auth_protocol;
-	ret = chap_check_algorithm(a_str);
-	switch (ret) {
+	digest_type = chap_check_algorithm(a_str);
+	switch (digest_type) {
 	case CHAP_DIGEST_MD5:
-		pr_debug("[server] Got CHAP_A=5\n");
-		/*
-		 * Send back CHAP_A set to MD5.
-		*/
-		*aic_len = sprintf(aic_str, "CHAP_A=5");
-		*aic_len += 1;
-		chap->digest_type = CHAP_DIGEST_MD5;
-		pr_debug("[server] Sending CHAP_A=%d\n", chap->digest_type);
+		chap->digest_size = MD5_SIGNATURE_SIZE;
+		break;
+	case CHAP_DIGEST_SHA1:
+		chap->digest_size = SHA1_SIGNATURE_SIZE;
+		break;
+	case CHAP_DIGEST_SHA256:
+		chap->digest_size = SHA256_SIGNATURE_SIZE;
+		break;
+	case CHAP_DIGEST_SHA3_256:
+		chap->digest_size = SHA3_256_SIGNATURE_SIZE;
 		break;
 	case CHAP_DIGEST_UNKNOWN:
 	default:
@@ -128,6 +169,13 @@ static struct iscsi_chap *chap_server_open(
 		return NULL;
 	}
 
+	chap->digest_name = chap_get_digest_name(digest_type);
+
+	pr_debug("[server] Got CHAP_A=%d\n", digest_type);
+	*aic_len = sprintf(aic_str, "CHAP_A=%d", digest_type);
+	*aic_len += 1;
+	pr_debug("[server] Sending CHAP_A=%d\n", digest_type);
+
 	/*
 	 * Set Identifier.
 	 */
@@ -146,7 +194,7 @@ static struct iscsi_chap *chap_server_open(
 	return chap;
 }
 
-static int chap_server_compute_md5(
+static int chap_server_compute_hash(
 	struct iscsi_conn *conn,
 	struct iscsi_node_auth *auth,
 	char *nr_in_ptr,
@@ -155,12 +203,13 @@ static int chap_server_compute_md5(
 {
 	unsigned long id;
 	unsigned char id_as_uchar;
-	unsigned char digest[MD5_SIGNATURE_SIZE];
-	unsigned char type, response[MD5_SIGNATURE_SIZE * 2 + 2];
+	unsigned char type;
 	unsigned char identifier[10], *challenge = NULL;
 	unsigned char *challenge_binhex = NULL;
-	unsigned char client_digest[MD5_SIGNATURE_SIZE];
-	unsigned char server_digest[MD5_SIGNATURE_SIZE];
+	unsigned char *digest = NULL;
+	unsigned char *response = NULL;
+	unsigned char *client_digest = NULL;
+	unsigned char *server_digest = NULL;
 	unsigned char chap_n[MAX_CHAP_N_SIZE], chap_r[MAX_RESPONSE_LENGTH];
 	size_t compare_len;
 	struct iscsi_chap *chap = conn->auth_protocol;
@@ -168,13 +217,33 @@ static int chap_server_compute_md5(
 	struct shash_desc *desc = NULL;
 	int auth_ret = -1, ret, challenge_len;
 
+	digest = kzalloc(chap->digest_size, GFP_KERNEL);
+	if (!digest) {
+		pr_err("Unable to allocate the digest buffer\n");
+		goto out;
+	}
+
+	response = kzalloc(chap->digest_size * 2 + 2, GFP_KERNEL);
+	if (!response) {
+		pr_err("Unable to allocate the response buffer\n");
+		goto out;
+	}
+
+	client_digest = kzalloc(chap->digest_size, GFP_KERNEL);
+	if (!client_digest) {
+		pr_err("Unable to allocate the client_digest buffer\n");
+		goto out;
+	}
+
+	server_digest = kzalloc(chap->digest_size, GFP_KERNEL);
+	if (!server_digest) {
+		pr_err("Unable to allocate the server_digest buffer\n");
+		goto out;
+	}
+
 	memset(identifier, 0, 10);
 	memset(chap_n, 0, MAX_CHAP_N_SIZE);
 	memset(chap_r, 0, MAX_RESPONSE_LENGTH);
-	memset(digest, 0, MD5_SIGNATURE_SIZE);
-	memset(response, 0, MD5_SIGNATURE_SIZE * 2 + 2);
-	memset(client_digest, 0, MD5_SIGNATURE_SIZE);
-	memset(server_digest, 0, MD5_SIGNATURE_SIZE);
 
 	challenge = kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
 	if (!challenge) {
@@ -219,18 +288,18 @@ static int chap_server_compute_md5(
 		pr_err("Could not find CHAP_R.\n");
 		goto out;
 	}
-	if (strlen(chap_r) != MD5_SIGNATURE_SIZE * 2) {
+	if (strlen(chap_r) != chap->digest_size * 2) {
 		pr_err("Malformed CHAP_R\n");
 		goto out;
 	}
-	if (hex2bin(client_digest, chap_r, MD5_SIGNATURE_SIZE) < 0) {
+	if (hex2bin(client_digest, chap_r, chap->digest_size) < 0) {
 		pr_err("Malformed CHAP_R\n");
 		goto out;
 	}
 
 	pr_debug("[server] Got CHAP_R=%s\n", chap_r);
 
-	tfm = crypto_alloc_shash("md5", 0, 0);
+	tfm = crypto_alloc_shash(chap->digest_name, 0, 0);
 	if (IS_ERR(tfm)) {
 		tfm = NULL;
 		pr_err("Unable to allocate struct crypto_shash\n");
@@ -271,15 +340,15 @@ static int chap_server_compute_md5(
 		goto out;
 	}
 
-	bin2hex(response, server_digest, MD5_SIGNATURE_SIZE);
-	pr_debug("[server] MD5 Server Digest: %s\n", response);
+	bin2hex(response, server_digest, chap->digest_size);
+	pr_debug("[server] %s Server Digest: %s\n", hash_name, response);
 
-	if (memcmp(server_digest, client_digest, MD5_SIGNATURE_SIZE) != 0) {
-		pr_debug("[server] MD5 Digests do not match!\n\n");
+	if (memcmp(server_digest, client_digest, chap->digest_size) != 0) {
+		pr_debug("[server] %s Digests do not match!\n\n", hash_name);
 		goto out;
 	} else
-		pr_debug("[server] MD5 Digests match, CHAP connection"
-				" successful.\n\n");
+		pr_debug("[server] %s Digests match, CHAP connection"
+				" successful.\n\n", hash_name);
 	/*
 	 * One way authentication has succeeded, return now if mutual
 	 * authentication is not enabled.
@@ -393,7 +462,7 @@ static int chap_server_compute_md5(
 	/*
 	 * Convert response from binary hex to ascii hext.
 	 */
-	bin2hex(response, digest, MD5_SIGNATURE_SIZE);
+	bin2hex(response, digest, chap->digest_size);
 	*nr_out_len += sprintf(nr_out_ptr + *nr_out_len, "CHAP_R=0x%s",
 			response);
 	*nr_out_len += 1;
@@ -405,31 +474,13 @@ static int chap_server_compute_md5(
 		crypto_free_shash(tfm);
 	kfree(challenge);
 	kfree(challenge_binhex);
+	kfree(digest);
+	kfree(response);
+	kfree(server_digest);
+	kfree(client_digest);
 	return auth_ret;
 }
 
-static int chap_got_response(
-	struct iscsi_conn *conn,
-	struct iscsi_node_auth *auth,
-	char *nr_in_ptr,
-	char *nr_out_ptr,
-	unsigned int *nr_out_len)
-{
-	struct iscsi_chap *chap = conn->auth_protocol;
-
-	switch (chap->digest_type) {
-	case CHAP_DIGEST_MD5:
-		if (chap_server_compute_md5(conn, auth, nr_in_ptr,
-				nr_out_ptr, nr_out_len) < 0)
-			return -1;
-		return 0;
-	default:
-		pr_err("Unknown CHAP digest type %d!\n",
-				chap->digest_type);
-		return -1;
-	}
-}
-
 u32 chap_main_loop(
 	struct iscsi_conn *conn,
 	struct iscsi_node_auth *auth,
@@ -448,7 +499,7 @@ u32 chap_main_loop(
 		return 0;
 	} else if (chap->chap_state == CHAP_STAGE_SERVER_AIC) {
 		convert_null_to_semi(in_text, *in_len);
-		if (chap_got_response(conn, auth, in_text, out_text,
+		if (chap_server_compute_hash(conn, auth, in_text, out_text,
 				out_len) < 0) {
 			chap_close(conn);
 			return 2;
diff --git a/drivers/target/iscsi/iscsi_target_auth.h b/drivers/target/iscsi/iscsi_target_auth.h
index d5600ac30b53..93db1ab5516c 100644
--- a/drivers/target/iscsi/iscsi_target_auth.h
+++ b/drivers/target/iscsi/iscsi_target_auth.h
@@ -6,14 +6,19 @@
 
 #define CHAP_DIGEST_UNKNOWN	0
 #define CHAP_DIGEST_MD5		5
-#define CHAP_DIGEST_SHA		6
+#define CHAP_DIGEST_SHA1	6
+#define CHAP_DIGEST_SHA256	7
+#define CHAP_DIGEST_SHA3_256	8
 
 #define CHAP_CHALLENGE_LENGTH	16
 #define CHAP_CHALLENGE_STR_LEN	4096
-#define MAX_RESPONSE_LENGTH	64	/* sufficient for MD5 */
+#define MAX_RESPONSE_LENGTH	128	/* sufficient for SHA3 256 */
 #define	MAX_CHAP_N_SIZE		512
 
 #define MD5_SIGNATURE_SIZE	16	/* 16 bytes in a MD5 message digest */
+#define SHA1_SIGNATURE_SIZE	20	/* 20 bytes in a SHA1 message digest */
+#define SHA256_SIGNATURE_SIZE	32	/* 32 bytes in a SHA256 message digest */
+#define SHA3_256_SIGNATURE_SIZE	32	/* 32 bytes in a SHA3 256 message digest */
 
 #define CHAP_STAGE_CLIENT_A	1
 #define CHAP_STAGE_SERVER_AIC	2
@@ -28,9 +33,11 @@ extern u32 chap_main_loop(struct iscsi_conn *, struct iscsi_node_auth *, char *,
 				int *, int *);
 
 struct iscsi_chap {
-	unsigned char	digest_type;
 	unsigned char	id;
 	unsigned char	challenge[CHAP_CHALLENGE_LENGTH];
+	unsigned int	challenge_len;
+	unsigned char	*digest_name;
+	unsigned int	digest_size;
 	unsigned int	authenticate_target;
 	unsigned int	chap_state;
 } ____cacheline_aligned;
-- 
Maurizio Lombardi

