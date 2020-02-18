Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0D162E45
	for <lists+target-devel@lfdr.de>; Tue, 18 Feb 2020 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgBRSSz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 18 Feb 2020 13:18:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41648 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgBRSSz (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:18:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so11326537pgf.8
        for <target-devel@vger.kernel.org>; Tue, 18 Feb 2020 10:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W8qANJcLy+Mf+aUnMJfTA4k9/ei9V44uT7l8mcq2MD8=;
        b=mQMqKGmbylQHYPdBXTQxHZ+eAArNIENZ5R3QkzDvHGntKGCmoVt+naElNaHlFVP1I/
         MoGzKY04lEDp3XHlPGNiIDSFQHIvi39vIiGHK+G8CtDKVhmlnshLWNGLXVZG8iZQ1UBt
         +86LBdCz/8A5cI14rWeEV2e6tz39fjFvR0mgH0c/eJAUVmMasKou1xoi2nMCiGFH3+9B
         CXggvZ9NCCdfO34QFiMHOvfZYP020KLeJS1VhNZzPhddOgG40RJZd9A8Kg2HWGGm4w5a
         UkY7HZHlGX6YZbWUxSgTUnDEvM/99KdUJMgbYFRURvLUTL5GAQpmQ388tVs31gyfCNrB
         dhnA==
X-Gm-Message-State: APjAAAUBcqpThiYj8jEq2ApgC5jjBoe7X1kHiflnUEyYOSVeHGtuEXVi
        tpWmW2b4eWuWsCvE4ICGn/c=
X-Google-Smtp-Source: APXvYqxzKKoe+gF39zEHbuo/fN8blS04Ycp2aVqDt6+jXsBZrQ7XaYTMLLNi8Njt4GXE+ZOEKVlC8Q==
X-Received: by 2002:a62:3603:: with SMTP id d3mr21499002pfa.37.1582049934380;
        Tue, 18 Feb 2020 10:18:54 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v7sm4890897pfn.61.2020.02.18.10.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:18:52 -0800 (PST)
Subject: Re: [PATCH] scsi: target: fix unmap_zeroes_data boolean
 initialisation
To:     David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com
References: <20200218180546.21313-1-ddiss@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9ae08fa6-ebfe-4488-df32-5d34122c68bd@acm.org>
Date:   Tue, 18 Feb 2020 10:18:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218180546.21313-1-ddiss@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2/18/20 10:05 AM, David Disseldorp wrote:
> The LIO unmap_zeroes_data device attribute is mapped to the LBPRZ flag in
> the READ CAPACITY (16) and Thin Provisioning VPD INQUIRY responses.
> It's exposed via configfs, where any write value is correctly validated
> via strtobool(), defaults to 0. However, when initialised via
> target_configure_unmap_from_queue() it takes the value of the device's
> max_write_zeroes_sectors queue limit, which is non-boolean.
> 
> Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>   drivers/target/target_core_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
> index 2d19f0e332b0..2c7ba2f7e13c 100644
> --- a/drivers/target/target_core_device.c
> +++ b/drivers/target/target_core_device.c
> @@ -829,7 +829,7 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
>   	attrib->unmap_granularity = q->limits.discard_granularity / block_size;
>   	attrib->unmap_granularity_alignment = q->limits.discard_alignment /
>   								block_size;
> -	attrib->unmap_zeroes_data = (q->limits.max_write_zeroes_sectors);
> +	attrib->unmap_zeroes_data = !!(q->limits.max_write_zeroes_sectors);
>   	return true;
>   }
>   EXPORT_SYMBOL(target_configure_unmap_from_queue);

Hi David,

How about changing the datatype of unmap_zeroes_data from 'int' into 
'bool'? I think that change would have the same effect as this patch and 
additionally would make it clear that 'true' and 'false' are the only 
allowed variables for that struct member.

Thanks,

Bart.


