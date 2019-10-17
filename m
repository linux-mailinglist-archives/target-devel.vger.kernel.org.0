Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C13DADF2
	for <lists+target-devel@lfdr.de>; Thu, 17 Oct 2019 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394305AbfJQNKq (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 17 Oct 2019 09:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfJQNKq (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:10:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE2DD3060398;
        Thu, 17 Oct 2019 13:10:45 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-199.brq.redhat.com [10.40.204.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75D4E600C4;
        Thu, 17 Oct 2019 13:10:44 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     cleech@redhat.com
Cc:     mchristi@redhat.com, target-devel@vger.kernel.org,
        hch@infradead.org
Subject: [PATCH V2 2/3] target-iscsi: tie the challenge length to the hash digest size
Date:   Thu, 17 Oct 2019 15:10:36 +0200
Message-Id: <20191017131037.9903-3-mlombard@redhat.com>
In-Reply-To: <20191017131037.9903-1-mlombard@redhat.com>
References: <20191017131037.9903-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 17 Oct 2019 13:10:45 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target_auth.c | 37 +++++++++++++++++-------
 drivers/target/iscsi/iscsi_target_auth.h |  4 +--
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index b09f20842e40..f3973ab19da2 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -41,16 +41,21 @@ static int chap_gen_challenge(
 	unsigned int *c_len)
 {
 	int ret;
-	unsigned char challenge_asciihex[CHAP_CHALLENGE_LENGTH * 2 + 1];
+	unsigned char *challenge_asciihex;
 	struct iscsi_chap *chap = conn->auth_protocol;
 
-	memset(challenge_asciihex, 0, CHAP_CHALLENGE_LENGTH * 2 + 1);
+	challenge_asciihex = kzalloc(chap->challenge_len * 2 + 1, GFP_KERNEL);
+	if (!challenge_asciihex)
+		return -ENOMEM;
 
-	ret = get_random_bytes_wait(chap->challenge, CHAP_CHALLENGE_LENGTH);
+	memset(chap->challenge, 0, MAX_CHAP_CHALLENGE_LEN);
+
+	ret = get_random_bytes_wait(chap->challenge, chap->challenge_len);
 	if (unlikely(ret))
-		return ret;
+		goto out;
+
 	bin2hex(challenge_asciihex, chap->challenge,
-				CHAP_CHALLENGE_LENGTH);
+				chap->challenge_len);
 	/*
 	 * Set CHAP_C, and copy the generated challenge into c_str.
 	 */
@@ -59,7 +64,10 @@ static int chap_gen_challenge(
 
 	pr_debug("[%s] Sending CHAP_C=0x%s\n\n", (caller) ? "server" : "client",
 			challenge_asciihex);
-	return 0;
+
+out:
+	kfree(challenge_asciihex);
+	return ret;
 }
 
 static int chap_test_algorithm(const char *name)
@@ -171,6 +179,9 @@ static struct iscsi_chap *chap_server_open(
 
 	chap->digest_name = chap_get_digest_name(digest_type);
 
+	/* Tie the challenge length to the digest size */
+	chap->challenge_len = chap->digest_size;
+
 	pr_debug("[server] Got CHAP_A=%d\n", digest_type);
 	*aic_len = sprintf(aic_str, "CHAP_A=%d", digest_type);
 	*aic_len += 1;
@@ -334,21 +345,23 @@ static int chap_server_compute_hash(
 	}
 
 	ret = crypto_shash_finup(desc, chap->challenge,
-				 CHAP_CHALLENGE_LENGTH, server_digest);
+				 chap->challenge_len, server_digest);
 	if (ret < 0) {
 		pr_err("crypto_shash_finup() failed for challenge\n");
 		goto out;
 	}
 
 	bin2hex(response, server_digest, chap->digest_size);
-	pr_debug("[server] %s Server Digest: %s\n", hash_name, response);
+	pr_debug("[server] %s Server Digest: %s\n",
+		chap->digest_name, response);
 
 	if (memcmp(server_digest, client_digest, chap->digest_size) != 0) {
-		pr_debug("[server] %s Digests do not match!\n\n", hash_name);
+		pr_debug("[server] %s Digests do not match!\n\n",
+			chap->digest_name);
 		goto out;
 	} else
 		pr_debug("[server] %s Digests match, CHAP connection"
-				" successful.\n\n", hash_name);
+				" successful.\n\n", chap->digest_name);
 	/*
 	 * One way authentication has succeeded, return now if mutual
 	 * authentication is not enabled.
@@ -414,7 +427,9 @@ static int chap_server_compute_hash(
 	 * initiator must not match the original CHAP_C generated by
 	 * the target.
 	 */
-	if (!memcmp(challenge_binhex, chap->challenge, CHAP_CHALLENGE_LENGTH)) {
+	if (challenge_len == chap->challenge_len &&
+				!memcmp(challenge_binhex, chap->challenge,
+				challenge_len)) {
 		pr_err("initiator CHAP_C matches target CHAP_C, failing"
 		       " login attempt\n");
 		goto out;
diff --git a/drivers/target/iscsi/iscsi_target_auth.h b/drivers/target/iscsi/iscsi_target_auth.h
index 93db1ab5516c..fc75c1c20e23 100644
--- a/drivers/target/iscsi/iscsi_target_auth.h
+++ b/drivers/target/iscsi/iscsi_target_auth.h
@@ -10,7 +10,7 @@
 #define CHAP_DIGEST_SHA256	7
 #define CHAP_DIGEST_SHA3_256	8
 
-#define CHAP_CHALLENGE_LENGTH	16
+#define MAX_CHAP_CHALLENGE_LEN	32
 #define CHAP_CHALLENGE_STR_LEN	4096
 #define MAX_RESPONSE_LENGTH	128	/* sufficient for SHA3 256 */
 #define	MAX_CHAP_N_SIZE		512
@@ -34,7 +34,7 @@ extern u32 chap_main_loop(struct iscsi_conn *, struct iscsi_node_auth *, char *,
 
 struct iscsi_chap {
 	unsigned char	id;
-	unsigned char	challenge[CHAP_CHALLENGE_LENGTH];
+	unsigned char	challenge[MAX_CHAP_CHALLENGE_LEN];
 	unsigned int	challenge_len;
 	unsigned char	*digest_name;
 	unsigned int	digest_size;
-- 
Maurizio Lombardi

