Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011191A3730
	for <lists+target-devel@lfdr.de>; Thu,  9 Apr 2020 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgDIP3y (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 9 Apr 2020 11:29:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44342 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728020AbgDIP3y (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586446193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHR+7wyWWQMKIj4iUOLklaqH1aeuxWR6fSfkpRk+srU=;
        b=S9MTyEc1ikPWE3EF12icOYsUTsyEa8xa9+fihPStcugjeV037R86GyAkFYjNfssGstshH6
        Rew2wnbgQ7otvX8/QxwiCBJRzfCAKD9hBH8DAPUkZGPYLI+J3wuIQzwNzGSC6WdvXbhAUF
        CAokWJPgMAOhetyG4CH/X3Av1MnsKlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-rA33jaIwMYiXjkqrHk8zvA-1; Thu, 09 Apr 2020 11:29:49 -0400
X-MC-Unique: rA33jaIwMYiXjkqrHk8zvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 490B5107ACCC;
        Thu,  9 Apr 2020 15:29:48 +0000 (UTC)
Received: from [10.10.117.7] (ovpn-117-7.rdu2.redhat.com [10.10.117.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4ACB272CC;
        Thu,  9 Apr 2020 15:29:47 +0000 (UTC)
Subject: Re: [PATCH] target: tcmu: reset_ring should reset TCMU_DEV_BIT_BROKEN
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200409101026.17872-1-bstroesser@ts.fujitsu.com>
Cc:     martin.petersen@oracle.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E8F3F6B.3020408@redhat.com>
Date:   Thu, 9 Apr 2020 10:29:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20200409101026.17872-1-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04/09/2020 05:10 AM, Bodo Stroesser wrote:
> In case command ring buffer becomes inconsistent, tcmu
> sets device flag TCMU_DEV_BIT_BROKEN.
> If the bit is set, tcmu rejects new commands from lio core
> with TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE, and no longer
> processes completions from the ring.
> The reset_ring attribute can be used to completely clean up
> the command ring, so after reset_ring the ring no longer is
> inconsistent.
> 
> Therefore reset_ring also should reset bit TCMU_DEV_BIT_BROKEN
> to allow normal processing.
> 
> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
> ---
>  drivers/target/target_core_user.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index 0b9dfa6b17bc..f769bb1e3735 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -2073,6 +2073,7 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
>  	mb->cmd_tail = 0;
>  	mb->cmd_head = 0;
>  	tcmu_flush_dcache_range(mb, sizeof(*mb));
> +	clear_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
>  
>  	del_timer(&udev->cmd_timer);
>  
> 

Acked-by: Mike Christie <mchristi@redhat.com>

