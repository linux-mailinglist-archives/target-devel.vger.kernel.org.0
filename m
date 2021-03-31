Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0B344B3E
	for <lists+target-devel@lfdr.de>; Mon, 22 Mar 2021 17:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhCVQ0s (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 22 Mar 2021 12:26:48 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50673 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230356AbhCVQ0O (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:26:14 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 12MGQ19f023546;
        Mon, 22 Mar 2021 17:26:01 +0100
Date:   Mon, 22 Mar 2021 17:26:01 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] target: pscsi: avoid Wempty-body warning
Message-ID: <20210322162601.GB23467@1wt.eu>
References: <20210322114441.3479365-1-arnd@kernel.org>
 <20210322154735.GA2079192@infradead.org>
 <20210322155344.GA23040@1wt.eu>
 <CAK8P3a1bb4QvNyM9kkt0KB9k70cdEZ-e+B-CHHtPhaPO6ouxeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1bb4QvNyM9kkt0KB9k70cdEZ-e+B-CHHtPhaPO6ouxeQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:18:23PM +0100, Arnd Bergmann wrote:
> I agree that this instance of the warning is particularly stupid, but the
> I'd like to leave the warning option there and eventually enable it by
> default because it tends to find other more interesting cases, and this
> one is trivial to work around.
> 
> I remember previously fixing a few drivers that did obviously
> incorrect things like
> 
>     if (error); /* note the extra ';' */
>          return error;

I totally agree with this one but usually it's already reported by
another one (probably the one complaining about misindenting). The
case I've seen quite a few times was:

     while (condition);

At least I want the ';' on its own line to avoid it being
confused with one that ends a do {} while() block.

> and a lot mostly harmless code like
> 
> #ifdef DEBUG_THIS_DRIVER /* always disabled */
> #define dprintk(args...) printk(args)
> #else
> #define dprintk(args...)
> #endif
>     /* note the mismatched format string */
>     dprintk(KERN_WARNING "error %d\n", &object);
> 
> Turning the empty dprintk() into no_printk() means we can catch
> the wrong format string during compile testing.

Hmmm OK for this one. With this said, given how plenty of warnings seem
to consider indent and whatever, I wouldn't be surprised if a difference
is made between a totally empty body and one that results from an empty
macro. But indeed this one can represent a real bug.

Willy
