Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11462222034
	for <lists+target-devel@lfdr.de>; Thu, 16 Jul 2020 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGPKCx (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 16 Jul 2020 06:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKCx (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:02:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1AC061755
        for <target-devel@vger.kernel.org>; Thu, 16 Jul 2020 03:02:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so3651972pls.4
        for <target-devel@vger.kernel.org>; Thu, 16 Jul 2020 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eZ7Ie7Pzshq3rg5eCb9AzgAsUX5k0M+860E+N34fP/o=;
        b=xxZtrvwPHqWYHHkyvvWLK+M1vaM/JpHpkMfqguLK9WkLT5CGTkPuAJQTxv+e9uxKIn
         zMZBbq4Hcht51A8Zz9no9RzQAZlvrkj8of02TxVxJy46MdywprFi0IRUuT0GjOvb+Sfa
         16Ahy3UWxc8xEZKvsRVcOqI0CYdfROy4ZgvZY+MiOHDvAIgxZulOU05x65yt+VxZ/xi+
         APyumUdDLswkdN0KpyAfRtrNE35wTKvkCSe9pxfpzfvAgtcah9yzRpoH/AmNrlBij60r
         A4r1SYbd2pBuddf9Qz0gnxznKrPmH0hvCFcU1+Sf4NIyHlkcAguVwHyeS+2535VOz7DM
         VDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eZ7Ie7Pzshq3rg5eCb9AzgAsUX5k0M+860E+N34fP/o=;
        b=W99a7VzTz5vMFB8u8dxumG8n2YwwrYSBTm5SF+J8SabHjgFcu9+r09kFWHnLPixdtL
         oNsW043h8KJLscV0gVw6Ib+fqPjePrMUgGY4B16hcuYwO3lRvWaIYVe4Qd3s/s7rA46T
         YyFMcNZ3H/oH+S6O8QCFFzMz9Lq5o3bo9HPh2LBl6VM8MFU3LhcYWY6Q5Nek0Sr2nswG
         U16q5g8Ns0C+1z8HjTCiEX39GAKO2IGj+gpme7yG9f+DbBr/Vpsm0eFlS1m6c126DqE9
         H8FPF1pRPbj+XwDjgWUoEv+VUlDDGFizbvqynYxxgdt95NSQMcyD8FlG7QInrUx9GZTq
         F1mw==
X-Gm-Message-State: AOAM533xT+VAdnvabXBwLU98Dy6DoD+ORkQa32iAW0wrkz70kKkatcrf
        o/AqFuEBDeEkE9J5AUyXmysr8w==
X-Google-Smtp-Source: ABdhPJwcbVZ8MV10vSa6FMvg/1mLmBVnY2s+e5WnELvu0CCKHVDxHLViNtH8HTNsY+ygkX3mh5LW6Q==
X-Received: by 2002:a17:90a:3002:: with SMTP id g2mr4142770pjb.68.1594893772444;
        Thu, 16 Jul 2020 03:02:52 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id f29sm4602477pga.59.2020.07.16.03.02.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2020 03:02:51 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, Hou Pu <houpu@bytedance.com>
Subject: [PATCH v4 1/2] iscsi-target: fix login error when receiving is too fast
Date:   Thu, 16 Jul 2020 06:02:11 -0400
Message-Id: <20200716100212.4237-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716100212.4237-1-houpu@bytedance.com>
References: <20200716100212.4237-1-houpu@bytedance.com>
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
pdu is successfully processed and replied.

So introduce another flag LOGIN_FLAGS_WRITE_ACTIVE to cover
the transmit part so that sk_state_change could work well
and clear LOGIN_FLAGS_READ_ACTIVE early so that sk_data_ready
could also work.

While at here, use login_flags more efficient.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/target/iscsi/iscsi_target_nego.c | 34 ++++++++++++++++++++++++++++----
 include/target/iscsi/iscsi_target_core.h |  9 +++++----
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 685d771b51d4..10477e44d17b 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -625,13 +625,37 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 	pr_debug("iscsi_target_do_login_rx after rx_login_io, %p, %s:%d\n",
 			conn, current->comm, current->pid);
 
+	/*
+	 * LOGIN_FLAGS_READ_ACTIVE is cleared so that sk_data_ready
+	 * could be trigger again after this.
+	 *
+	 * LOGIN_FLAGS_WRITE_ACTIVE is cleared after we successfully
+	 * process a login pdu, so that sk_state_chage could do login
+	 * cleanup as needed if the socket is closed. If a delayed work is
+	 * ongoing (LOGIN_FLAGS_WRITE_ACTIVE or LOGIN_FLAGS_READ_ACTIVE),
+	 * sk_state_change will leave the cleanup to the delayed work or
+	 * it will schedule a delayed work to do cleanup.
+	 */
+	if (conn->sock) {
+		struct sock *sk = conn->sock->sk;
+
+		write_lock_bh(&sk->sk_callback_lock);
+		if (!test_bit(LOGIN_FLAGS_INITIAL_PDU, &conn->login_flags)) {
+			clear_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags);
+			set_bit(LOGIN_FLAGS_WRITE_ACTIVE, &conn->login_flags);
+		}
+		write_unlock_bh(&sk->sk_callback_lock);
+	}
+
 	rc = iscsi_target_do_login(conn, login);
 	if (rc < 0) {
 		goto err;
 	} else if (!rc) {
-		if (iscsi_target_sk_check_and_clear(conn, LOGIN_FLAGS_READ_ACTIVE))
+		if (iscsi_target_sk_check_and_clear(conn,
+						    LOGIN_FLAGS_WRITE_ACTIVE))
 			goto err;
 	} else if (rc == 1) {
+		cancel_delayed_work(&conn->login_work);
 		iscsi_target_nego_release(conn);
 		iscsi_post_login_handler(np, conn, zero_tsih);
 		iscsit_deaccess_np(np, tpg, tpg_np);
@@ -640,6 +664,7 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 
 err:
 	iscsi_target_restore_sock_callbacks(conn);
+	cancel_delayed_work(&conn->login_work);
 	iscsi_target_login_drop(conn, login);
 	iscsit_deaccess_np(np, tpg, tpg_np);
 }
@@ -670,9 +695,10 @@ static void iscsi_target_sk_state_change(struct sock *sk)
 	state = __iscsi_target_sk_check_close(sk);
 	pr_debug("__iscsi_target_sk_close_change: state: %d\n", state);
 
-	if (test_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags)) {
-		pr_debug("Got LOGIN_FLAGS_READ_ACTIVE=1 sk_state_change"
-			 " conn: %p\n", conn);
+	if (test_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags) ||
+	    test_bit(LOGIN_FLAGS_WRITE_ACTIVE, &conn->login_flags)) {
+		pr_debug("Got LOGIN_FLAGS_{READ|WRITE}_ACTIVE=1"
+			 " sk_state_change conn: %p\n", conn);
 		if (state)
 			set_bit(LOGIN_FLAGS_CLOSED, &conn->login_flags);
 		write_unlock_bh(&sk->sk_callback_lock);
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 591cd9e4692c..844bef255e89 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -566,10 +566,11 @@ struct iscsi_conn {
 	struct socket		*sock;
 	void			(*orig_data_ready)(struct sock *);
 	void			(*orig_state_change)(struct sock *);
-#define LOGIN_FLAGS_READ_ACTIVE		1
-#define LOGIN_FLAGS_CLOSED		2
-#define LOGIN_FLAGS_READY		4
-#define LOGIN_FLAGS_INITIAL_PDU		8
+#define LOGIN_FLAGS_READY		0
+#define LOGIN_FLAGS_INITIAL_PDU		1
+#define LOGIN_FLAGS_READ_ACTIVE		2
+#define LOGIN_FLAGS_WRITE_ACTIVE	3
+#define LOGIN_FLAGS_CLOSED		4
 	unsigned long		login_flags;
 	struct delayed_work	login_work;
 	struct iscsi_login	*login;
-- 
2.11.0

