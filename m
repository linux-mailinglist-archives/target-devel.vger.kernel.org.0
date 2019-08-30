Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2EA3CD7
	for <lists+target-devel@lfdr.de>; Fri, 30 Aug 2019 19:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfH3RQ1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 30 Aug 2019 13:16:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:59068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbfH3RQ1 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:16:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 668CCAB7D;
        Fri, 30 Aug 2019 17:16:26 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, mlombard@redhat.com,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH] target: compare full CHAP_A Algorithm strings
Date:   Fri, 30 Aug 2019 19:16:11 +0200
Message-Id: <20190830171611.32540-1-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

RFC 2307 states:

  For CHAP [RFC1994], in the first step, the initiator MUST send:

      CHAP_A=<A1,A2...>

   Where A1,A2... are proposed algorithms, in order of preference.
...
   For the Algorithm, as stated in [RFC1994], one value is required to
   be implemented:

       5     (CHAP with MD5)

LIO currently checks for this value by only comparing a single byte in
the tokenized Algorithm string, which means that any value starting with
a '5' (e.g. "55") is interpreted as "CHAP with MD5". Fix this by
comparing the entire tokenized string.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/iscsi/iscsi_target_auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index 51ddca2033e0..8fe9b12a07a4 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -70,7 +70,7 @@ static int chap_check_algorithm(const char *a_str)
 		if (!token)
 			goto out;
 
-		if (!strncmp(token, "5", 1)) {
+		if (!strcmp(token, "5")) {
 			pr_debug("Selected MD5 Algorithm\n");
 			kfree(orig);
 			return CHAP_DIGEST_MD5;
-- 
2.16.4

