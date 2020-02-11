Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD1158903
	for <lists+target-devel@lfdr.de>; Tue, 11 Feb 2020 04:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBKDrp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 10 Feb 2020 22:47:45 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:42299 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgBKDrp (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:47:45 -0500
Received: by mail-pl1-f182.google.com with SMTP id e8so3670964plt.9
        for <target-devel@vger.kernel.org>; Mon, 10 Feb 2020 19:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=vUURFI3BlXd+4m2zgDagYn1ct/053gzsiBb1x3hIr+0=;
        b=itMAhIKxi1EMW8KGZFpdsiYYDwcsjGQNBseeOecSHL7nv9Gu0QbKFw9jlvrjO3d3U4
         t67+LQFHckV9qxin3v12ShgpZwFbNax7eiWRGEYklw2my+QnpfEMb1nbaVYfLHOYqkyr
         TIljF6tLZZ8iqIaZff3iSp6lixPUv3ZCumJFHc+/hHJNKfIu3su29jGPK+rXtGVwna7O
         PnM/b/EAeiAnd2cAliJAudCfOZrymWt3FbCdhIlPpoMc2x0n9+MfIxTcGk+Zo97aguA6
         cg/imuTVD6oh/c2i9nVu3Zogc3LgU+VEyhZBlczQ8DkX0btoHOH+T4EX6z1nASVI3vlu
         JFiA==
X-Gm-Message-State: APjAAAULBTCj9J4a5fRpkKyU0TqFp3IhH/6dnzzD2uCo8OSwqFUML5IJ
        /jjIrkv2xUH8p5TiCVdbvZY=
X-Google-Smtp-Source: APXvYqzqhmJNM+PpBLtv3+1hIZ6gU9Rz8ZYTx6vnOdEB+UDJfAGfW+RlK9UmzgmmOEocb2CqPg/d5w==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr1211946pll.49.1581392864639;
        Mon, 10 Feb 2020 19:47:44 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:c830:d60f:c88f:af3b? ([2601:647:4000:d7:c830:d60f:c88f:af3b])
        by smtp.gmail.com with ESMTPSA id 26sm861819pjk.3.2020.02.10.19.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 19:47:43 -0800 (PST)
Subject: Re: IOZONE fails intermittently while toggling the interface
To:     Dakshaja Uppalapati <dakshaja@chelsio.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <CH2PR12MB4005D671F3D274C4D5FA0BAEDD1C0@CH2PR12MB4005.namprd12.prod.outlook.com>
 <d397e15d-ab3b-5446-a1e8-c06a1f6c66e8@acm.org>
 <20200210141913.GB11516@chelsio.com>
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
Message-ID: <16017b1b-b69f-242d-cee4-7117b3b3742e@acm.org>
Date:   Mon, 10 Feb 2020 19:47:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210141913.GB11516@chelsio.com>
Content-Type: multipart/mixed;
 boundary="------------0E4FE9B39418730D79C7DCA9"
Content-Language: en-US
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0E4FE9B39418730D79C7DCA9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 2020-02-10 06:19, Dakshaja Uppalapati wrote:
> I had run the test multiple times with the given patch, attached traces are seen.

Thanks for having tested the patch I had shared. Can you test the
attached patch on top of v5.6-rc1? It reverts the following two patches:
* e9d3009cb936 ("scsi: target: iscsi: Wait for all commands to finish
before freeing a session") # v5.5-rc1.
* 04060db41178 ("scsi: RDMA/isert: Fix a recently introduced regression
related to logout") # v5.5

Thanks,

Bart.

--------------0E4FE9B39418730D79C7DCA9
Content-Type: text/x-patch; charset=UTF-8;
 name="revert-recent-iscsi-and-iser-patches.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="revert-recent-iscsi-and-iser-patches.patch"

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b273e421e910..a1a035270cab 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2575,6 +2575,17 @@ isert_wait4logout(struct isert_conn *isert_conn)
 	}
 }
 
+static void
+isert_wait4cmds(struct iscsi_conn *conn)
+{
+	isert_info("iscsi_conn %p\n", conn);
+
+	if (conn->sess) {
+		target_sess_cmd_list_set_waiting(conn->sess->se_sess);
+		target_wait_for_sess_cmds(conn->sess->se_sess);
+	}
+}
+
 /**
  * isert_put_unsol_pending_cmds() - Drop commands waiting for
  *     unsolicitate dataout
@@ -2622,6 +2633,7 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 
 	ib_drain_qp(isert_conn->qp);
 	isert_put_unsol_pending_cmds(conn);
+	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
 
 	queue_work(isert_release_wq, &isert_conn->release_work);
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index b94ed4e30770..09e55ea0bf5d 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1165,9 +1165,7 @@ int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 		hdr->cmdsn, be32_to_cpu(hdr->data_length), payload_length,
 		conn->cid);
 
-	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
-		return iscsit_add_reject_cmd(cmd,
-				ISCSI_REASON_WAITING_FOR_LOGOUT, buf);
+	target_get_sess_cmd(&cmd->se_cmd, true);
 
 	cmd->sense_reason = transport_lookup_cmd_lun(&cmd->se_cmd,
 						     scsilun_to_int(&hdr->lun));
@@ -2004,9 +2002,7 @@ iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 			      conn->sess->se_sess, 0, DMA_NONE,
 			      TCM_SIMPLE_TAG, cmd->sense_buffer + 2);
 
-	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
-		return iscsit_add_reject_cmd(cmd,
-				ISCSI_REASON_WAITING_FOR_LOGOUT, buf);
+	target_get_sess_cmd(&cmd->se_cmd, true);
 
 	/*
 	 * TASK_REASSIGN for ERL=2 / connection stays inside of
@@ -4149,6 +4145,9 @@ int iscsit_close_connection(
 	iscsit_stop_nopin_response_timer(conn);
 	iscsit_stop_nopin_timer(conn);
 
+	if (conn->conn_transport->iscsit_wait_conn)
+		conn->conn_transport->iscsit_wait_conn(conn);
+
 	/*
 	 * During Connection recovery drop unacknowledged out of order
 	 * commands for this connection, and prepare the other commands
@@ -4231,11 +4230,6 @@ int iscsit_close_connection(
 	 * must wait until they have completed.
 	 */
 	iscsit_check_conn_usage_count(conn);
-	target_sess_cmd_list_set_waiting(sess->se_sess);
-	target_wait_for_sess_cmds(sess->se_sess);
-
-	if (conn->conn_transport->iscsit_wait_conn)
-		conn->conn_transport->iscsit_wait_conn(conn);
 
 	ahash_request_free(conn->conn_tx_hash);
 	if (conn->conn_rx_hash) {
diff --git a/include/scsi/iscsi_proto.h b/include/scsi/iscsi_proto.h
index 533f56733ba8..b71b5c4f418c 100644
--- a/include/scsi/iscsi_proto.h
+++ b/include/scsi/iscsi_proto.h
@@ -627,7 +627,6 @@ struct iscsi_reject {
 #define ISCSI_REASON_BOOKMARK_INVALID	9
 #define ISCSI_REASON_BOOKMARK_NO_RESOURCES	10
 #define ISCSI_REASON_NEGOTIATION_RESET	11
-#define ISCSI_REASON_WAITING_FOR_LOGOUT	12
 
 /* Max. number of Key=Value pairs in a text message */
 #define MAX_KEY_VALUE_PAIRS	8192

--------------0E4FE9B39418730D79C7DCA9--
