Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7751531FF91
	for <lists+target-devel@lfdr.de>; Fri, 19 Feb 2021 20:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBSTrR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 19 Feb 2021 14:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBSTrQ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:47:16 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D77AC061574;
        Fri, 19 Feb 2021 11:46:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bl23so15676778ejb.5;
        Fri, 19 Feb 2021 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Q+K9jHnpOaQNC9jhm6/BtGo2FCGVYeFqwWB2Nq7ax1s=;
        b=gxC7wWN0EaHKOFCiyRmiLPGOHDBJiBWGTE7wOpKucGzqXw3wFbf5aJAFqTtwgFu8K7
         9rq/+EuZVohEI4OrCUWemsxRpMxBG6U+F7F0lUmzAjIDCEMPJS+67tGOwrzERCwsQ0l/
         oM19ECmy0Cy/xyoPWE7OdvAYLUflOxnEJzF92UUnEUZZ9H4ZmRfG0T5ltWkLvLv9ptoJ
         JkmOXbmRnIK/8EmzHAVio0VjAWTXW46T1N41ifU+nD67FHL2+FSrda91P0eQmJPzYH5z
         AUfiu/U5zrqLyJGhsmS/w2Ru7anGTWeIfWrNVUGSB9muVpOSnq6kZ4YXrT6su6yI6cNB
         eVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+K9jHnpOaQNC9jhm6/BtGo2FCGVYeFqwWB2Nq7ax1s=;
        b=h9LMvfKDOhhT6GtbBs5d9r04HqpACyTspOKimqpmJ3KByELxlaCaS6iLx3SiHzcLNn
         s0s8zShez6GJe9PB8N5YMtSId6c4sSjqgsd2s8Uz087dcTJFkRztZa9wHTKV63pyCRCz
         j7Tnt44mLGGQYgVqUf3B/cAkkEuO24uEUDGNMXW4e15UdwCWnEMq6T/aFAln3/jE9QAO
         6juu9RI4Rv1ykohxi3k+owExhGoGvJpcSJBrHbIpKHY33/zSy6TsxriYbIsit8rDlb4v
         L3jVB6z5Dd20aQyTT2v5m8g/z0PIoV69f9YK1mpgyKf38/KRmsTESooezwC6sSYhAUFm
         M0/A==
X-Gm-Message-State: AOAM533Hf7RjfE8FUepn+TY3hEki2QujVIUh2LcqUlcplp2CKnPS6kiH
        HgkWYDD2c7Gw7qe40ZgZSycew2x4TAg=
X-Google-Smtp-Source: ABdhPJwyLa1X/qvLKpXF7IIjj7zTOZVlYcsr3ty7zzGZI0PGISykU0vWXZ6556bTzK/HzCpa7xYSAA==
X-Received: by 2002:a17:906:cf89:: with SMTP id um9mr10225786ejb.189.1613763995156;
        Fri, 19 Feb 2021 11:46:35 -0800 (PST)
Received: from [192.168.178.40] (ipbcc06d06.dynamic.kabel-deutschland.de. [188.192.109.6])
        by smtp.gmail.com with ESMTPSA id dk18sm5706138edb.92.2021.02.19.11.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 11:46:34 -0800 (PST)
Subject: Re: [PATCH 24/25] target: flush submission work during TMR processing
To:     Mike Christie <michael.christie@oracle.com>, mst@redhat.com,
        stefanha@redhat.com, Chaitanya.Kulkarni@wdc.com, hch@lst.de,
        loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20210217202811.5575-1-michael.christie@oracle.com>
 <20210217202811.5575-25-michael.christie@oracle.com>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <770b06d7-bc73-fb87-6ab0-61144b257e8a@gmail.com>
Date:   Fri, 19 Feb 2021 20:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217202811.5575-25-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 17.02.21 21:28, Mike Christie wrote:
> If a cmd is on the submission workqueue then the TMR code will
> miss it, and end up returning task not found or success for
> lun resets. The fabric driver might then tell the initiator that
> the running cmds have been handled when they are about to run.
> 
> This adds a flush when we are processing TMRs to make sure queued
> cmds do not run after returning the TMR response.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> ---
>   drivers/target/target_core_tmr.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
> index 7347285471fa..e7fcbc09f9db 100644
> --- a/drivers/target/target_core_tmr.c
> +++ b/drivers/target/target_core_tmr.c
> @@ -124,6 +124,8 @@ void core_tmr_abort_task(
>   	int i;
>   
>   	for (i = 0; i < dev->queue_cnt; i++) {
> +		flush_work(&dev->queues[i].sq.work);
> +
>   		spin_lock_irqsave(&dev->queues[i].lock, flags);
>   		list_for_each_entry_safe(se_cmd, next, &dev->queues[i].state_list,
>   					 state_list) {
> @@ -302,6 +304,8 @@ static void core_tmr_drain_state_list(
>   	 * in the Control Mode Page.
>   	 */
>   	for (i = 0; i < dev->queue_cnt; i++) {
> +		flush_work(&dev->queues[i].sq.work);
> +
>   		spin_lock_irqsave(&dev->queues[i].lock, flags);
>   		list_for_each_entry_safe(cmd, next, &dev->queues[i].state_list,
>   					 state_list) {
> 

Looks good.

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
