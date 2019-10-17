Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94FDADF3
	for <lists+target-devel@lfdr.de>; Thu, 17 Oct 2019 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394307AbfJQNKs (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 17 Oct 2019 09:10:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfJQNKs (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A47EE69089;
        Thu, 17 Oct 2019 13:10:47 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-199.brq.redhat.com [10.40.204.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39C57600C4;
        Thu, 17 Oct 2019 13:10:46 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     cleech@redhat.com
Cc:     mchristi@redhat.com, target-devel@vger.kernel.org,
        hch@infradead.org
Subject: [PATCH V2 3/3] target-iscsi: rename some variables to avoid confusion.
Date:   Thu, 17 Oct 2019 15:10:37 +0200
Message-Id: <20191017131037.9903-4-mlombard@redhat.com>
In-Reply-To: <20191017131037.9903-1-mlombard@redhat.com>
References: <20191017131037.9903-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 17 Oct 2019 13:10:47 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch renames some variables in chap_server_compute_hash()
to make it harder to confuse the initiator's challenge with
the target's challenge when the mutual chap authentication is used.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target_auth.c | 40 ++++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index f3973ab19da2..0e54627d9aa8 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -215,8 +215,8 @@ static int chap_server_compute_hash(
 	unsigned long id;
 	unsigned char id_as_uchar;
 	unsigned char type;
-	unsigned char identifier[10], *challenge = NULL;
-	unsigned char *challenge_binhex = NULL;
+	unsigned char identifier[10], *initiatorchg = NULL;
+	unsigned char *initiatorchg_binhex = NULL;
 	unsigned char *digest = NULL;
 	unsigned char *response = NULL;
 	unsigned char *client_digest = NULL;
@@ -226,7 +226,7 @@ static int chap_server_compute_hash(
 	struct iscsi_chap *chap = conn->auth_protocol;
 	struct crypto_shash *tfm = NULL;
 	struct shash_desc *desc = NULL;
-	int auth_ret = -1, ret, challenge_len;
+	int auth_ret = -1, ret, initiatorchg_len;
 
 	digest = kzalloc(chap->digest_size, GFP_KERNEL);
 	if (!digest) {
@@ -256,15 +256,15 @@ static int chap_server_compute_hash(
 	memset(chap_n, 0, MAX_CHAP_N_SIZE);
 	memset(chap_r, 0, MAX_RESPONSE_LENGTH);
 
-	challenge = kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
-	if (!challenge) {
+	initiatorchg = kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
+	if (!initiatorchg) {
 		pr_err("Unable to allocate challenge buffer\n");
 		goto out;
 	}
 
-	challenge_binhex = kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
-	if (!challenge_binhex) {
-		pr_err("Unable to allocate challenge_binhex buffer\n");
+	initiatorchg_binhex = kzalloc(CHAP_CHALLENGE_STR_LEN, GFP_KERNEL);
+	if (!initiatorchg_binhex) {
+		pr_err("Unable to allocate initiatorchg_binhex buffer\n");
 		goto out;
 	}
 	/*
@@ -399,7 +399,7 @@ static int chap_server_compute_hash(
 	 * Get CHAP_C.
 	 */
 	if (extract_param(nr_in_ptr, "CHAP_C", CHAP_CHALLENGE_STR_LEN,
-			challenge, &type) < 0) {
+			initiatorchg, &type) < 0) {
 		pr_err("Could not find CHAP_C.\n");
 		goto out;
 	}
@@ -408,28 +408,28 @@ static int chap_server_compute_hash(
 		pr_err("Could not find CHAP_C.\n");
 		goto out;
 	}
-	challenge_len = DIV_ROUND_UP(strlen(challenge), 2);
-	if (!challenge_len) {
+	initiatorchg_len = DIV_ROUND_UP(strlen(initiatorchg), 2);
+	if (!initiatorchg_len) {
 		pr_err("Unable to convert incoming challenge\n");
 		goto out;
 	}
-	if (challenge_len > 1024) {
+	if (initiatorchg_len > 1024) {
 		pr_err("CHAP_C exceeds maximum binary size of 1024 bytes\n");
 		goto out;
 	}
-	if (hex2bin(challenge_binhex, challenge, challenge_len) < 0) {
+	if (hex2bin(initiatorchg_binhex, initiatorchg, initiatorchg_len) < 0) {
 		pr_err("Malformed CHAP_C\n");
 		goto out;
 	}
-	pr_debug("[server] Got CHAP_C=%s\n", challenge);
+	pr_debug("[server] Got CHAP_C=%s\n", initiatorchg);
 	/*
 	 * During mutual authentication, the CHAP_C generated by the
 	 * initiator must not match the original CHAP_C generated by
 	 * the target.
 	 */
-	if (challenge_len == chap->challenge_len &&
-				!memcmp(challenge_binhex, chap->challenge,
-				challenge_len)) {
+	if (initiatorchg_len == chap->challenge_len &&
+				!memcmp(initiatorchg_binhex, chap->challenge,
+				initiatorchg_len)) {
 		pr_err("initiator CHAP_C matches target CHAP_C, failing"
 		       " login attempt\n");
 		goto out;
@@ -461,7 +461,7 @@ static int chap_server_compute_hash(
 	/*
 	 * Convert received challenge to binary hex.
 	 */
-	ret = crypto_shash_finup(desc, challenge_binhex, challenge_len,
+	ret = crypto_shash_finup(desc, initiatorchg_binhex, initiatorchg_len,
 				 digest);
 	if (ret < 0) {
 		pr_err("crypto_shash_finup() failed for ma challenge\n");
@@ -487,8 +487,8 @@ static int chap_server_compute_hash(
 	kzfree(desc);
 	if (tfm)
 		crypto_free_shash(tfm);
-	kfree(challenge);
-	kfree(challenge_binhex);
+	kfree(initiatorchg);
+	kfree(initiatorchg_binhex);
 	kfree(digest);
 	kfree(response);
 	kfree(server_digest);
-- 
Maurizio Lombardi

