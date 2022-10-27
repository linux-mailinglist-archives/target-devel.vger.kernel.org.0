Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A255060FBAD
	for <lists+target-devel@lfdr.de>; Thu, 27 Oct 2022 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiJ0PU6 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 27 Oct 2022 11:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiJ0PUW (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F846B1E6;
        Thu, 27 Oct 2022 08:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBB9DB826D5;
        Thu, 27 Oct 2022 15:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E0C433D6;
        Thu, 27 Oct 2022 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666883940;
        bh=AaMB8NCIdgfiIoB4P8i4ZrWBp77/MCyzpJ/dSGKMeOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAN11w8vbxAnZj57IiVap+TOoIA8UTFnyS6l8eUYeJ0zfh7jFKqk6ghlIv0uQ74VP
         6s+sJZw1FklPXoEaKYisv71ntr1NXakG1/ryanh2GOMtePJyEhRRCumLhESC77RuVp
         VomokqAkfVHDHNHBSX0zXTkh9+xtmSucWj9QlDNMJ+vBxBuYfioS5k4S3qbfdXsYBp
         XGukBNBFODPySgzjVvMq3YAlULS/RNvZM0jX30U9DuxmKqiGXKTuT/ayguaBDhmIOB
         GkOpSl7CVoeT0NI812xMCb9/3TTPA9u16Zu0sjgAb7IJPKlh3QXTZL4qmz9p83e7RG
         9q/Nk0QRDNidg==
Date:   Thu, 27 Oct 2022 09:18:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        target-devel@vger.kernel.org
Subject: Re: [PATCH v3 10/19] nvme: Move NVMe and Block PR types to an array
Message-ID: <Y1qhXQYOpEUk2uqF@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-11-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-11-michael.christie@oracle.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Oct 26, 2022 at 06:19:36PM -0500, Mike Christie wrote:
> For Reservation Report support we need to also convert from the NVMe spec
> PR type back to the block PR definition. This moves us to an array, so in
> the next patch we can add another helper to do the conversion without
> having to manage 2 switches.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/nvme/host/pr.c | 42 +++++++++++++++++++++++-------------------
>  include/linux/nvme.h   |  9 +++++++++
>  2 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> index df7eb2440c67..5c4611d15d9c 100644
> --- a/drivers/nvme/host/pr.c
> +++ b/drivers/nvme/host/pr.c
> @@ -6,24 +6,28 @@
>  
>  #include "nvme.h"
>  
> -static char nvme_pr_type(enum pr_type type)
> +static const struct {
> +	enum nvme_pr_type	nvme_type;
> +	enum pr_type		blk_type;
> +} nvme_pr_types[] = {
> +	{ NVME_PR_WRITE_EXCLUSIVE, PR_WRITE_EXCLUSIVE },
> +	{ NVME_PR_EXCLUSIVE_ACCESS, PR_EXCLUSIVE_ACCESS },
> +	{ NVME_PR_WRITE_EXCLUSIVE_REG_ONLY, PR_WRITE_EXCLUSIVE_REG_ONLY },
> +	{ NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY, PR_EXCLUSIVE_ACCESS_REG_ONLY },
> +	{ NVME_PR_WRITE_EXCLUSIVE_ALL_REGS, PR_WRITE_EXCLUSIVE_ALL_REGS },
> +	{ NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS, PR_EXCLUSIVE_ACCESS_ALL_REGS },
> +};

Wouldn't it be easier to use the block type as the array index to avoid
the whole looped lookup?

  enum nvme_pr_type types[] = {
	.PR_WRITE_EXCLUSIVE = NVME_PR_WRITE_EXCLUSIVE,
	.PR_EXCLUSIVE_ACCESS  = NVME_PR_EXCLUSIVE_ACCESS,
        ...
  };

?
