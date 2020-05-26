Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD511B7C9A
	for <lists+target-devel@lfdr.de>; Fri, 24 Apr 2020 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDXRXo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 24 Apr 2020 13:23:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgDXRXn (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eto8bBOwPEFUS6RXOzvDJP1PcQd24OPhNFrNG1QCDdM=;
        b=RHTPCNNniLNCSvIIe9cZGbNom5UXUWeTzgNXD6axrOXgBuDlV3Ww2/dMsf2SI1ZafReon8
        PRSkR8lVNQdUbhJ6NfPpuN2hUU2Petzmv8dJW9qz3Fbib9WVxXIPYbkIJbSVNQtAROhZRz
        EiW/DV7J+Ygf5d6MQmkl1KpEt3AhW8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-kShV457eOau1SNr1kZWgCw-1; Fri, 24 Apr 2020 13:23:40 -0400
X-MC-Unique: kShV457eOau1SNr1kZWgCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B1DE45F;
        Fri, 24 Apr 2020 17:23:39 +0000 (UTC)
Received: from [10.10.117.115] (ovpn-117-115.rdu2.redhat.com [10.10.117.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A38827CCD;
        Fri, 24 Apr 2020 17:23:35 +0000 (UTC)
Subject: Re: [PATCH] target: iscsi: remove the iscsi_data_count structure
To:     Maurizio Lombardi <mlombard@redhat.com>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200424113913.17237-1-mlombard@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <844cc331-22a2-ed33-d9cd-fffe543a9b64@redhat.com>
Date:   Fri, 24 Apr 2020 12:23:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200424113913.17237-1-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 4/24/20 6:39 AM, Maurizio Lombardi wrote:
> This patch removes the iscsi_data_count structure and the
> iscsit_do_rx_data() function because they are used only by rx_data()
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/target/iscsi/iscsi_target_util.c | 30 +++++-------------------
>  include/target/iscsi/iscsi_target_core.h | 10 --------
>  2 files changed, 6 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
> index fae85bfd790e..25677e2865be 100644
> --- a/drivers/target/iscsi/iscsi_target_util.c
> +++ b/drivers/target/iscsi/iscsi_target_util.c
> @@ -1236,18 +1236,20 @@ void iscsit_print_session_params(struct iscsi_session *sess)
>  	iscsi_dump_sess_ops(sess->sess_ops);
>  }
>  
> -static int iscsit_do_rx_data(
> +int rx_data(
>  	struct iscsi_conn *conn,
> -	struct iscsi_data_count *count)
> +	struct kvec *iov,
> +	int iov_count,
> +	int data)
>  {
> -	int data = count->data_length, rx_loop = 0, total_rx = 0;
> +	int rx_loop = 0, total_rx = 0;
>  	struct msghdr msg;
>  
>  	if (!conn || !conn->sock || !conn->conn_ops)
>  		return -1;
>  
>  	memset(&msg, 0, sizeof(struct msghdr));
> -	iov_iter_kvec(&msg.msg_iter, READ, count->iov, count->iov_count, data);
> +	iov_iter_kvec(&msg.msg_iter, READ, iov, iov_count, data);
>  
>  	while (msg_data_left(&msg)) {
>  		rx_loop = sock_recvmsg(conn->sock, &msg, MSG_WAITALL);
> @@ -1264,26 +1266,6 @@ static int iscsit_do_rx_data(
>  	return total_rx;
>  }
>  
> -int rx_data(
> -	struct iscsi_conn *conn,
> -	struct kvec *iov,
> -	int iov_count,
> -	int data)
> -{
> -	struct iscsi_data_count c;
> -
> -	if (!conn || !conn->sock || !conn->conn_ops)
> -		return -1;
> -
> -	memset(&c, 0, sizeof(struct iscsi_data_count));
> -	c.iov = iov;
> -	c.iov_count = iov_count;
> -	c.data_length = data;
> -	c.type = ISCSI_RX_DATA;
> -
> -	return iscsit_do_rx_data(conn, &c);
> -}
> -
>  int tx_data(
>  	struct iscsi_conn *conn,
>  	struct kvec *iov,
> diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
> index a49d37140a64..c2de9274c57a 100644
> --- a/include/target/iscsi/iscsi_target_core.h
> +++ b/include/target/iscsi/iscsi_target_core.h
> @@ -301,16 +301,6 @@ struct iscsi_queue_req {
>  	struct list_head	qr_list;
>  };
>  
> -struct iscsi_data_count {
> -	int			data_length;
> -	int			sync_and_steering;
> -	enum data_count_type	type;
> -	u32			iov_count;
> -	u32			ss_iov_count;
> -	u32			ss_marker_count;
> -	struct kvec		*iov;
> -};
> -
>  struct iscsi_param_list {
>  	bool			iser;
>  	struct list_head	param_list;
> 

Reviewed-by: Mike Christie <mchristi@redhat.com>

