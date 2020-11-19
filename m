Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F72B9907
	for <lists+target-devel@lfdr.de>; Thu, 19 Nov 2020 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgKSRJB (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 19 Nov 2020 12:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbgKSRJA (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:09:00 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99117C0613CF;
        Thu, 19 Nov 2020 09:08:59 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t8so5079720pfg.8;
        Thu, 19 Nov 2020 09:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3jwRzYh5eBRDXKSUjnimUTZgZnImvs3tPqk9uLXKM8=;
        b=Q09CUPq3p7/L63rO5X2XHwdBmQzH9mQPiPutCAYOmwM2YyafFpTWV111jPTCymkG9Y
         ovduueR9oZ61aWho4Yz17uIz6uTEtuQXdUK4RvAHXzpkmm5rPE1t2Aw4+DSlciucvF5R
         jotssCUfpFMS6O+6wxZgAKOoZoHVV9f8HTl0+iSjpYCT1HGZhBFXrd3/8HtuVTjl7RYb
         bfRM/cst8SBFn9Zml/YxCxPxqLQqOnYCl2Dw3TuOxZf/jmFNY5DwqRr7toUCi6oLaFF4
         QE1LSxuIoEwA9v8eqE65TqJLI3JnEvsRzPIWESo/aSVW59lSNU/8gyo04pJUaw4YwwGt
         OFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3jwRzYh5eBRDXKSUjnimUTZgZnImvs3tPqk9uLXKM8=;
        b=ZVUp8p+0DxXTOoA+2kVbq69xUt6XB4Csdg+A/MGXYAUXrXg0dSTAmn4l0nLAcZgq43
         rRYdDmJD7Zr7fX6e22AeR2u3R+Ei5GMg+ZEUr3vliPEotVVCBoxi3ohp98EEcQrsbpgH
         u370ICAIgmD3aI+jBe2N85y+GIiEaPUI2XytDqU9px+HMGt6XPXMHkmGA2oes04Up3xE
         dK1fhO1j0AP0tkmwZaHpf0sNRhHogbX++DQpWDakKn0w3R8T+ijjzVV0R3i14POEwaC+
         xzy0jwoPValSi2uOjFwWxEf1VDQlzIiEFfiLPpfL8Ee6KhU5ggFbarfQ5SUIq46NZ1rR
         0U5A==
X-Gm-Message-State: AOAM530z+RPc27hvkc7/Bd4hjcDtlOL9v9Gn2yvGBK1+Vtqen+TdVJZo
        qUmziNek1rkOSQwTnjMT+pvIwJd/dkN4NeXvCV8=
X-Google-Smtp-Source: ABdhPJyDEv/rHjyCS4JMHft6qsXpnMX+lNmHydsgOhE+h0eF4acHxdAjpVUYkUc61MNhiw0Te7O/Sse7gIf5gynlGgY=
X-Received: by 2002:a63:4e49:: with SMTP id o9mr13956352pgl.61.1605805739158;
 Thu, 19 Nov 2020 09:08:59 -0800 (PST)
MIME-Version: 1.0
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain> <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
 <20201118113117.GF182763@stefanha-x1.localdomain> <20201119094315-mutt-send-email-mst@kernel.org>
 <ceebdc90-3ffc-1563-ff85-12a848bcba18@oracle.com> <CAJSP0QUvSwX5NCPmfSODV_C+D41E21LZT=oXQ2PLc6baAsGGDQ@mail.gmail.com>
 <ffd88f0c-981e-a102-4b08-f29d6b9a0f71@oracle.com>
In-Reply-To: <ffd88f0c-981e-a102-4b08-f29d6b9a0f71@oracle.com>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Thu, 19 Nov 2020 17:08:47 +0000
Message-ID: <CAJSP0QUfqd=QNFa-RikH4dVcLmfcP-pYCwznP3W0zobYkM+KDw@mail.gmail.com>
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
To:     Mike Christie <michael.christie@oracle.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, fam <fam@euphon.net>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        qemu-devel <qemu-devel@nongnu.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        target-devel <target-devel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Nov 19, 2020 at 4:43 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/19/20 10:24 AM, Stefan Hajnoczi wrote:
> > On Thu, Nov 19, 2020 at 4:13 PM Mike Christie
> > <michael.christie@oracle.com> wrote:
> >>
> >> On 11/19/20 8:46 AM, Michael S. Tsirkin wrote:
> >>> On Wed, Nov 18, 2020 at 11:31:17AM +0000, Stefan Hajnoczi wrote:
> > struct vhost_run_worker_info {
> >      struct timespec *timeout;
> >      sigset_t *sigmask;
> >
> >      /* List of virtqueues to process */
> >      unsigned nvqs;
> >      unsigned vqs[];
> > };
> >
> > /* This blocks until the timeout is reached, a signal is received, or
> > the vhost device is destroyed */
> > int ret = ioctl(vhost_fd, VHOST_RUN_WORKER, &info);
> >
> > As you can see, userspace isn't involved with dealing with the
> > requests. It just acts as a thread donor to the vhost driver.
> >
> > We would want the VHOST_RUN_WORKER calls to be infrequent to avoid the
> > penalty of switching into the kernel, copying in the arguments, etc.
>
> I didn't get this part. Why have the timeout? When the timeout expires,
> does userspace just call right back down to the kernel or does it do
> some sort of processing/operation?
>
> You could have your worker function run from that ioctl wait for a
> signal or a wake up call from the vhost_work/poll functions.

An optional timeout argument is common in blocking interfaces like
poll(2), recvmmsg(2), etc.

Although something can send a signal to the thread instead,
implementing that in an application is more awkward than passing a
struct timespec.

Compared to other blocking calls we don't expect
ioctl(VHOST_RUN_WORKER) to return soon, so maybe the timeout will
rarely be used and can be dropped from the interface.

BTW the code I posted wasn't a carefully thought out proposal :). The
details still need to be considered and I'm going to be offline for
the next week so maybe someone else can think it through in the
meantime.

Stefan
