Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145B47FE94
	for <lists+target-devel@lfdr.de>; Fri,  2 Aug 2019 18:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391175AbfHBQ1D (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 2 Aug 2019 12:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732543AbfHBQ1D (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:27:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74BFE308FEC1;
        Fri,  2 Aug 2019 16:27:02 +0000 (UTC)
Received: from [10.10.124.71] (ovpn-124-71.rdu2.redhat.com [10.10.124.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CCE519C68;
        Fri,  2 Aug 2019 16:27:02 +0000 (UTC)
Subject: Re: tcmu: Reporting of errors detected by handler_read() before it
 returns
To:     David Butterfield <dab21774@gmail.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <5e14ffb2-d08d-7ee4-7bba-09a83627b0d5@gmail.com>
 <5D4310E7.5020701@redhat.com>
 <9f2e4a82-a16f-80bb-2c5d-847ec2d24c5f@gmail.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D446455.4080100@redhat.com>
Date:   Fri, 2 Aug 2019 11:27:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <9f2e4a82-a16f-80bb-2c5d-847ec2d24c5f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 02 Aug 2019 16:27:02 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 08/02/2019 11:20 AM, David Butterfield wrote:
> On 8/1/19 10:18 AM, Mike Christie wrote:
>> Update your tcmu-runner git repo :)
>>
>> A little bit ago, the comments in tcmu-runner.h were updated to make it
>> clear what type of handler can do what, and also support for not having
>> to call cmd->done in handlers like file_example was added.
> 
> I've pulled the latest master and the comment has been revised, but part
> of my question still remains:
> 
> If the handler successfully completes execution of the block I/O command
> in the callout function, what TCMU_STS code should it return from the
> callout function?
> 
> It can't be TCMU_STS_OK, right?  Because that would leave tcmu-runner
> expecting a call to cmd->done() later.
> 
> And it can't be a TCMU_STS error, because the I/O was successful.
> 
> So what does the handler return to indicate both success and completion?

What is says on line 128.

You must return a TCMU_STS code. It can TMCU_STS_OK or a TCMU_STS error
value like TCMU_STS_WR_ERR.

For handlers like file_example that operate like described on line 128,
tcmu-runner core will do cmd->done for it.


> 
> 125         /*
> 126          * Below callouts are only executed by generic_handle_cmd.
> 127          *
> 128          * Handlers that completely execute cmds from the callout's calling
> 129          * context must return a TCMU_STS code from the callout.
> 130          *
> 131          * Async handlers that queue a command from the callout and complete
> 132          * it from their own async context return:
> 133          * - TCMU_STS_OK if the handler has queued the command.
> 134          * - TCMU_STS_NO_RESOURCE if the handler was not able to allocate
> 135          *   resources to queue the command.
> 136          *
> 137          * If TCMU_STS_OK is returned from the callout the handler must call
> 138          * tcmur_cmd_complete with a TCMU_STS return code to complete the
> 139          * command.
> 140          */
> 141         int (*read)(struct tcmu_device *dev, struct tcmur_cmd *cmd,
> 142                     struct iovec *iovec, size_t iov_cnt, size_t len, off_t off);
> 143         int (*write)(struct tcmu_device *dev, struct tcmur_cmd *cmd,
> 144                      struct iovec *iovec, size_t iov_cnt, size_t len, off_t off);
> 145         int (*flush)(struct tcmu_device *dev, struct tcmur_cmd *cmd);
> 
> 
>>> However, the code in file_example.c does not do either of those things, and directly
>>> violates the comment in tcmu-runner.h -- this excerpt is from file_read():

file_example operates like described in line 128.

>>>
>>> 	while (remaining) {
>>> 		ret = preadv(state->fd, iov, iov_cnt, offset);
>>> 		if (ret < 0) {
>>> 			tcmu_err("read failed: %m\n");
>>> 			ret = TCMU_STS_RD_ERR;
>>> 			goto done;
>>> 		}
>>> 		...
>>> 	}
>>> 	ret = TCMU_STS_OK;
>>> done:
>>> 	return ret;
>>>
>>> The file_read() function operates synchronously, and never issues a call to cmd->done()
>>> for successful reads returning TCMU_STS_OK, contradicting the comment in tcmu-runner.h.
> 

