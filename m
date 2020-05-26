Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B61B8CD3
	for <lists+target-devel@lfdr.de>; Sun, 26 Apr 2020 08:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDZGJ7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 26 Apr 2020 02:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgDZGJ7 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:09:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8421C061A0E
        for <target-devel@vger.kernel.org>; Sat, 25 Apr 2020 23:09:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so6963581pgg.4
        for <target-devel@vger.kernel.org>; Sat, 25 Apr 2020 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=XOw1H4oXPIq3rZovMfQY+eLQ6uLDOSF3nS0HnhuTMmk=;
        b=yOw06D+9HOA+L4bX1CLXoqYaVnUdFIo0vJKdwnDLNLh+Ajla4hx12dqeTHcHd007bp
         caq2pk0sh3Jcnw2rmnFK1Uv8yisCtAW0oFhhbU9QlG6J5Cx+KGeF87ntqtavedkahBla
         V1h1un9HvZQV+9CObuk9OBrujJ7K6FIbxsi26RKp1Ulevk4G53rNbR+XGdB16vJwiUPf
         Z+DwliJrlsdm+RucI5dOWMi6C70HoMYrQs1YwOrLV4QdPqYbKvLe86Nb+YetKCACEykV
         tKvxSdwKyyHjypLdMqKnjhIGmLwOtUNYrhnrOtWoKt0qCoNv0wiGLk2r2+1H4P+pJW2P
         RfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XOw1H4oXPIq3rZovMfQY+eLQ6uLDOSF3nS0HnhuTMmk=;
        b=tHqXTVGu4wewLKT+F5OamDjGTNwIxj/BsXx7mw+BIaOGvR8EnInIXqOhsLWDgKPYHk
         g9HLsGn9rs/0W6RVANojmCKBvAjlXOBFkkwMWrVW3WJy6UfH5qCjaPZZ2ctoyX4j5lo2
         eSGt1kK0EzkOb5hPnRa3dcyZdYYSfPhF1qzNPhh6DtxFqGjhu16j7bfb9Ipzsl8IsqtR
         jiiXZGD8BLpZJ1TLMfWWQ2QdC7PsXUyzAYrWiFx5iDX17WXd4GXiyVk6KWha58M5Yiy2
         1jmZ+vk6K91jhebLmL1/E630Gjf++2w7KPnW5oYhSyqFKzFPWnoIE7aNPHYJqztdP3LZ
         4ZNg==
X-Gm-Message-State: AGi0PuaJn6J3Xw9Qve8j22oxHxf7euC5iTUNBftybtZBGPGE4qTOcTx+
        pqnqlFijXuIuM1ksBLUCbx51kk83jk1p4g==
X-Google-Smtp-Source: APiQypLWKBdZPwHYJyRSMusYXRiWqYiLgjA5RC/U7UpVHMmOlVeHNTrBWrqp95wClRdvSG0ptMLJ3w==
X-Received: by 2002:a63:7d5d:: with SMTP id m29mr16636068pgn.65.1587881398044;
        Sat, 25 Apr 2020 23:09:58 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w12sm9110367pfq.133.2020.04.25.23.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 23:09:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] iscsi-target: fix login error when receiving is
 too fast
From:   Hou Pu <houpu@bytedance.com>
To:     Mike Christie <mchristi@redhat.com>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200424123528.17627-1-houpu@bytedance.com>
 <20200424123528.17627-2-houpu@bytedance.com>
 <cee3c624-4d43-fd4c-1436-cfc0c08a4321@redhat.com>
 <8f3b123e-1dc3-54ba-ae6d-90e76e5702b5@redhat.com>
 <44a02338-0923-5b57-ed26-8528bf9cde70@bytedance.com>
Message-ID: <ef4dce23-dca8-c75a-0e18-c4bb49fe503a@bytedance.com>
Date:   Sun, 26 Apr 2020 14:09:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <44a02338-0923-5b57-ed26-8528bf9cde70@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


>>>> +     */
>>>> +    if (conn->sock) {
>>>> +        struct sock *sk = conn->sock->sk;
>>>> +
>>>> +        write_lock_bh(&sk->sk_callback_lock);
>>>> +        clear_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags);
>>>> +        set_bit(LOGIN_FLAGS_WRITE_ACTIVE, &conn->login_flags);
>>>> +        write_unlock_bh(&sk->sk_callback_lock);
>>>> +    }
>>>> +
>>> Hey,
>>>
>>> I had one more question.
>>>
>>> With the above code, I think we have a race where if we clear the bit
>>> above early and iscsi_target_sk_data_ready runs while
>>> iscsi_target_do_login_rx is still running then we could queue the work
>>> an extra time and get stuck. Because the bit is now not set, if
>>> iscsi_target_sk_data_ready runs it will end up calling
>>> schedule_delayed_work which will queue up the work again since the work
>>> is running and not pending.
>
> Yes. I was trying to allow queuing the delayed work early.
>
>>>
>>> If that is correct and we hit the race what happens if this was the 
>>> last
>>> login pdu, and we are supposed to go to full feature phase next? For
>>> example if iscsi_target_do_login_rx runs an extra time, will we end up
>>> stuck waiting in iscsi_target_do_login_rx's call to:
>>>
>>> rc = conn->conn_transport->iscsit_get_login_rx(conn, login);
>>>
>>> ?
>
> For the last login pdu, we may have race as you said. thanks for 
> pointing it out.
>
> I was trying to image a case where we can hit the race, normally it is 
> case a).
>
> a). initiator send last login pdu -> target received -> target replied
>
> b). initiator send last login pdu -> target received -> initiator send 
> something -> target replied
>
> in case b). we will queue another delayed work which we should not.  
> After the target replied
>
> the last login pdu, conn->conn_login is freed. we might visited it in 
> the delayed work.
>
>
>> Just answering my own question. It looks like we do not get stuck. But
>> we either get nothing on the session so the login timeout fires and we
>> drop the session. Or, we get a PDU and the login thread reads it in
>> before the normal rx thread does, but it assumes it is a login related
>> and we most likely drop the session due to invalid fields.
>>
>> I think in iscsi_target_restore_sock_callbacks we want to do a:
>>
>> cancel_delayed_work(&conn->login_work)
>>
>> after we reset the callbacks and drop the sk_callback_lock lock.
>
> I am not very sure if we could or if it is good to cancel_delayed_work 
> from the work itself.
>
> If it is ok then i am ok with it. Or in another way, I think we could 
> just clear
>
> LOGIN_FLAGS_READ_ACTIVE and set LOGIN_FLAGS_WRITE_ACTIVE
>
> after iscsi_target_restore_sock_callbacks when finish process last 
> login pdu.

That would look like (in iscsi_target_do_tx_login_io):

diff --git a/drivers/target/iscsi/iscsi_target_nego.c 
b/drivers/target/iscsi/iscsi_target_nego.c
index 685d771b51d4..4d0658731382 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -328,6 +328,28 @@ static int iscsi_target_do_tx_login_io(struct 
iscsi_conn *conn, struct iscsi_log
         u32 padding = 0;
         struct iscsi_login_rsp *login_rsp;

+       /*
+        * LOGIN_FLAGS_READ_ACTIVE is cleared so that sk_data_ready
+        * could be trigger again after this.
+        *
+        * LOGIN_FLAGS_WRITE_ACTIVE is cleared after we successfully
+        * process a login pdu, so that sk_state_chage could do login
+        * cleanup as needed if the socket is closed. If a delayed work is
+        * ongoing (LOGIN_FLAGS_WRITE_ACTIVE or LOGIN_FLAGS_READ_ACTIVE),
+        * sk_state_change will leave the cleanup to the delayed work or
+        * it will schedule a delayed work to do cleanup.
+        */
+       if (conn->sock) {
+               struct sock *sk = conn->sock->sk;
+
+               write_lock_bh(&sk->sk_callback_lock);
+               if (!test_bit(LOGIN_FLAGS_INITIAL_PDU, 
&conn->login_flags)) {
+                       clear_bit(LOGIN_FLAGS_READ_ACTIVE, 
&conn->login_flags);
+                       set_bit(LOGIN_FLAGS_WRITE_ACTIVE, 
&conn->login_flags);
+               }
+               write_unlock_bh(&sk->sk_callback_lock);
+       }

>
> What do you think?
>
>
>
> Thanks,
>
> Hou
>
>
>>
