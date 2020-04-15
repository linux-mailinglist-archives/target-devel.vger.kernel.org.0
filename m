Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B13D1A95D4
	for <lists+target-devel@lfdr.de>; Wed, 15 Apr 2020 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635634AbgDOIIq (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 15 Apr 2020 04:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635591AbgDOIIj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:08:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A14C061A10
        for <target-devel@vger.kernel.org>; Wed, 15 Apr 2020 01:08:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so6359286pjb.3
        for <target-devel@vger.kernel.org>; Wed, 15 Apr 2020 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J1KNQcrs+r+mnZk64I+SHchI9mC/y3tQBfBRhzGH08Q=;
        b=ylb7PeJBNyX27HueSsiGtbzDDBcU/RllNtSgxaFPLJGUAZcwxSNQmgDXpgh6UqCXiV
         gZG2iS8HitalmpN1xbbxEhI5TVWW2mqT7Clymxogs2qyM5izhMedjxE7Y/ZzXY9qOWoM
         9doDiQr2cpKwL0xD/Kx9qDOsVCwFxgtZIDtIzrghpC1/1z7rB23GGDQY5iDOB8099gk+
         1jFGGY9i/CYJ0NKbT8h+zX8oyZrr32bRUKGTLY4ZA79zCApUzmYsUYRKsh1+l+c6nh3Z
         POsjJLXsFapEtHDgTsicEAB4DJZ1h6IvrlXHSqm7LNJCu4fYENKT2kBDw08f8MMbsYqM
         93Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J1KNQcrs+r+mnZk64I+SHchI9mC/y3tQBfBRhzGH08Q=;
        b=aU/NFn2z1uyqXe7BmY5dB2BidbhI+IBod+9yHqMXQ8wm2nFwULAnBlDiV1l2X8bGd7
         je1SMTPMKTLDCpUEr/QeVeZTMJq8MrgJtfmkcbu/udEwUfOpN5jIgmcc3KSOUiAyWW4X
         mMiSCHoAv/1MGD+l9JAbJOEy2pwhQfVDPTVZuCE3wJ7xXdwM8mxzFKnN6846z0yZyLbv
         4SUGD47p99pMrOLGujNwYXSSICZNAWjS8TYdk5CzMEaxvEd2hOCMWAcD2oPZxf2+YbAG
         x6qNsUmwuzcXV8Z1Y7dx2/brT9Nf1H+U998HOQXAEGUrMAuNowRxXHB8cujkHnVoTNEp
         ORiA==
X-Gm-Message-State: AGi0PuaSmd46jJytmUkTZXgrYQ+bu4jxGnyjWeAVWAvR0Z6ikB8hd1vg
        btizrjPw8i4Q5XmciItTDglT1g==
X-Google-Smtp-Source: APiQypJCwloBa6GBYdjzyEclkg33cepnJPT9pZgmxs4dUxdmzDcwPNg2lyy2cQvaRXm1RqVQXgT6bg==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr3882761plo.12.1586938118923;
        Wed, 15 Apr 2020 01:08:38 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id c10sm10020576pfc.23.2020.04.15.01.08.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 01:08:38 -0700 (PDT)
From:   Pu Hou <houpu@bytedance.com>
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, Pu Hou <houpu@bytedance.com>
Subject: [PATCH 1/2] iscsi-target: fix login error when receiving is too fast
Date:   Wed, 15 Apr 2020 04:08:18 -0400
Message-Id: <20200415080819.27327-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200415080819.27327-1-houpu@bytedance.com>
References: <20200415080819.27327-1-houpu@bytedance.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

iscsi_target_sk_data_ready() could be invoked indirectly
by iscsi_target_do_login_rx() from workqueue like following:

iscsi_target_do_login_rx()
  iscsi_target_do_login()
    iscsi_target_do_tx_login_io()
      iscsit_put_login_tx()
        iscsi_login_tx_data()
          tx_data()
            sock_sendmsg_nosec()
              tcp_sendmsg()
                release_sock()
                  sk_backlog_rcv()
                    tcp_v4_do_rcv()
                      tcp_data_ready()
                        iscsi_target_sk_data_ready()

At that time LOGIN_FLAGS_READ_ACTIVE is not cleared.
and iscsi_target_sk_data_ready will not read data
from the socket. And some iscsi initiator(i.e. libiscsi)
will wait forever for a reply.

LOGIN_FLAGS_READ_ACTIVE should be cleared early just after
doing the receive and before writing to the socket in
iscsi_target_do_login_rx.

But sad news is that LOGIN_FLAGS_READ_ACTIVE is also used
by sk_state_change to do login cleanup if a socket was closed
at login time. It is supposed to be cleared after the login
pdu is successfully processed and reponsed.

So introduce another flag LOGIN_FLAGS_WRITE_ACTIVE to cover
the transmit part so that sk_state_change could work well
and clear LOGIN_FLAGS_READ_ACTIVE early so that sk_data_ready
could also work.

Signed-off-by: Pu Hou <houpu@bytedance.com>
---
 drivers/target/iscsi/iscsi_target_nego.c | 29 +++++++++++++++++++++++++----
 include/target/iscsi/iscsi_target_core.h |  1 +
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 685d771b51d4..950339655778 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -622,6 +622,26 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 	if (rc < 0)
 		goto err;
 
+	/*
+	 * LOGIN_FLAGS_READ_ACTIVE is cleared so that sk_data_ready
+	 * could be trigger again after this.
+	 *
+	 * LOGIN_FLAGS_WRITE_ACTIVE is cleared after we successfully
+	 * processing a login pdu. So that sk_state_chage could do login
+	 * cleanup as need if the socket is closed. If a delay work is
+	 * ongoing LOGIN_FLAGS_WRITE_ACTIVE or LOGIN_FLAGS_READ_ACTIVE),
+	 * sk_state_change will leave the cleanup to the delayed work or
+	 * it will schedule a delayed work to do cleanup.
+	 */
+	if (conn->sock) {
+		struct sock *sk = conn->sock->sk;
+
+		write_lock_bh(&sk->sk_callback_lock);
+		clear_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags);
+		set_bit(LOGIN_FLAGS_WRITE_ACTIVE, &conn->login_flags);
+		write_unlock_bh(&sk->sk_callback_lock);
+	}
+
 	pr_debug("iscsi_target_do_login_rx after rx_login_io, %p, %s:%d\n",
 			conn, current->comm, current->pid);
 
@@ -629,7 +649,7 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 	if (rc < 0) {
 		goto err;
 	} else if (!rc) {
-		if (iscsi_target_sk_check_and_clear(conn, LOGIN_FLAGS_READ_ACTIVE))
+		if (iscsi_target_sk_check_and_clear(conn, LOGIN_FLAGS_WRITE_ACTIVE))
 			goto err;
 	} else if (rc == 1) {
 		iscsi_target_nego_release(conn);
@@ -670,9 +690,10 @@ static void iscsi_target_sk_state_change(struct sock *sk)
 	state = __iscsi_target_sk_check_close(sk);
 	pr_debug("__iscsi_target_sk_close_change: state: %d\n", state);
 
-	if (test_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags)) {
-		pr_debug("Got LOGIN_FLAGS_READ_ACTIVE=1 sk_state_change"
-			 " conn: %p\n", conn);
+	if (test_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags) ||
+	    test_bit(LOGIN_FLAGS_WRITE_ACTIVE, &conn->login_flags)) {
+		pr_debug("Got LOGIN_FLAGS_{READ|WRITE}_ACTIVE=1"
+			 "sk_state_change conn: %p\n", conn);
 		if (state)
 			set_bit(LOGIN_FLAGS_CLOSED, &conn->login_flags);
 		write_unlock_bh(&sk->sk_callback_lock);
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 591cd9e4692c..0c2dfc81bf8b 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -570,6 +570,7 @@ struct iscsi_conn {
 #define LOGIN_FLAGS_CLOSED		2
 #define LOGIN_FLAGS_READY		4
 #define LOGIN_FLAGS_INITIAL_PDU		8
+#define LOGIN_FLAGS_WRITE_ACTIVE	12
 	unsigned long		login_flags;
 	struct delayed_work	login_work;
 	struct iscsi_login	*login;
-- 
2.11.0

