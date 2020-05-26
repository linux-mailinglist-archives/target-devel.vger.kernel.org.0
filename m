Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B81CCE5F
	for <lists+target-devel@lfdr.de>; Sun, 10 May 2020 23:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgEJV6K (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 10 May 2020 17:58:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729471AbgEJV6J (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 10 May 2020 17:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589147888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZrWSCPYOQkVLPby+SpEg4W1WGSJ+XmZjUu304SKXz0=;
        b=csbuiJXBq6Jz+txlvN2Kce3uRJsNCAFS4MxFwFCSJY6pylM2fL+3kvP0RvLD2gWmT88lwc
        CpGHSalEGwWpb5gcGU8PDXGX4Rkd/YV8dNfbie6zbH/6mZpa96VHG2IR9xzv1w1BxZ1SSW
        UPHCzbWfT1Xes7llaiSKBnrTdDoXNh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-SAcTsozZNdCNUzUZwnGViA-1; Sun, 10 May 2020 17:58:04 -0400
X-MC-Unique: SAcTsozZNdCNUzUZwnGViA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3F9B107ACF2;
        Sun, 10 May 2020 21:58:02 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-113-0.rdu2.redhat.com [10.10.113.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B92A1002382;
        Sun, 10 May 2020 21:58:02 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 08/15] target: use tpt_id in target_stat_iport_port_ident_show
Date:   Sun, 10 May 2020 16:57:37 -0500
Message-Id: <20200510215744.21999-9-mchristi@redhat.com>
In-Reply-To: <20200510215744.21999-1-mchristi@redhat.com>
References: <20200510215744.21999-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Use the tpt_id session id instead of sess_get_initiator_sid.

Note that for userspace compat this patch continues the behavior:

1. Still add the "+i+" even if there is no session_id.
2. Use the acl initiatorname instead of the transportID port/addr/name.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/target/target_core_stat.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/target/target_core_stat.c b/drivers/target/target_core_stat.c
index 237309d..3eb1b9b 100644
--- a/drivers/target/target_core_stat.c
+++ b/drivers/target/target_core_stat.c
@@ -1308,9 +1308,7 @@ static ssize_t target_stat_iport_port_ident_show(struct config_item *item,
 	struct se_lun_acl *lacl = iport_to_lacl(item);
 	struct se_node_acl *nacl = lacl->se_lun_nacl;
 	struct se_session *se_sess;
-	struct se_portal_group *tpg;
 	ssize_t ret;
-	unsigned char buf[64];
 
 	spin_lock_irq(&nacl->nacl_sess_lock);
 	se_sess = nacl->nacl_sess;
@@ -1319,13 +1317,9 @@ static ssize_t target_stat_iport_port_ident_show(struct config_item *item,
 		return -ENODEV;
 	}
 
-	tpg = nacl->se_tpg;
-	/* scsiAttIntrPortName+scsiAttIntrPortIdentifier */
-	memset(buf, 0, 64);
-	if (tpg->se_tpg_tfo->sess_get_initiator_sid != NULL)
-		tpg->se_tpg_tfo->sess_get_initiator_sid(se_sess, buf, 64);
-
-	ret = snprintf(page, PAGE_SIZE, "%s+i+%s\n", nacl->initiatorname, buf);
+	ret = snprintf(page, PAGE_SIZE, "%s+i+%s\n", nacl->initiatorname,
+		       se_sess->tpt_id->session_id ? se_sess->tpt_id->session_id :
+		       "");
 	spin_unlock_irq(&nacl->nacl_sess_lock);
 	return ret;
 }
-- 
1.8.3.1

