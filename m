Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E57A2768
	for <lists+target-devel@lfdr.de>; Thu, 29 Aug 2019 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfH2TmT (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Aug 2019 15:42:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36799 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfH2TmT (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:42:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so2074964plr.3
        for <target-devel@vger.kernel.org>; Thu, 29 Aug 2019 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iTeH1bRSVoF8B4d86treqUEeQNzKa5v+a4z2/CcG7y8=;
        b=jfdmVmbrp07gpI8yPtIV2dKeiFtOs3JgQ6MAssq0x2mx7rO+i4WrO1KNtKKOIEuit0
         wVzSdDQkBoWoduixtdnek/C8OhnS1b69MgIIccZGoaiHdt8AjSvE4nRMtsuEICv6TT1o
         QaVbZcOuXoE0QDOauJm/fcZqG0QpMUBf0/L6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iTeH1bRSVoF8B4d86treqUEeQNzKa5v+a4z2/CcG7y8=;
        b=X8uYzKi+XDKe3QRDOB1vOS83o2VtTTAWDHOQWPMHadg7sdwTeHwjk05pG90MADAYGj
         OMyXmTfL/3oeADtB5TPeWSfkEha5M6XQuxdLhcH4/vl24M4PCfe5CPuMjDhlqKEkttSZ
         7BkUcpIUgV1r0KWWhyyRcx0nyMyNBEEMVQtuSrnCF96F7h6NMsP3WsEVYQNJxuCcgl+Q
         fe6JXgNt0L5uY284Jv2i0zwlMCq2kgQ8C3M/2VvTQpcXAN0RWfQFa0EDy9rNjYjP3IOm
         TzMuyMQddzZ5Q9zQaFkz4bsTOJ8eadeW9PcU0ZpMNW7wkUjQUiTmLrC35GISQTdGevH1
         y67w==
X-Gm-Message-State: APjAAAV+s5I3JKF0ySEwxY8NssgwZw9JlOPvqspE7VTboJc9qiAiVD8X
        B0tol2a3mzOdksIeXxhtXeWiSA==
X-Google-Smtp-Source: APXvYqwOMh9ctwAc9ExPiXRq0RmPZPqDUDrDGfcxYsiRTyBrrAqNo9SrGQBPyDnALtjdFgGUPtiI5A==
X-Received: by 2002:a17:902:720a:: with SMTP id ba10mr11039783plb.231.1567107738828;
        Thu, 29 Aug 2019 12:42:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m145sm3847828pfd.68.2019.08.29.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:42:18 -0700 (PDT)
Date:   Thu, 29 Aug 2019 12:42:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     laokz <laokz@foxmail.com>, Greg KH <greg@kroah.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        stefani <stefani@seibold.net>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
Message-ID: <201908291240.A6A9AA5431@keescook>
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
 <20190722114700.GE3089@kadam>
 <20190722115010.GF3089@kadam>
 <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
 <20190802073057.GD26174@kroah.com>
 <5d49567f.1c69fb81.97950.e58aSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAHk-=wgQeKWHW0bQ1aV5=2ivbD-WWDHcBBJ_cX5R75iiNNq2uA@mail.gmail.com>
 <CAHk-=wh3EKnDXnt681b0+11UbiA8roO8Ui==eKVaKU4pnPe7rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3EKnDXnt681b0+11UbiA8roO8Ui==eKVaKU4pnPe7rw@mail.gmail.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:32:41PM -0700, Linus Torvalds wrote:
> On Thu, Aug 29, 2019 at 11:48 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Anybody?
> 
> This is ENTIRELY UNTESTED.
> 
> Anybody willing to test and take ownership?

I don't know this code at all, but note below...

> 
>               Linus

>  include/linux/kfifo.h | 12 ++++++++----
>  lib/kfifo.c           |  4 +++-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> index fc4b0b10210f..078f52c20aad 100644
> --- a/include/linux/kfifo.h
> +++ b/include/linux/kfifo.h
> @@ -117,6 +117,12 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
>   */
>  #define DECLARE_KFIFO(fifo, type, size)	STRUCT_KFIFO(type, size) fifo
>  
> +#define VERIFY_POWER_OF2(x) \
> +	((x)+BUILD_BUG_ON_ZERO((x) & ((x)-1)))
> +
> +#define __KFIFO_MASK_SIZE(fifo) \
> +	(__is_kfifo_ptr(&(fifo)) ? 0 : VERIFY_POWER_OF2(ARRAY_SIZE((fifo).buf)) - 1)
> +
>  /**
>   * INIT_KFIFO - Initialize a fifo declared by DECLARE_KFIFO
>   * @fifo: name of the declared fifo datatype
> @@ -127,7 +133,7 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
>  	struct __kfifo *__kfifo = &__tmp->kfifo; \
>  	__kfifo->in = 0; \
>  	__kfifo->out = 0; \
> -	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
> +	__kfifo->mask = __KFIFO_MASK_SIZE(fifo); \

I think this should be:

+	__kfifo->mask = __KFIFO_MASK_SIZE(*__tmp); \

? I didn't compile it, but I saw the others were using (fifo).buf but
this was using __tmp->buf.

>  	__kfifo->esize = sizeof(*__tmp->buf); \
>  	__kfifo->data = __is_kfifo_ptr(__tmp) ?  NULL : __tmp->buf; \
>  })
> @@ -147,9 +153,7 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
>  			{ \
>  			.in	= 0, \
>  			.out	= 0, \
> -			.mask	= __is_kfifo_ptr(&(fifo)) ? \
> -				  0 : \
> -				  ARRAY_SIZE((fifo).buf) - 1, \
> +			.mask	= __KFIFO_MASK_SIZE(fifo), \
>  			.esize	= sizeof(*(fifo).buf), \
>  			.data	= __is_kfifo_ptr(&(fifo)) ? \
>  				NULL : \
> diff --git a/lib/kfifo.c b/lib/kfifo.c
> index 117ad0e7fbf4..7f145cb41e6d 100644
> --- a/lib/kfifo.c
> +++ b/lib/kfifo.c
> @@ -68,7 +68,9 @@ int __kfifo_init(struct __kfifo *fifo, void *buffer,
>  {
>  	size /= esize;
>  
> -	size = roundup_pow_of_two(size);
> +	/* Warn because we had a bug here and would round up */
> +	if (WARN_ON_ONCE(!is_power_of_2(size)))
> +		size = rounddown_pow_of_two(size);
>  
>  	fifo->in = 0;
>  	fifo->out = 0;


-- 
Kees Cook
