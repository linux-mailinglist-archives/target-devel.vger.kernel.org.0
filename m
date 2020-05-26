Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E31B7C51
	for <lists+target-devel@lfdr.de>; Fri, 24 Apr 2020 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDXRCS (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 24 Apr 2020 13:02:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726793AbgDXRCR (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587747736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5VjJRnpRqS/ZMW8sEnz5z0hClHF0TzY0T7D0+CVxMbM=;
        b=JUSKmd0e8zRhwF0G2RxVsncGGeEPTvGmChjXlnmDMtpF2NK3KFTIkiyZjwf5yWwdSfsT92
        2tWFxHPGdW2hWnQZQdqiPLMKr1/EGYDAqzjrsndDK5y1PY2rv2ZGSmw89KGvHYgW59xiIO
        ya6QfAH97xKValjxrdPZxrGHeWLwt5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-KpQ-dVmoOVKpIYFZKFP8Xw-1; Fri, 24 Apr 2020 13:02:12 -0400
X-MC-Unique: KpQ-dVmoOVKpIYFZKFP8Xw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A4F61F42;
        Fri, 24 Apr 2020 17:02:01 +0000 (UTC)
Received: from [10.10.117.115] (ovpn-117-115.rdu2.redhat.com [10.10.117.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 959D25D9CC;
        Fri, 24 Apr 2020 17:01:59 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] iscsi-target: fix login error when receiving is
 too fast
To:     Hou Pu <houpu@bytedance.com>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200424123528.17627-1-houpu@bytedance.com>
 <20200424123528.17627-2-houpu@bytedance.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <cee3c624-4d43-fd4c-1436-cfc0c08a4321@redhat.com>
Date:   Fri, 24 Apr 2020 12:01:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200424123528.17627-2-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 4/24/20 7:35 AM, Hou Pu wrote:
> iscsi_target_sk_data_ready() could be invoked indirectly
> by iscsi_target_do_login_rx() from workqueue like following:
> 
> iscsi_target_do_login_rx()
>   iscsi_target_do_login()
>     iscsi_target_do_tx_login_io()
>       iscsit_put_login_tx()
>         iscsi_login_tx_data()
>           tx_data()
>             sock_sendmsg_nosec()
>               tcp_sendmsg()
>                 release_sock()
>                   sk_backlog_rcv()
>                     tcp_v4_do_rcv()
>                       tcp_data_ready()
>                         iscsi_target_sk_data_ready()
> 
> At that time LOGIN_FLAGS_READ_ACTIVE is not cleared.
> and iscsi_target_sk_data_ready will not read data
> from the socket. And some iscsi initiator(i.e. libiscsi)
> will wait forever for a reply.
> 
> LOGIN_FLAGS_READ_ACTIVE should be cleared early just after
> doing the receive and before writing to the socket in
> iscsi_target_do_login_rx.
> 
> But sad news is that LOGIN_FLAGS_READ_ACTIVE is also used
> by sk_state_change to do login cleanup if a socket was closed
> at login time. It is supposed to be cleared after the login
> pdu is successfully processed and replied.
> 
> So introduce another flag LOGIN_FLAGS_WRITE_ACTIVE to cover
> the transmit part so that sk_state_change could work well
> and clear LOGIN_FLAGS_READ_ACTIVE early so that sk_data_ready
> could also work.
> 
> While at here, use login_flags more efficient.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>
> ---
>  drivers/target/iscsi/iscsi_target_nego.c | 30 ++++++++++++++++++++++++++----
>  include/target/iscsi/iscsi_target_core.h |  9 +++++----
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
> index 685d771b51d4..4cfa742e61df 100644
> --- a/drivers/target/iscsi/iscsi_target_nego.c
> +++ b/drivers/target/iscsi/iscsi_target_nego.c
> @@ -622,6 +622,26 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
>  	if (rc < 0)
>  		goto err;
>  
> +	/*
> +	 * LOGIN_FLAGS_READ_ACTIVE is cleared so that sk_data_ready
> +	 * could be trigger again after this.
> +	 *
> +	 * LOGIN_FLAGS_WRITE_ACTIVE is cleared after we successfully
> +	 * process a login pdu, so that sk_state_chage could do login
> +	 * cleanup as needed if the socket is closed. If a delayed work is
> +	 * ongoing (LOGIN_FLAGS_WRITE_ACTIVE or LOGIN_FLAGS_READ_ACTIVE),
> +	 * sk_state_change will leave the cleanup to the delayed work or
> +	 * it will schedule a delayed work to do cleanup.
> +	 */
> +	if (conn->sock) {
> +		struct sock *sk = conn->sock->sk;
> +
> +		write_lock_bh(&sk->sk_callback_lock);
> +		clear_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags);
> +		set_bit(LOGIN_FLAGS_WRITE_ACTIVE, &conn->login_flags);
> +		write_unlock_bh(&sk->sk_callback_lock);
> +	}
> +

Hey,

I had one more question.

With the above code, I think we have a race where if we clear the bit
above early and iscsi_target_sk_data_ready runs while
iscsi_target_do_login_rx is still running then we could queue the work
an extra time and get stuck. Because the bit is now not set, if
iscsi_target_sk_data_ready runs it will end up calling
schedule_delayed_work which will queue up the work again since the work
is running and not pending.

If that is correct and we hit the race what happens if this was the last
login pdu, and we are supposed to go to full feature phase next? For
example if iscsi_target_do_login_rx runs an extra time, will we end up
stuck waiting in iscsi_target_do_login_rx's call to:

rc = conn->conn_transport->iscsit_get_login_rx(conn, login);

?


>  	pr_debug("iscsi_target_do_login_rx after rx_login_io, %p, %s:%d\n",
>  			conn, current->comm, current->pid);
>  
> @@ -629,7 +649,8 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
>  	if (rc < 0) {
>  		goto err;
>  	} else if (!rc) {
> -		if (iscsi_target_sk_check_and_clear(conn, LOGIN_FLAGS_READ_ACTIVE))
> +		if (iscsi_target_sk_check_and_clear(conn,
> +						    LOGIN_FLAGS_WRITE_ACTIVE))
>  			goto err;
>  	} else if (rc == 1) {
>  		iscsi_target_nego_release(conn);
> @@ -670,9 +691,10 @@ static void iscsi_target_sk_state_change(struct sock *sk)
>  	state = __iscsi_target_sk_check_close(sk);
>  	pr_debug("__iscsi_target_sk_close_change: state: %d\n", state);
>  
> -	if (test_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags)) {
> -		pr_debug("Got LOGIN_FLAGS_READ_ACTIVE=1 sk_state_change"
> -			 " conn: %p\n", conn);
> +	if (test_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags) ||
> +	    test_bit(LOGIN_FLAGS_WRITE_ACTIVE, &conn->login_flags)) {
> +		pr_debug("Got LOGIN_FLAGS_{READ|WRITE}_ACTIVE=1"
> +			 " sk_state_change conn: %p\n", conn);
>  		if (state)
>  			set_bit(LOGIN_FLAGS_CLOSED, &conn->login_flags);
>  		write_unlock_bh(&sk->sk_callback_lock);
> diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
> index 591cd9e4692c..844bef255e89 100644
> --- a/include/target/iscsi/iscsi_target_core.h
> +++ b/include/target/iscsi/iscsi_target_core.h
> @@ -566,10 +566,11 @@ struct iscsi_conn {
>  	struct socket		*sock;
>  	void			(*orig_data_ready)(struct sock *);
>  	void			(*orig_state_change)(struct sock *);
> -#define LOGIN_FLAGS_READ_ACTIVE		1
> -#define LOGIN_FLAGS_CLOSED		2
> -#define LOGIN_FLAGS_READY		4
> -#define LOGIN_FLAGS_INITIAL_PDU		8
> +#define LOGIN_FLAGS_READY		0
> +#define LOGIN_FLAGS_INITIAL_PDU		1
> +#define LOGIN_FLAGS_READ_ACTIVE		2
> +#define LOGIN_FLAGS_WRITE_ACTIVE	3
> +#define LOGIN_FLAGS_CLOSED		4
>  	unsigned long		login_flags;
>  	struct delayed_work	login_work;
>  	struct iscsi_login	*login;
> 

