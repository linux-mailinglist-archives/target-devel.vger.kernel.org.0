Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B466F123898
	for <lists+target-devel@lfdr.de>; Tue, 17 Dec 2019 22:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLQVWU (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 17 Dec 2019 16:22:20 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:52820 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfLQVWU (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:22:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47crgv6BRfz9vYVS
        for <target-devel@vger.kernel.org>; Tue, 17 Dec 2019 21:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8ddfMMRybtlp for <target-devel@vger.kernel.org>;
        Tue, 17 Dec 2019 15:22:19 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47crgv4y4Pz9vYTl
        for <target-devel@vger.kernel.org>; Tue, 17 Dec 2019 15:22:19 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id j194so8533428ybg.7
        for <target-devel@vger.kernel.org>; Tue, 17 Dec 2019 13:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKSXDJGEfO6XnQrXdIqcw1t4M7GCKuGkDlvUOYzoj9E=;
        b=FvyIhtqi2TU6dCcZtEq40XFqYCUpKactMnMWvPoLcHOE9a7z+IblwJjvMhVVwWPxew
         m/n+MdzJ2U442WIYSPvp8Kts3/SOHeEomUEyux07PFqecBWnGNOZcbDjw1n5zWRsvxKn
         sjcoIsj3FFfgdymVtZDdKoYDd9NnuDpymNvESEGgmpDLnWQT8ZO7+66Jr5XZayEDiEWl
         5G5fbB53ZC81eAW+R/uip0uEIjmSjqJMPk/+HI5KhrTmkpzM2aDCgO6YZcnqmhwZz0PW
         MhowlFaOU3sJQ7aYfmyaE8viHJfljLoKzAIGOk+JcqqmJXMNA6HWwTXV7QLCdmvnhbLq
         n3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKSXDJGEfO6XnQrXdIqcw1t4M7GCKuGkDlvUOYzoj9E=;
        b=oJBWbEN5bArFpQIVd4czahHD867Lz5kBqy6QphAA4T/iiEM+XEAG0JwajBjNeEkmEV
         vq4nP8bNQRtpF+TNS4cxw20BTQ2wOxg+wrmGLpP1EbhmtPdlqnO+949WLoKyKH4T0eFT
         WKbNUlxJdMgDXPe/khblcysqzkoGj3NXCmBQylbVLhMSCIfZt+6c823i+ifrpG0ICXki
         1HHxg1QdwrIJBDU6TEIfKF6YlVqSgh3Gqex5QhPOxwmxdM3pFwXplQa1jyI9dyfLG5dL
         IjZ7V9FmkbSjMPqDknBh7qFrSx8NxM5i/zhE8jhnNOmc9E/Q5CX1vE4HmWb4YjlVDr4D
         LDpw==
X-Gm-Message-State: APjAAAUb7JmELGxO4+pInPlTK78SP7e7fECiCrD5KjdsFPZ6wXZkMVJC
        HYOMXJUO8LSOR3VTp86lCibpJSD9F0zjTYsgVXMVeW8aH0JaFUIxKR4bXjmyuMY3Z0k1XYyHbmU
        JL0MuFAL3MGegGuqdobjPQ/g935yS
X-Received: by 2002:a81:de03:: with SMTP id k3mr693553ywj.504.1576617739219;
        Tue, 17 Dec 2019 13:22:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6+drdAHEBR8pRqveMcJwWGEBYCzK6y5x7+hFckUzevP2NHLT1ZNcmcUQ00ImO6UEXbJBcgw==
X-Received: by 2002:a81:de03:: with SMTP id k3mr693534ywj.504.1576617738960;
        Tue, 17 Dec 2019 13:22:18 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id m7sm22002ywh.24.2019.12.17.13.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 13:22:18 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libfc: remove unnecessary assertion on ep variable
Date:   Tue, 17 Dec 2019 15:22:13 -0600
Message-Id: <20191217212214.30722-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

In ft_recv_write_data(), the pointer ep is dereferenced first and
then asserts for NULL. The patch removes the unnecessary assertion.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/target/tcm_fc/tfc_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/target/tcm_fc/tfc_io.c b/drivers/target/tcm_fc/tfc_io.c
index 1354a157e9af..6a38ff936389 100644
--- a/drivers/target/tcm_fc/tfc_io.c
+++ b/drivers/target/tcm_fc/tfc_io.c
@@ -221,7 +221,6 @@ void ft_recv_write_data(struct ft_cmd *cmd, struct fc_frame *fp)
 	ep = fc_seq_exch(seq);
 	lport = ep->lp;
 	if (cmd->was_ddp_setup) {
-		BUG_ON(!ep);
 		BUG_ON(!lport);
 		/*
 		 * Since DDP (Large Rx offload) was setup for this request,
-- 
2.20.1

