Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2622FFFB
	for <lists+target-devel@lfdr.de>; Tue, 28 Jul 2020 05:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgG1DQt (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 27 Jul 2020 23:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgG1DQt (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 27 Jul 2020 23:16:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344DCC061794
        for <target-devel@vger.kernel.org>; Mon, 27 Jul 2020 20:16:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id lw1so2078653pjb.1
        for <target-devel@vger.kernel.org>; Mon, 27 Jul 2020 20:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tyXSmhsn7QCatX2okhnG1C0YXtOurTJuxXETVAxJmFQ=;
        b=gul/nKyBvS7ujATqra7vJ9my/xCJFo4FTj65YeCeVuw+ODY47SRwHLBLpaiHTf89yw
         ULgxULFpwjei2q5tPqdWBk0BUSjB4StO1FKrOLgzxZ4sCQhvEKhGZWroxi00bNVTqbOK
         /aZ7ZREe7i4dz4WU3GwJMOlPgmRzNvx129Fv90s33gUWyRtRLh8h8pbyZqJH2z3rsuXr
         CnfcapbuLOUYRaX/mMazToRh6duTrpzNHYrOnvM8J4nKkWxg7DSxahzrFPdZre+ATDe6
         PajVgmYkfOyg+HO15lKkob7JdZPZPUMb3V2xvn/aLnMT9exgmnMdsa3AMlMzPkazfhed
         twfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tyXSmhsn7QCatX2okhnG1C0YXtOurTJuxXETVAxJmFQ=;
        b=TcT7S6fDmIvRqKObNUPiThJSTBoAbiTSpbtNCAN91iuKKFIyDPeOCqpMgMQQiWLkA6
         wDoi/HEYXULiGqo7OiZckpxN9UNxm9zKWbZjWO/FmshQv292vTBzorhR7j5eUTkyN2kb
         r4j410xqoa9MmLbirWBnds5zQyGoU4T6uBwMRzeg2k8PPBML0J8Ky/VxDhUEy4Y7JBG/
         oep4F2QOUCqJOrNnrX/+MIw7nYxJv6tJjSD1e1w4z/zuRjjnXxV8eLIwrJQm2S5cU0IR
         Zo4K14iXRcg9nkybbIFunkqRxJJv8UOYu1CFVSw3xmxEIUegU+Yrduyt91sd7xqP2JBf
         RIwA==
X-Gm-Message-State: AOAM532Iq+Yo+LhKMMMN27yl0A+5KJXMXX8KsCPqkVyo68d1XO2CqHsi
        uEFBiBxomKzt6qiieRpKY0U/Cw==
X-Google-Smtp-Source: ABdhPJzMVSo6UZFalKB0SOZudI+B+Zyph8W/0YdfDVAFMXLqCL3k7GAEJrwyNptn59ySk/MMeXhDMg==
X-Received: by 2002:a17:90a:f00d:: with SMTP id bt13mr2272863pjb.109.1595906208734;
        Mon, 27 Jul 2020 20:16:48 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id c30sm16415944pfj.213.2020.07.27.20.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 20:16:48 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] iscsi-target: fix login error when receiving is
 too fast
To:     Mike Christie <michael.christie@oracle.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     mchristi@redhat.com
References: <20200716100212.4237-1-houpu@bytedance.com>
 <a78662d5-0bb4-8b27-125e-b4c2176b70c6@oracle.com>
From:   Hou Pu <houpu@bytedance.com>
Message-ID: <8c4539d7-c8e5-2698-6d70-f255122fc596@bytedance.com>
Date:   Tue, 28 Jul 2020 11:16:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a78662d5-0bb4-8b27-125e-b4c2176b70c6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



On 2020/7/26 10:58 上午, Mike Christie wrote:
> On 7/16/20 5:02 AM, Hou Pu wrote:
>> Hi,
>> We encountered "iSCSI Login negotiation failed" several times.
>> After enable debug log in iscsi_target_nego.c of iSCSI target.
>> Error shows:
>>    "Got LOGIN_FLAGS_READ_ACTIVE=1, conn: xxxxxxxxxx >>>>"
>>
>> Patch 1 is trying to fix this problem. Please see comment in patch 1
>> for details.
>>
>> Sorry for delay of v4. Version 3 of this patchset could be found here[1].
>>
>> Changes from v4:
>> * In iscsi_target_do_login_rx(), call cancel_delayed_work() if it is final
>>    login pdu. Also call cancel_delayed_work() if current negotiation is failed.
>>    This is advised by Mike Christie. See below[1] for more details.
>>
>> Changes from v3:
>> * Fix style problem found by checkpatch.pl.
>>
> Ah sorry, I thought I replied a little later about my concerns being overly paranoid and your patch being ok. I don't see it on the list so not sure what happened.
> 
> If you are still not liking the cancel call, I'm ok with v3. Add my reviewed by to either version you prefer.
> 
> Reviewed-by: Mike Christie <michael.christie@oracle.com>
> 

It took me some time to understand how workqueue works and make sure
it is safe to cancel it. So it is delayed between v3 and v4. Sorry
for that.

I think it is necessary to cancel delayed work as your suggestion.

Thanks,
Hou
