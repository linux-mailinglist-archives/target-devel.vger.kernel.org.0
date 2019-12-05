Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CE1139E3
	for <lists+target-devel@lfdr.de>; Thu,  5 Dec 2019 03:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfLEC2y (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 4 Dec 2019 21:28:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44580 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfLEC2y (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:28:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id x3so1222950oto.11
        for <target-devel@vger.kernel.org>; Wed, 04 Dec 2019 18:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LydF41+XS1XpaJQ+yxPQmJEE3Ym/bVw2nM/HalqfLqo=;
        b=NlQC+aqzBoFyBHLLtIA8s033pHvwInrfDBm4EkKSy6m5ujN8FW4nzWswYAciLjkVZq
         kk1NGP0PQBGHZ8DPsiqLcOqf1Fz7NzyNbeq2HCDMYaOurrZr/UT5f5nI1MWP4P4IGP7A
         B1U33GilTGp8KRuZ6xiLYVjTD/+bZ9sGPre5bVOI+UQSxqVMdOm2ta+ADom6AWDlHNcy
         26E+nbiaWZlw/NvDwvjj/sSKxvfNw+ia3q9U8P47Iqhtrw64Ltdq3fRRfEEtARdrbdgn
         K6MtszgeqtSyRrNqfjitHINDq7FHDZjcXOKyNlEKt0yIv8pY5NCXpBIHEimSKSbL8FER
         V/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LydF41+XS1XpaJQ+yxPQmJEE3Ym/bVw2nM/HalqfLqo=;
        b=Lvd2bEP61s394jRAxY4Xsio5qy7f8MXLs0IB7vAGrBzXIGkC0RXAoGLneoc0Luxkbb
         O2JsXqB2ddqGC4TNp0hBxlpO8SguidJlv4R2Z9nkQ3aVlkgB3+V6QVVdcEdtMG9GFtXa
         kUZkHy1cc/G7r04vI8s06rrS5KsG4Obdi2IMGCeEB85l4+jfEHYtfg/XaSEAg0m9NcrK
         aLcgJb2woo9Hh9xqGqkZZf7KrQUDHNTcHE4/4H/dxWwjR5RAT77R4EG6CckQxw4WKMjq
         ky5yp21nDPks9/V6aYk5jQpRJRuEFIhzG8zu4rs9A3tFPBlyu8E8sNLOYs5nLmqfEg7c
         jnIA==
X-Gm-Message-State: APjAAAXcjQLACFa24BkyyF7qVF5z212uwy2PXFuFQmMB0koNEhzpcYRi
        r9aPNqe77Y9KUohd9TKUz7DylFBKgPm+yd3rNKhP1Q==
X-Google-Smtp-Source: APXvYqx/pgfpaSL+3I+gSb4wa9YGqkrMuR88GpGJ4EGJ8reJFgeDwP7YkFUaHsJc3o+9N9AHCnrl8BmOaf0uRI9TRPw=
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr4995353otp.202.1575512934159;
 Wed, 04 Dec 2019 18:28:54 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p> <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p> <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p>
In-Reply-To: <20191204230225.GA26189@ming.t460p>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Wed, 4 Dec 2019 21:28:43 -0500
Message-ID: <CAAFE1bcwcdVuzAG5+x1UNcTaa22bf0tOaT=QOWrTup98sFXxuQ@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Ming,

Thanks for all your help and insight. I really appreciate it.

> > Presumably non-brd devices, ie: real scsi devices work for these test
> > cases because they accept un-aligned buffers?
>
> Right, not every driver supports such un-aligned buffer.

Can you please clarify: does the block layer require that it is called
with 512-byte aligned buffers? If that is the case, would it make
sense for the block interface (bio_add_page() or other) to reject
buffers that are not aligned?

It seems that passing these buffers on to underlying drivers that
don't support un-aligned buffers can result in silent data corruption.
Perhaps it would be better to fail the I/O up front. This would also
help future proof the block interface when changes/new target drivers
are added.

I'm also curious how these same unaligned buffers from iSER made it to
brd and were written successfully in the pre "multi-page bvec" world.
(Just trying to understand, if you have any thoughts, as this same
test case worked fine in 4.14+ until 5.1)

> I am not familiar with RDMA, but from the trace we have done so far,
> it is highly related with iser driver.

Do you think it is fair to say that the iSER/block integration is
causing corruption by using un-aligned buffers?

Thanks,
Steve
