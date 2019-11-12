Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782E7F8730
	for <lists+target-devel@lfdr.de>; Tue, 12 Nov 2019 04:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKLD6E (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 22:58:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45385 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLD6E (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 22:58:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so12320380pfn.12
        for <target-devel@vger.kernel.org>; Mon, 11 Nov 2019 19:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQsBDiPkxtL928atho+ukThThK4lob1as5aFbJEM/XA=;
        b=Pa+DVt5YXnUjimnhbBcjc4U8Xx41fy7xrsbaRHihjoNzi1N7HKxhfxtHdvlLl5dfOv
         aO9eGfR7IKDofyJi8r0It9ys5MaeJILshXftxDQ74ocueN9F9t5ow5SkS5JZQttEcjTw
         PGVmYEbWUXvmELUDA8MVWw0gMIods0vSZ6FKHbN9sG4OKVmx4oMTndMkI1mv/xs2eHR5
         +m3a4ZIJfYfPWssTPpFZcd/MFhVm8VoTZcl9DL9rmZQJPPoW2vJs5jv6L1IUqFvGaEO0
         l2Ss4mBqHNW0EsFLoMvz8FWO5vAqWERmySGDWtUR7b0+iNmiA45MIqvep1W198pJ7hnc
         jqqQ==
X-Gm-Message-State: APjAAAXufmdEVwnyhbyAjqRcEBaRauYYunZaX6QZwTQduyXnVEHDG+qu
        1f3fipOBrLEBYf5uU+DoCcI=
X-Google-Smtp-Source: APXvYqzKPBtgMo4mMTX5F2AHF8WWZ5fM25oSFGQ+tM9ADGxKsqYH/IkBv9OuDeowWzL/iWRJnWZo7Q==
X-Received: by 2002:a17:90b:30ca:: with SMTP id hi10mr3481014pjb.143.1573531083264;
        Mon, 11 Nov 2019 19:58:03 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:a8:97:b734:6b8f:663c])
        by smtp.gmail.com with ESMTPSA id e5sm784288pjv.29.2019.11.11.19.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 19:58:02 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/3] target/core: Fix a use-after-free in the TMF handling code
Date:   Mon, 11 Nov 2019 19:57:51 -0800
Message-Id: <20191112035752.8338-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112035752.8338-1-bvanassche@acm.org>
References: <20191112035752.8338-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The target_remove_from_state_list() call uses the cmd->dev pointer. Make
sure that that pointer remains valid as long as TMF processing is in
progress.  This patch fixes the following KASAN complaint:

BUG: KASAN: use-after-free in target_remove_from_state_list+0x22/0x130 [target_core_mod]
Read of size 8 at addr ffff8880b110cf80 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.4.0-rc1-dbg+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Workqueue: events target_tmr_work [target_core_mod]
Call Trace:
 dump_stack+0x8a/0xd6
 print_address_description.constprop.0+0x40/0x60
 __kasan_report.cold+0x1b/0x33
 kasan_report+0x16/0x20
 __asan_load8+0x58/0x90
 target_remove_from_state_list+0x22/0x130 [target_core_mod]
 transport_cmd_check_stop_to_fabric+0x17/0xe0 [target_core_mod]
 target_tmr_work+0xe2/0x1a0 [target_core_mod]
 process_one_work+0x549/0xa40
 worker_thread+0x7a/0x5d0
 kthread+0x1bc/0x210
 ret_from_fork+0x24/0x30

The buggy address belongs to the page:
page:ffffea0002c44300 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x1fff000000000000()
raw: 1fff000000000000 0000000000000000 ffffea0002c44308 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880b110ce80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880b110cf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880b110cf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8880b110d000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880b110d080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Cc: Mike Christie <mchristi@redhat.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_transport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 09f833c1de8a..ba6bd73fe63b 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3256,6 +3256,8 @@ static void target_tmr_work(struct work_struct *work)
 	struct se_tmr_req *tmr = cmd->se_tmr_req;
 	int ret;
 
+	target_depend_item(&dev->dev_group.cg_item);
+
 	if (cmd->transport_state & CMD_T_ABORTED)
 		goto aborted;
 
@@ -3297,10 +3299,14 @@ static void target_tmr_work(struct work_struct *work)
 	cmd->se_tfo->queue_tm_rsp(cmd);
 
 	transport_cmd_check_stop_to_fabric(cmd);
+
+out:
+	target_undepend_item(&dev->dev_group.cg_item);
 	return;
 
 aborted:
 	target_handle_abort(cmd);
+	goto out;
 }
 
 int transport_generic_handle_tmr(
-- 
2.23.0

