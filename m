Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45636B0C06
	for <lists+target-devel@lfdr.de>; Thu, 12 Sep 2019 11:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfILJ4A (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 12 Sep 2019 05:56:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730428AbfILJz7 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:55:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 468F3B6EA;
        Thu, 12 Sep 2019 09:55:58 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/3] target: fix SendTargets=All string compares
Date:   Thu, 12 Sep 2019 11:55:46 +0200
Message-Id: <20190912095547.22427-3-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190912095547.22427-1-ddiss@suse.de>
References: <20190912095547.22427-1-ddiss@suse.de>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

strncmp is currently used for "SendTargets" key and "All" value matching
without checking for trailing garbage. This means that Text request PDUs
with garbage such as "SendTargetsPlease=All" and "SendTargets=Alle" are
processed successfully as if they were "SendTargets=All" requests.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/iscsi/iscsi_target.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index d19e051f2bc2..09e55ea0bf5d 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2189,24 +2189,22 @@ iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 		}
 		goto empty_sendtargets;
 	}
-	if (strncmp("SendTargets", text_in, 11) != 0) {
+	if (strncmp("SendTargets=", text_in, 12) != 0) {
 		pr_err("Received Text Data that is not"
 			" SendTargets, cannot continue.\n");
 		goto reject;
 	}
+	/* '=' confirmed in strncmp */
 	text_ptr = strchr(text_in, '=');
-	if (!text_ptr) {
-		pr_err("No \"=\" separator found in Text Data,"
-			"  cannot continue.\n");
-		goto reject;
-	}
-	if (!strncmp("=All", text_ptr, 4)) {
+	BUG_ON(!text_ptr);
+	if (!strncmp("=All", text_ptr, 5)) {
 		cmd->cmd_flags |= ICF_SENDTARGETS_ALL;
 	} else if (!strncmp("=iqn.", text_ptr, 5) ||
 		   !strncmp("=eui.", text_ptr, 5)) {
 		cmd->cmd_flags |= ICF_SENDTARGETS_SINGLE;
 	} else {
-		pr_err("Unable to locate valid SendTargets=%s value\n", text_ptr);
+		pr_err("Unable to locate valid SendTargets%s value\n",
+		       text_ptr);
 		goto reject;
 	}
 
-- 
2.16.4

