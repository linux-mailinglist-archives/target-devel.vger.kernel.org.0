Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B6C4E929D
	for <lists+target-devel@lfdr.de>; Mon, 28 Mar 2022 12:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbiC1Kl0 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 28 Mar 2022 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiC1KlZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 897BD3F8B6
        for <target-devel@vger.kernel.org>; Mon, 28 Mar 2022 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648463984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JhrTyJTCFu7hB8SBZVA1X46PfehWP4fpym3XvVhqnZE=;
        b=dOoAuP7gfMS5sIzWLJmT64TDcMqDqkNnurgQEOypltRLn8lnEsQKD6yrHV5YqJo5x0e35K
        odQx5PJuWsg8ovy5hKa34KZrOEYF6iaHsrHgytGm3MESEQUpUt87wo2Q3dw/bJn502kBaH
        xNZXWAr6cEKwVDJHFmPbYVSxY6Hj5XU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-MXhb0bPBO8G_WswNfEEhBQ-1; Mon, 28 Mar 2022 06:39:43 -0400
X-MC-Unique: MXhb0bPBO8G_WswNfEEhBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6471802803;
        Mon, 28 Mar 2022 10:39:42 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2EA6400E54D;
        Mon, 28 Mar 2022 10:39:41 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     martin.petersen@oracle.com
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        michael.christie@oracle.com
Subject: [PATCH V2] target: allow changing dbroot if there are no registered devices
Date:   Mon, 28 Mar 2022 12:39:40 +0200
Message-Id: <20220328103940.19977-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The target driver prevents the users from changing
the database root directory if a target module like ib_srpt has
been registered, this makes it difficult for users to
set their preferred database directory if the module
gets loaded during the system boot.

Let the users modify dbroot if there are no registered devices

v2: add a mutex to protect against possible race conditions

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/target/target_core_configfs.c | 47 ++++++++++++++++-----------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 023bd4516a68..fed1e7bdc013 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -72,6 +72,9 @@ static struct config_group target_core_hbagroup;
 static struct config_group alua_group;
 static struct config_group alua_lu_gps_group;
 
+static unsigned int target_devices;
+static DEFINE_MUTEX(target_devices_lock);
+
 static inline struct se_hba *
 item_to_hba(struct config_item *item)
 {
@@ -105,51 +108,48 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 {
 	ssize_t read_bytes;
 	struct file *fp;
+	ssize_t r = -EINVAL;
 
-	mutex_lock(&g_tf_lock);
-	if (!list_empty(&g_tf_list)) {
-		mutex_unlock(&g_tf_lock);
-		pr_err("db_root: cannot be changed: target drivers registered");
-		return -EINVAL;
+	mutex_lock(&target_devices_lock);
+	if (target_devices) {
+		pr_err("db_root: cannot be changed because it's in use\n");
+		goto unlock;
 	}
 
 	if (count > (DB_ROOT_LEN - 1)) {
-		mutex_unlock(&g_tf_lock);
 		pr_err("db_root: count %d exceeds DB_ROOT_LEN-1: %u\n",
 		       (int)count, DB_ROOT_LEN - 1);
-		return -EINVAL;
+		goto unlock;
 	}
 
 	read_bytes = snprintf(db_root_stage, DB_ROOT_LEN, "%s", page);
-	if (!read_bytes) {
-		mutex_unlock(&g_tf_lock);
-		return -EINVAL;
-	}
+	if (!read_bytes)
+		goto unlock;
+
 	if (db_root_stage[read_bytes - 1] == '\n')
 		db_root_stage[read_bytes - 1] = '\0';
 
 	/* validate new db root before accepting it */
 	fp = filp_open(db_root_stage, O_RDONLY, 0);
 	if (IS_ERR(fp)) {
-		mutex_unlock(&g_tf_lock);
 		pr_err("db_root: cannot open: %s\n", db_root_stage);
-		return -EINVAL;
+		goto unlock;
 	}
 	if (!S_ISDIR(file_inode(fp)->i_mode)) {
 		filp_close(fp, NULL);
-		mutex_unlock(&g_tf_lock);
 		pr_err("db_root: not a directory: %s\n", db_root_stage);
-		return -EINVAL;
+		goto unlock;
 	}
 	filp_close(fp, NULL);
 
 	strncpy(db_root, db_root_stage, read_bytes);
-
-	mutex_unlock(&g_tf_lock);
-
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
 
-	return read_bytes;
+	r = read_bytes;
+
+unlock:
+	mutex_unlock(&target_devices_lock);
+	return r;
 }
 
 CONFIGFS_ATTR(target_core_item_, dbroot);
@@ -3315,6 +3315,10 @@ static struct config_group *target_core_make_subdev(
 	 */
 	target_stat_setup_dev_default_groups(dev);
 
+	mutex_lock(&target_devices_lock);
+	target_devices++;
+	mutex_unlock(&target_devices_lock);
+
 	mutex_unlock(&hba->hba_access_mutex);
 	return &dev->dev_group;
 
@@ -3353,6 +3357,11 @@ static void target_core_drop_subdev(
 	 * se_dev is released from target_core_dev_item_ops->release()
 	 */
 	config_item_put(item);
+
+	mutex_lock(&target_devices_lock);
+	target_devices--;
+	mutex_unlock(&target_devices_lock);
+
 	mutex_unlock(&hba->hba_access_mutex);
 }
 
-- 
2.27.0

