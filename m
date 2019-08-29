Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A3A27B6
	for <lists+target-devel@lfdr.de>; Thu, 29 Aug 2019 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfH2UHA (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Aug 2019 16:07:00 -0400
Received: from www84.your-server.de ([213.133.104.84]:35344 "EHLO
        www84.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfH2UHA (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:07:00 -0400
X-Greylist: delayed 1568 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 16:06:59 EDT
Received: from [188.192.85.118] (helo=[192.168.0.7])
        by www84.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <stefani@seibold.net>)
        id 1i3QHq-0000Ju-5a; Thu, 29 Aug 2019 21:40:50 +0200
Message-ID: <b551fb9b06fc50198cc7febcb334c33b13216314.camel@seibold.net>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
From:   Stefani Seibold <stefani@seibold.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        laokz <laokz@foxmail.com>
Cc:     Greg KH <greg@kroah.com>, Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Date:   Thu, 29 Aug 2019 21:40:46 +0200
In-Reply-To: <CAHk-=wh3EKnDXnt681b0+11UbiA8roO8Ui==eKVaKU4pnPe7rw@mail.gmail.com>
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
         <20190722114700.GE3089@kadam> <20190722115010.GF3089@kadam>
         <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
         <20190802073057.GD26174@kroah.com>
         <5d49567f.1c69fb81.97950.e58aSMTPIN_ADDED_BROKEN@mx.google.com>
         <CAHk-=wgQeKWHW0bQ1aV5=2ivbD-WWDHcBBJ_cX5R75iiNNq2uA@mail.gmail.com>
         <CAHk-=wh3EKnDXnt681b0+11UbiA8roO8Ui==eKVaKU4pnPe7rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: stefani@seibold.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25556/Thu Aug 29 10:25:39 2019)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Linus,

i am back from vacation next week. I will have a look on it.

Stefani

Am Donnerstag, den 29.08.2019, 12:32 -0700 schrieb Linus Torvalds:
> On Thu, Aug 29, 2019 at 11:48 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Anybody?
> 
> This is ENTIRELY UNTESTED.
> 
> Anybody willing to test and take ownership?
> 
>               Linus

