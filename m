Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034423FFFF7
	for <lists+target-devel@lfdr.de>; Fri,  3 Sep 2021 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348912AbhICMtT (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 3 Sep 2021 08:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234262AbhICMtH (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630673286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=44qV1t1dNjoY+ogDzQhPAlZXPZTbBgSbSE3UNWUYIN0=;
        b=fCs0Y+B1v6Lax8tpDrFFiZgmcLEyyF27MBOThPvo1yEHmjHPvWC+RbGYladJBm+e09CTs5
        3KQ1LymuBsUB4o99gu4aC+pnl0WezpB9pwPnDJ/8snEunPms9QlNSRdFR2uKgQ2roEiefJ
        XijwDWDXjevzXakCF/QEG2jyWUtSUmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-XcyneTKqPHSfKk1ieHJX0g-1; Fri, 03 Sep 2021 08:48:04 -0400
X-MC-Unique: XcyneTKqPHSfKk1ieHJX0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC18801AC3;
        Fri,  3 Sep 2021 12:48:03 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6A4C6B543;
        Fri,  3 Sep 2021 12:48:01 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     martin.petersen@oracle.com
Cc:     bostroesser@gmail.com, michael.christie@oracle.com,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] target: fix the pgr/alua_support_store functions
Date:   Fri,  3 Sep 2021 14:48:00 +0200
Message-Id: <20210903124800.30525-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Commit 356ba2a8bc8d ("scsi: target: tcmu: Make pgr_support and
alua_support attributes writable")
introduced support for changeable alua_support and pgr_support
target attributes. They can only be changed
if the backstore is user-backed, otherwise the kernel returns -EINVAL.

This caused a regression in targetcli/rtslib because now a warning
is triggered when performing a target restore that includes
non-userbacked backstores, even if rtslib is not trying to change
the attributes' values:

$ targetctl restore
Storage Object block/storage1: Cannot set attribute alua_support:
[Errno 22] Invalid argument, skipped
Storage Object block/storage1: Cannot set attribute pgr_support:
[Errno 22] Invalid argument, skipped

Fix this warning by returning an error only if we are really
going to flip the PGR/ALUA bit in the transport_flags field,
otherwise we'll do nothing and return success.

Return EOPNOTSUPP instead of EINVAL if the pgr/alua attributes
can't be changed, this way it'll be possible for userspace to understand
if the operation failed because an invalid value has been passed
to strtobool() or because the attributes are fixed.

Fixes: 356ba2a8bc8d ("scsi: target: tcmu: Make pgr_support and alua_support attributes writable")

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/target_core_configfs.c | 32 +++++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 102ec644bc8a..72d750f753bf 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1110,20 +1110,24 @@ static ssize_t alua_support_store(struct config_item *item,
 {
 	struct se_dev_attrib *da = to_attrib(item);
 	struct se_device *dev = da->da_dev;
-	bool flag;
+	bool flag, oldflag;
 	int ret;
 
+	ret = strtobool(page, &flag);
+	if (ret < 0)
+		return ret;
+
+	oldflag = !(dev->transport_flags & TRANSPORT_FLAG_PASSTHROUGH_ALUA);
+	if (flag == oldflag)
+		return count;
+
 	if (!(dev->transport->transport_flags_changeable &
 	      TRANSPORT_FLAG_PASSTHROUGH_ALUA)) {
 		pr_err("dev[%p]: Unable to change SE Device alua_support:"
 			" alua_support has fixed value\n", dev);
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
-	ret = strtobool(page, &flag);
-	if (ret < 0)
-		return ret;
-
 	if (flag)
 		dev->transport_flags &= ~TRANSPORT_FLAG_PASSTHROUGH_ALUA;
 	else
@@ -1145,20 +1149,24 @@ static ssize_t pgr_support_store(struct config_item *item,
 {
 	struct se_dev_attrib *da = to_attrib(item);
 	struct se_device *dev = da->da_dev;
-	bool flag;
+	bool flag, oldflag;
 	int ret;
 
+	ret = strtobool(page, &flag);
+	if (ret < 0)
+		return ret;
+
+	oldflag = !(dev->transport_flags & TRANSPORT_FLAG_PASSTHROUGH_PGR);
+	if (flag == oldflag)
+		return count;
+
 	if (!(dev->transport->transport_flags_changeable &
 	      TRANSPORT_FLAG_PASSTHROUGH_PGR)) {
 		pr_err("dev[%p]: Unable to change SE Device pgr_support:"
 			" pgr_support has fixed value\n", dev);
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
-	ret = strtobool(page, &flag);
-	if (ret < 0)
-		return ret;
-
 	if (flag)
 		dev->transport_flags &= ~TRANSPORT_FLAG_PASSTHROUGH_PGR;
 	else
-- 
2.27.0

