Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA91A15D3
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 21:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDGTVV (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Apr 2020 15:21:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727797AbgDGTVI (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586287266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJyN+DD5cR12LYOWJ93Tcjz0xQA0tLc6a9l3K5zPfkM=;
        b=cgr/StbEjv1K2XMbqCLg9kVKwOopg1QG5ur8/KDf8x/KquZ1x1+2xXJcn1Z2+Mi1jlfayl
        foWnzV9x4zapQkAD/YFPD98aw85glwkGL8503YC7oBVYB7oFUmE51Cjb6foWJ6zGzwNMNF
        QloxxjFlG0T6Z5jlbCy0PSymKKPtflk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-8E_vrU3LM5SVe7rhaMLxoA-1; Tue, 07 Apr 2020 15:21:04 -0400
X-MC-Unique: 8E_vrU3LM5SVe7rhaMLxoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59FDDBA5;
        Tue,  7 Apr 2020 19:21:03 +0000 (UTC)
Received: from [10.10.113.202] (ovpn-113-202.rdu2.redhat.com [10.10.113.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4429F5DA7B;
        Tue,  7 Apr 2020 19:21:03 +0000 (UTC)
Subject: Re: [PATCH] target: pr: fix PR IN, READ FULL STATUS
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        target-devel@vger.kernel.org
References: <20200406182951.17446-1-bstroesser@ts.fujitsu.com>
 <5E8B99AC.2010303@redhat.com>
 <99574976-b040-11a1-c1f1-3a7958adb51a@ts.fujitsu.com>
 <5E8CBF28.7060301@redhat.com>
Cc:     martin.petersen@oracle.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E8CD29E.2050907@redhat.com>
Date:   Tue, 7 Apr 2020 14:21:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <5E8CBF28.7060301@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04/07/2020 12:58 PM, Mike Christie wrote:
> On 04/07/2020 09:59 AM, Bodo Stroesser wrote:
>> Hi Mike,
>>
>> On 04/06/20 23:05, Mike Christie wrote:
>>> On 04/06/2020 01:29 PM, Bodo Stroesser wrote:
>>>> AFAICS there are some problems in target_core_fabric_lib.c
>>>> that afflict PERSISTENT RESERVE IN / READ FULL STATUS command.
>>>>
>>>> 1) Creation of the response to READ FULL STATUS fails for FC
>>>>     based reservations. Reason is the too high loop limit (< 24)
>>>>     in fc_get_pr_transport_id(). The string representation of FC
>>>>     WWPN is 23 chars long only ("11:22:33:44:55:66:77:88"). So
>>>>     when i is 23, the loop body is executed a last time for the
>>>>     ending '\0' of the string and thus hex2bin() reports an error.
>>>>
>>>> 2) For iSCSI based reservations that include an ISID, the
>>>>     reported TRANSPORT ID is wrong. This has two reasons:
>>>>     a) The code inserts an NULL byte between the ISCSI Name and
>>>>        the SEPARATOR
>>>>     b) Only the first 6 chars of the ISID are appended. AFAIK,
>>>>        binary ISID is 48 bits, so 12 chars might be necessary.
>>>>
>>>> The last hunk in this patch fixes a minor flaw that could be
>>>> triggered by a PR OUT RESERVE on iSCSI, if TRANSPORT IDs with
>>>> and without ISID are used in the same command. I don't know, if
>>>> that ever could happen, but with the change the code is cleaner,
>>>> I think.
>>>>
>>>> This patch is based on code review only. It compiles fine, but
>>>> unfortunately I wasn't able to test.
>>>
>>> Your patch for #2 is still not going to work for iscsi, because there's
>>> lots of issue in that code. Offlist I sent you my patch for #2 and a
>>> hand full of other fixes in that code path.
>>
>> Thank you.
>>
>>>
>>> Let's sync them up, so we can test it all together.
>>
>> Ok.
>>
>>>
>>> - We should break out the first chunk for your issue #1, and the last
>>> chunk that sets port_nexus_ptr to NULL into separate patches.
>>
>> I did, will be sent soon. Meanwhile I was able to test chunk 1, works fine.
>>
>>>
>>> I tested the NULL ptr chunk with my patches and it works fine.
>>
>> Thank you.
>>
>>>
>>> - If you are ok with my patch for #2, I will post my patch for that and
>>> the other ones to the list. As you saw I have other fixes in the same
>>> lines of code and I fixed up the comments, so it would just be easier
>>> code conflict wise.
>>
>> One question:
>> why did you remove writing of the format code in byte 0 of buf?
>> Isn't that necessary?
> 
> That is a bug. I forgot to send a patch where it had
> core_scsi3_pri_read_full_status set it with the other common transport
> id value the proto id.
> 
> I will fix it when I send.
> 
> 
>>
>> Regarding the separator: instead of writing 5 single ASCII bytes as hex
>> values, wouldn't it be better to do:
>>     memcpy(&buf[off], ",i,0x", 5);
> 
> I think they just did it the way we have it, because they saw how it was
> worded in SPC and were trying to follow it exactly like how they saw it
> in there.
> 
> I think we can do that cleanup in a separate non-bug patch.
> 
>> In the beginning I thought, that using the hex values makes the code
>> independent from the host code. But there are many other places in the
>> code, where silently is assumed, that host code is ASCII.
>>
>> I'm not sure, whether it is a good idea to assume a fixed size of 12 hex
>> digits for the ISID string. I know, ISID is 48 bits, but if there are
>> leading 0s, is there anything in the spec, that disallows to shorten the
>> string?
> 
> There is nothing about drop leading 0s, but it does say to go by the
> null char and ignore the ADDITIONAL LENGTH field, so I think we could.
> However, I would be worried about initiators actually supporting it
> because it's not explicitly mentioned in the spec and so it seems like
> something we would mess up on the initiator side. On the target side we
> do not even handle when the isid is not 12 bytes (it looks like
> iscsi_parse_pr_out_transport_id is broken).
> 
> I would just do the safest and easiest approach like we have been. Just
> give it the full isid, because initiators have to always handle it. It's
> not like this a fast path, and dropping a couple bytes is going to help
> perf. On the other hand, you risk adding a regression.
> 
> But I think we should fix up the short isid handling on the target side
> in places like iscsi_parse_pr_out_transport_id, so we do not crash or
> read in bogus data.

Hey Bodo,

For this when I fix iscsi_parse_pr_out_transport_id I will make it so we
support whatever the initiator has sent us, so it should handle what you
requested.

