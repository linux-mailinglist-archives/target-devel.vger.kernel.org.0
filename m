Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C288E68220F
	for <lists+target-devel@lfdr.de>; Tue, 31 Jan 2023 03:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAaCc1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 30 Jan 2023 21:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAaCcV (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310727D68
        for <target-devel@vger.kernel.org>; Mon, 30 Jan 2023 18:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675132292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=utT+RE/MkgWVBG/iNzPiYM+H0kp8FILH2HeviGKceUM=;
        b=iIdtkuaYs/BbKRcsDyPG4Mg1BhleizrqjVxD6N8jBFBJKZKa+V2jcEeS+3JNbPSeNvLCet
        yGh12u5zvC4SuQCq19HlLglg5OMYNSII0ZXAeUIjkN5J3tH2Ke7MmqIrLuCL3AhPLL1fWm
        E2CYPaFkiXa2KYKOOQa3iHQY2fjUXek=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-5xmg9KFmMJuqEcbfaZG8cw-1; Mon, 30 Jan 2023 21:31:29 -0500
X-MC-Unique: 5xmg9KFmMJuqEcbfaZG8cw-1
Received: by mail-ot1-f70.google.com with SMTP id w9-20020a9d5a89000000b0068bc6c8621eso3162846oth.9
        for <target-devel@vger.kernel.org>; Mon, 30 Jan 2023 18:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utT+RE/MkgWVBG/iNzPiYM+H0kp8FILH2HeviGKceUM=;
        b=ct0g0FyuRa+yzdi9O+Y+gFdDVTslM6PM2QVmqaoIlyy1yE3bUIRk14Qh6L/myKMrrE
         a4CDDHbKaa5RY1jQzfquRRiY/aoL2yLFkUAY4PWt4qUuvHJDDL54Cd4NydjguRFgcOjF
         drR/nnNp1AgqmN27g45BYzUBDNyD074ukxdByIYYg9YGsGPUAwpwxQXLyQcu2UIKb17N
         xVmL/d3TTv0p5Icnf1N4U158npgY3gbjKKwhx8/7Wk99L0WNinsudJHZw2sW9i+0UkDP
         aJhdFI1UAqKIA2r9RN2YdPRRFUwnsmkHScMX0GSzDFODeRa3E+5tkvB4oCFcyJDSOTUB
         cm+Q==
X-Gm-Message-State: AFqh2kr6cWtAAoEMf43rP6osFUX0Gv1tg6CKPTcnRjdBf2nJL8KH2pAj
        XwS8ezhltDi6S0sDiHVMIFvzyhsF2IVYMOE5IoJYzPZHdQ9zt9t+qb3jMmwsrpBGCWHC8TqZKHF
        ImUAVX9Fuvs5Fb4mdHA3JXsnK23hdZxU34Krbxwnu
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id m126-20020aca3f84000000b0036ef5f8cce1mr1057780oia.35.1675132289138;
        Mon, 30 Jan 2023 18:31:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXssco6mBUOhDTHWFT4/t2hB47krC6OsHE12Ww1f+hysvA2CpNEADdT3xvxh0DzmLnnFuHE/ftXAK22WOSTVfWk=
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id
 m126-20020aca3f84000000b0036ef5f8cce1mr1057763oia.35.1675132288910; Mon, 30
 Jan 2023 18:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20230130092157.1759539-1-hch@lst.de> <20230130092157.1759539-23-hch@lst.de>
In-Reply-To: <20230130092157.1759539-23-hch@lst.de>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 31 Jan 2023 10:31:18 +0800
Message-ID: <CACGkMEsPvy5jVWA7AHJkyRKa8-xr9oi4DUAzBcU0pQ_n4rqCFA@mail.gmail.com>
Subject: Re: [PATCH 22/23] vring: use bvec_set_page to initialize a bvec
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Jan 30, 2023 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the bvec_set_page helper to initialize a bvec.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

A typo in the subject, should be "vringh".

Other than this

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vringh.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 33eb941fcf1546..a1e27da544814a 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1126,9 +1126,8 @@ static int iotlb_translate(const struct vringh *vrh,
>                 size = map->size - addr + map->start;
>                 pa = map->addr + addr - map->start;
>                 pfn = pa >> PAGE_SHIFT;
> -               iov[ret].bv_page = pfn_to_page(pfn);
> -               iov[ret].bv_len = min(len - s, size);
> -               iov[ret].bv_offset = pa & (PAGE_SIZE - 1);
> +               bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, size),
> +                             pa & (PAGE_SIZE - 1));
>                 s += size;
>                 addr += size;
>                 ++ret;
> --
> 2.39.0
>

