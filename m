Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D839C1B757F
	for <lists+target-devel@lfdr.de>; Fri, 24 Apr 2020 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgDXMgI (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 24 Apr 2020 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXMgH (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:36:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9FDC09B045
        for <target-devel@vger.kernel.org>; Fri, 24 Apr 2020 05:36:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so3825645pjb.1
        for <target-devel@vger.kernel.org>; Fri, 24 Apr 2020 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9tUT7Sdxjs9d1FtuElo+1LtV4QfTZv6jD05EGpHmGw=;
        b=swaQC/WdzPeqWRdb41ozEYjD1QidtymToEBCKLqH1mBs6RR3A0HyAAvX8udA03D2qS
         YaP5ccB6stYsJEkqqbim5LpcMrRvnmH6HhfxVNkZinFFINvwLUTzaKiZJLleLYITCwCk
         CB2AmcFsFiXoUhSKTPRwK/9H/rW54JHMh5yoZJO8tmLtAq3WfxpZYnyezrkPyEH13NOt
         7Qvz/6YC5wI5CLPfsIcuUcHQBy0XMn4p3V12Xv5K+s4E77bZSzaGbhhKqkcVDIZF0XBY
         knB8r0xEwq7nEmyMy0TkXIYu6LG3GmCEDzqzIxGB4CivoP6HNgMmG6QPhZBONFSk37LL
         hhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9tUT7Sdxjs9d1FtuElo+1LtV4QfTZv6jD05EGpHmGw=;
        b=Lp2uKiJj8zcB2prXLvQdb87oHorM9/oA1qDPSURMXS1yUNTXm88XSHsKOV92ksoQsu
         EfuXK5WJsPHF/B139+63CZ9bng00xZiR+BQiODbyi4yzg1dRNIW8kIFMEzHDx/DQNZx1
         u8krRVFNUpBFQmTChnLDu0mRop1hhwO+zpN0jeZTCxgu/WBmb1Q6zhggbpM3vmvX6kYZ
         SA0+dpIR5QL6lGQS2fsrKJj4YhoKt1bi2otOeZm5UIwDSMTD6XWwtSVNiNi2eM/MEhdK
         VxOrMBcL7oPN6yiMqceuky6cc/Dqj9d9u/cBeWWaatIJlXbeG0iyx3Evy4/9ysXRpjSs
         DAiQ==
X-Gm-Message-State: AGi0PuYRxfqXmvzXkgPn4gWmnSzWAaHpyp8y/uzh/NRNnlJyA3jtZGeU
        Y0RAoU/uEIr7+YuOKonmtWOktQ==
X-Google-Smtp-Source: APiQypL1qhUJKzjVLt4qhaft9oUKjShlxAtdFTiuLe7ZXjkd1A/AO90PuPsv0zXh2m1ZU2X8aVtKWQ==
X-Received: by 2002:a17:90a:9504:: with SMTP id t4mr5996468pjo.21.1587731766695;
        Fri, 24 Apr 2020 05:36:06 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id 128sm5510851pfy.5.2020.04.24.05.36.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 05:36:06 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, Hou Pu <houpu@bytedance.com>
Subject: [PATCH v3 2/2] iscsi-target: Fix inconsistent debug message in __iscsi_target_sk_check_close
Date:   Fri, 24 Apr 2020 08:35:28 -0400
Message-Id: <20200424123528.17627-3-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200424123528.17627-1-houpu@bytedance.com>
References: <20200424123528.17627-1-houpu@bytedance.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The commit 25cdda95fda7 ("iscsi-target: Fix initial login PDU
asynchronous socket close OOPs") changed the return value of
__iscsi_target_sk_check_close. But the pr_debug is still printing
FALSE when returning TRUE which is a little confusing.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/target/iscsi/iscsi_target_nego.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 4cfa742e61df..7c36368e617d 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -481,7 +481,7 @@ static bool __iscsi_target_sk_check_close(struct sock *sk)
 {
 	if (sk->sk_state == TCP_CLOSE_WAIT || sk->sk_state == TCP_CLOSE) {
 		pr_debug("__iscsi_target_sk_check_close: TCP_CLOSE_WAIT|TCP_CLOSE,"
-			"returning FALSE\n");
+			"returning TRUE\n");
 		return true;
 	}
 	return false;
-- 
2.11.0

