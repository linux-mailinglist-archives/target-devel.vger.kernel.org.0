Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4613B43852C
	for <lists+target-devel@lfdr.de>; Sat, 23 Oct 2021 22:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJWUNg (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 23 Oct 2021 16:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230142AbhJWUNf (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635019875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aXVp8tyrghvJw92JwPIZDHyEdU7IU/XO1DvnZcDPNf8=;
        b=XfuXp4iYVvrsk4TAOm0e09BL3RJqToocR/nuAcOFt6i4y51FpEimJldNNP2GtEnUjn/JTB
        2HYKPxQxNiwGXxCq5dC1axFg4YVXH0umiQh8a5pmyWs02LRQkVk6Ejjuch0j8WuhwrZ5ZF
        gIVx6t6MZH9fHtILaCoK4S49eH9Rov4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-UvTRYg0tMI6BWr1ZKdbiag-1; Sat, 23 Oct 2021 16:11:13 -0400
X-MC-Unique: UvTRYg0tMI6BWr1ZKdbiag-1
Received: by mail-wm1-f70.google.com with SMTP id l39-20020a05600c1d2700b0030dba1dc6eeso2569896wms.7
        for <target-devel@vger.kernel.org>; Sat, 23 Oct 2021 13:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXVp8tyrghvJw92JwPIZDHyEdU7IU/XO1DvnZcDPNf8=;
        b=ddc9uk2x2LkoHPn3eni7M08SkvxJTOiFtuDg62KJYJFc+crBhhJPzNzJWxRCe1SW9x
         PtKhnSAq0DXV0ZVt+8wAa035bU5883LPtgZ5s61KsgmI0vI7nMgBUJ5bBJJ5nb3MGPcn
         TsjjpK5+fblBGCQ1/SYtZBvi6ugbHwV+DYkoA3ESeyLyHOOZhOA3ZHTEg16/cpJgbZiP
         nmeOstFBodtnB4kKBQ1NO+ywq9AibBsyM8R0CyoaQ7SOfNaZ/IL553ZjXDKcHa8CZGpz
         TTv4XbOKI0ca5TMWALjB7XLp455aO9LSvP3ODpxxAD3tu18MeU6couR7YKClph1UBNff
         2TCQ==
X-Gm-Message-State: AOAM531QhGF6UVr/olDKuo85beX4mLXaf+Gfr5+8VH5NX7UAlI97ddb+
        bpxRZ+H2UW5AOKeOiB/tILPn/36wn3x5vj9aO+9cb7QV+ZCPW0APAeOnT1QQYp4KdJ2zNAtnbVb
        PcSbeJkB/e0ffQcZSrzeGCM13
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr8838240wmq.166.1635019872616;
        Sat, 23 Oct 2021 13:11:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0SYiUm8Dg2wDtDS76O9WIfq6qcZsbjs5OvzyUDna2Kx4HMh0JOKdg+tqLwDRmgRp5+ULpfw==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr8838220wmq.166.1635019872410;
        Sat, 23 Oct 2021 13:11:12 -0700 (PDT)
Received: from redhat.com ([2.55.9.147])
        by smtp.gmail.com with ESMTPSA id f18sm11302380wrg.3.2021.10.23.13.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:11:11 -0700 (PDT)
Date:   Sat, 23 Oct 2021 16:11:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     michael.christie@oracle.com
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
Message-ID: <20211023160838-mutt-send-email-mst@kernel.org>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
 <20211022064359-mutt-send-email-mst@kernel.org>
 <94289c36-431a-513f-9b52-b55225f6b89d@oracle.com>
 <28250f62-ff38-901f-6014-9e975381d523@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28250f62-ff38-901f-6014-9e975381d523@oracle.com>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Oct 22, 2021 at 01:17:26PM -0500, michael.christie@oracle.com wrote:
> On 10/22/21 11:12 AM, michael.christie@oracle.com wrote:
> > On 10/22/21 5:47 AM, Michael S. Tsirkin wrote:
> >>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >>> index c998860d7bbc..e5c0669430e5 100644
> >>> --- a/include/uapi/linux/vhost.h
> >>> +++ b/include/uapi/linux/vhost.h
> >>> @@ -70,6 +70,17 @@
> >>>  #define VHOST_VRING_BIG_ENDIAN 1
> >>>  #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
> >>>  #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> >>> +/* By default, a device gets one vhost_worker created during VHOST_SET_OWNER
> >>> + * that its virtqueues share. This allows userspace to create a vhost_worker
> >>> + * and map a virtqueue to it or map a virtqueue to an existing worker.
> >>> + *
> >>> + * If pid > 0 and it matches an existing vhost_worker thread it will be bound
> >>> + * to the vq. If pid is VHOST_VRING_NEW_WORKER, then a new worker will be
> >>> + * created and bound to the vq.
> >>> + *
> >>> + * This must be called after VHOST_SET_OWNER and before the vq is active.
> >>> + */
> >>
> >> A couple of things here:
> >> it's probably a good idea not to make it match pid exactly,
> >> if for no other reason than I'm not sure we want to
> >> commit this being a pid. Let's just call it an id?
> > 
> > Ok.
> > 
> >> And maybe byteswap it or xor with some value
> >> just to make sure userspace does not begin abusing it anyway.
> >>
> >> Also, interaction with pid namespace is unclear to me.
> >> Can you document what happens here?
> > 
> > This current patchset only allows the vhost_dev owner to
> > create/bind workers for devices it owns, so namespace don't come
> 
> I made a mistake here. The patches do restrict VHOST_SET_VRING_WORKER
> to the same owner like I wrote. However, it looks like we could have 2
> threads with the same mm pointer so vhost_dev_check_owner returns true,
> but they could be in different namespaces.
> 
> Even though we are not going to pass the pid_t between user/kernel
> space, should I add a pid namespace check when I repost the patches?

Um it's part of the ioctl. How you are not going to pass it around?

So if we do worry about this, I would just make it a 64 bit integer,
rename it "id" and increment each time a thread is created.
 
> 
> > into play. If a thread from another namespace tried to create/bind
> > a worker we would hit the owner checks in vhost_dev_ioctl which is
> > done before vhost_vring_ioctl normally (for vdpa we hit the use_worker
> > check and fail there).
> > 
> > However, with the kernel worker API changes the worker threads will
> > now be in the vhost dev owner's namespace and not the kthreadd/default
> > one, so in the future we are covered if we want to do something more
> > advanced. For example, I've seen people working on an API to export the
> > worker pids:
> > 
> > https://lore.kernel.org/netdev/20210507154332.hiblsd6ot5wzwkdj@steredhat/T/
> > 
> > and in the future for interfaces that export that info we could restrict
> > access to root or users from the same namespace or I guess add interfaces
> > to allow different namespaces to see the workers and share them.
> > 
> > 
> >> No need to fix funky things like moving the fd between
> >> pid namespaces while also creating/destroying workers, but let's
> >> document it's not supported.
> > 
> > Ok. I'll add a comment.
> > 

