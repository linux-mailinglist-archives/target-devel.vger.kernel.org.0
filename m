Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6924F7F7C
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 20:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKKS34 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 13:29:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42139 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKKS3z (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:29:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so8103553plt.9
        for <target-devel@vger.kernel.org>; Mon, 11 Nov 2019 10:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uO17rM70VvFmZWfOSQ7X9zYCjdulEcWbWB/wbqG4K4=;
        b=nWNrbuakGDxbovP8d/3P/C//JtW1vEgpYxT8ngAvFL9atGHk4p8v3E83OVpWWquuCi
         GU/WJKkq3GLEe0+wmdxnDYcEhKi1hF2hWchYAycYz4FXJrIK9ZYsqL2uZkF/FBHVFCE2
         tpmRNPsI9lEyCSQnkYpd/d/HX8crlqVP/7a4wYL7km6w9Mx7I23gL4O2WAOU1Vv415K0
         YouszlbKApdog0ODZtT9NXVdRkdYmZX2qvI/eosQ5NhsDqBeMEljAZVywNeoqVfpEzI8
         0L9pgy7DT/1Mq+6eJqadcGijJLsNXes40kqRhBUu8/LKAaVKjQ1qDyG6Xztq2JlpJHz9
         tGNQ==
X-Gm-Message-State: APjAAAU+rfTUvf4XwcAOoncjRTFLYgITg8iSmLh++RrehADI4Zpql65v
        xgs4PC/QiPcG8Nm7xrCAF0E=
X-Google-Smtp-Source: APXvYqy9qtNRIISqxxsMeq+VGVHqdf0wi+N2QUFDGc9Cj0UPBhWblmPn6Qn9nHSDGV5OxPqAZh/b9g==
X-Received: by 2002:a17:902:aa86:: with SMTP id d6mr27975812plr.268.1573496993319;
        Mon, 11 Nov 2019 10:29:53 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z62sm20635925pfz.135.2019.11.11.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 10:29:52 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/2] target/iscsi: Fix a use-after-free while closing a session
Date:   Mon, 11 Nov 2019 10:29:44 -0800
Message-Id: <20191111182944.191123-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191111182944.191123-1-bvanassche@acm.org>
References: <20191111182944.191123-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patch fixes the following use-after-free in the code that supports
SPC-2 reservations:

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

Cc: Mike Christie <mchristi@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_transport.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index ba7a01bcad7c..12bc8545f91b 100644
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
+		dev->reservation_holder = NULL;
+	return 0;
+}
+
 void transport_deregister_session(struct se_session *se_sess)
 {
 	struct se_portal_group *se_tpg = se_sess->se_tpg;
@@ -600,6 +609,8 @@ void transport_deregister_session(struct se_session *se_sess)
 	se_sess->fabric_sess_ptr = NULL;
 	spin_unlock_irqrestore(&se_tpg->session_lock, flags);
 
+	target_for_each_device(target_release_res, se_sess);
+
 	pr_debug("TARGET_CORE[%s]: Deregistered fabric_sess\n",
 		se_tpg->se_tpg_tfo->fabric_name);
 	/*
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

