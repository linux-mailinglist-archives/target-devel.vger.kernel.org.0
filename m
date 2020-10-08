Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A704287D10
	for <lists+target-devel@lfdr.de>; Thu,  8 Oct 2020 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgJHU1B (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 8 Oct 2020 16:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729280AbgJHU1B (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602188820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=twVz8zn39JFNygX3N+DpgBYsBehN6K5Zd/Llqp3b+sk=;
        b=D8rBjlEUu9coQlAdU6VIf7LZTj4M3/LwhaG2M62pehbu4vYZBb/wgBEDbT0G3jm3Hu9UkV
        e1CxSMrONaP1Jb8SYRUUCkZss778FuqRBw0oQ4v8OpIxSft6roi6je6sN9U+d6Ri+qM1L/
        zzBjLy5x2qRDwl0qzoy6RnfryT01Q70=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-aXsJXu85Nmap0yC_xjVgaA-1; Thu, 08 Oct 2020 16:26:56 -0400
X-MC-Unique: aXsJXu85Nmap0yC_xjVgaA-1
Received: by mail-wm1-f72.google.com with SMTP id v14so3517009wmj.6
        for <target-devel@vger.kernel.org>; Thu, 08 Oct 2020 13:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=twVz8zn39JFNygX3N+DpgBYsBehN6K5Zd/Llqp3b+sk=;
        b=CZdJUh7cjaofxvhopgcWUPbUOVofhGGzuPh9YUBUa8uL4eG8AMg/Kt6N9w2PpgRePq
         pRQKAMT3gkyRVKvpFU3snXJY1ZEmwi5GRDPq8+JqPCb0g9vKHXEQ7YGRYGprgXDYdGD/
         p5cfLYd94hWCg2ORARot0AGCg0UB36/X56MZGmgi4bN4NKLwZ9dlOKD7hwdO1VGEvUSy
         TX0R/d7xh2+Wx5/Mrp/vFAMCCAIia0eyt8VyzL5DpT68Ly0hTBpkkQkjuBsqgqyj3mgQ
         n33Ixvbr25Kbllxok6PmX3f/zXTU/Xa8wyY977PPCVwPrBmjqLT42/q5z+c2SGVaP+zN
         c4gg==
X-Gm-Message-State: AOAM531+4sXK0YU6oZQorNdUqZ7KXloaNfCggRFNpQUKSNzxBqxYZkb5
        L0TyYG6eaC1XQubUF6SOqOVLB7j6EUdNqzZgFXGI72VFnEqqnyTvD2/bs4iChIE8FwLMfSZQoGY
        Bir1QNzTwr2tTo2xClJtl3lJf
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr9940714wmh.166.1602188815246;
        Thu, 08 Oct 2020 13:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3KfXXvkMS5m5z/HtHdSxRswCK5ykunjW1kWHIj15VRre8iCzBqPKFXNiyvij71iupd9gn4A==
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr9940704wmh.166.1602188815005;
        Thu, 08 Oct 2020 13:26:55 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id a199sm8942819wmd.8.2020.10.08.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:26:54 -0700 (PDT)
Date:   Thu, 8 Oct 2020 16:26:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 12/16] vhost: support multiple worker threads
Message-ID: <20201008162523-mutt-send-email-mst@kernel.org>
References: <1602104101-5592-1-git-send-email-michael.christie@oracle.com>
 <1602104101-5592-13-git-send-email-michael.christie@oracle.com>
 <da6f25b4-7a98-9294-a987-43d100625499@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da6f25b4-7a98-9294-a987-43d100625499@oracle.com>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Oct 08, 2020 at 12:56:53PM -0500, Mike Christie wrote:
> On 10/7/20 3:54 PM, Mike Christie wrote:
> > This is a prep patch to support multiple vhost worker threads per vhost
> > dev. This patch converts the code that had assumed a single worker
> > thread by:
> > 
> > 1. Moving worker related fields to a new struct vhost_worker.
> > 2. Converting vhost.c code to use the new struct and assume we will
> > have an array of workers.
> > 3. It also exports a helper function that will be used in the last
> > patch when vhost-scsi is converted to use this new functionality.
> > 
> 
> Oh yeah I also wanted to bring up this patch:
> 
> https://www.spinics.net/lists/netdev/msg192548.html
> 
> The problem with my multi-threading patches is that I was focused on
> the cgroup support parts and that lead to some gross decisions.
> 
> 1. I kept the cgroup support, but as a result I do not have control
> over the threading affinity and making sure cmds are executed on a
> optimal CPU like the above patches do.
> 
> When I drop the cgroup support and make sure threads are bound to
> specific CPUs and then make sure IO is run on the CPU it came in on
> then IOPs jumps from 600K to 800K for vhost-scsi.
> 
> 2. I can possible create a lot of threads.
> 
> So a couple open issues are:
> 
> 1. Can we do a thread per cpu that is shared across all vhost devices?
> That would lead to dropping the cgroup vhost worker support.
> 
> 2. Can we just use the kernel's workqueues then?


Problem is, we are talking about *lots* of CPU, IO etc and ATM cgroups
is how people expect to account for that overhead.

