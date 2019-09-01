Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59434A4AE5
	for <lists+target-devel@lfdr.de>; Sun,  1 Sep 2019 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfIARjK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 1 Sep 2019 13:39:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36905 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfIARjJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 1 Sep 2019 13:39:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so8796984lff.4
        for <target-devel@vger.kernel.org>; Sun, 01 Sep 2019 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kT7cfy6aeYaGpe5SSP2A85kTX2B6wA4CN3oNeyGbEUQ=;
        b=OAl/J5pQIkdIReASj2utqteB1csb9UU4oZN7emR3PnQ7pTBywxMmmdq+Pcdm4GnrJi
         K2DE/7UXx+Sq77nLIZ8UpwsFqqZL+V5oWRt20gVeJB5hdgPdaEBB4IcE3t2ZRciB1KI3
         yRf/N4VxgOdDNRBNvLKz/ynODfUvaSbNi5PnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kT7cfy6aeYaGpe5SSP2A85kTX2B6wA4CN3oNeyGbEUQ=;
        b=hRsjjszu0uN5RUlnbh03a47cdp9Kqt3b7Re2SVY4DdrBNGTe+qqqJgD+e1SAIzbCTR
         6pGMExdFyk32belCJyCJovbA6gmDt1Xj31rL0XHXin6AQhmYxn3ThM/tue5SwBOG0ThB
         aC29hRjYbjd1+vWQpZMWfYVS3PVtZnmWIwzFNswbuUGqUZiU39YLKHtH96Pp8s+HPcdr
         TOmz80Dp6oC/Ut/kjtK0Hhca5TDUYxSVT/GFw9LbKGD9onOH8G8PBStMPyI+YzKaUN29
         D8XyonKlI4UNu8xJ/Zy2f6cHFLvyGhkytfKRu12sG3wxrfIceB7uIidlqv3QGGU5Izo+
         8mJA==
X-Gm-Message-State: APjAAAWYtpGRU9byTZYUWVzxHf1orJ8DTgZ6XOjsL8vOHL+Gk1UUUItv
        u0v7FE2w5om+OrdnCdnb+i+0Gotrv50=
X-Google-Smtp-Source: APXvYqySUCic7qV5s7TPEqKV3GvRH6Q29dS20rQrLb9bQENPoaU10BsPz8WjPakra1mW96uyGBRizw==
X-Received: by 2002:a19:5d53:: with SMTP id p19mr14417100lfj.109.1567359547603;
        Sun, 01 Sep 2019 10:39:07 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id r20sm1638146ljd.44.2019.09.01.10.39.06
        for <target-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2019 10:39:06 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id h15so10770430ljg.10
        for <target-devel@vger.kernel.org>; Sun, 01 Sep 2019 10:39:06 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr14067878lji.52.1567359546290;
 Sun, 01 Sep 2019 10:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
 <20190722114700.GE3089@kadam> <20190722115010.GF3089@kadam>
 <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
 <20190802073057.GD26174@kroah.com> <5d49567f.1c69fb81.97950.e58aSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAHk-=wgQeKWHW0bQ1aV5=2ivbD-WWDHcBBJ_cX5R75iiNNq2uA@mail.gmail.com> <5d6bfbd2.1c69fb81.df96a.1bfeSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5d6bfbd2.1c69fb81.df96a.1bfeSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Sep 2019 10:38:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqSDYowpYexqmryVc0ibX3tORb5H4G+ryW--g4vGENXg@mail.gmail.com>
Message-ID: <CAHk-=wjqSDYowpYexqmryVc0ibX3tORb5H4G+ryW--g4vGENXg@mail.gmail.com>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
To:     laokz <laokz@foxmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        stefani <stefani@seibold.net>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Sun, Sep 1, 2019 at 10:11 AM laokz <laokz@foxmail.com> wrote:
>
> At first glance, I thought this issue was serious, based on user space
> experience. Later I realized it may be trivial in kernel space, for kmalloc
> also using roundup_power_of_2 algorithm through SLAB/SLUB.

No, there are definitely slab sizes that aren't always powers of two.

It may be that almost by mistake, the particular one problem you point
out (ibmvscsi_tgt) ends up having its allocation grown to a power of
two, so it's not a problem in practice, but you definitely found a
bug.

I ended up doing a minimal half-revert in commit ab9bb6318b09
("Partially revert "kfifo: fix kfifo_alloc() and kfifo_init()"") which
fixes the basic problem.

> > Also, INIT_KFIFO() and DECLARE_KFIFO() should probably have a
> >
> >      BUILD_BUG_ON(!__is_kfifo_ptr && !is_power_of_2(ARRAY_SIZE(__tmp-
> > >buf)));
> >
> > or something. Probably worth indirection through a helper macro to set
> > the ".mask" field.
>
> Now, I learned that actual scenario may be more complex and uncontrollable
> in some degree, supposing this issue had a statically allocated buffer. So,
> it's worth to use least cost to keep kernel from potential damage.

It turns out that DECLARE_KFIFO ends up protecting against bad kfifo
sizes, because __STRUCT_KFIFO() does this:

        type            buf[((size < 2) || (size & (size - 1))) ? -1 : size]; \

which is making sure that size is at least 2 and a power-of-two. If it
isn't, the compiler will error out due to a negative array size thanks
to that check.

So it's _probably_ the case that the only actual problem was
kfifo_init() itself. And yes, it's quite possible that the only user
that didn't use a power of two ended up having SLAB round that
allocation up for the size it *did* use.

But your bug report was valid, and I'd love you to double-check all
this. Code that just happens to work by mistake is still a serious bug
waiting to happen.

Thanks,

             Linus
