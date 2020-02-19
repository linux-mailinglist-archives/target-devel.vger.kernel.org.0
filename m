Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7E164BF2
	for <lists+target-devel@lfdr.de>; Wed, 19 Feb 2020 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSRcU (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 19 Feb 2020 12:32:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35559 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSRcU (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:32:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id q39so360443pjc.0
        for <target-devel@vger.kernel.org>; Wed, 19 Feb 2020 09:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YAeTLbUkG04U2sTHtfn3yDn6PVvfLK819G1YWg+WRXU=;
        b=pT2TRw061WCcCTGFHtKhx4pvXvA1mJiZXg38jnokowUDD9AD+CLppzfmQm2jYkbwA4
         Vb+ubnA8jJTfluGe+ViZf6rGC8gLsfdvBFeQe5M80BiVCuKU2UPnOEncD3tKgmc6ojLn
         6itmCyiMu5tCar58iPt2JoLMGZ7XJDxQOxlDpmIwPE1QTNLYuevmG53MWeDoTGBmIwdK
         JsZfX6WDIF/sKaOvdHYhKn8hOm1kHwz6ZS2qXk4hJ7M1ViuHDJcPjKB0syH5CDqMwjaM
         1bvSpRA+duVeXtXb62OFVClmgKsjQEfUX1vAoIBjMbvuurYAvNmGYODPWXb/6/r3+X4m
         u1Wg==
X-Gm-Message-State: APjAAAVQ5NPxgnJ5gXlCPbNyyd7bKNa3o3PGrgURqxDJgcIQzTCF7QzZ
        Z6oGCHLrOqxltBuZceABPZs=
X-Google-Smtp-Source: APXvYqzsSfA0zdewZTZ89cNgyWoYUo86cu5YUjN02MmJkcQLTblylP0rZ6ETI0eC8mxvOyr4LMFfwg==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr9962762pjb.10.1582133539288;
        Wed, 19 Feb 2020 09:32:19 -0800 (PST)
Received: from ?IPv6:2620:15c:2d1:206:bfe1:be9c:5072:1789? ([2620:15c:2d1:206:bfe1:be9c:5072:1789])
        by smtp.gmail.com with ESMTPSA id q187sm202829pfq.185.2020.02.19.09.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 09:32:18 -0800 (PST)
Subject: Re: [PATCH v2 1/2] scsi: target: fix unmap_zeroes_data boolean
 initialisation
To:     David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com
References: <20200219130136.18946-1-ddiss@suse.de>
 <20200219130136.18946-2-ddiss@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3b7e0f30-3d75-779b-9c8e-67f227cedc96@acm.org>
Date:   Wed, 19 Feb 2020 09:32:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219130136.18946-2-ddiss@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2/19/20 5:01 AM, David Disseldorp wrote:
> The LIO unmap_zeroes_data device attribute is mapped to the LBPRZ flag
> in the READ CAPACITY (16) and Thin Provisioning VPD INQUIRY responses.
> 
> The unmap_zeroes_data attribute is exposed via configfs, where any write
> value is correctly validated via strtobool(). However, when initialised
> via target_configure_unmap_from_queue() it takes the value of the
> device's max_write_zeroes_sectors queue limit, which is non-boolean.
> 
> A non-boolean value can be read from configfs, but attempting to write
> the same value back results in -EINVAL, causing problems for configuration
> utilities such as targetcli.
> 
> Fixes: 2237498f0b5c ("target/iblock: Convert WRITE_SAME to blkdev_issue_zeroout")
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>   drivers/target/target_core_device.c | 2 +-
>   include/target/target_core_base.h   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
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
> diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
> index 1728e883b7b2..35188e64239e 100644
> --- a/include/target/target_core_base.h
> +++ b/include/target/target_core_base.h
> @@ -682,7 +682,7 @@ struct se_dev_attrib {
>   	int		force_pr_aptpl;
>   	int		is_nonrot;
>   	int		emulate_rest_reord;
> -	int		unmap_zeroes_data;
> +	bool		unmap_zeroes_data;
>   	u32		hw_block_size;
>   	u32		block_size;
>   	u32		hw_max_sectors;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
