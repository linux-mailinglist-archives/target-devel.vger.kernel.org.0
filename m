Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284B6A2218
	for <lists+target-devel@lfdr.de>; Thu, 29 Aug 2019 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfH2RVh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Aug 2019 13:21:37 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36468 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfH2RVg (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:21:36 -0400
Received: by mail-pf1-f180.google.com with SMTP id w2so2515087pfi.3
        for <target-devel@vger.kernel.org>; Thu, 29 Aug 2019 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4Qu73IVvOMqSFwggsLa8khZSft5OQHpTShEKNjWUwrE=;
        b=EMDpiF/h4mw2zAqaVcMxVQ7OT3KUyeNqEyJHmLeG+/ZHtfDrAA5L5lsfbnHIwCTJpa
         rqtxLB5OxG9F33zi5fSIGdTH/StnREa3ve82sTRWPXIGra/wJQAl+oizqAVp1ckdsGQY
         1DRqSJ5yVLLvRt0JpNAmVh7doLJQ3MkZDUx9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4Qu73IVvOMqSFwggsLa8khZSft5OQHpTShEKNjWUwrE=;
        b=ghgdbOrfriuS93bLwVZbnKDgGbNs4I6WXrX9rp8TetZ8jNspzUxfUr+SZaDYUtwmR7
         ObCvY9MXHTXtJ7L5FLMl+Aw830fmAWKGaQWH89cId68teMcovQwHwakt2Ank8IJAWwcd
         35t70dPsKaFdKEQlZAalCbcGAJahyyLQKB0RMREwHy7RMNwcCoP7ev5HF9n9sCUHWrRA
         gQKSJPukP0MOwUv6IZEqOi8V9SpDP20jWkafDrlrvRollh0Ejnqwf4UoTb8GgaE5rinH
         s+MvYdQpf/eIOjOrvptFzJ45kfPIC6ndgtX5Ydp1VnvyE+WfUcOBbexgqUyvj3HWDDC+
         YjPw==
X-Gm-Message-State: APjAAAWK3Qk+O4TpXAIoT+zVO81pfNIWu/zPmZlIz9cENDVmPPrmRWNO
        PhACEkyjUAXNKFmWijz0W9TwuzewDVU=
X-Google-Smtp-Source: APXvYqyzgH7P8udfSR4ASf9YRaZs5zKRx7SjKeXYB9gEOM47sV2TxA8nfyY9woUtvVe0wmsTYAHZSA==
X-Received: by 2002:a17:90a:9a7:: with SMTP id 36mr11117228pjo.93.1567099295801;
        Thu, 29 Aug 2019 10:21:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13sm3196839pjz.10.2019.08.29.10.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:21:34 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:21:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laokz <laokz@foxmail.com>
Cc:     Greg KH <greg@kroah.com>, Dan Carpenter <dan.carpenter@oracle.com>,
        security@kernel.org, stefani <stefani@seibold.net>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
Message-ID: <201908291021.DF893CEE5B@keescook>
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
 <20190722114700.GE3089@kadam>
 <20190722115010.GF3089@kadam>
 <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
 <20190802073057.GD26174@kroah.com>
 <5d49567f.1c69fb81.f0e1d.3d10SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d49567f.1c69fb81.f0e1d.3d10SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:27:13PM +0800, laokz wrote:
> On Fri, Aug 2, 2019 at 09:30 +0200，Greg KH wrote:
> > On Mon, Jul 22, 2019 at 09:26:23PM +0800, laokz wrote:
> > > Hello Dan,
> > > 
> > > On Mon, Jul 22, 2019 at 14:50 +0300，Dan Carpenter wrote:
> > > > > It looks like you're right.  Probably the fix is to:
> > > > > 1) Change INITIAL_SRP_LIMIT to 8192
> > > > 
> > > > I meant 1024 not 8192.
> > > 
> > > Nice to see that. It really helped for me. Thank you very much.
> > 
> > Did anything ever happen with this?  Was a patch submitted to resolve
> > this issue?
> Sorry for the late reply. I didn't submit any patch, for as newbie I wasn't
> quite sure about the severity of this issue. The developers may do their
> choice.

It's worth fixing regardless. :) Did a patch get sent for this?

-- 
Kees Cook
