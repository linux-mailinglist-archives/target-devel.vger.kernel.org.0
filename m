Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630AB222037
	for <lists+target-devel@lfdr.de>; Thu, 16 Jul 2020 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGPKDR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 16 Jul 2020 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgGPKDR (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:03:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02C7C08C5C0
        for <target-devel@vger.kernel.org>; Thu, 16 Jul 2020 03:03:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so4595928pgc.8
        for <target-devel@vger.kernel.org>; Thu, 16 Jul 2020 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wCm6g8PFrAG/ekXZHVoEYGMTgypsF/q64n/9gor/F3E=;
        b=LLgdBMQyAhNYTnpWigaSMpydcREs4d8c4U0eDCKJ8X+mjBnhzN0q2zVyx4YEVb5wtU
         IgmIVL6wRWiwIdQTVmQipxJK2d6SubI6RGxX1IKMCLrNJmjpRELqFfuBd+nKLb6bweSp
         bklBPVC8P0qfmySgq8gSnANR7dEktyMxLFo4khg7CJxU6286saIfTew02ANDUOGyOLqu
         oeevooUJHyVzAGcJmTV8g6uJZ2Qi8A05Yy7wqjjyfPwh2tZApzwk19MRpXcH+LRD7lQH
         /Z6mjraTM/5KRVeh5vSyKAU+2LuwZocpJWjfjz8j1wPNfoF1vGwrU/Xi7Be3pv8Q+cva
         Iunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wCm6g8PFrAG/ekXZHVoEYGMTgypsF/q64n/9gor/F3E=;
        b=r0tJGTTuw7NszXR6cOKi9LjQ2qy4OwinPK7KO4vNmmxj0Xkk0q7PZ2WsQ3WyXFkSUJ
         Rn4aepZOhU6ErV2Wvv7dduKCq9Oj3+BPd601GI5NEd2reMppsA0Zy/qRdt6ee+RnunnB
         jHHFyabtw1QO7tPC/o46cYEWBs6C8xM0hHcdaWnCF6cQew7U/HZkCKv134/ZskzIenyY
         jWK2hOV2iR9lxOKBl/cdmiq3+qNZVNVSHxpHIIIQ3JH6zfL0N5Dk5Nsk4tgunfddMPEO
         +2ssMIDDMtRi8NGDkIQCQwtI6tJ5nrcCUdvDtj7W0mPcJp7XmDmwZvy2lcczC8mm4eHV
         uQwQ==
X-Gm-Message-State: AOAM532pcTk0WThAw0bcrdbAGp2RUcJuzMIGQwo7mklirGDSc9ZqTu2b
        mcxS1Og1WxlxICpAu5VQBdXTpA==
X-Google-Smtp-Source: ABdhPJwNrDgUO7VlNAjZ8Fo6AQngwNwXisibH9GXT9GMvN4cprhyzv7vwb7cxiTZ8B256OaU3jnMag==
X-Received: by 2002:a62:8183:: with SMTP id t125mr3019763pfd.210.1594893796570;
        Thu, 16 Jul 2020 03:03:16 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id f29sm4602477pga.59.2020.07.16.03.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2020 03:03:16 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, Hou Pu <houpu@bytedance.com>
Subject: [PATCH v4 2/2] iscsi-target: Fix inconsistent debug message in __iscsi_target_sk_check_close
Date:   Thu, 16 Jul 2020 06:02:12 -0400
Message-Id: <20200716100212.4237-3-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716100212.4237-1-houpu@bytedance.com>
References: <20200716100212.4237-1-houpu@bytedance.com>
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
index 10477e44d17b..701c008d6bd5 100644
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

