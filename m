Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655AC172C6E
	for <lists+target-devel@lfdr.de>; Fri, 28 Feb 2020 00:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgB0Xmf (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 27 Feb 2020 18:42:35 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46659 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbgB0Xmf (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:42:35 -0500
Received: by mail-oi1-f195.google.com with SMTP id a22so1044255oid.13
        for <target-devel@vger.kernel.org>; Thu, 27 Feb 2020 15:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=csw4/Y/uaRktiEhueQScer9WfQ1Q2P2eZTlCH2kLB5M=;
        b=HN9gpfXmUrqjdz9bnngJkGqf21AilonFNaE5CSjy8SULtJMDSez+X0AXBHNqV/LFwv
         HGOF7/fmz3urUQ47Nh/R1tfenmdrnTDhWvGgbF+pST2VV3pIAa+yLLG+E0N1KDKgDdZf
         By0sLj1tt87AygTjugYBPIsPhkQytVtM+LFP1N0XJD4WONvr/wP3zPrheqLhG7d9DQg0
         iWt/YAFgEfPkr58fkjKcwlO/tfIf22LOJnKKvLHvIUJJSHFCjZyhdagLumet7fr3nxKL
         xhRDrrOcFKR7UPlsUr1ufiyJpfxeB97Loa6RMjn+sx7OhY+MfC2kiyE52h/AmF/8GGA0
         m1qQ==
X-Gm-Message-State: APjAAAWjQ6Bm9ZMk+tym5ZUiIuIOOmCfpdVTrtIvh9sMAjNcB4uCEElk
        AX/vhLnQESyMAzZpm3j6IPo=
X-Google-Smtp-Source: APXvYqwb8m2KLwSBsu7ef80Pe9EeW8PdpoQVEXPRQQsO4C8L2EpCWBHbp/14WuUftBK5L8ykmPOwFA==
X-Received: by 2002:aca:f40a:: with SMTP id s10mr1197085oih.61.1582846954666;
        Thu, 27 Feb 2020 15:42:34 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e206sm2509582oia.24.2020.02.27.15.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 15:42:33 -0800 (PST)
Subject: Re: Connection errors with ISER IO
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     target-devel@vger.kernel.org, maxg@mellanox.com,
        martin.petersen@oracle.com
References: <20200226155241.GA28594@chelsio.com>
 <d655f85f-d910-a77b-1672-0fbb919e5d9a@grimberg.me>
 <20200227140045.GA2029@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b021295a-cc41-d8e9-8605-cfbc77cead80@grimberg.me>
Date:   Thu, 27 Feb 2020 15:42:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200227140045.GA2029@chelsio.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


>>> Hi All,
>>> I observe connection errors almost immediately after I start iozone over iser
>>> luns. Atached are the connection error and hung task traces on initator and
>>> target respecively.
>>> Interestingly, I see connection errors only if LUN size is less than 512MB.
>>> In my case I could consistently reproduce the issue with 511MB LUN and 300MB
>>> lun size. Connections errors are not seen if I create 512MB or greated LUN.
>>
>> Can you share log output on the target to before hung tasks?
> 
> Sure, Attached are the target and initiator dmesg logs.
>>
>>> Further, after the connection errors, I noticed that the poll work queue is
>>> stuck and never processes drain CQE resulting in hung tasks on the target side.
>>
>> Is the drain CQE actually generated?
>>
> 
> Yes it is generated. I was able to track it with prints until queue_work() in
> ib_cq_completion_workqueue(). Work Function ib_cq_poll_work() is never getting
> scheduled. Therefore, I see drain CQE unpolled and hung task due to
> __ib_drain_sq() waiting forever for complete() to be called from drain CQE
> done() handler.

Hmm, that is interesting. This tells me that cq->work is probably
blocked by another completion invokation (which hangs), which means that
queuing the cq->work did not happen as workqueues are not re-entrant.

Looking at the code, nothing should be blocking in the isert ->done()
handlers, so its not clear to me how this can happen.

Would it be possible to run:
echo t > /proc/sysrq-trigger when this happens? I'd like to see where
that cq->work is blocking.

I'd also enable pr_debug on iscsi_traget.c

> 
>>> I tried changing the CQ poll workqueue to be UNBOUND but it did not fix the issue.
>>>
>>> Here is what my test does:
>>> Create 8 targets with 511MB lun each, login and format disks to ext3, mount the
>>> disks and run iozone over them.
>>> #iozone -a -I -+d -g 256m
>>
>> Does it happen specifically with iozone? or can dd/fio also
>> reproduce this issue? on which I/O pattern do you see the issue?
>>
> I see it with iozone. I am trying with fio, shall soon update.
> I see issue with at iosizes around 128k/256k block sizes of iozone. Its not
> consistent.
>>> I am not sure how LUN size could cause the connection errors. I appreciate any
>>> inputs on this.
>>
>> I imagine that a single LUN is enough to reproduce the issue?
>>
> 
> yes, attached is the target conf.
>> btw, I tried reproducing the issue with rxe (couldn't setup an iser
>> listener with siw) in 2 VMs on my laptop using lio to a file backend but
>> I cannot reproduce the issue..
> I see the issue quickly with 40G/25G links. I have not seen the issue on a 100G
> link. BTW i a trying iwarp(T6/t5)
> 
> Thanks for looking into it.
> 

 From the log, looks like the hang happens when the initiator tries to
login after the failure (trace starts in iscsi_target_do_login). and
looks like the target gave up on login timeout, but what is not
indicated is why did the initiator got a ping timeout in the
first place...
