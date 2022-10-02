Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F05F2565
	for <lists+target-devel@lfdr.de>; Sun,  2 Oct 2022 23:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJBVJe (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 2 Oct 2022 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJBVJd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:09:33 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C372CDE3;
        Sun,  2 Oct 2022 14:09:29 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so13647403pjs.1;
        Sun, 02 Oct 2022 14:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yRg2sTrGFqd5rOCQ5l3Q1GlwU0+m+16wi/XdK3UzFOI=;
        b=fwPr3cE+QYseLCb6fFAdIK8RCNaNaQcJBNEZpNutpNJJ7vRTCB0HBkBambQTEKCrp6
         ixIMFlrlnbuONipbZwgOVbLUGhTJLXYfyBzksopL+hU4gA3zhk9Ga270Dm1Tkt8EM1fq
         C+2zIi0gwHVioNL+T4YUrK724Tn3812LDcdLavvMcodH8ed1gh7bQnPB88UORMPBBZcT
         a58HZqXH73ynH2OSzgmFMHtqOpec5lysb0wcRU8V77hBREbeiyVTLPCtCG1atuCZbORi
         xX60wTFKGGIFHzIkRUTFFUaip+Jh+vQeaq2/B3+0/7RzbdpjmHvm+CDwQCh0JzjH5p3t
         bTnQ==
X-Gm-Message-State: ACrzQf31yOXMTy29B59Rd/DAc2h+5mzUhIS7hXgjfTkWpzagrFl4Oiei
        j3cnMjurVeIfdm8AJL5C6GaiJw/nsxE=
X-Google-Smtp-Source: AMsMyM5sl/kpsXmFK15LAYvujbUKvHjY9dj2k80Oai9vzmze1neL1ch5LF8ICs+1LLqL6fdQl/Hlhw==
X-Received: by 2002:a17:90a:de8b:b0:20a:730d:2bf with SMTP id n11-20020a17090ade8b00b0020a730d02bfmr8098501pjv.181.1664744968492;
        Sun, 02 Oct 2022 14:09:28 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id g24-20020a63dd58000000b004393c5a8006sm3262088pgj.75.2022.10.02.14.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 14:09:27 -0700 (PDT)
Message-ID: <fde47e5e-119a-54ca-7cf6-5b58552ee2b3@acm.org>
Date:   Sun, 2 Oct 2022 14:09:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] tcm_loop: Increase maximum request size
Content-Language: en-US
To:     Nikos Tsironis <ntsironis@arrikto.com>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20220929115504.23806-1-ntsironis@arrikto.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220929115504.23806-1-ntsironis@arrikto.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 9/29/22 04:55, Nikos Tsironis wrote:
> Increase the maximum request size for tcm_loop, by setting sg_tablesize
> to SG_MAX_SEGMENTS.
> 
> The current value of 256 for sg_tablesize limits the request size to
> PAGE_SIZE * 256, which for 4K pages is 1MiB.
> 
> Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
> ---
>   drivers/target/loopback/tcm_loop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
> index 4407b56aa6d1..6d7c3ebd8613 100644
> --- a/drivers/target/loopback/tcm_loop.c
> +++ b/drivers/target/loopback/tcm_loop.c
> @@ -308,7 +308,7 @@ static struct scsi_host_template tcm_loop_driver_template = {
>   	.eh_device_reset_handler = tcm_loop_device_reset,
>   	.eh_target_reset_handler = tcm_loop_target_reset,
>   	.this_id		= -1,
> -	.sg_tablesize		= 256,
> +	.sg_tablesize		= SG_MAX_SEGMENTS,
>   	.max_sectors		= 0xFFFF,
>   	.dma_boundary		= PAGE_SIZE - 1,
>   	.module			= THIS_MODULE,

There is more that can be improved for this driver, namely removal of 
the dma_boundary parameter and increasing max_sectors.

Thanks,

Bart.
