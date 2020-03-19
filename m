Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAA18C20A
	for <lists+target-devel@lfdr.de>; Thu, 19 Mar 2020 22:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgCSVF3 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 19 Mar 2020 17:05:29 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:39153 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSVF2 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:05:28 -0400
Received: by mail-pf1-f176.google.com with SMTP id d25so2076682pfn.6
        for <target-devel@vger.kernel.org>; Thu, 19 Mar 2020 14:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mCKod3PCyOHriIZZUVsIwNmthx0kIWI5v6WD4aE0vIU=;
        b=YCNrSNmOpWylT4noV8wVh2X0cRqZfofbTAb2cWhLvkTSzRYyvKqUdCM29BqrJhKVg8
         EukPjqMCs5rCSDmk3KgRCRnWxgPbUZYJFUXKQLr2lrKxoPDVPKh44+QuZ9Qk3nUjYwiV
         I3QoPTOQOyhvK5UfgEzyu0ZgV/fHMQWPjzYD6YQ82t5e5B58R8V/4NQTCDCWB5o2TxVM
         adCKkapEqM2WH8JjnhPIYlVvVRwqr/JhCGuUxnKKrp3gVwbIK+6MVADTNvqdVYXu65oF
         sqP0+fLIf5pcpoIOs6JwqVF2LEXYAUU92xRpCoh+NQDA40ACa8RiyvjMY8VXxR2z+EW2
         Hn1Q==
X-Gm-Message-State: ANhLgQ3YQl6K8FLl2PQvpbvsZoiYN1K5e9X9WsNZxFjoZyLNm6fyvUUg
        3AoOWdYNM9UauGMeT8hFDZc=
X-Google-Smtp-Source: ADFU+vtsqUc74w9Z1VjYK+o0Iot7lf6RqqPBUEgTbleKcMvCD5wfdGkvxhFR8dL7uZaeaORI/PZx8Q==
X-Received: by 2002:a63:1e44:: with SMTP id p4mr5294929pgm.367.1584651927769;
        Thu, 19 Mar 2020 14:05:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f092:4ccc:3e48:6081? ([2601:647:4802:9070:f092:4ccc:3e48:6081])
        by smtp.gmail.com with ESMTPSA id p4sm3272596pfg.163.2020.03.19.14.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 14:05:26 -0700 (PDT)
Subject: Re: Connection errors with ISER IO
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20200226155241.GA28594@chelsio.com>
 <d655f85f-d910-a77b-1672-0fbb919e5d9a@grimberg.me>
 <20200227140045.GA2029@chelsio.com>
 <b021295a-cc41-d8e9-8605-cfbc77cead80@grimberg.me>
 <20200304182612.GA6665@chelsio.com> <20200310120150.GA7669@chelsio.com>
 <20200319174510.GB29063@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1d236e48-d76e-e7be-53a5-a1e6426a26b5@grimberg.me>
Date:   Thu, 19 Mar 2020 14:05:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200319174510.GB29063@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



On 3/19/20 10:45 AM, Potnuri Bharat Teja wrote:
> On Tuesday, March 03/10/20, 2020 at 17:31:51 +0530, Potnuri Bharat Teja wrote:
>> On Wednesday, March 03/04/20, 2020 at 23:56:12 +0530, Potnuri Bharat Teja wrote:
>>> On Friday, February 02/28/20, 2020 at 05:12:32 +0530, Sagi Grimberg wrote:
>>>>
>>>>>>> Hi All,
>>>>>>> I observe connection errors almost immediately after I start iozone over iser
>>>>>>> luns. Atached are the connection error and hung task traces on initator and
>>>>>>> target respecively.
>>>>>>> Interestingly, I see connection errors only if LUN size is less than 512MB.
>>>>>>> In my case I could consistently reproduce the issue with 511MB LUN and 300MB
>>>>>>> lun size. Connections errors are not seen if I create 512MB or greated LUN.
>>>>>>
>>>>>> Can you share log output on the target to before hung tasks?
>>>>>
>>>>> Sure, Attached are the target and initiator dmesg logs.
>>>>>>
>>>>>>> Further, after the connection errors, I noticed that the poll work queue is
>>>>>>> stuck and never processes drain CQE resulting in hung tasks on the target side.
>>>>>>
>>>>>> Is the drain CQE actually generated?
>>>>>>
>>>>>
>>>>> Yes it is generated. I was able to track it with prints until queue_work() in
>>>>> ib_cq_completion_workqueue(). Work Function ib_cq_poll_work() is never getting
>>>>> scheduled. Therefore, I see drain CQE unpolled and hung task due to
>>>>> __ib_drain_sq() waiting forever for complete() to be called from drain CQE
>>>>> done() handler.
>>>>
>>>> Hmm, that is interesting. This tells me that cq->work is probably
>>>> blocked by another completion invokation (which hangs), which means that
>>>> queuing the cq->work did not happen as workqueues are not re-entrant.
>>>>
>>>> Looking at the code, nothing should be blocking in the isert ->done()
>>>> handlers, so its not clear to me how this can happen.
>>>>
>>>> Would it be possible to run:
>>>> echo t > /proc/sysrq-trigger when this happens? I'd like to see where
>>>> that cq->work is blocking.
>>>>
>>> Attached file t_sysrq-trigger_and_dmesg.txt is the triggered output. Please let
>>> me know if that is timed correctly as I triggered it a little after login timeout.
>>> I'll try getting a better one meanwhile.
>>>> I'd also enable pr_debug on iscsi_traget.c
>>>>
>>> Attached files are with debug enabled:
>>> tgt_discovery_and_login_dmesg.txt -> dmesg just after login for reference
>>> tgt_IO_511MB_8target_1lun_each_iozone_dmesg_untill_hang.txt -> dmesg untill connection error.
>>>
>>> Please let me know if there is anything that I could check.
>>
> Hi All,
> any suggestions on what to check?
> 
> I tried limiting max_data_sg_nnets to 32 as T6 has relatively lower resources
> and I dont see the issue with the patch.
> 
> Though the visible effect is at the workqueue, I think there is something to do
> iscsi/iser flow control mechanism, which is failing and overwhelming the target.
> I am not sure how to verify this exactly. I appreciate any suggestions on the debug.

Can you check what threads are blocking on?

When the hang happens, run echo t > /proc/sysrq-trigger. I'd like to
understand what is preventing the workqueue from running...
