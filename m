Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF27211102
	for <lists+target-devel@lfdr.de>; Wed,  1 Jul 2020 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgGAQrW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 1 Jul 2020 12:47:22 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:58949 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732161AbgGAQrV (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:47:21 -0400
Received: from fcoe-test11.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 061GlGQQ018014;
        Wed, 1 Jul 2020 09:47:16 -0700
From:   Varun Prakash <varun@chelsio.com>
To:     martin.petersen@oracle.com
Cc:     target-devel@vger.kernel.org, dt@chelsio.com,
        ganji.aravind@chelsio.com, varun@chelsio.com
Subject: [PATCH] scsi: target: cxgbit: remove tx flow control code
Date:   Wed,  1 Jul 2020 22:17:12 +0530
Message-Id: <1593622032-3082-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Firmware does tx flow control so remove tx flow
control code from the driver.

Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/target/iscsi/cxgbit/cxgbit.h        |  1 -
 drivers/target/iscsi/cxgbit/cxgbit_cm.c     |  2 --
 drivers/target/iscsi/cxgbit/cxgbit_target.c | 24 ++++--------------------
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit.h b/drivers/target/iscsi/cxgbit/cxgbit.h
index c04cd08..4069033 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit.h
+++ b/drivers/target/iscsi/cxgbit/cxgbit.h
@@ -207,7 +207,6 @@ struct cxgbit_sock {
 	/* socket lock */
 	spinlock_t lock;
 	wait_queue_head_t waitq;
-	wait_queue_head_t ack_waitq;
 	bool lock_owner;
 	struct kref kref;
 	u32 max_iso_npdu;
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 493070c..518ded2 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -1360,7 +1360,6 @@ cxgbit_pass_accept_req(struct cxgbit_device *cdev, struct sk_buff *skb)
 	cxgbit_sock_reset_wr_list(csk);
 	spin_lock_init(&csk->lock);
 	init_waitqueue_head(&csk->waitq);
-	init_waitqueue_head(&csk->ack_waitq);
 	csk->lock_owner = false;
 
 	if (cxgbit_alloc_csk_skb(csk)) {
@@ -1887,7 +1886,6 @@ static void cxgbit_fw4_ack(struct cxgbit_sock *csk, struct sk_buff *skb)
 		if (csk->snd_una != snd_una) {
 			csk->snd_una = snd_una;
 			dst_confirm(csk->dst);
-			wake_up(&csk->ack_waitq);
 		}
 	}
 
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_target.c b/drivers/target/iscsi/cxgbit/cxgbit_target.c
index fcdc421..9b3eb2e 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_target.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_target.c
@@ -284,18 +284,6 @@ void cxgbit_push_tx_frames(struct cxgbit_sock *csk)
 	}
 }
 
-static bool cxgbit_lock_sock(struct cxgbit_sock *csk)
-{
-	spin_lock_bh(&csk->lock);
-
-	if (before(csk->write_seq, csk->snd_una + csk->snd_win))
-		csk->lock_owner = true;
-
-	spin_unlock_bh(&csk->lock);
-
-	return csk->lock_owner;
-}
-
 static void cxgbit_unlock_sock(struct cxgbit_sock *csk)
 {
 	struct sk_buff_head backlogq;
@@ -325,20 +313,16 @@ static int cxgbit_queue_skb(struct cxgbit_sock *csk, struct sk_buff *skb)
 {
 	int ret = 0;
 
-	wait_event_interruptible(csk->ack_waitq, cxgbit_lock_sock(csk));
+	spin_lock_bh(&csk->lock);
+	csk->lock_owner = true;
+	spin_unlock_bh(&csk->lock);
 
 	if (unlikely((csk->com.state != CSK_STATE_ESTABLISHED) ||
 		     signal_pending(current))) {
 		__kfree_skb(skb);
 		__skb_queue_purge(&csk->ppodq);
 		ret = -1;
-		spin_lock_bh(&csk->lock);
-		if (csk->lock_owner) {
-			spin_unlock_bh(&csk->lock);
-			goto unlock;
-		}
-		spin_unlock_bh(&csk->lock);
-		return ret;
+		goto unlock;
 	}
 
 	csk->write_seq += skb->len +
-- 
2.0.2

