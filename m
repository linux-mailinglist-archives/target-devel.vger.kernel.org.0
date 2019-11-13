Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0EFB6B1
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 18:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKMRzy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 12:55:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39521 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKMRzy (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:55:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so2153453pfo.6
        for <target-devel@vger.kernel.org>; Wed, 13 Nov 2019 09:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cK2Ri/mqNqrEyaHPQ2AiDVfobXI8gHtHG1oN7mgLnh0=;
        b=GoYM2QeJHzVVKiADffd0vC4BpZ/ZepY+qX5Ao7GkjwFg71xWhoTLTuPUmjwiOauEBo
         XECM8MC8Ha25uP3B77R9yHrNamX1hWnMowHbNE4LOmAOxlF44WAOcibbxis+aG243s0C
         YXdPDeVgXx1G2XnEdNHKHVXj/qZ/pdJmlLMUdqblkkKDmxs0ANOh6NtR17kJrYgyJgwb
         6OBy8k4+Bu+VfmiSXSlv75DZAbVgpLcj5iET5gF5m5eYvVD/iSU4woALTmhSeEo9+2ux
         gVNZ0pHp8fiRMbzlGCYObU9bVinmRYiB+qjmD/V8nM7pJkabtNeGK0T81GONnW77S/mR
         y/UA==
X-Gm-Message-State: APjAAAUUkXxUYL73S2tYh9TuX329F8fTKXSAI5KHfbJcs3jd4weOa65W
        1rNa37H4fIbXbQDw0x9QZc0l1KR/
X-Google-Smtp-Source: APXvYqzN/V9ca43beIE5w0CwlCEOnh17UlFVVpxb7pHKcOxowlf02Lx1p9b9oO4jJ9q/LDjofC38PQ==
X-Received: by 2002:a62:75c5:: with SMTP id q188mr6012839pfc.132.1573667751372;
        Wed, 13 Nov 2019 09:55:51 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v189sm3482085pfv.133.2019.11.13.09.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 09:55:50 -0800 (PST)
Subject: Re: [PATCH 3/3] target/iscsi: Wait for all commands to finish before
 freeing a session
To:     Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
References: <20191112035752.8338-1-bvanassche@acm.org>
 <20191112035752.8338-4-bvanassche@acm.org>
 <20191113134253.rlypgdve7qwfynjz@SPB-NB-133.local>
 <04168d9b-bd0e-0fb0-1977-8671ab9db282@acm.org>
 <20191113172949.dkcantqtx7c2zcpo@SPB-NB-133.local>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b7b6a08a-cc45-76ca-5797-d3a6648a4171@acm.org>
Date:   Wed, 13 Nov 2019 09:55:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113172949.dkcantqtx7c2zcpo@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/13/19 9:29 AM, Roman Bolshakov wrote:
> Thanks for the context, would reason code "Waiting for Logout" (0x0c) be
> suffice for the case as documented in 11.9.1. AsyncEvent
> (https://tools.ietf.org/html/rfc7143#section-11.9.1):
> 
>          1 (Logout Request) - the target requests Logout.  This Async
>            Message MUST be sent on the same connection as the one
>            requesting to be logged out.  The initiator MUST honor this
>            request by issuing a Logout as early as possible but no later
>            than Parameter3 seconds.  The initiator MUST send a Logout
>            with a reason code of "close the connection" OR "close the
>            session" to close all the connections.  Once this message is
>            received, the initiator SHOULD NOT issue new iSCSI commands on
>            the connection to be logged out.  The target MAY reject any
>            new I/O requests that it receives after this message with the
>            reason code "Waiting for Logout". If the initiator does not
>            log out in Parameter3 seconds, the target should send an Async
>            PDU with iSCSI event code "Dropped the connection" if possible
>            or simply terminate the transport connection.  Parameter1 and
>            Parameter2 are reserved.

That sounds like a good idea to me. Please have a look at version three 
of this patch series. That version uses reason code 0x0c.

Thanks,

Bart.
