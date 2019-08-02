Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1217FE7E
	for <lists+target-devel@lfdr.de>; Fri,  2 Aug 2019 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbfHBQUW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 2 Aug 2019 12:20:22 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:38650 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389867AbfHBQUV (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:20:21 -0400
Received: by mail-io1-f43.google.com with SMTP id j6so33570168ioa.5
        for <target-devel@vger.kernel.org>; Fri, 02 Aug 2019 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hBgqiAyePcu8hwfEQaAIjfH3JGMM3vWKXaZEHjK+vY4=;
        b=nBeqJKPHHtJXG8bzFyywj0veRQ9lIh97MQ26l3DEfm6yGKiwWqSJCVjEiiFSQITYu5
         Z/ZFgvHF/uEWunTup1o0SpWWmLPAyLilS+KpDKFW8Ms+MI5RNgRtfRZvG0brfO07C1zW
         n/nWqowBA2u+lCXpgKJXoNSAI6G9cmFwkdd17fm4oHLfHM8y3MhMnco9qhDNQj3yyJMH
         ikE8RYuksmkf/4uwmhWejRBkAuKYpKjoVCysL73HJ10ih1TVJqmLPq1o5UuDQeemvaNy
         Q6HH/gBfN6Gj78VDUZasmW001iDTPKhMhlQOf94HcFGnQBAIcsknh2H6U4jODE9ovVi3
         58fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hBgqiAyePcu8hwfEQaAIjfH3JGMM3vWKXaZEHjK+vY4=;
        b=YtEqJyC+mDi2S9dSoTc4OfUPAhG6nIym04FFS86FV3YvXOmQL3UiEHDYucrWytS/Xm
         aEjzXILe6THzKoh8KsWDo6TmNaRndRpq+H7mi5lkKA0gvxn2gcu+QNpADwluOGoSNdGA
         tibRZM3kAxH8GMvzFTaAZw+xRzxvPNirmCjlo1vMmiWz84y4SAsG5ts7oWB9AvrR/6IW
         5K0//APtDqsKNeFnSmp3eQc8ma3OghPoR3I1ibI08954Jh0RpZUh+bQplpJDtAe6pCq7
         qlihyYLmqq7NuprVCezG9XfrRlzCPh/ydP+CwFMGfwqFx2LenVdw/BwJx7Gx6hWKZEGI
         J63A==
X-Gm-Message-State: APjAAAXOw4fMzwTHf3v0pIHnsk2PDptPiIw5K691xGmmAcU1IAAUHcN8
        S2O1tC1FW6Qack719ZSFU9WmHWRp
X-Google-Smtp-Source: APXvYqxQ4iFNybLSVDGlkoyVAesszTAvYLgRDU4EgMtyaCvvRrB8FSLHLkdlPqO9qXQOvwytw7AKaw==
X-Received: by 2002:a6b:621a:: with SMTP id f26mr7232119iog.127.1564762821034;
        Fri, 02 Aug 2019 09:20:21 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net. [73.78.150.191])
        by smtp.gmail.com with ESMTPSA id n26sm55700867ioc.74.2019.08.02.09.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 09:20:20 -0700 (PDT)
Subject: tcmu: Reporting of errors detected by handler_read() before it
 returns
To:     Mike Christie <mchristi@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <5e14ffb2-d08d-7ee4-7bba-09a83627b0d5@gmail.com>
 <5D4310E7.5020701@redhat.com>
From:   David Butterfield <dab21774@gmail.com>
Organization: PGP: 70C7 0309 E859 40AB 4D1F CDC5 F7CE 9A64 95EB 9D1B
Message-ID: <9f2e4a82-a16f-80bb-2c5d-847ec2d24c5f@gmail.com>
Date:   Fri, 2 Aug 2019 10:20:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5D4310E7.5020701@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 8/1/19 10:18 AM, Mike Christie wrote:
> Update your tcmu-runner git repo :)
> 
> A little bit ago, the comments in tcmu-runner.h were updated to make it
> clear what type of handler can do what, and also support for not having
> to call cmd->done in handlers like file_example was added.

I've pulled the latest master and the comment has been revised, but part
of my question still remains:

If the handler successfully completes execution of the block I/O command
in the callout function, what TCMU_STS code should it return from the
callout function?

It can't be TCMU_STS_OK, right?  Because that would leave tcmu-runner
expecting a call to cmd->done() later.

And it can't be a TCMU_STS error, because the I/O was successful.

So what does the handler return to indicate both success and completion?

125         /*
126          * Below callouts are only executed by generic_handle_cmd.
127          *
128          * Handlers that completely execute cmds from the callout's calling
129          * context must return a TCMU_STS code from the callout.
130          *
131          * Async handlers that queue a command from the callout and complete
132          * it from their own async context return:
133          * - TCMU_STS_OK if the handler has queued the command.
134          * - TCMU_STS_NO_RESOURCE if the handler was not able to allocate
135          *   resources to queue the command.
136          *
137          * If TCMU_STS_OK is returned from the callout the handler must call
138          * tcmur_cmd_complete with a TCMU_STS return code to complete the
139          * command.
140          */
141         int (*read)(struct tcmu_device *dev, struct tcmur_cmd *cmd,
142                     struct iovec *iovec, size_t iov_cnt, size_t len, off_t off);
143         int (*write)(struct tcmu_device *dev, struct tcmur_cmd *cmd,
144                      struct iovec *iovec, size_t iov_cnt, size_t len, off_t off);
145         int (*flush)(struct tcmu_device *dev, struct tcmur_cmd *cmd);


>> However, the code in file_example.c does not do either of those things, and directly
>> violates the comment in tcmu-runner.h -- this excerpt is from file_read():
>>
>> 	while (remaining) {
>> 		ret = preadv(state->fd, iov, iov_cnt, offset);
>> 		if (ret < 0) {
>> 			tcmu_err("read failed: %m\n");
>> 			ret = TCMU_STS_RD_ERR;
>> 			goto done;
>> 		}
>> 		...
>> 	}
>> 	ret = TCMU_STS_OK;
>> done:
>> 	return ret;
>>
>> The file_read() function operates synchronously, and never issues a call to cmd->done()
>> for successful reads returning TCMU_STS_OK, contradicting the comment in tcmu-runner.h.

