Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308CD53D98D
	for <lists+target-devel@lfdr.de>; Sun,  5 Jun 2022 06:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiFEEAG (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 5 Jun 2022 00:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiFEEAF (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 5 Jun 2022 00:00:05 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F44D9CF;
        Sat,  4 Jun 2022 21:00:04 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so10051131pjq.2;
        Sat, 04 Jun 2022 21:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u41z4fwr/UUMAFS3+mX3poOxe2IdRXrMg1LQj8AZaCg=;
        b=0Cuu3fFRlf7qhYADEVM5DoKMRWaV7eGws8X/NVCIqjVdNJQ7pKFMvHHtUgyZOqQs85
         Q0SErM/EHUO6qYpy/eCDVQRndLuHb5+9buRpiFGsgY009AMaoBDcqzyhEPC3W8jCgmyG
         hTNzn7JbUjXLp2465LF0/eMWxVPr3bjaMCa448ugt90egjp7KxQR5yr9W9MKNiI0HrBH
         N5K79KbVC8+9XJq45NVkpcKIBT3D64DoWgX/+xMKIoTD2xyUu1VycSINWqTxCppcGOOJ
         Hks1A9pCIhQFpJTVg2PkDsGlU1KP+cxG5UnYYNn/H8NXhYf0nSsgza2Np1rywytkFT+1
         FsAA==
X-Gm-Message-State: AOAM533GPEmDsleRZWrblFNPwJU+f7H+qqiwZkVavyf2L9s42oFVF7vE
        bJQW9x8rwEqAeukX1di2TlI=
X-Google-Smtp-Source: ABdhPJyHCNfBXsPFIEQqA+e98Z3husOOJOYqpQ8J70F7LC0WRuf++Ip/Fo/IX19u9k26r7v91fC7UQ==
X-Received: by 2002:a17:90a:7f94:b0:1cb:1853:da1b with SMTP id m20-20020a17090a7f9400b001cb1853da1bmr18988161pjl.14.1654401604166;
        Sat, 04 Jun 2022 21:00:04 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902d59100b0016242b71e9fsm7901182plh.158.2022.06.04.21.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 21:00:03 -0700 (PDT)
Message-ID: <c026fa1e-cca1-08c3-5d99-81ec79d8d343@acm.org>
Date:   Sat, 4 Jun 2022 21:00:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH 09/11] block, nvme: Add error for reservation
 conflicts.
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, hch@lst.de, axboe@kernel.dk,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20220603065536.5641-1-michael.christie@oracle.com>
 <20220603065536.5641-10-michael.christie@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220603065536.5641-10-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 6/2/22 23:55, Mike Christie wrote:
> BLK_STS_NEXUS is used for nvme/scsi reservation conflicts and also
> general nexus failures. For the pr_ops use we want to know if an IO failed
> for specifically a reservation conflict so we can report that error upwards
> to a VM. This patch adds a new error code for this case and converts nvme.
> The next patch converts scsi because it's a little more complicated.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   block/blk-core.c          | 1 +
>   drivers/nvme/host/core.c  | 2 +-
>   include/linux/blk_types.h | 4 ++++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bc0506772152..3908ac4a70b6 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -171,6 +171,7 @@ static const struct {
>   	/* zone device specific errors */
>   	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
>   	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
> +	[BLK_STS_RSV_CONFLICT]	= { -EBADE,	"resevation conflict" },
                                                  ^^^^^^^^^^

Please fix the spelling of "reservation".

Thanks,

Bart.
