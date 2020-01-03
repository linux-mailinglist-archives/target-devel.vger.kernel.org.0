Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D72A912FDD7
	for <lists+target-devel@lfdr.de>; Fri,  3 Jan 2020 21:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgACUXZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 3 Jan 2020 15:23:25 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42791 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgACUXZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 3 Jan 2020 15:23:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so37694719qtq.9
        for <target-devel@vger.kernel.org>; Fri, 03 Jan 2020 12:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Eh1yQkvu28vzyYRDiVcQwSW+SUklb8lMZ4DpMKEnY4=;
        b=YTiWrOb56a1ZHIaSf9O1wVNbS19lXhKtyLknLuzFJx77TN9chzR0h/NE0jPdefQVKN
         YlDU+Z6Z1GO5iLxvZenhQO/P1FszjgWeD+IeraEzD38TNudMORVNtJDUz4eL+ILvOOZt
         /sTzBavh0R4suV3EcHnPQAj0BTBZ6aKNK+A48gwqPlbK6X2PHv1qjQSYQnnX91TnF4jk
         7B+Fo2XNfybeccmk9/U+j53rZjHC/ZTbes07YToLu+tHhLpG6roLycovloDH0klYvpvl
         a96tuQL+sP3DDA/f0kwXdsqelAsLzsUYlkrcvGtBPtCn5gs/MKnRtzDSDN+eySr3sVu9
         p3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Eh1yQkvu28vzyYRDiVcQwSW+SUklb8lMZ4DpMKEnY4=;
        b=HzOemyBRK6+tpzB+voDqFx/aJveH3kluubuNhSCswBCGw/ZVzifblL5zQlzYgDe6CH
         2UxgOlaVfUaNcGRpdndVWqN5HY48kItaJ7zFT+xgCZmLy+jThZ6u5mc9+hCJhzJCryJt
         r5P9m6/ARgc9pGKdVSSzYP4kLCZT9dl2ncv32Mt+PRixH9Cliaw+eMAIVMu2ZfDNOhQW
         UnidxWnWkPlJL4OojBK9wy2jP10+O2l/fbWcxlUUGRju76ljEJOJqhrS7zdaFOaGCu3B
         bj9YH4B2JyzjBCQdBHEOjhG47Qb7xdbMhxggY7XDktBqySgFAj0252wUSRPP5y38o+HA
         26/g==
X-Gm-Message-State: APjAAAWZfbC3c4dzgSD6luXcSwGzCGb0RtpUlzYkej1K8F7gGIQbxJhc
        /MTYJLyMUz4h98+BTSWHMXP4BA==
X-Google-Smtp-Source: APXvYqxy1Faz1t5NblybFE11de0p8ag9hlUiNxnTiTsaHJhdsIDTGMwllYn8llwMRaRMp/npH4bmGw==
X-Received: by 2002:ac8:1aeb:: with SMTP id h40mr66103001qtk.269.1578083004353;
        Fri, 03 Jan 2020 12:23:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d143sm16960386qke.123.2020.01.03.12.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 12:23:23 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inTTf-00043e-Dx; Fri, 03 Jan 2020 16:23:23 -0400
Date:   Fri, 3 Jan 2020 16:23:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: RDMA/srpt: remove unnecessary assertion in
 srpt_queue_response
Message-ID: <20200103202323.GA15557@ziepe.ca>
References: <20191217194437.25568-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217194437.25568-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:44:37PM -0600, Aditya Pakki wrote:
> Currently, BUG_ON in srpt_queue_response, is used as an assertion for
> empty rdma channel. However, if the channel is NULL, the call trace
> on console is sufficient for diagnosis.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> v1: Avoid potential NULL pointer derefernce of ch. Current fix
> suggested by Bart Van Assche
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next with the reworked commit message Bart suggested

Thanks,
Jason
