Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875241B6C57
	for <lists+target-devel@lfdr.de>; Fri, 24 Apr 2020 05:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDXD7W (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 23 Apr 2020 23:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgDXD7W (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:59:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE1C09B045
        for <target-devel@vger.kernel.org>; Thu, 23 Apr 2020 20:59:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ms17so3451801pjb.0
        for <target-devel@vger.kernel.org>; Thu, 23 Apr 2020 20:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sQwlKsCSfMq4rjmHqo8apkoz0QYUw6N5U1Ng8ApZcfM=;
        b=1i1JzHXrE94FkzgJAzCw6RnzocUPee3iR8gI3IEsNgAbp/x1c+98oC3uYX1dp+QMnV
         1DrcThKfqx3iN+TMxe1oJs4q6LwDRHGoSSgBJ0Or0hjkxTN0oTrZyDFKw7dbUv1x7tTK
         RsiVN93S+t0lf2wEXZvypenHuxxSPDLkuWtjASK0G6nK0c+b/UMkZDUwe16xhxCSfzdM
         SldXT69tkQmfyApCZrc4Ks3gXTml66VjAioBSXTl1FDzZcup02FjSt50TLt5sghRRnSW
         e7DVYJ0ADqq54vdt7JGj672Nav3+XtQKj2WuZdIEgieH1wfMTSn34Yynq08HxIV2z2jB
         PVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sQwlKsCSfMq4rjmHqo8apkoz0QYUw6N5U1Ng8ApZcfM=;
        b=ktAeaxo34lkiKaoVO5UAHYlAbzcJ/qQRxiTSqHu4q8Ktjyv64m9J6rVFs/wQQmhA7c
         QZ7/BM7qhx2FEeyIndjK4MYs3CCBmad3gadMx766dI7Ij4Lbvv4OAozACOuzxKOKYqfv
         3J7EmWLWQ5z0sf1VtRtMSuQg04utVcOXPQmchwPEB0hXb+kU/IWJ5mwfNKpcqsQrdUtZ
         i5Gl+Cg2P5k9kjlXvi/XJ0kEC3CKqN5/h22RbxsfgTDMAoPuUuxsF9tfTNWmX39bJQj8
         CB4SwQOnJ6GPka5yEVPf7dFyKKSNuudXBGCi86xDcnWoJaGR0tSJzDHCCQeO/H/ChhWi
         lLIA==
X-Gm-Message-State: AGi0PubaoST8s3UacbmuTBos+Ieid1IlwLsMBHIrhNfOFfG/OEXou3ce
        u9m6BmNGIlAmM4ufe2pJWZWZbQ==
X-Google-Smtp-Source: APiQypJeJXcGZEjx8E2ZQV2fZlQeLm589teq7lNwZoQIOBrCu/bUlNsiEtlki+yRtaFoJfSwMVzGRQ==
X-Received: by 2002:a17:902:a405:: with SMTP id p5mr7335387plq.36.1587700760135;
        Thu, 23 Apr 2020 20:59:20 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id h14sm3624577pjc.46.2020.04.23.20.59.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 20:59:19 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     martin.petersen@oracle.com, mchristi@redhat.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH v2 1/2] iscsi-target: fix login error when receiving is too fast
Date:   Thu, 23 Apr 2020 23:58:42 -0400
Message-Id: <20200424035843.5914-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200424035843.5914-1-houpu@bytedance.com>
References: <20200424035843.5914-1-houpu@bytedance.com>
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

While at here, use login_flags more efficient.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/target/iscsi/iscsi_target_nego.c | 29 +++++++++++++++++++++++++----
 include/target/iscsi/iscsi_target_core.h |  9 +++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 685d771b51d4..5292b6c51b4e 100644
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

