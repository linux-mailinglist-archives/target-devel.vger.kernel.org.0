Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46E2299886
	for <lists+target-devel@lfdr.de>; Mon, 26 Oct 2020 22:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgJZVFM (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 26 Oct 2020 17:05:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:59712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730037AbgJZVFM (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:05:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EC1CADE8;
        Mon, 26 Oct 2020 21:05:10 +0000 (UTC)
Date:   Mon, 26 Oct 2020 22:05:09 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 1/5] lib/scatterlist: use consistent sg_copy_buffer()
 return type
Message-ID: <20201026220509.7f0a2abb@suse.de>
In-Reply-To: <08c0e425-d8c5-a950-f2a1-01bb6c9a5adf@interlog.com>
References: <20201026190646.8727-1-ddiss@suse.de>
        <20201026190646.8727-2-ddiss@suse.de>
        <08c0e425-d8c5-a950-f2a1-01bb6c9a5adf@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, 26 Oct 2020 16:50:53 -0400, Douglas Gilbert wrote:

> On 2020-10-26 3:06 p.m., David Disseldorp wrote:
> > sg_copy_buffer() returns a size_t with the number of bytes copied.
> > Return 0 instead of false if the copy is skipped.
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >   lib/scatterlist.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> > index 0a482ef988e5..a59778946404 100644
> > --- a/lib/scatterlist.c
> > +++ b/lib/scatterlist.c
> > @@ -933,7 +933,7 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
> >   	sg_miter_start(&miter, sgl, nents, sg_flags);
> >   
> >   	if (!sg_miter_skip(&miter, skip))
> > -		return false;
> > +		return 0;
> >   
> >   	while ((offset < buflen) && sg_miter_next(&miter)) {
> >   		unsigned int len;
> >   
> 
> This one probably should be sent by itself as a fix to:
>     linux-block@vger.kernel.org
> 
> and cc-ed to:
>     axboe@kernel.dk
> 
> on the assumption that Jens Axboe is the maintainer of lib/scatterlist.c .
> He put a fix of mine in sgl_alloc_order() into the kernel recently.
> 
> Otherwise:
> Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>

Sent. Thanks Douglas!
