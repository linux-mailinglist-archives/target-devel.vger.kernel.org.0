Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B274137467
	for <lists+target-devel@lfdr.de>; Fri, 10 Jan 2020 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgAJRG6 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 10 Jan 2020 12:06:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37202 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgAJRG6 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:06:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so1280325pga.4;
        Fri, 10 Jan 2020 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIXyMxyHb52Dqb3xzKBUlHwhFwf+AsnzOx4pqWqWlWY=;
        b=Qq/eSddVaNrHi4aFsdIW47GKoMp5/AouAcANV8I9EI/aUy0FYixHPk3LViqJkSvjq3
         MfYGuA+R3Nl7y4cxOBJ/grgL+QF0Otmarxdzx2nDg0/J6Az3VA3Vvwiq1jaJpXGaROLC
         nxMK6xmFicvJ/4LYtB0+WZ7kd1EeNxydqiQoHB9fIwBMPWpzD1gQbgDQF2twLFHxiokD
         wno1xRcPl8aeQQ9a7/OWDqfTw+jWp3AqGLIhWZnQzuh2pkgCQVuCUjjnWGzT39X9sc6m
         G2VGSavSYYCXhNuW0gc1g4HGhlDCDmpnRvQ7BrHJzpC4/g8vCIUdNcgl830i3mr6Gjc/
         SArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIXyMxyHb52Dqb3xzKBUlHwhFwf+AsnzOx4pqWqWlWY=;
        b=uMaDF7o7vSzrFVPL3bVNMhWDb6kVRJ3s72dPiFi10+m5qUNxgOtAqMuzgvbNeJQ9oW
         aqUVxI+svsKbxeIVZ+Rdxcm8xUrzA60jFft3qm6IFRbZy+TNbzL8QD+aoXS2vXKTeUxM
         21WPmXEBvLB3ZO0BZmsrNWFs6k2Kcl8Pc1/CxXoJ+RcVgLU5VEVU4drOCfrnwt8JvnWE
         3QON7PQgZt+h9ECTqBfgooDJfoUAl6gGW/NpvDvHv5jWcFwZwaaiCClV1YKnaSUO+PKO
         YwUt/IvWDZ5V87rLRPps19NFd2Kd6+ExoMTEWCZS6rb8sNeMlO0nJ0m8pdDW293kRu+Q
         u9fQ==
X-Gm-Message-State: APjAAAVCkCSIRmXXVNVrmNOS6O+hSNO1zwUahbbRp86bo2XPtPqqnY3v
        V2YL8B2DxXZWC+tEvuwwubg=
X-Google-Smtp-Source: APXvYqx1bOJJ1EYx+JdDvHs8uo8AXTRyG4cSwLpVeu4x3iHlpshx7fU4qmCEoHVe+Y77WlnkQkEjOg==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr5668585pgp.47.1578676017609;
        Fri, 10 Jan 2020 09:06:57 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.220])
        by smtp.googlemail.com with ESMTPSA id x4sm3613268pff.143.2020.01.10.09.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:06:57 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2 3/3] drivers: target: tcm_fc: tfc_sess: Pass lockdep expression to RCU lists
Date:   Fri, 10 Jan 2020 22:35:59 +0530
Message-Id: <20200110170558.23466-3-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110170558.23466-1-frextrite@gmail.com>
References: <20200110170558.23466-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

head is traversed with hlist_for_each_entry_rcu
outside an RCU read-side critical section but under the
protection of ft_lport_lock.

Hence, add the corresponding lockdep expression to the list traversal
primitive to silence false-positive lockdep warnings, and
harden RCU lists.

Add macro for the corresponding lockdep expression to make the code
clean and concise.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 drivers/target/tcm_fc/tfc_sess.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/target/tcm_fc/tfc_sess.c b/drivers/target/tcm_fc/tfc_sess.c
index 4fd6a1de947c..8e9598010fb9 100644
--- a/drivers/target/tcm_fc/tfc_sess.c
+++ b/drivers/target/tcm_fc/tfc_sess.c
@@ -32,6 +32,9 @@
 		 (lport)->host->host_no,	   \
 		 (lport)->port_id, ##args )
 
+#define ft_lport_lock_held() \
+	lockdep_is_held(&ft_lport_lock)
+
 static void ft_sess_delete_all(struct ft_tport *);
 
 /*
@@ -45,7 +48,7 @@ static struct ft_tport *ft_tport_get(struct fc_lport *lport)
 	int i;
 
 	tport = rcu_dereference_protected(lport->prov[FC_TYPE_FCP],
-					  lockdep_is_held(&ft_lport_lock));
+							ft_lport_lock_held());
 	if (tport && tport->tpg)
 		return tport;
 
@@ -170,7 +173,7 @@ static struct ft_sess *ft_sess_get(struct fc_lport *lport, u32 port_id)
 	}
 
 	head = &tport->hash[ft_sess_hash(port_id)];
-	hlist_for_each_entry_rcu(sess, head, hash) {
+	hlist_for_each_entry_rcu(sess, head, hash, ft_lport_lock_held()) {
 		if (sess->port_id == port_id) {
 			kref_get(&sess->kref);
 			rcu_read_unlock();
@@ -215,7 +218,7 @@ static struct ft_sess *ft_sess_create(struct ft_tport *tport, u32 port_id,
 	ft_format_wwn(&initiatorname[0], TRANSPORT_IQN_LEN, rdata->ids.port_name);
 
 	head = &tport->hash[ft_sess_hash(port_id)];
-	hlist_for_each_entry_rcu(sess, head, hash)
+	hlist_for_each_entry_rcu(sess, head, hash, ft_lport_lock_held())
 		if (sess->port_id == port_id)
 			return sess;
 
@@ -264,7 +267,7 @@ static struct ft_sess *ft_sess_delete(struct ft_tport *tport, u32 port_id)
 	struct ft_sess *sess;
 
 	head = &tport->hash[ft_sess_hash(port_id)];
-	hlist_for_each_entry_rcu(sess, head, hash) {
+	hlist_for_each_entry_rcu(sess, head, hash, ft_lport_lock_held()) {
 		if (sess->port_id == port_id) {
 			ft_sess_unhash(sess);
 			return sess;
@@ -291,7 +294,7 @@ static void ft_sess_delete_all(struct ft_tport *tport)
 
 	for (head = tport->hash;
 	     head < &tport->hash[FT_SESS_HASH_SIZE]; head++) {
-		hlist_for_each_entry_rcu(sess, head, hash) {
+		hlist_for_each_entry_rcu(sess, head, hash, ft_lport_lock_held()) {
 			ft_sess_unhash(sess);
 			ft_close_sess(sess);	/* release from table */
 		}
@@ -454,7 +457,7 @@ static void ft_prlo(struct fc_rport_priv *rdata)
 
 	mutex_lock(&ft_lport_lock);
 	tport = rcu_dereference_protected(rdata->local_port->prov[FC_TYPE_FCP],
-					  lockdep_is_held(&ft_lport_lock));
+							ft_lport_lock_held());
 
 	if (!tport) {
 		mutex_unlock(&ft_lport_lock);
-- 
2.24.1

