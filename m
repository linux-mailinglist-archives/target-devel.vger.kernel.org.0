Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4785A0C
	for <lists+target-devel@lfdr.de>; Thu,  8 Aug 2019 07:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfHHFub (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 8 Aug 2019 01:50:31 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39104 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfHHFub (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:50:31 -0400
Received: by mail-ot1-f48.google.com with SMTP id r21so107987536otq.6
        for <target-devel@vger.kernel.org>; Wed, 07 Aug 2019 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fjHo/y10u98W+ubj0jw5rdgBSy/PWgBInR3oVmCLf24=;
        b=UrZnFKAWgg1ARG9G5MYcT4aD3IWMYeriqWPSudhFO8+fc81AIxxnotk4LF75UTEyRT
         X5cMYKmRqZz6GodvnwQ8v+pzZK56PSjMQ6LjR3EqhWMWdvtzBWoGjyBcOzdI7LP0IGd7
         q70qOjcs9KSaXU9P2uWWqEMKiVCVGCiWyW7/s+OZRiSzpyyphsjdKExU+qnLbPQRLzEA
         i3oj2fAlUYLkW9ZCgoJLE0GHdwtv16AEjatMkrMfX9rxQDDRx3bxaj/yicQ1DieN23QJ
         JUSaUQo7IbhwAxfpM72sz/icRAPTE4nCdwzUAw3A6aj+lZIehPe4GfDMvTyMR3+DPcva
         zuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fjHo/y10u98W+ubj0jw5rdgBSy/PWgBInR3oVmCLf24=;
        b=La8vCoa4301on6seLeEfFKJZ98vC+H287QquzBqDVQYO/b1DahnrldipUylMOdk0n0
         cZtau3Plzqy12Ssr4852wkN0XXseKYBjlcftGDns+SlhqnTEOY8EnWZoYJUON3M3p+KB
         pHZflDFpure4pIIsf3kqZLVHRXCdmaZQ2dZVS222lmQk2W4U/RLVaL7dijIeK1uYwVk1
         V+uv7KWUIizffMNBN1s+9RKX7+nrGbFZw3e33n4ac2aMjqudqvOkpJn7Kj5JaV3HP7FT
         qePc3KrlUgC1fjTlcZNvXOVKJJd6FxpMS/uYUfPfEWIIsqQQ3inPORzQkb6V42aXfrMv
         mpfQ==
X-Gm-Message-State: APjAAAVbmLBxhOL/Jdojcn4eWhXNvTNgdFPv5Df9zfLEqeerNqfWX/9M
        YlINvAU/6tz0lw56c9ElA7qxcgIk
X-Google-Smtp-Source: APXvYqzPVennKyBu2JAY2q6h5vT0B9YoaAh/KXvks+Mm8s5x2LghA2tzv/XHLIbxPwgoGDbQHDncoQ==
X-Received: by 2002:a6b:ee12:: with SMTP id i18mr12903967ioh.172.1565243429875;
        Wed, 07 Aug 2019 22:50:29 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net. [73.78.150.191])
        by smtp.gmail.com with ESMTPSA id t5sm70802862iol.55.2019.08.07.22.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 22:50:29 -0700 (PDT)
Subject: Re: tcmu: Reporting of errors detected by handler_read() before it
 returns
To:     Mike Christie <mchristi@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <5e14ffb2-d08d-7ee4-7bba-09a83627b0d5@gmail.com>
 <5D4310E7.5020701@redhat.com>
 <9f2e4a82-a16f-80bb-2c5d-847ec2d24c5f@gmail.com>
 <5D446455.4080100@redhat.com>
From:   David Butterfield <dab21774@gmail.com>
Organization: PGP: 70C7 0309 E859 40AB 4D1F CDC5 F7CE 9A64 95EB 9D1B
Message-ID: <4b2b4cfc-230f-31fd-d93f-2fa2a076ab36@gmail.com>
Date:   Wed, 7 Aug 2019 23:50:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5D446455.4080100@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Thanks for your help.  I'm afraid I'm still confused somehow about this.

>> If the handler successfully completes execution of the block I/O command
>> in the callout function, what TCMU_STS code should it return from the
>> callout function
>
> What is says on line 128.
> 
> You must return a TCMU_STS code. It can TMCU_STS_OK or a TCMU_STS error
> value like TCMU_STS_WR_ERR.

So, then, line 137 is intended to apply only to line 131 and not line 128?
I was reading it as applying to both.

> For handlers like file_example that operate like described on line 128,
> tcmu-runner core will do cmd->done for it.

If TCMU_STS_OK is returned from file_read(), how does runner know whether that is

    (1) TCMU_STS_OK because the handler is async and it queued the command, and
	there will be a future call to tcmur_cmd_complete() from the handler; or

    (2) TCMU_STS_OK because the handler executed the entire command successfully
	and runner needs to issue the cmd->done for it now?

Also, I wonder why the return from async handlers for successful queueing
of the command is TCMU_STS_OK rather than TCMU_STS_ASYNC_HANDLED.

>> 125         /*
>> 126          * Below callouts are only executed by generic_handle_cmd.
>> 127          *
>> 128          * Handlers that completely execute cmds from the callout's calling
>> 129          * context must return a TCMU_STS code from the callout.
>> 130          *
>> 131          * Async handlers that queue a command from the callout and complete
>> 132          * it from their own async context return:
>> 133          * - TCMU_STS_OK if the handler has queued the command.
>> 134          * - TCMU_STS_NO_RESOURCE if the handler was not able to allocate
>> 135          *   resources to queue the command.
>> 136          *
>> 137          * If TCMU_STS_OK is returned from the callout the handler must call
>> 138          * tcmur_cmd_complete with a TCMU_STS return code to complete the
>> 139          * command.
>> 140          */
>> 141         int (*read)(struct tcmu_device *dev, struct tcmur_cmd *cmd,
>> 142                     struct iovec *iovec, size_t iov_cnt, size_t len, off_t off);
>> 143         int (*write)(struct tcmu_device *dev, struct tcmur_cmd *cmd,
>> 144                      struct iovec *iovec, size_t iov_cnt, size_t len, off_t off);
>> 145         int (*flush)(struct tcmu_device *dev, struct tcmur_cmd *cmd);

