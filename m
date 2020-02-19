Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A16164C12
	for <lists+target-devel@lfdr.de>; Wed, 19 Feb 2020 18:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgBSRhv (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 19 Feb 2020 12:37:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46491 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSRhv (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:37:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id k29so391097pfp.13
        for <target-devel@vger.kernel.org>; Wed, 19 Feb 2020 09:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSztaqz47cQI+rfuq/VGek2utew7Q+dUjOwQVQ2olJc=;
        b=FpuCMyxbaEcH5zsJ3V8EF7Wy3s/BszXuE2oWs0LxmpwsnbxmVAz8UKgUF/4XGlxlL/
         CUB5wBeIdwHfrt1ed5PR7Y6/T3oENy5SH3CLPeDD0kQGTpUQEei3xDJsROFDT+XCK4SA
         Hc2R2PQFJ14obvpWxPCbBgz55bvUTty/T42w9uEtbbj+aIVLy88X6wsKWCuNVd7CZ4t5
         vjJccQCvKid/k5vYvOfGG+ilc0hGGxnAESnedOohVekNwOw5fXydAgDh5oBmUCjHGhaa
         5SdV9u1V25ER8QNciGEJsxCWbUajzbYDra/A/nPXPOWcyENjzJVBjViuv2EUZiTkx18M
         sF/Q==
X-Gm-Message-State: APjAAAV35sCqNYmf80OBeH25HUN2vR398arJvd97sKUK3KHSpGJTSkYM
        QzudCE8ihFfyUNt4sEE16uE=
X-Google-Smtp-Source: APXvYqwI9o41qdSNjJk+X//7KVmokxoGzscvnZHNdXvKuj8cHkoMCi3tBdc1kps5MMHLquFpDmcfrg==
X-Received: by 2002:a62:b604:: with SMTP id j4mr9372530pff.93.1582133870250;
        Wed, 19 Feb 2020 09:37:50 -0800 (PST)
Received: from ?IPv6:2620:15c:2d1:206:bfe1:be9c:5072:1789? ([2620:15c:2d1:206:bfe1:be9c:5072:1789])
        by smtp.gmail.com with ESMTPSA id o29sm221082pfp.124.2020.02.19.09.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 09:37:49 -0800 (PST)
Subject: Re: [PATCH v2 2/2] scsi: target: convert boolean se_dev_attrib types
 to bool
To:     David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com
References: <20200219130136.18946-1-ddiss@suse.de>
 <20200219130136.18946-3-ddiss@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b68f71dc-a0df-dfdf-2790-6e4d3ced075a@acm.org>
Date:   Wed, 19 Feb 2020 09:37:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219130136.18946-3-ddiss@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2/19/20 5:01 AM, David Disseldorp wrote:
>   struct se_dev_attrib {
> -	int		emulate_model_alias;
> -	int		emulate_dpo;
> -	int		emulate_fua_write;
> -	int		emulate_fua_read;
> -	int		emulate_write_cache;
> +	bool		emulate_model_alias;
> +	bool		emulate_dpo;		/* deprecated */
> +	bool		emulate_fua_write;
> +	bool		emulate_fua_read;	/* deprecated */
> +	bool		emulate_write_cache;
>   	int		emulate_ua_intlck_ctrl;
> -	int		emulate_tas;
> -	int		emulate_tpu;
> -	int		emulate_tpws;
> -	int		emulate_caw;
> -	int		emulate_3pc;
> -	int		emulate_pr;
> +	bool		emulate_tas;
> +	bool		emulate_tpu;
> +	bool		emulate_tpws;
> +	bool		emulate_caw;
> +	bool		emulate_3pc;
> +	bool		emulate_pr;
>   	enum target_prot_type pi_prot_type;
>   	enum target_prot_type hw_pi_prot_type;
> -	int		pi_prot_verify;
> -	int		enforce_pr_isids;
> -	int		force_pr_aptpl;
> -	int		is_nonrot;
> -	int		emulate_rest_reord;
> +	bool		pi_prot_verify;
> +	bool		enforce_pr_isids;
> +	bool		force_pr_aptpl;
> +	bool		is_nonrot;
> +	bool		emulate_rest_reord;
>   	bool		unmap_zeroes_data;
>   	u32		hw_block_size;
>   	u32		block_size;

How about introducing an enum type for emulate_ua_intlck_ctrl? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
