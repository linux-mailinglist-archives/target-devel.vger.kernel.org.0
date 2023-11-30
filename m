Return-Path: <target-devel+bounces-19-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005697FFD78
	for <lists+target-devel@lfdr.de>; Thu, 30 Nov 2023 22:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6114AB2106E
	for <lists+target-devel@lfdr.de>; Thu, 30 Nov 2023 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99553E08;
	Thu, 30 Nov 2023 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kTJ5AfD1"
X-Original-To: target-devel@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005610D1
	for <target-devel@vger.kernel.org>; Thu, 30 Nov 2023 13:25:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d045097b4cso6499565ad.0
        for <target-devel@vger.kernel.org>; Thu, 30 Nov 2023 13:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701379534; x=1701984334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a85qT15pDzdpel5gAuB/Pf8iqGvsBNG0rw6z7GTZ+18=;
        b=kTJ5AfD1oyJZ5xgrDlZ1wWqUF4X2MHy59XeBZO1G+MQvTgxp690SglGE2GDstdGNxg
         adSryWlfdXZXmcA+Xq4n6e72AH60lYqYhvQ9M2Yrk0L/l+j5hLVRCooCVPsv2Haepeix
         HcwReOShiQW2KJEaYHs7ojwRUXVahzvGbIRz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379534; x=1701984334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a85qT15pDzdpel5gAuB/Pf8iqGvsBNG0rw6z7GTZ+18=;
        b=WLGSINJG01fRHTOrtC+/Y9GHxxPBWRB2RdEZCRQrzBkjSaOfS3vbaHnomhsSUj9wsg
         GGivjiryilWcjJ3BMxPLa6cMOjSEerZeMgc5k24gGDryHjvw8iY5oOukfr4kFWdDS0xk
         ZNEpaokOLkkaKDjzVvF/4T1ShY5LOei4JFBGMz6vpOaxa4mxxT0yfk02Ja6YoBxNQ/jT
         yh45S7xm5Cq5K5ujyZz56R4N+9rxNAB07cbsF0Lm4PzOYcv1PjWCraALuUxUyYnd8cIX
         CBQizvMVN+eN7EDwmRY8mW0l6OLSka00ak7zfu8ADn+5AlmeOknbpjMcgRj9oDi8I3pu
         uPbA==
X-Gm-Message-State: AOJu0YynU38PSaEoDy+BHAfy2teh/TtVNY3Fnk142wMbq57EwjtdXbxf
	QNBH1+87rLJLcMBYdA4LIu18Lg==
X-Google-Smtp-Source: AGHT+IGiYA7iwc3ReI+OQGlKYslymufSwvsJah4H2gMq04CzpdkKFgR/kZAc5Za9Ltu7ai3/MUS0Yw==
X-Received: by 2002:a17:902:e88b:b0:1cf:d404:5e7c with SMTP id w11-20020a170902e88b00b001cfd4045e7cmr18459112plg.42.1701379534271;
        Thu, 30 Nov 2023 13:25:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b001cf7c07be50sm1869304plb.58.2023.11.30.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:25:33 -0800 (PST)
Date: Thu, 30 Nov 2023 13:25:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Michael Cyr <mikecyr@linux.ibm.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvscsi_tgt: replace deprecated strncpy with
 strscpy
Message-ID: <202311301315.BAB096926@keescook>
References: <20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v1-1-859b5ce257fd@google.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v1-1-859b5ce257fd@google.com>

On Mon, Oct 30, 2023 at 09:43:20PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We don't need the NUL-padding behavior that strncpy() provides as vscsi
> is NUL-allocated in ibmvscsis_probe() which proceeds to call
> ibmvscsis_adapter_info():
> |       vscsi = kzalloc(sizeof(*vscsi), GFP_KERNEL);
> 
> ibmvscsis_probe() -> ibmvscsis_handle_crq() -> ibmvscsis_parse_command()
> -> ibmvscsis_mad() -> ibmvscsis_process_mad() -> ibmvscsis_adapter_info()
> 
> Following the same idea, `partition_name` is defiend as:
> |       static char partition_name[PARTITION_NAMELEN] = "UNKNOWN";
> 
> ... which is NUL-padded already, meaning strscpy() is the best option.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.

My only worry here is that I don't see if %NUL termination is _required_
for these variables. (i.e. do we run the risk of truncating these by 1
byte if they're right at the limit?) Are they __nonstring?

I *think* they're %NUL terminated since they follow the same sizing as
the global "partition_name", but I'm not sure.

Can any of the SCSI authors comment on this?

> 
> However, for cap->name let's use strscpy_pad as cap is allocated via
> dma_alloc_coherent():
> |       cap = dma_alloc_coherent(&vscsi->dma_dev->dev, olen, &token,
> |                                GFP_ATOMIC);

This is also true for the "info" allocation (it comes out of DMA).

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> index 385f812b8793..cd223ef696e5 100644
> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> @@ -1551,17 +1551,17 @@ static long ibmvscsis_adapter_info(struct scsi_info *vscsi,
>  	if (vscsi->client_data.partition_number == 0)
>  		vscsi->client_data.partition_number =
>  			be32_to_cpu(info->partition_number);
> -	strncpy(vscsi->client_data.srp_version, info->srp_version,
> +	strscpy(vscsi->client_data.srp_version, info->srp_version,
>  		sizeof(vscsi->client_data.srp_version));
> -	strncpy(vscsi->client_data.partition_name, info->partition_name,
> +	strscpy(vscsi->client_data.partition_name, info->partition_name,
>  		sizeof(vscsi->client_data.partition_name));
>  	vscsi->client_data.mad_version = be32_to_cpu(info->mad_version);
>  	vscsi->client_data.os_type = be32_to_cpu(info->os_type);
>  
>  	/* Copy our info */
> -	strncpy(info->srp_version, SRP_VERSION,
> +	strscpy(info->srp_version, SRP_VERSION,
>  		sizeof(info->srp_version));
> -	strncpy(info->partition_name, vscsi->dds.partition_name,
> +	strscpy(info->partition_name, vscsi->dds.partition_name,
>  		sizeof(info->partition_name));

Since "info" is from DMA, let's use the _pad variant here just to be
safe.

>  	info->partition_number = cpu_to_be32(vscsi->dds.partition_num);
>  	info->mad_version = cpu_to_be32(MAD_VERSION_1);
> @@ -1645,8 +1645,8 @@ static int ibmvscsis_cap_mad(struct scsi_info *vscsi, struct iu_entry *iue)
>  			 be64_to_cpu(mad->buffer),
>  			 vscsi->dds.window[LOCAL].liobn, token);
>  	if (rc == H_SUCCESS) {
> -		strncpy(cap->name, dev_name(&vscsi->dma_dev->dev),
> -			SRP_MAX_LOC_LEN);
> +		strscpy_pad(cap->name, dev_name(&vscsi->dma_dev->dev),
> +			sizeof(cap->name));

And this is a safe conversion to sizeof():

struct capabilities {
	...
        char name[SRP_MAX_LOC_LEN];


If we can convince ourselves that non of these are __nonstring types,
then I think with the "info" change above, this should be good.

-Kees

-- 
Kees Cook

