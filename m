Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890FCFB6A2
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKMRwu (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 12:52:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43698 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKMRwt (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:52:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so1808540pgh.10
        for <target-devel@vger.kernel.org>; Wed, 13 Nov 2019 09:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miiNknlqJbfsuCx4rB6qwOhsRU8FNfPC+e/j92RFzAU=;
        b=CtJO40HFgxk6rIH8ZvVjkmcVlN64Zp70za/VIgzeiyMtJm74zANrkveyHVPHCxihXt
         D9bMZ0to5VNpyXxl3mrEVJbDWWfl4c/uHua0pPo9PTTOIabNexzkZ5aCaq8M3vRo+IOR
         3WA0L9sFqUFSOKoViHhGgXNQnjCeb+4DBpwuqCbduHwkfHL6oez9FgyArRJRuWzxKbym
         y2pDSWjYSuFdujhNOywLdqLowta1Ag0J9o9bMjiJuQ6BiSn4CCpTDuCQuxiONTunauEi
         NPQau+q56xOtxQfldh0E++ZOa9OLnJ9lydzouXtyI6HJoc4yhr/4La8/vo8YK46A0zIp
         zrGg==
X-Gm-Message-State: APjAAAUQEVFdnJjYf9qC3Phwo62FfQYRO6TnNFElmYMYATeh9O6A4bwQ
        NtDhH/lws2TdH4uM59h9jdE=
X-Google-Smtp-Source: APXvYqwS0cRK11ZlvRSBSC3bnQDZTGzsL5PTXNYYtCWI+suNP8/jSaDSctd+zqhBDHJV9M5mYrk4xA==
X-Received: by 2002:a65:48c7:: with SMTP id o7mr5127364pgs.276.1573667569002;
        Wed, 13 Nov 2019 09:52:49 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u36sm4166557pgn.29.2019.11.13.09.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 09:52:48 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v3 2/3] target/core: Fix a use-after-free in the TMF handling code
Date:   Wed, 13 Nov 2019 09:52:38 -0800
Message-Id: <20191113175239.147389-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191113175239.147389-1-bvanassche@acm.org>
References: <20191113175239.147389-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The target_remove_from_state_list() call uses the cmd->dev pointer. Make
sure that that pointer is valid as long as TMF processing is in progress.
This patch fixes the following KASAN complaint:

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
index 09f833c1de8a..944777f4356f 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3256,6 +3256,8 @@ static void target_tmr_work(struct work_struct *work)
 	struct se_tmr_req *tmr = cmd->se_tmr_req;
 	int ret;
 
+	config_item_get(&dev->dev_group.cg_item);
+
 	if (cmd->transport_state & CMD_T_ABORTED)
 		goto aborted;
 
@@ -3297,10 +3299,14 @@ static void target_tmr_work(struct work_struct *work)
 	cmd->se_tfo->queue_tm_rsp(cmd);
 
 	transport_cmd_check_stop_to_fabric(cmd);
+
+out:
+	config_item_put(&dev->dev_group.cg_item);
 	return;
 
 aborted:
 	target_handle_abort(cmd);
+	goto out;
 }
 
 int transport_generic_handle_tmr(
