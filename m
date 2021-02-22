Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0224C321B2B
	for <lists+target-devel@lfdr.de>; Mon, 22 Feb 2021 16:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBVPRz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 22 Feb 2021 10:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhBVPPd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73E4C061A28;
        Mon, 22 Feb 2021 07:13:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so14705764wml.2;
        Mon, 22 Feb 2021 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaIJGjhVZ09u/EP3bHxMgqdNAjXosc23vp6hWLR+1MA=;
        b=UmcqE3lzOznpZPI93PnZsK+swpRu7m70pr3gta9k6ZAIq9lPUwIAP1G9soX57vzhSE
         P/a0sNKNqSnFIIPV7MzCjU+UngDEfNkYIt1Ygt32naA/1AwNmtutkAmWt+cP5uyegNef
         zE726RgSRt3elVe1YYwaEEYrhpNaIp3q1R/HZBsH0pBTATq61HxX2NdtCGsRw8xtKOvS
         7zLaHvg7AsObv5YcMHfFoP3BZaymoqvShDHdx5v0vni/ynrG07sM5E3+GEUdzclERKOi
         3vnvPl7WCz5W7zmqT1YjbquukYOHREJtRbP0rGS9D+SWNg+8POkwIaRGxb5jq0Ro4qqy
         cXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaIJGjhVZ09u/EP3bHxMgqdNAjXosc23vp6hWLR+1MA=;
        b=oCoBR44oYk8IjZXqmIqalIEKi1sIGRlx0Ufy9I4UiJCkVev3Dz1r2QS5vqrnGwNxud
         L3UuPIgigakDRnIeMG5StqRTdvWTcqP2nRFU5jvMHLfGAsFN7DsudbyIrCC6JmEbVf/D
         lRVNzUL5aW0F/20tff3KDjWtrPUb/PUQGobN5FOAVzE3E0VbPb7gZ5MP0Bs2tUE45p4T
         13hHzF6Q9ww0uL7evZUC06CEnxqQ+2tZN/Ssar/5pLpv4vpdarKV4COvEAwDXFvwbrsZ
         DHH5Ay3X1jnciiFiGHQ+1c+PpFZ7i7LrUkNyLAGFsNq0rGLTzZ3annpssD8BxFIEvlqb
         /s2Q==
X-Gm-Message-State: AOAM531vET1eio+Mem4NtDW7YWD22PVJMD8Xmj6r69kixPTTh/MlIQVI
        gYiMqh432VntUwdDUNWEDujEc9/4EwTLNkrMTgA=
X-Google-Smtp-Source: ABdhPJxPIIevSdHpq0bz8dkLKKzkdobBzKa6BG4pC9pZkFSwSrY4yq1GT/LnCNM1hIF4l39fbEWI4g==
X-Received: by 2002:a1c:2090:: with SMTP id g138mr20574057wmg.137.1614006779236;
        Mon, 22 Feb 2021 07:12:59 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id h11sm24964006wmq.26.2021.02.22.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:58 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] target: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:25 +0100
Message-Id: <20210222151231.22572-15-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/target/target_core_configfs.c |   33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index f04352285155..676215cd8847 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1325,16 +1325,11 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_VENDOR_LEN + 2];
 	char *stripped = NULL;
-	size_t len;
+	ssize_t len;
 	ssize_t ret;
 
-	len = strlcpy(buf, page, sizeof(buf));
-	if (len < sizeof(buf)) {
-		/* Strip any newline added from userspace. */
-		stripped = strstrip(buf);
-		len = strlen(stripped);
-	}
-	if (len > INQUIRY_VENDOR_LEN) {
+	len = strscpy(buf, page, sizeof(buf));
+	if (len == -E2BIG) {
 		pr_err("Emulated T10 Vendor Identification exceeds"
 			" INQUIRY_VENDOR_LEN: " __stringify(INQUIRY_VENDOR_LEN)
 			"\n");
@@ -1381,16 +1376,11 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_MODEL_LEN + 2];
 	char *stripped = NULL;
-	size_t len;
+	ssize_t len;
 	ssize_t ret;
 
-	len = strlcpy(buf, page, sizeof(buf));
-	if (len < sizeof(buf)) {
-		/* Strip any newline added from userspace. */
-		stripped = strstrip(buf);
-		len = strlen(stripped);
-	}
-	if (len > INQUIRY_MODEL_LEN) {
+	len = strscpy(buf, page, sizeof(buf));
+	if (len == -E2BIG) {
 		pr_err("Emulated T10 Vendor exceeds INQUIRY_MODEL_LEN: "
 			 __stringify(INQUIRY_MODEL_LEN)
 			"\n");
@@ -1437,16 +1427,11 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_REVISION_LEN + 2];
 	char *stripped = NULL;
-	size_t len;
+	ssize_t len;
 	ssize_t ret;
 
-	len = strlcpy(buf, page, sizeof(buf));
-	if (len < sizeof(buf)) {
-		/* Strip any newline added from userspace. */
-		stripped = strstrip(buf);
-		len = strlen(stripped);
-	}
-	if (len > INQUIRY_REVISION_LEN) {
+	len = strscpy(buf, page, sizeof(buf));
+	if (len == -E2BIG) {
 		pr_err("Emulated T10 Revision exceeds INQUIRY_REVISION_LEN: "
 			 __stringify(INQUIRY_REVISION_LEN)
 			"\n");

