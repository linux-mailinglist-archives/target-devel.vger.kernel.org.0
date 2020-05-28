Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA91E6CE3
	for <lists+target-devel@lfdr.de>; Thu, 28 May 2020 22:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407348AbgE1Uxz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 28 May 2020 16:53:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46312 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407319AbgE1Uxy (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 28 May 2020 16:53:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SKCCr6062074;
        Thu, 28 May 2020 20:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QHiQmF731w2gPc8YvWOwn9LoaX5iqW2yMhIt158oZxc=;
 b=QbYo5iRYsDkrf1HyL16Yf/VULj7M5MBhXsqKHG7K46t+ab//ZYbAnb523ylx/twqHeS+
 zuh11toDh7SxaqDG1mDmbzX0VZvVKBvdLIcWFxsBsb6ycDoysBeJk/GSVD+Ph8R1rqu9
 oipvrQE6qIJhSw4XeV1ZteymDd58iCUbYJI1zBwODbPh6wYj3uNK17yta3lfFStY3Tj2
 TDrutgcAOrI3SWusZzO65rrBNJk/1HJfirqM45YO6s6YWYBql+Yjz0I27LQf7fR4jwIm
 w/1n09h7TYTxplYFsNREA+TwSo1HIxEC/M8j07Fx59Acy0qz+v2SvTdLOxXHLXcFNCRZ Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 318xe1q860-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 20:53:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SK8w3f177107;
        Thu, 28 May 2020 20:53:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 317ds38f6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 20:53:48 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04SKrl7X020612;
        Thu, 28 May 2020 20:53:47 GMT
Received: from [20.15.0.202] (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 13:53:47 -0700
Subject: Re: [PATCH] scsi: target: tcmu: fix size in calls to
 tcmu_flush_dcache_range
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20200528193108.9085-1-bstroesser@ts.fujitsu.com>
From:   Mike Christie <michael.christie@oracle.com>
Message-ID: <d13df4f2-edb5-3e13-8fd9-ddd5a80c809d@oracle.com>
Date:   Thu, 28 May 2020 15:53:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528193108.9085-1-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280132
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



On 5/28/20 2:31 PM, Bodo Stroesser wrote:
> 1) If remaining ring space before the end of the ring is
>     smaller then the next cmd to write, tcmu writes a padding
>     entry which fills the remaining space at the end of the
>     ring.
>     Then tcmu calls tcmu_flush_dcache_range() with the size
>     of struct tcmu_cmd_entry as data length to flush.
>     If the space filled by the padding was smaller then
>     tcmu_cmd_entry, tcmu_flush_dcache_range() is called for
>     an address range reaching behind the end of the vmalloc'ed
>     ring.
>     tcmu_flush_dcache_range() in a loop calls
>        flush_dcache_page(virt_to_page(start));
>     for every page being part of the range. On x86 the line is
>     optimized out by the compiler, as flush_dcache_page() is
>     empty on x86.
>     But I assume the above can cause trouble on other
>     architectures that really have a flush_dcache_page().
>     For paddings only the header part of an entry is relevant
>     Due to alignment rules the header always fits in the
>     remaining space, if padding is needed.
>     So tcmu_flush_dcache_range() can safely be called with
>     sizeof(entry->hdr) as the length here.
> 
> 2) After it has written a command to cmd ring, tcmu calls
>     tcmu_flush_dcache_range() using the size of a struct
>     tcmu_cmd_entry as data length to flush.
>     But if a command needs many iovecs, the real size of the
>     command may be bigger then tcmu_cmd_entry, so a part of
>     the written command is not flushed then.
> 
> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
> ---
>   drivers/target/target_core_user.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index f769bb1e3735..cdb4848d23c6 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -1026,7 +1026,7 @@ static int queue_cmd_ring(struct tcmu_cmd *tcmu_cmd, sense_reason_t *scsi_err)
>   		entry->hdr.cmd_id = 0; /* not used for PAD */
>   		entry->hdr.kflags = 0;
>   		entry->hdr.uflags = 0;
> -		tcmu_flush_dcache_range(entry, sizeof(*entry));
> +		tcmu_flush_dcache_range(entry, sizeof(entry->hdr));
>   
>   		UPDATE_HEAD(mb->cmd_head, pad_size, udev->cmdr_size);
>   		tcmu_flush_dcache_range(mb, sizeof(*mb));
> @@ -1084,7 +1084,7 @@ static int queue_cmd_ring(struct tcmu_cmd *tcmu_cmd, sense_reason_t *scsi_err)
>   	cdb_off = CMDR_OFF + cmd_head + base_command_size;
>   	memcpy((void *) mb + cdb_off, se_cmd->t_task_cdb, scsi_command_size(se_cmd->t_task_cdb));
>   	entry->req.cdb_off = cdb_off;
> -	tcmu_flush_dcache_range(entry, sizeof(*entry));
> +	tcmu_flush_dcache_range(entry, command_size);
>   
>   	UPDATE_HEAD(mb->cmd_head, command_size, udev->cmdr_size);
>   	tcmu_flush_dcache_range(mb, sizeof(*mb));
> 

Acked-by: Mike Christie <michael.christie@oracle.com>
