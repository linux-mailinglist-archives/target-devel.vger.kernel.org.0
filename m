Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F144D2A8C
	for <lists+target-devel@lfdr.de>; Wed,  9 Mar 2022 09:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiCIIVv (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 9 Mar 2022 03:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiCIIVv (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:21:51 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004CD5C677
        for <target-devel@vger.kernel.org>; Wed,  9 Mar 2022 00:20:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0V6iM1PF_1646814050;
Received: from 30.225.28.191(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V6iM1PF_1646814050)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Mar 2022 16:20:50 +0800
Message-ID: <95823aae-28fd-f078-e358-b02e05f40935@linux.alibaba.com>
Date:   Wed, 9 Mar 2022 16:20:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Content-Language: en-US
To:     Bodo Stroesser <bostroesser@gmail.com>
Cc:     target-devel@vger.kernel.org
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: code question about tcmu_try_get_data_page()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

hi Bodo,

I have implemented a zero-copy prototype for tcmu(not sent out yet), it 
reallys
improves throughput in large io size cases, and I met some code question 
that
may need you kind help, thanks in advance. In my prototype, I choose to
unmap pages in tcmu_irqcontrol():
==> tcmu_irqcontrol, which holds cmdr_lock.
====> tcmu_handle_completions
======> tcmu_handle_completion
========> zap_page_range, which needs to hold mm related lock.

But in page fault procedure:
==> tcmu_vma_fault, which I think its caller hold mm related lock.
====> tcmu_try_get_data_page, which tries to hold cmdr_lock.

Then dead lock may happens. In tcmu_try_get_data_page(),
it mainly acts like below:
         mutex_lock(&udev->cmdr_lock);
         page = xa_load(&udev->data_pages, dpi);
         if (likely(page)) {
                 mutex_unlock(&udev->cmdr_lock);
                 return page;
         }

         /*
          * Userspace messed up and passed in a address not in the
          * data iov passed to it.
          */
         pr_err("Invalid addr to data page mapping (dpi %u) on device %s\n",
                dpi, udev->name);
         mutex_unlock(&udev->cmdr_lock);

I wonder do we really need to hold cmdr_lock here, seems it doesn't
protect any real resources. If cmdr_lock here is used to avoid concurrent
xa_erase(), after releasing cmdr_lock, page still can be removed.
So my question is that can we safely remove this cmdr_lock here? thanks.


Regards,
Xiaoguang Wang
