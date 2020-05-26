Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12F01CCE4E
	for <lists+target-devel@lfdr.de>; Sun, 10 May 2020 23:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgEJV5x (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 10 May 2020 17:57:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42802 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728972AbgEJV5x (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 10 May 2020 17:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589147871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtOC7yhozGwSpi1ObIbsOC3pYvzbInVS5uL0N04TdXg=;
        b=g4jBJ7vKy0nynoNpy7NnvTn+aqTK4QJn9ZXlVPQ+3ilpGTVRt0mwSEbwMBNP8Gzsjc4o6V
        IE69mK1C9qgDj9WWf+WscTPMrN9Z2/5HFw9apE7+HS1FLn62mDckD5iVRi9Y4lyMVj0Ris
        8DsjCSK3+xsN+I4WO9834uT9iIlstlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-QIdEDkicMcaMuZqnFklMQQ-1; Sun, 10 May 2020 17:57:49 -0400
X-MC-Unique: QIdEDkicMcaMuZqnFklMQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE451899521;
        Sun, 10 May 2020 21:57:48 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-113-0.rdu2.redhat.com [10.10.113.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A322F1002382;
        Sun, 10 May 2020 21:57:47 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 01/15] target: check enforce_pr_isids during registration
Date:   Sun, 10 May 2020 16:57:30 -0500
Message-Id: <20200510215744.21999-2-mchristi@redhat.com>
In-Reply-To: <20200510215744.21999-1-mchristi@redhat.com>
References: <20200510215744.21999-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Move the check for enforce_pr_isids to the registration code where we
can fail at the time an initiator tries to register a path without an
isid. In its current place in __core_scsi3_locate_pr_reg, it is too
late because it can be registered and be reported in PR in commands and
it is stuck in this state because we cannot unregister it.

Note.
I am including in this patchset, because the 5th patch is built on top.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/target/target_core_pr.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 5e93169..cd2d32f 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -1176,15 +1176,6 @@ static struct t10_pr_registration *__core_scsi3_locate_pr_reg(
 		 * ISID, then we have found a match.
 		 */
 		if (!pr_reg->isid_present_at_reg) {
-			/*
-			 * Determine if this SCSI device server requires that
-			 * SCSI Intiatior TransportID w/ ISIDs is enforced
-			 * for fabric modules (iSCSI) requiring them.
-			 */
-			if (tpg->se_tpg_tfo->sess_get_initiator_sid != NULL) {
-				if (dev->dev_attrib.enforce_pr_isids)
-					continue;
-			}
 			atomic_inc_mb(&pr_reg->pr_res_holders);
 			spin_unlock(&pr_tmpl->registration_lock);
 			return pr_reg;
@@ -1591,10 +1582,25 @@ static void core_scsi3_lunacl_undepend_item(struct se_dev_entry *se_deve)
 				continue;
 			dest_rtpi = tmp_lun->lun_rtpi;
 
+			iport_ptr = NULL;
 			i_str = target_parse_pr_out_transport_id(tmp_tpg,
 					ptr, &tid_len, &iport_ptr);
 			if (!i_str)
 				continue;
+			/*
+			 * Determine if this SCSI device server requires that
+			 * SCSI Intiatior TransportID w/ ISIDs is enforced
+			 * for fabric modules (iSCSI) requiring them.
+			 */
+			if (tpg->se_tpg_tfo->sess_get_initiator_sid &&
+                            dev->dev_attrib.enforce_pr_isids &&
+			    !iport_ptr) {
+				pr_warn("SPC-PR: enforce_pr_isids is set but a isid has not been sent in the SPEC_I_PT data for %s.",
+					i_str);
+				ret = TCM_INVALID_PARAMETER_LIST;
+				spin_unlock(&dev->se_port_lock);
+				goto out_unmap;
+			}
 
 			atomic_inc_mb(&tmp_tpg->tpg_pr_ref_count);
 			spin_unlock(&dev->se_port_lock);
-- 
1.8.3.1

