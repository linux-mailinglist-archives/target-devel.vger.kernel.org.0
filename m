Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC29A2935
	for <lists+target-devel@lfdr.de>; Thu, 29 Aug 2019 23:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfH2Vvi (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Aug 2019 17:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfH2Vvi (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:51:38 -0400
Received: from brain-police (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9114821726;
        Thu, 29 Aug 2019 21:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567115497;
        bh=X39JIQ6IVFZlEtUsuCeQCAuJNIKd7PyHfZamwI/HMNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMqISVwI9rk8Iw0hYaVRGoVCAmpjYP4g/4vyVEkOUIdcdVSsDG55aAV8QAtMoSswr
         C4t3XTyeJ5f3cInVZqXd28rvSUGD+635snEkmvtWbi0MjCy+tjQTSlMKFPLXa84qEC
         MnHNEcCY5lgzvUui9FIL7afhgjdCt7y5Ha68QDmI=
Date:   Thu, 29 Aug 2019 22:51:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, laokz <laokz@foxmail.com>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        stefani <stefani@seibold.net>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
Message-ID: <20190829215131.GA2404@brain-police>
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
 <20190722114700.GE3089@kadam>
 <20190722115010.GF3089@kadam>
 <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
 <20190802073057.GD26174@kroah.com>
 <5d49567f.1c69fb81.97950.e58aSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAHk-=wgQeKWHW0bQ1aV5=2ivbD-WWDHcBBJ_cX5R75iiNNq2uA@mail.gmail.com>
 <CAHk-=wh3EKnDXnt681b0+11UbiA8roO8Ui==eKVaKU4pnPe7rw@mail.gmail.com>
 <201908291240.A6A9AA5431@keescook>
 <CAHk-=wiNZjcxrR2w633xYSJ42dor3NL8eJDTk_npCjJUXsZtfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiNZjcxrR2w633xYSJ42dor3NL8eJDTk_npCjJUXsZtfg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:00:21PM -0700, Linus Torvalds wrote:
> [ at the dentist, sorry for mobile html gunk ]
> 
> On Thu, Aug 29, 2019, 12:42 Kees Cook <keescook@chromium.org> wrote:
> 
>     On Thu, 
> 
>     I don't know this code at all, but note below...
> 
>     > +     __kfifo->mask = __KFIFO_MASK_SIZE(fifo); \
> 
>     I think this should be:
> 
>     +       __kfifo->mask = __KFIFO_MASK_SIZE(*__tmp); \
> 
>     ? 
> 
> 
> If it matters, we're in deep doo-doo. It only uses the type of the thing, not
> the value, so it's immaterial. I think it's easier to use the original type
> rather than the temporary that we created using it..
> 
> But that's the least of my worries in that code.

If it makes you feel any better [perhaps as a distraction from the dreaded
dentist], the memory ordering side of things is suspicious as well:

https://lore.kernel.org/lkml/CAGXu5jKkqf-9ksvNTCS5xgB_JtfvCc=Eot2uWYYP8rpoKLw=mg@mail.gmail.com/

When I started pulling on it, it all fell apart, so I haven't had a
chance to do a proper set of fixes.

Will
