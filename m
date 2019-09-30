Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04493C2AC6
	for <lists+target-devel@lfdr.de>; Tue,  1 Oct 2019 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfI3XWg (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 30 Sep 2019 19:22:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33376 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3XWg (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 30 Sep 2019 19:22:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so4514479pls.0
        for <target-devel@vger.kernel.org>; Mon, 30 Sep 2019 16:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uxGGBUzIfLNd6+WejbualuXBYnZCiMhALRVzr6e9yGc=;
        b=mwApIBKIyj1zmWMEZ0s+iWCLfD10KHfL8ialmRhzoFItUNBc+M+2eKbTLa7DZJS6bu
         GETeIo5/e3qkYjJzMSa3xVobs/k6T93g8sb31MYpfkp83UUTvm74mJ+bX6VuutmYDl/k
         xtNQf05K6p0doL20Y4nZ/y6biHGJYow8o/Wv2E4sftDw7zr0W+WvDoPYAfcl4UZc93EJ
         /MdunX+hKUDQA2xTLrHk2p80VaO4EnuV5IGBHkgYV+dPqdKXx1BjXH3L0BXwKjlPZggw
         3k28EJyvAFa5I1YeZg8kMwYAE+K+1hYFhSXJPYbwqvB+2W4mgtcUVaNuZ5yamUmLoyW+
         i7Fg==
X-Gm-Message-State: APjAAAV+Hy0oeRKsllBRvIwJkUuHigQgRaSq4obEid1rBLGcsvpvznz/
        OppM/r12YBBxqMv7OOd8ZPA=
X-Google-Smtp-Source: APXvYqykt5Hs3vORajaGQNvj0uL1dq7+Bh1/DO+XoROxIEguTV9ax7BVVkY1+b4z4m5cdToSgByemg==
X-Received: by 2002:a17:902:b704:: with SMTP id d4mr22382204pls.204.1569885751294;
        Mon, 30 Sep 2019 16:22:31 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b69sm13738994pfb.132.2019.09.30.16.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:22:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH] target: Remove tpg_list and se_portal_group.se_tpg_node
Date:   Mon, 30 Sep 2019 16:22:24 -0700
Message-Id: <20190930232224.58980-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Maintaining tpg_list without ever iterating over it is not useful. Hence
remove tpg_list. This patch does not change the behavior of the SCSI
target code.

Cc: Mike Christie <mchristie@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_tpg.c   | 12 ------------
 drivers/target/target_core_xcopy.c |  1 -
 include/target/target_core_base.h  |  1 -
 3 files changed, 14 deletions(-)

diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index e5a71addbb06..d24e0a3ba3ff 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -32,9 +32,6 @@
 
 extern struct se_device *g_lun0_dev;
 
-static DEFINE_SPINLOCK(tpg_lock);
-static LIST_HEAD(tpg_list);
-
 /*	__core_tpg_get_initiator_node_acl():
  *
  *	mutex_lock(&tpg->acl_node_mutex); must be held when calling
@@ -475,7 +472,6 @@ int core_tpg_register(
 	se_tpg->se_tpg_wwn = se_wwn;
 	atomic_set(&se_tpg->tpg_pr_ref_count, 0);
 	INIT_LIST_HEAD(&se_tpg->acl_node_list);
-	INIT_LIST_HEAD(&se_tpg->se_tpg_node);
 	INIT_LIST_HEAD(&se_tpg->tpg_sess_list);
 	spin_lock_init(&se_tpg->session_lock);
 	mutex_init(&se_tpg->tpg_lun_mutex);
@@ -494,10 +490,6 @@ int core_tpg_register(
 		}
 	}
 
-	spin_lock_bh(&tpg_lock);
-	list_add_tail(&se_tpg->se_tpg_node, &tpg_list);
-	spin_unlock_bh(&tpg_lock);
-
 	pr_debug("TARGET_CORE[%s]: Allocated portal_group for endpoint: %s, "
 		 "Proto: %d, Portal Tag: %u\n", se_tpg->se_tpg_tfo->fabric_name,
 		se_tpg->se_tpg_tfo->tpg_get_wwn(se_tpg) ?
@@ -519,10 +511,6 @@ int core_tpg_deregister(struct se_portal_group *se_tpg)
 		tfo->tpg_get_wwn(se_tpg) ? tfo->tpg_get_wwn(se_tpg) : NULL,
 		se_tpg->proto_id, tfo->tpg_get_tag(se_tpg));
 
-	spin_lock_bh(&tpg_lock);
-	list_del(&se_tpg->se_tpg_node);
-	spin_unlock_bh(&tpg_lock);
-
 	while (atomic_read(&se_tpg->tpg_pr_ref_count) != 0)
 		cpu_relax();
 
diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index b9b1e92c6f8d..425c1070de08 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -467,7 +467,6 @@ int target_xcopy_setup_pt(void)
 	}
 
 	memset(&xcopy_pt_tpg, 0, sizeof(struct se_portal_group));
-	INIT_LIST_HEAD(&xcopy_pt_tpg.se_tpg_node);
 	INIT_LIST_HEAD(&xcopy_pt_tpg.acl_node_list);
 	INIT_LIST_HEAD(&xcopy_pt_tpg.tpg_sess_list);
 
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 7c9716fe731e..1728e883b7b2 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -876,7 +876,6 @@ struct se_portal_group {
 	/* Spinlock for adding/removing sessions */
 	spinlock_t		session_lock;
 	struct mutex		tpg_lun_mutex;
-	struct list_head	se_tpg_node;
 	/* linked list for initiator ACL list */
 	struct list_head	acl_node_list;
 	struct hlist_head	tpg_lun_hlist;
-- 
2.23.0.444.g18eeb5a265-goog

