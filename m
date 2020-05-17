Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8537B1D6E1A
	for <lists+target-devel@lfdr.de>; Mon, 18 May 2020 01:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgEQXjg (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 17 May 2020 19:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgEQXjf (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 17 May 2020 19:39:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703F5C05BD0A
        for <target-devel@vger.kernel.org>; Sun, 17 May 2020 16:39:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v4so6741577qte.3
        for <target-devel@vger.kernel.org>; Sun, 17 May 2020 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uyEuxRNFXxTHy3jGi0sWbeje0rtWktiI61ku1YR5XQM=;
        b=XjhPGZRo0hy8lSmN30iv1FoYoHjLrpvvcHo2ygtee9JGSbbc23mYomHH8Z86s2tlCX
         gnqc2lLavwzbflQSUEgeR0JQ6AsJHCUplyGvNtfeCAEUoNY009++TEHuN2WdzM5d+FO9
         g7ahM11TlktabGO9d5LIGR3Rob5zJaeP4GICBIBjYyDxvVdMrkk0yheOmhFnAgWVy0x3
         iVRXrugQ4lAyw+MIKA3ccFfqbZI61v5/idR6NHYVq0uAcJ5ZGTd7PfCjj9+SK6zeJpBd
         rpeTm1mqNIgKMC3U+Mu/KfxUhILzYwZEgY2/4u76ovdTYjffdFJVBEo6KZThyEmnuSLD
         DqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uyEuxRNFXxTHy3jGi0sWbeje0rtWktiI61ku1YR5XQM=;
        b=H3CC6+tTnviByyyMavLiyOcUQPYF90nuvlvAyuJDKKZMHsCayJ8UCe9Yt8C9X3Muz+
         GlXKKle7NYssuwdeYUv4odF8T8VkeBV6HGgQ3iL2II1qYVtD1Ep1Mk6lENGtyLuOGFh9
         pwLS+Me620UNT7GmTMQJgEQ6Exhdnv0Hj5ZrdBniQT+Icu9ThR4EudJ+NM8UEAmF0fWX
         iByZQGf8fSSaEzhHNBAv0i0W7tJgbYJRxQ9rIi1/R8UdNyDfxIBs8/tuNqVaau3rOM4o
         tGeb5lO70bqC70/Efu9FPOp0+BxhNByj8mfU95tjoG3JKcVaCXvyw7f4Ku+3GazYTOUQ
         HTlA==
X-Gm-Message-State: AOAM531DtemlU5YNmapZt+SmCzX+zLvCqHqpYUUXZC5Wn4U92U2/uY3+
        PrH33oS9j+ZqQ/YLjl/0n7VhBQ==
X-Google-Smtp-Source: ABdhPJywRpZiu8hlsjiCj7AHdvyj1Pqr2ufHjq9Exhw35hVjtBlDgjnAeGfjnWQZjfBVBC7HAqbrAg==
X-Received: by 2002:ac8:518f:: with SMTP id c15mr13340000qtn.142.1589758774534;
        Sun, 17 May 2020 16:39:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j45sm8412885qtk.14.2020.05.17.16.39.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:39:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSsX-0005YA-Ll; Sun, 17 May 2020 20:39:33 -0300
Date:   Sun, 17 May 2020 20:39:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/srpt: Add a newline when printing parameter
 'srpt_service_guid' by sysfs
Message-ID: <20200517233933.GA21233@ziepe.ca>
References: <1589182629-27743-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589182629-27743-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, May 11, 2020 at 03:37:09PM +0800, Xiongfeng Wang wrote:
> When I cat module parameter 'srpt_service_guid', it displays as follows.
> It is better to add a newline for easy reading.
> 
> [root@hulk-202 ~]# cat /sys/module/ib_srpt/parameters/srpt_service_guid
> 0x0205cdfffe8346b9[root@hulk-202 ~]#
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
