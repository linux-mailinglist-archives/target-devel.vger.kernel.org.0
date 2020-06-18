Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE901FF60D
	for <lists+target-devel@lfdr.de>; Thu, 18 Jun 2020 17:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgFRPCx (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 18 Jun 2020 11:02:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFRPCx (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:02:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IEvInL016116;
        Thu, 18 Jun 2020 15:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TnflwDdart9A5pX7oW6y8eCz/jZi03g2hO4oDxswQ3g=;
 b=BqBqQakTDHx7XbdvZDjiYjZR3Q3rbmMfMosNM6jViubqP4VtFlZ8s2Q98K+IXtnsur/2
 FbY1VaDI/jV3OM0rXIUlxsDmhVWGRccgDZVTyLVIA9OT7EGaKmJwW6i4dy+q65IsUIqo
 aiJvjaNDEgo6gcWg+xW/gXzgE59KlIWFjVMsT4Sv4rwM50sIpQ2MB6Av9AHqVbvFr3cI
 iu57IEoIySKVPSzVulHrfILLG00jEmLoHFzqbsGvUQTEPGsrS7fqDy0fzuWW1CIJG3fq
 J7YRbYCkMhmbeAO43yV0PPQFjtOUaO2IOfHgsc2p4Jz/5XaEJZHWpGbmPUDN1r/qAKS6 Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31qecm09sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 15:02:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IExGhR052933;
        Thu, 18 Jun 2020 15:00:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31q66sew56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 15:00:42 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05IF0gIp006390;
        Thu, 18 Jun 2020 15:00:42 GMT
Received: from [20.15.0.202] (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jun 2020 08:00:42 -0700
Subject: Re: [PATCH 2/2 v2] scsi: target: tcmu: Fix crash in
 tcmu_flush_dcache_range on ARM
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     JiangYu <lnsyyj@hotmail.com>, Daniel Meyerholt <dxm523@gmail.com>
References: <20200618131632.32748-1-bstroesser@ts.fujitsu.com>
 <20200618131632.32748-3-bstroesser@ts.fujitsu.com>
From:   Mike Christie <michael.christie@oracle.com>
Message-ID: <5e4be724-bd54-3a4d-e0d4-8c60910b0c0a@oracle.com>
Date:   Thu, 18 Jun 2020 10:00:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618131632.32748-3-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 malwarescore=0
 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180113
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 6/18/20 8:16 AM, Bodo Stroesser wrote:
> This patch fixes the following crash
> (see https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id=208045__;!!GqivPVa7Brio!O7JgZIL3VPAzIqwJfZjL48y8M90K3HXv3pUVeoCzZ-vXovCpx5g7xMg-z5aAiVXVtkfE$ )
> 
>   Process iscsi_trx (pid: 7496, stack limit = 0x0000000010dd111a)
>   CPU: 0 PID: 7496 Comm: iscsi_trx Not tainted 4.19.118-0419118-generic
>          #202004230533
>   Hardware name: Greatwall QingTian DF720/F601, BIOS 601FBE20 Sep 26 2019
>   pstate: 80400005 (Nzcv daif +PAN -UAO)
>   pc : flush_dcache_page+0x18/0x40
>   lr : is_ring_space_avail+0x68/0x2f8 [target_core_user]
>   sp : ffff000015123a80
>   x29: ffff000015123a80 x28: 0000000000000000
>   x27: 0000000000001000 x26: ffff000023ea5000
>   x25: ffffcfa25bbe08b8 x24: 0000000000000078
>   x23: ffff7e0000000000 x22: ffff000023ea5001
>   x21: ffffcfa24b79c000 x20: 0000000000000fff
>   x19: ffff7e00008fa940 x18: 0000000000000000
>   x17: 0000000000000000 x16: ffff2d047e709138
>   x15: 0000000000000000 x14: 0000000000000000
>   x13: 0000000000000000 x12: ffff2d047fbd0a40
>   x11: 0000000000000000 x10: 0000000000000030
>   x9 : 0000000000000000 x8 : ffffc9a254820a00
>   x7 : 00000000000013b0 x6 : 000000000000003f
>   x5 : 0000000000000040 x4 : ffffcfa25bbe08e8
>   x3 : 0000000000001000 x2 : 0000000000000078
>   x1 : ffffcfa25bbe08b8 x0 : ffff2d040bc88a18
>   Call trace:
>    flush_dcache_page+0x18/0x40
>    is_ring_space_avail+0x68/0x2f8 [target_core_user]
>    queue_cmd_ring+0x1f8/0x680 [target_core_user]
>    tcmu_queue_cmd+0xe4/0x158 [target_core_user]
>    __target_execute_cmd+0x30/0xf0 [target_core_mod]
>    target_execute_cmd+0x294/0x390 [target_core_mod]
>    transport_generic_new_cmd+0x1e8/0x358 [target_core_mod]
>    transport_handle_cdb_direct+0x50/0xb0 [target_core_mod]
>    iscsit_execute_cmd+0x2b4/0x350 [iscsi_target_mod]
>    iscsit_sequence_cmd+0xd8/0x1d8 [iscsi_target_mod]
>    iscsit_process_scsi_cmd+0xac/0xf8 [iscsi_target_mod]
>    iscsit_get_rx_pdu+0x404/0xd00 [iscsi_target_mod]
>    iscsi_target_rx_thread+0xb8/0x130 [iscsi_target_mod]
>    kthread+0x130/0x138
>    ret_from_fork+0x10/0x18
>   Code: f9000bf3 aa0003f3 aa1e03e0 d503201f (f9400260)
>   ---[ end trace 1e451c73f4266776 ]---
> 
> The solution is based on patch:
> 
>    "scsi: target: tcmu: Optimize use of flush_dcache_page"
> 
> which restricts the use of tcmu_flush_dcache_range() to
> addresses from vmalloc'ed areas only.
> 
> This patch now replaces the virt_to_page() call in
> tcmu_flush_dcache_range() - which is wrong for vmalloced addrs -
> by vmalloc_to_page().
> 
> The patch was tested on ARM with kernel 4.19.118 and 5.7.2
> 
> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
> Tested-by: JiangYu <lnsyyj@hotmail.com>
> Tested-by: Daniel Meyerholt <dxm523@gmail.com>
> ---
>   drivers/target/target_core_user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index a65e9671ae7a..835d3001cb0e 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -601,7 +601,7 @@ static inline void tcmu_flush_dcache_range(void *vaddr, size_t size)
>   	size = round_up(size+offset, PAGE_SIZE);
>   
>   	while (size) {
> -		flush_dcache_page(virt_to_page(start));
> +		flush_dcache_page(vmalloc_to_page(start));
>   		start += PAGE_SIZE;
>   		size -= PAGE_SIZE;
>   	}

For this bug we only need to change the flush in is_ring_space_avail 
right? It's what is accessing the mb which is vmalloc'd.

Is it reccommended to call vmalloc_to_page on a page we get with 
alloc_page and is the mm then always going to do the right thing for us 
(I do not know the mm code well and just quickly scanned the 
Documentation and comments, but could not find anything), or could we 
hit similar issues where we are using the wrong call on different types 
of allocated memory down the line?
