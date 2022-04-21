Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8417250951B
	for <lists+target-devel@lfdr.de>; Thu, 21 Apr 2022 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiDUCoE (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 20 Apr 2022 22:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUCoD (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:44:03 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A8B3E;
        Wed, 20 Apr 2022 19:41:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAcKenE_1650508871;
Received: from 30.225.28.170(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0VAcKenE_1650508871)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 10:41:12 +0800
Message-ID: <1c0ffbd6-7ab5-e598-b4f2-fd6e9b932204@linux.alibaba.com>
Date:   Thu, 21 Apr 2022 10:41:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v4] scsi: target: tcmu: Fix possible data corruption
Content-Language: en-US
To:     Bodo Stroesser <bostroesser@gmail.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20220417052604.120942-1-xiaoguang.wang@linux.alibaba.com>
 <5015edcc-0b62-4c1f-d4f4-ec0d7a1470d7@gmail.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <5015edcc-0b62-4c1f-d4f4-ec0d7a1470d7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

hi,

> Hi,
>
> just some remarks regarding the new comment.
>
> Bodo
>
> On 17.04.22 07:26, Xiaoguang Wang wrote:
>
> ... snip ...
>
>>   static const struct vm_operations_struct tcmu_vm_ops = {
>> @@ -3205,12 +3228,19 @@ static void find_free_blocks(void)
>>               udev->dbi_max = block;
>>           }
>>   +        /*
>> +         * Release the block pages.
>> +         * Also note that since tcmu_vma_fault() gets one extra page
>> +         * refcount, tcmu_blocks_release() won't free pages if pages
>> +         * are in page fault procedure, which means it's safe to
>
> s/in page fault procedure/mapped/
>
>> +         * call tcmu_blocks_release() before unmap_mapping_range().
>
> "... before unmap_mapping_range(), which drops the refcount of pages it
> unmaps and thus releases those pages."
>
> Please feel free to find an even better wording.
Yours seems better, just apply your suggestions.
I'm not a native english speaker :)

Regards,
Xiaoguang Wang
>
>> +         */
>> +        pages_freed = tcmu_blocks_release(udev, start, end - 1);
>> +
>>           /* Here will truncate the data area from off */
>>           off = udev->data_off + (loff_t)start * udev->data_blk_size;
>>           unmap_mapping_range(udev->inode->i_mapping, off, 0, 1);
>>   -        /* Release the block pages */
>> -        pages_freed = tcmu_blocks_release(udev, start, end - 1);
>>           mutex_unlock(&udev->cmdr_lock);
>>             total_pages_freed += pages_freed;

