Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6704DAE66
	for <lists+target-devel@lfdr.de>; Wed, 16 Mar 2022 11:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbiCPKod (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 16 Mar 2022 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiCPKoc (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:44:32 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B43913DF9;
        Wed, 16 Mar 2022 03:43:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V7Mc5x4_1647427395;
Received: from 30.225.28.170(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V7Mc5x4_1647427395)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 18:43:16 +0800
Message-ID: <c6a25258-6937-6cdf-0fab-081312c4dee6@linux.alibaba.com>
Date:   Wed, 16 Mar 2022 18:43:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] scsi: target: tcmu: Use
 address_space->invalidate_lock
Content-Language: en-US
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     bostroesser@gmail.com
References: <20220311132206.24515-1-xiaoguang.wang@linux.alibaba.com>
 <20220311132206.24515-2-xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <20220311132206.24515-2-xiaoguang.wang@linux.alibaba.com>
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

hello,

Gentle ping.

Regards,
Xiaoguang Wang

> Currently tcmu_vma_fault() uses udev->cmdr_lock to avoid concurrent
> find_free_blocks(), which unmaps idle pages and truncates them. This
> work is really like many filesystem's truncate operations, but they
> use address_space->invalidate_lock to protect race.
>
> This patch replaces cmdr_lock with address_space->invalidate_lock in
> tcmu fault procedure, which will also make page-fault have concurrency.
>
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> ---
>   drivers/target/target_core_user.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index 06a5c4086551..e0a62623ccd7 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -1815,13 +1815,14 @@ static int tcmu_find_mem_index(struct vm_area_struct *vma)
>   
>   static struct page *tcmu_try_get_data_page(struct tcmu_dev *udev, uint32_t dpi)
>   {
> +	struct address_space *mapping = udev->inode->i_mapping;
>   	struct page *page;
>   
> -	mutex_lock(&udev->cmdr_lock);
> +	filemap_invalidate_lock_shared(mapping);
>   	page = xa_load(&udev->data_pages, dpi);
>   	if (likely(page)) {
>   		get_page(page);
> -		mutex_unlock(&udev->cmdr_lock);
> +		filemap_invalidate_unlock_shared(mapping);
>   		return page;
>   	}
>   
> @@ -1831,7 +1832,7 @@ static struct page *tcmu_try_get_data_page(struct tcmu_dev *udev, uint32_t dpi)
>   	 */
>   	pr_err("Invalid addr to data page mapping (dpi %u) on device %s\n",
>   	       dpi, udev->name);
> -	mutex_unlock(&udev->cmdr_lock);
> +	filemap_invalidate_unlock_shared(mapping);
>   
>   	return NULL;
>   }
> @@ -3111,6 +3112,7 @@ static void find_free_blocks(void)
>   	loff_t off;
>   	u32 pages_freed, total_pages_freed = 0;
>   	u32 start, end, block, total_blocks_freed = 0;
> +	struct address_space *mapping;
>   
>   	if (atomic_read(&global_page_count) <= tcmu_global_max_pages)
>   		return;
> @@ -3134,6 +3136,7 @@ static void find_free_blocks(void)
>   			continue;
>   		}
>   
> +		mapping = udev->inode->i_mapping;
>   		end = udev->dbi_max + 1;
>   		block = find_last_bit(udev->data_bitmap, end);
>   		if (block == udev->dbi_max) {
> @@ -3152,12 +3155,14 @@ static void find_free_blocks(void)
>   			udev->dbi_max = block;
>   		}
>   
> +		filemap_invalidate_lock(mapping);
>   		/* Here will truncate the data area from off */
>   		off = udev->data_off + (loff_t)start * udev->data_blk_size;
> -		unmap_mapping_range(udev->inode->i_mapping, off, 0, 1);
> +		unmap_mapping_range(mapping, off, 0, 1);
>   
>   		/* Release the block pages */
>   		pages_freed = tcmu_blocks_release(udev, start, end - 1);
> +		filemap_invalidate_unlock(mapping);
>   		mutex_unlock(&udev->cmdr_lock);
>   
>   		total_pages_freed += pages_freed;

