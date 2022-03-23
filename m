Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8497C4E53C0
	for <lists+target-devel@lfdr.de>; Wed, 23 Mar 2022 14:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbiCWOBQ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 23 Mar 2022 10:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbiCWOBN (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:01:13 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2108A7E0A7;
        Wed, 23 Mar 2022 06:59:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V80Be2u_1648043977;
Received: from 30.225.28.175(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V80Be2u_1648043977)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Mar 2022 21:59:38 +0800
Message-ID: <cfa0b9ae-6a4d-7482-8994-aec1f1cd45f3@linux.alibaba.com>
Date:   Wed, 23 Mar 2022 21:59:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC 2/3] mm: export zap_page_range()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     linux-block@vger.kernel.org, xuyu@linux.alibaba.com,
        bostroesser@gmail.com
References: <20220318095531.15479-1-xiaoguang.wang@linux.alibaba.com>
 <20220318095531.15479-3-xiaoguang.wang@linux.alibaba.com>
 <a37e9ba2-354b-0b75-cb05-bc730cb30151@redhat.com>
 <37d6b269-dd9d-dbd1-74b1-4191cc3d4bf9@linux.alibaba.com>
 <019a2159-57d6-c330-53c5-38458b6b5ec9@redhat.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <019a2159-57d6-c330-53c5-38458b6b5ec9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

hi,

> On 22.03.22 14:02, Xiaoguang Wang wrote:
>> hi,
>>
>>> On 18.03.22 10:55, Xiaoguang Wang wrote:
>>>> Module target_core_user will use it to implement zero copy feature.
>>>>
>>>> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/memory.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 1f745e4d11c2..9974d0406dad 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -1664,6 +1664,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>>>>    	mmu_notifier_invalidate_range_end(&range);
>>>>    	tlb_finish_mmu(&tlb);
>>>>    }
>>>> +EXPORT_SYMBOL_GPL(zap_page_range);
>>>>    
>>>>    /**
>>>>     * zap_page_range_single - remove user pages in a given range
>>> To which VMAs will you be applying zap_page_range? I assume only to some
>>> special ones where you previously vm_insert_page(s)_mkspecial'ed pages,
>>> not to some otherwise random VMAs, correct?
>> Yes, you're right :)
> I'd suggest exposing a dedicated function that performs sanity checks on
> the vma (VM_PFNMAP ?) and only zaps within a single VMA.
>
> Essentially zap_page_range_single(), excluding "struct zap_details
> *details" and including sanity checks.
>
> Reason is that we don't want anybody to blindly zap_page_range() within
> random VMAs from a kernel module.
OK, I see, thanks. Xu Yu and I will try to implement a new helper in 
following new version patches.

Regards,
Xiaoguang Wang
>

