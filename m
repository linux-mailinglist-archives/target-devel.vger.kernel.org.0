Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1856E04
	for <lists+target-devel@lfdr.de>; Wed, 26 Jun 2019 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFZPsj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 26 Jun 2019 11:48:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZPsj (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:48:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EADB882FD;
        Wed, 26 Jun 2019 15:48:39 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29E25D71B;
        Wed, 26 Jun 2019 15:48:37 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, cleech@redhat.com, ddiss@suse.de
Subject: [PATCH] target/iscsi: set auth_protocol back to NULL if CHAP_A value is not supported.
Date:   Wed, 26 Jun 2019 17:48:36 +0200
Message-Id: <20190626154836.11542-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 26 Jun 2019 15:48:39 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

If the CHAP_A value is not supported, the chap_server_open() function
should free the auth_protocol pointer and set it to NULL, or
we will leave a dangling pointer around.

[   66.010905] Unsupported CHAP_A value
[   66.011660] Security negotiation failed.
[   66.012443] iSCSI Login negotiation failed.
[   68.413924] general protection fault: 0000 [#1] SMP PTI
[   68.414962] CPU: 0 PID: 1562 Comm: targetcli Kdump: loaded Not tainted 4.18.0-80.el8.x86_64 #1
[   68.416589] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   68.417677] RIP: 0010:__kmalloc_track_caller+0xc2/0x210

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/iscsi/iscsi_target_auth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index b6e4862cc242..139abb19da43 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -119,6 +119,7 @@ static struct iscsi_chap *chap_server_open(
 	default:
 		pr_err("Unsupported CHAP_A value\n");
 		kfree(conn->auth_protocol);
+		conn->auth_protocol = NULL;
 		return NULL;
 	}
 
-- 
Maurizio Lombardi

