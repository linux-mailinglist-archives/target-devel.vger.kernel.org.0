Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF524B688
	for <lists+target-devel@lfdr.de>; Thu, 20 Aug 2020 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgHTKgv (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 20 Aug 2020 06:36:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbgHTKgu (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:36:50 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4652C5DEAC01CB543DBB;
        Thu, 20 Aug 2020 18:36:45 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.35) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 18:36:36 +0800
Subject: Re: [PATCH] target:iscsi-target:Fix null pointer access while logout
 the iscsi session
To:     David Disseldorp <ddiss@suse.de>
CC:     <martin.petersen@oracle.com>, <michael.christie@oracle.com>,
        <bvanassche@acm.org>, <sudhakar.panneerselvam@oracle.com>,
        <mlombard@redhat.com>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
References: <1597749370-631500-1-git-send-email-wubo40@huawei.com>
 <20200818161125.359383ef@suse.de>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <49026bef-fb57-208d-c08c-cbdc3d166200@huawei.com>
Date:   Thu, 20 Aug 2020 18:36:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200818161125.359383ef@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.35]
X-CFilter-Loop: Reflected
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2020/8/18 22:11, David Disseldorp wrote:
> Hi,
> 
> On Tue, 18 Aug 2020 19:16:10 +0800, Wu Bo wrote:
> 
>> From: Wu Bo <wubo40@huawei.com>
>>
>> When I use fio to test the iscsi volumes and logout of the iscsi session
>> at the same time, the following crash occurs:
> 
> The change looks reasonable here, but I'd like get a reproducer for it.
> I've attempted something via:
> https://github.com/ddiss/libiscsi/tree/async_logout_during_write
> (run iscsi-test-cu --test iSCSI.iSCSITMF.LogoutDuringIOAsync)
> 
> Do you have any ideas why I'm not able to hit this oops?
> 
> Thanks, David
> 
> .
> 

Hi,

This is more difficult to reproduce it,
I found that the upstream already has a similar solution.

commit: e9d3009cb936bd0faf0719f68d98ad8afb1e613b
scsi: target: iscsi: Wait for all commands to finish before freeing a 
session.

Thanks, Wu Bo








