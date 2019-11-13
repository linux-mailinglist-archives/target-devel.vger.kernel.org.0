Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206CDFB6A1
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKMRwt (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 12:52:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40938 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKMRws (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:52:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id e3so1372667plt.7
        for <target-devel@vger.kernel.org>; Wed, 13 Nov 2019 09:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xl76pmWe9AcE/cdnE194As3UKSyvLWQyrFCc+s0s0jM=;
        b=sPYeePsRPOSD6R6nB/7mTXfRadhwAhDcqru3PNWfEv82stvyt5k9YmZF1qudZ4HhFg
         h6Q3oN0y+uatpGhJode+dyWsngZlEJmpd0h1898lxmrl8lpqmclPrcXBa3S7Cr7K+hfQ
         r/LFqh6MsoBnVyMRftQcc63ee67dRrXEvndZl7X8RQZdjldZjBEsrpALlyvUz3LH2SO8
         8w0ImDzwSipnArSbMZvR5VOd1BAXeavACnYzV7WGk/wsJVTxuFBJV7cYeMFZEqxm2UdW
         4HROxKzaER87P4x5y+0YCrLoJ7YKDMu4+l1H0MQnDlpX+aHcWSq/nIKcFuaO+Opn8mHU
         NYiw==
X-Gm-Message-State: APjAAAXV7+xZMJ9FI2hyhTcC8JxJCsuFFjcOJAWPP5l1MDwrueNH5b8t
        WDHAHznfH3EtTBcKavoby8/deqGx
X-Google-Smtp-Source: APXvYqx5F3NaKEqo+ASiR4PvtyZcg1Nx+PpJZGIOhdivBoUQTvha6cDvTdfBonT/J6jAdg7RKYBaHA==
X-Received: by 2002:a17:902:7d90:: with SMTP id a16mr5072249plm.149.1573667567580;
        Wed, 13 Nov 2019 09:52:47 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u36sm4166557pgn.29.2019.11.13.09.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 09:52:46 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v3 1/3] target/core: Release SPC-2 reservations when closing a session
Date:   Wed, 13 Nov 2019 09:52:37 -0800
Message-Id: <20191113175239.147389-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191113175239.147389-1-bvanassche@acm.org>
References: <20191113175239.147389-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The SCSI specs require to release SPC-2 reservations when a session is
closed. Make sure that the target core does this.

Running the libiscsi tests triggers the KASAN complaint shown below.
This patch fixes that use-after-free.

BUG: KASAN: use-after-free in target_check_reservation+0x171/0x980 [target_core_mod]
Read of size 8 at addr ffff88802ecd1878 by task iscsi_trx/17200

CPU: 0 PID: 17200 Comm: iscsi_trx Not tainted 5.4.0-rc1-dbg+ #1
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x8a/0xd6
 print_address_description.constprop.0+0x40/0x60
 __kasan_report.cold+0x1b/0x34
 kasan_report+0x16/0x20
 __asan_load8+0x58/0x90
 target_check_reservation+0x171/0x980 [target_core_mod]
 __target_execute_cmd+0xb1/0xf0 [target_core_mod]
 target_execute_cmd+0x22d/0x4d0 [target_core_mod]
 transport_generic_new_cmd+0x31f/0x5b0 [target_core_mod]
 transport_handle_cdb_direct+0x6f/0x90 [target_core_mod]
 iscsit_execute_cmd+0x381/0x3f0 [iscsi_target_mod]
 iscsit_sequence_cmd+0x13b/0x1f0 [iscsi_target_mod]
 iscsit_process_scsi_cmd+0x4c/0x130 [iscsi_target_mod]
 iscsit_get_rx_pdu+0x8e8/0x15f0 [iscsi_target_mod]
 iscsi_target_rx_thread+0x105/0x1b0 [iscsi_target_mod]
 kthread+0x1bc/0x210
 ret_from_fork+0x24/0x30

Allocated by task 1079:
 save_stack+0x23/0x90
 __kasan_kmalloc.constprop.0+0xcf/0xe0
 kasan_slab_alloc+0x12/0x20
 kmem_cache_alloc+0xfe/0x3a0
 transport_alloc_session+0x29/0x80 [target_core_mod]
 iscsi_target_login_thread+0xceb/0x1920 [iscsi_target_mod]
 kthread+0x1bc/0x210
 ret_from_fork+0x24/0x30

Freed by task 17193:
 save_stack+0x23/0x90
 __kasan_slab_free+0x13a/0x190
 kasan_slab_free+0x12/0x20
 kmem_cache_free+0xc8/0x3e0
 transport_free_session+0x179/0x2f0 [target_core_mod]
 transport_deregister_session+0x121/0x170 [target_core_mod]
 iscsit_close_session+0x12c/0x350 [iscsi_target_mod]
 iscsit_logout_post_handler+0x136/0x380 [iscsi_target_mod]
 iscsit_response_queue+0x8fa/0xc00 [iscsi_target_mod]
 iscsi_target_tx_thread+0x28e/0x390 [iscsi_target_mod]
 kthread+0x1bc/0x210
 ret_from_fork+0x24/0x30

The buggy address belongs to the object at ffff88802ecd1860
 which belongs to the cache se_sess_cache of size 352
The buggy address is located 24 bytes inside of
 352-byte region [ffff88802ecd1860, ffff88802ecd19c0)
The buggy address belongs to the page:
page:ffffea0000bb3400 refcount:1 mapcount:0 mapping:ffff8880bef2ed00 index:0x0 compound_mapcount: 0
flags: 0x1000000000010200(slab|head)
raw: 1000000000010200 dead000000000100 dead000000000122 ffff8880bef2ed00
raw: 0000000000000000 0000000080270027 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88802ecd1700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ecd1780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802ecd1800: fb fb fb fb fc fc fc fc fc fc fc fc fb fb fb fb
                                                                ^
 ffff88802ecd1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ecd1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: Mike Christie <mchristi@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_transport.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index ba7a01bcad7c..09f833c1de8a 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -584,6 +584,15 @@ void transport_free_session(struct se_session *se_sess)
 }
 EXPORT_SYMBOL(transport_free_session);
 
+static int target_release_res(struct se_device *dev, void *data)
+{
+	struct se_session *sess = data;
+
+	if (dev->reservation_holder == sess)
+		target_release_reservation(dev);
+	return 0;
+}
+
 void transport_deregister_session(struct se_session *se_sess)
 {
 	struct se_portal_group *se_tpg = se_sess->se_tpg;
@@ -600,6 +609,12 @@ void transport_deregister_session(struct se_session *se_sess)
 	se_sess->fabric_sess_ptr = NULL;
 	spin_unlock_irqrestore(&se_tpg->session_lock, flags);
 
+	/*
+	 * Since the session is being removed, release SPC-2
+	 * reservations held by the session that is disappearing.
+	 */
+	target_for_each_device(target_release_res, se_sess);
+
 	pr_debug("TARGET_CORE[%s]: Deregistered fabric_sess\n",
 		se_tpg->se_tpg_tfo->fabric_name);
 	/*
