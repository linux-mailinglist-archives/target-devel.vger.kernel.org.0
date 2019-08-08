Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0086860
	for <lists+target-devel@lfdr.de>; Thu,  8 Aug 2019 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbfHHSBy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 8 Aug 2019 14:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732609AbfHHSBy (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D33593064FD3;
        Thu,  8 Aug 2019 18:01:53 +0000 (UTC)
Received: from mchristi.msp.csb (ovpn-125-55.rdu2.redhat.com [10.10.125.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53D385D772;
        Thu,  8 Aug 2019 18:01:53 +0000 (UTC)
Reply-To: mchristi@redhat.com
Subject: Re: tcmu: Reporting of errors detected by handler_read() before it
 returns
To:     David Butterfield <dab21774@gmail.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <5e14ffb2-d08d-7ee4-7bba-09a83627b0d5@gmail.com>
 <5D4310E7.5020701@redhat.com>
 <9f2e4a82-a16f-80bb-2c5d-847ec2d24c5f@gmail.com>
 <5D446455.4080100@redhat.com>
 <4b2b4cfc-230f-31fd-d93f-2fa2a076ab36@gmail.com>
From:   Michael Christie <mchristi@redhat.com>
Organization: Red Hat
Message-ID: <f3bfd765-34b8-cddd-be2d-19fdb6a29293@redhat.com>
Date:   Thu, 8 Aug 2019 13:02:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <4b2b4cfc-230f-31fd-d93f-2fa2a076ab36@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 08 Aug 2019 18:01:53 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 08/08/2019 12:50 AM, David Butterfield wrote:
> Thanks for your help.  I'm afraid I'm still confused somehow about this.
> 
>>> If the handler successfully completes execution of the block I/O command
>>> in the callout function, what TCMU_STS code should it return from the
>>> callout function
>>
>> What is says on line 128.
>>
>> You must return a TCMU_STS code. It can TMCU_STS_OK or a TCMU_STS error
>> value like TCMU_STS_WR_ERR.
> 
> So, then, line 137 is intended to apply only to line 131 and not line 128?

Correct.

> I was reading it as applying to both.
> 
>> For handlers like file_example that operate like described on line 128,
>> tcmu-runner core will do cmd->done for it.
> 
> If TCMU_STS_OK is returned from file_read(), how does runner know whether that is
> 
>     (1) TCMU_STS_OK because the handler is async and it queued the command, and
> 	there will be a future call to tcmur_cmd_complete() from the handl>
>     (2) TCMU_STS_OK because the handler executed the entire command successfully
> 	and runner needs to issue the cmd->done for it now?

If you set nr_threads > 0 and implement the callouts below then
TCMU_STS_OK means you completed the command in the callout successfully.

If you set nr_threads = 0 and implement the callouts below then OK means
it got queued successfully and the handler is going to complete it by
calling tcmur_cmd_complete.

We do not have any handlers where nr_threads = 0, the callouts below are
implemented and the handler executes the command in the callout, so it's
not supported right now.


> 
> Also, I wonder why the return from async handlers for successful queueing
> of the command is TCMU_STS_OK rather than TCMU_STS_ASYNC_HANDLED.

It's just one of those things that needs to be cleaned up.

tcmu-runner uses it internally and when interacting with libtcmu, and
runner handlers that only implement a handle_cmd can use it directly.

> 
>>> 125         /*
>>> 126          * Below callouts are only executed by generic_handle_cmd.
>>> 127          *
>>> 128          * Handlers that completely execute cmds from the callout's calling
>>> 129          * context must return a TCMU_STS code from the callout.
>>> 130          *
>>> 131          * Async handlers that queue a command from the callout and complete
>>> 132          * it from their own async context return:
>>> 133          * - TCMU_STS_OK if the handler has queued the command.
>>> 134          * - TCMU_STS_NO_RESOURCE if the handler was not able to allocate
>>> 135          *   resources to queue the command.
>>> 136          *
>>> 137          * If TCMU_STS_OK is returned from the callout the handler must call
>>> 138          * tcmur_cmd_complete with a TCMU_STS return code to complete the
>>> 139          * command.
>>> 140          */
>>> 141         int (*read)(struct tcmu_device *dev, struct tcmur_cmd *cmd,
>>> 142                     struct iovec *iovec, size_t iov_cnt, size_t len, off_t off);
>>> 143         int (*write)(struct tcmu_device *dev, struct tcmur_cmd *cmd,
>>> 144                      struct iovec *iovec, size_t iov_cnt, size_t len, off_t off);
>>> 145         int (*flush)(struct tcmu_device *dev, struct tcmur_cmd *cmd);
> 

