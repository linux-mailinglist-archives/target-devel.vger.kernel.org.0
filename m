Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932DD36FC67
	for <lists+target-devel@lfdr.de>; Fri, 30 Apr 2021 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhD3OaE (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 30 Apr 2021 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhD3OaD (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:30:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34619C06174A;
        Fri, 30 Apr 2021 07:29:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y26so3242619eds.4;
        Fri, 30 Apr 2021 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lkzMRDz3EKi3qa9HUgoov0nFfmSvHU5WWdnRd2PhEfY=;
        b=Djek82IazPreK1nAfG7GyGE8CUKxRqOVvi0sX6P9Hki4Sdbox5lbWVWM8phK/zx8/E
         OA0mdloRD+8T6tARQ3cAieaThw7Ww2/vBYoUiwuyt24htWijgxFoNJ9QK3qbgb/hjKa8
         UkQJwAeJg9OlkvxpbIesRVHN5nIIZmgguDgTmHJY/FBp/8l3++32riFNcFlQJW/YFfTF
         ATBKorPWiOWguRvbKrojZZHwLg8rhCD2GcrgdLNm2ovwlOqL+pgRNgMf0ZqQWkaZupZQ
         n87N/3/5iPBXynK/k988PtaN9lViIq2DW3AGQn0ZrIeYiUkqHj6S/y2BYxmzitOjj/+X
         CKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lkzMRDz3EKi3qa9HUgoov0nFfmSvHU5WWdnRd2PhEfY=;
        b=QbJclMcxfXWCn+mH/BXqM607nMlr5xaTealB/qqVRbWZXT552nW48bnbtPSH42lW8v
         Wi6JfyTQyDfmtuGcvE/JSgi+M2iWlLtdVs0cFBLiRiWvq7xdg/LdfETD2C39FQQDYeIg
         MheVG5Jf+Z585suy78VMy1HZHw9+Fw6y7QE6xhnv3dzkTTWLF8YaItRlGtLBFhIsnJpM
         CeWDUjgkEryH8NEKjEH2+0pgsAQ2dBjwq26S7APmj1Hzkd7PCGim8IWhcSUq6GmJw+fI
         HxIH9+FAPIIBle/iQ2bzHzRpXN7254mcgGmivavbb+xw6swZDJftZ0ZJZqlMpX0yNh6X
         7OSQ==
X-Gm-Message-State: AOAM531l4rPjClF8qejmf/vFBKL7N/3zRIyK7Oosc+G3VJMh6zqKo1Xk
        VTv+Mpu2fz4ATqnPwhUvF8jFSxObRsQ=
X-Google-Smtp-Source: ABdhPJyK6nisePrI1zhyReqfVdYYFwPRp5NNscbrAQ2ojGDNZdbHyjLPoxaXyaLnj7FAJt/MdPRmkg==
X-Received: by 2002:a05:6402:4d1:: with SMTP id n17mr6231689edw.118.1619792952913;
        Fri, 30 Apr 2021 07:29:12 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc11466.dynamic.kabel-deutschland.de. [188.193.20.102])
        by smtp.gmail.com with ESMTPSA id p4sm2064792ejr.81.2021.04.30.07.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 07:29:12 -0700 (PDT)
Subject: Re: [PATCH] scsi: target: configfs: Remove redundant assignment to
 ret
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1619774627-118766-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <69ef77bd-4ef8-6446-8192-6d8569516f33@gmail.com>
Date:   Fri, 30 Apr 2021 16:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1619774627-118766-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 30.04.21 11:23, Jiapeng Chong wrote:
> Variable ret is set to '-EINVAL' but this value is never read as it is
> overwritten later on, hence it is a redundant assignment and can be
> removed.
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/target/target_core_configfs.c:2037:5: warning: Value stored to
> 'ret' is never read [clang-analyzer-deadcode.DeadStores].
> 
> drivers/target/target_core_configfs.c:1973:5: warning: Value stored to
> 'ret' is never read [clang-analyzer-deadcode.DeadStores].
> 
> drivers/target/target_core_configfs.c:1959:5: warning: Value stored to
> 'ret' is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/target/target_core_configfs.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index 4b2e493..bda05c3 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1956,7 +1956,6 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
>   				pr_err("APTPL metadata initiator_node="
>   					" exceeds PR_APTPL_MAX_IPORT_LEN: %d\n",
>   					PR_APTPL_MAX_IPORT_LEN);
> -				ret = -EINVAL;
>   				break;
>   			}
>   			break;
> @@ -1970,7 +1969,6 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
>   				pr_err("APTPL metadata initiator_isid"
>   					"= exceeds PR_REG_ISID_LEN: %d\n",
>   					PR_REG_ISID_LEN);
> -				ret = -EINVAL;
>   				break;
>   			}
>   			break;
> @@ -2034,7 +2032,6 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
>   				pr_err("APTPL metadata target_node="
>   					" exceeds PR_APTPL_MAX_TPORT_LEN: %d\n",
>   					PR_APTPL_MAX_TPORT_LEN);
> -				ret = -EINVAL;
>   				break;
>   			}
>   			break;
> 

I don't think storing -EINVAL in ret is wrong. But maybe the "break" in
the next line should better be "goto out"?

AFAICS, the "break" finally leads to calling
core_scsi3_alloc_aptpl_registration () despite a too long string in
i_port, isid or t_port. Is this behaviour intentional?

BTW: why is "initiator_sid" input handled as string?
core_scsi3_alloc_aptpl_registration later calls get_unaligned_be64 for
that string. I don't think this makes sense.

Finally, I think there is a possible memory leak. If the input written
to res_aptpl_metadata for example contains "initiator_sid=xxxxx" more
than once, a previously created string isid ("isid = match_strdup(args)")
is not freed before it is overwritten in the loop. The same is true for
all tokens handled with match_strdup.
