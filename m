Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF36B156BD1
	for <lists+target-devel@lfdr.de>; Sun,  9 Feb 2020 18:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgBIR3j (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 9 Feb 2020 12:29:39 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50787 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgBIR3j (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 9 Feb 2020 12:29:39 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so3136336pjb.0
        for <target-devel@vger.kernel.org>; Sun, 09 Feb 2020 09:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=4N4J/tEhIAyXzy38EnBonNLDJQFCA559SGF8PgxZrjI=;
        b=JM1jRpQWn09VBMQSYNKRhhjMsJEWukl9F+i2MUkAHQasllO4A0yO/2ktu14ax+omSD
         N2oZD3pSYmBmtIcHJ0s+JonRFNWee68T3eTEi7p31WXkH7ukWRQOtXo9H1T6dD00OvAf
         nhGOI4I09zP6TiRkLjIGwSFg0Hj7neP5ZgQ86GIuto8KM0A7415ndSYbcal9uYqrMQto
         W+yl4veuRlrwvtW5VBo8LEAjiucsMq5qdZnInqBXXY3agBJqx8aKTCLuONHtSU093xZY
         TC7ND3s2uFv/ddl7oezfww89eD/g6V02qKpZLH3KTMzVBzgUHr54cNG06aMFeNK6eiok
         LlQg==
X-Gm-Message-State: APjAAAVYTlMZTFwrUVnR68tYPeMbPmRj0B7rdBqG/qTKdai+6lUvb4dL
        EYIoCH3SxEE0EQeVySEot90=
X-Google-Smtp-Source: APXvYqwYQlPbSiODqrwn3EkGfmaM4IchVNuNFzw+CiN7h9lAln3Tz5giOghuixC2Q80HXhRzFhCKMg==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr16410005pjp.102.1581269378708;
        Sun, 09 Feb 2020 09:29:38 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:b43a:c72e:d61c:15d6? ([2601:647:4000:d7:b43a:c72e:d61c:15d6])
        by smtp.gmail.com with ESMTPSA id b1sm9625904pfp.44.2020.02.09.09.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 09:29:37 -0800 (PST)
Subject: Re: IOZONE fails intermittently while toggling the interface
To:     Dakshaja Uppalapati <dakshaja@chelsio.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Cc:     Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <CH2PR12MB4005D671F3D274C4D5FA0BAEDD1C0@CH2PR12MB4005.namprd12.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <d397e15d-ab3b-5446-a1e8-c06a1f6c66e8@acm.org>
Date:   Sun, 9 Feb 2020 09:29:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CH2PR12MB4005D671F3D274C4D5FA0BAEDD1C0@CH2PR12MB4005.namprd12.prod.outlook.com>
Content-Type: multipart/mixed;
 boundary="------------DE860A0EB28FA851911169E4"
Content-Language: en-US
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DE860A0EB28FA851911169E4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 2020-02-07 06:00, Dakshaja Uppalapati wrote:
> While testing iser with kernel 5.5, I see attached soft lockups.
> Logged in and ran iozone on mounted disks. While the traffic is running, toggled the initiators interface down to up for 13 secs.
> I see the attached hung task warnings in the target dmesg. 
> # iozone -a -I -+d -g 32m
> 
> The same test with kernel-5.4 runs fine. I have suspected the following three commits which are all correlated, so removed these commits from 5.5 kernel, rebuilt the kernel and ran the same test then no issue is seen. Iozone is running successfully.
> 
> 80647a89eaf3f2: scsi: target: core: Release SPC-2 reservations when closing a session
> e9d3009cb936b: scsi: target: iscsi: Wait for all commands to finish before freeing a session
> 04060db41178c: scsi: RDMA/isert: Fix a recently introduced regression related to logout
> 
> I am trying to root cause the issue. Please do suggest me if you want me to  check some thing specific.

Does the attached patch help?

Thanks,

Bart.

--------------DE860A0EB28FA851911169E4
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-RDMA-isert-Really-fix-logout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-RDMA-isert-Really-fix-logout.patch"

From 855af6a1c94f8319867ac944d2e0d97c2c06742c Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Fri, 7 Feb 2020 19:57:35 -0800
Subject: [PATCH] RDMA/isert: Really fix logout

Commit 04060db41178 moved the isert_put_unsol_pending_cmds() call from
before target_wait_for_sess_cmds() to after that call. However, a comment
above isert_put_unsol_pending_cmds() is as follows: "We might still have
commands that are waiting for unsolicited dataouts messages. We must put
the extra reference on those before blocking on the
target_wait_for_session_cmds()". Make sure that
isert_put_unsol_pending_cmds() is again called before
target_wait_for_sess_cmds().

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Rahul Kundu <rahul.kundu@chelsio.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
Fixes: 04060db41178 ("scsi: RDMA/isert: Fix a recently introduced regression related to logout")
---
 drivers/infiniband/ulp/isert/ib_isert.c | 15 ++++++++++++---
 drivers/target/iscsi/iscsi_target.c     |  3 +++
 include/target/iscsi/iscsi_transport.h  |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b273e421e910..65111025cd87 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2582,7 +2582,7 @@ isert_wait4logout(struct isert_conn *isert_conn)
  *
  * We might still have commands that are waiting for unsolicited
  * dataouts messages. We must put the extra reference on those
- * before blocking on the target_wait_for_session_cmds
+ * before blocking on the target_wait_for_sess_cmds().
  */
 static void
 isert_put_unsol_pending_cmds(struct iscsi_conn *conn)
@@ -2610,11 +2610,11 @@ isert_put_unsol_pending_cmds(struct iscsi_conn *conn)
 	}
 }
 
-static void isert_wait_conn(struct iscsi_conn *conn)
+static void isert_close_conn(struct iscsi_conn *conn)
 {
 	struct isert_conn *isert_conn = conn->context;
 
-	isert_info("Starting conn %p\n", isert_conn);
+	isert_info("Closing conn %p\n", isert_conn);
 
 	mutex_lock(&isert_conn->mutex);
 	isert_conn_terminate(isert_conn);
@@ -2622,6 +2622,14 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 
 	ib_drain_qp(isert_conn->qp);
 	isert_put_unsol_pending_cmds(conn);
+}
+
+static void isert_wait_conn(struct iscsi_conn *conn)
+{
+	struct isert_conn *isert_conn = conn->context;
+
+	isert_info("Waiting for logout on conn %p\n", isert_conn);
+
 	isert_wait4logout(isert_conn);
 
 	queue_work(isert_release_wq, &isert_conn->release_work);
@@ -2653,6 +2661,7 @@ static struct iscsit_transport iser_target_transport = {
 	.iscsit_setup_np	= isert_setup_np,
 	.iscsit_accept_np	= isert_accept_np,
 	.iscsit_free_np		= isert_free_np,
+	.iscsit_close_conn	= isert_close_conn,
 	.iscsit_wait_conn	= isert_wait_conn,
 	.iscsit_free_conn	= isert_free_conn,
 	.iscsit_get_login_rx	= isert_get_login_rx,
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index b94ed4e30770..0e6449c87924 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4226,6 +4226,9 @@ int iscsit_close_connection(
 	atomic_set(&conn->connection_reinstatement, 1);
 	spin_unlock_bh(&conn->state_lock);
 
+	if (conn->conn_transport->iscsit_close_conn)
+		conn->conn_transport->iscsit_close_conn(conn);
+
 	/*
 	 * If any other processes are accessing this connection pointer we
 	 * must wait until they have completed.
diff --git a/include/target/iscsi/iscsi_transport.h b/include/target/iscsi/iscsi_transport.h
index 75bee29fd7dd..f5a370b9e5b3 100644
--- a/include/target/iscsi/iscsi_transport.h
+++ b/include/target/iscsi/iscsi_transport.h
@@ -14,6 +14,7 @@ struct iscsit_transport {
 	int (*iscsit_setup_np)(struct iscsi_np *, struct sockaddr_storage *);
 	int (*iscsit_accept_np)(struct iscsi_np *, struct iscsi_conn *);
 	void (*iscsit_free_np)(struct iscsi_np *);
+	void (*iscsit_close_conn)(struct iscsi_conn *);
 	void (*iscsit_wait_conn)(struct iscsi_conn *);
 	void (*iscsit_free_conn)(struct iscsi_conn *);
 	int (*iscsit_get_login_rx)(struct iscsi_conn *, struct iscsi_login *);

--------------DE860A0EB28FA851911169E4--
