Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4704AEDBE
	for <lists+target-devel@lfdr.de>; Wed,  9 Feb 2022 10:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiBIJNh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 9 Feb 2022 04:13:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiBIJNf (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:13:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4380CDF498BD
        for <target-devel@vger.kernel.org>; Wed,  9 Feb 2022 01:13:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id fy20so5551689ejc.0
        for <target-devel@vger.kernel.org>; Wed, 09 Feb 2022 01:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A0aS6PsHWqLfuEf0mpE1atYMX0+ueYp+jlUgmxEtLqY=;
        b=DX92WZhCC8pRPSGw5ySiXzzQ8Gfpfd4r+qOKBeQ+3hwXptsaaV61BwpN1/bKIW3J0g
         hmRXfRjLR13U72gyHqk3KSurv6aiykgsCYy0QdScn98FdtLnHuaPUULwzx91BfOKnwlt
         T+uuXhCv0nadD0qN257lXBfSWaU4ug8bfmvdQo+5V6aPFNWDRhFjyJW9JhHzPl2okBE/
         Z+Ws3dzLhvmP8GoQub78NMyDQ3NW5aDSovD9axM2F/if4/8MDZwD7rQjMCTgULbBaN97
         /gs0bf/1OCVWWdqytVgtXqFdk6OVNDQ6edClQeV6Oo4jxSteyXz10xueZRfvVzEB1iAp
         Vc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A0aS6PsHWqLfuEf0mpE1atYMX0+ueYp+jlUgmxEtLqY=;
        b=TeOkCtQfLTMq8L4qjaCzK0ujKLCr7cCTYmyY6pNQav6OQik6y3OciJ6mCukElm0w8D
         nshmdCAROshyUOuN2q2no9Im8g/0kYHbbQex9mgMKcDqhCbGMEXNHYLO8AXQNqJ2zXrl
         BucMoAQ16ntxStSQMuQvRgl7pOPFknCI87X8gMGbvOuLZdG/3E5a4nMm29IqBUdRTqPE
         +psF5YhSOOsIDfVvkqrG4+VRClXwwvqGlq1EOFDPqVTSKe2+ga1ymaD9VPaDEg744XT4
         +3cY2TylK+xALT8rNedYariYwjBRzP169jJYOs0V1JbhkGY7kDDypDh1o/043nKjpTvY
         GEqw==
X-Gm-Message-State: AOAM530FfnA6UPIuJuncRuyfuM2TQlz7Bz3gccRBxe+UvgSEG7Fdu5iP
        hpSGQjbNqQmgxiHyZ3cf9ahKqkCONjpk0lDSr8bOHw==
X-Google-Smtp-Source: ABdhPJwXBtBmq59kwj593KMdIS7kgVxhoLsds+ZjZ43rf+IIYpSxMGmDPqwgtWYgnVZDMIdJ2pvE/ZGIfbLuC68TslE=
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr1012913eji.441.1644397998273;
 Wed, 09 Feb 2022 01:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20220209082828.2629273-1-hch@lst.de> <20220209082828.2629273-4-hch@lst.de>
 <4f1565b2-0f83-0cfa-58bd-86d5dee48e51@linux.dev>
In-Reply-To: <4f1565b2-0f83-0cfa-58bd-86d5dee48e51@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 9 Feb 2022 10:13:07 +0100
Message-ID: <CAMGffE=FmVj26PJtu5fwtr3rNbtE+-dcfxOrmT4hEt3sO7Kw2A@mail.gmail.com>
Subject: Re: [PATCH 3/7] rnbd: drop WRITE_SAME support
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, target-devel@vger.kernel.org,
        haris.iqbal@ionos.com, manoj@linux.ibm.com, mrochs@linux.ibm.com,
        ukrishn@linux.ibm.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Feb 9, 2022 at 10:05 AM Guoqing Jiang <guoqing.jiang@linux.dev> wro=
te:
>
>
>
> On 2/9/22 4:28 PM, Christoph Hellwig wrote:
> > REQ_OP_WRITE_SAME was only ever submitted by the legacy Linux zeroing
> > code, which has switched to use REQ_OP_WRITE_ZEROES long before rnbd wa=
s
> > even merged.
> >
> > Signed-off-by: Christoph Hellwig<hch@lst.de>
> > ---
> >   drivers/block/rnbd/rnbd-clt.c   | 7 ++-----
> >   drivers/block/rnbd/rnbd-clt.h   | 1 -
> >   drivers/block/rnbd/rnbd-proto.h | 6 ------
> >   drivers/block/rnbd/rnbd-srv.c   | 3 +--
> >   4 files changed, 3 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-cl=
t.c
> > index c08971de369fc..dc192d2738854 100644
> > --- a/drivers/block/rnbd/rnbd-clt.c
> > +++ b/drivers/block/rnbd/rnbd-clt.c
> > @@ -82,7 +82,6 @@ static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev =
*dev,
> >       dev->nsectors               =3D le64_to_cpu(rsp->nsectors);
> >       dev->logical_block_size     =3D le16_to_cpu(rsp->logical_block_si=
ze);
> >       dev->physical_block_size    =3D le16_to_cpu(rsp->physical_block_s=
ize);
> > -     dev->max_write_same_sectors =3D le32_to_cpu(rsp->max_write_same_s=
ectors);
> >       dev->max_discard_sectors    =3D le32_to_cpu(rsp->max_discard_sect=
ors);
> >       dev->discard_granularity    =3D le32_to_cpu(rsp->discard_granular=
ity);
> >       dev->discard_alignment      =3D le32_to_cpu(rsp->discard_alignmen=
t);
> > @@ -1359,8 +1358,6 @@ static void setup_request_queue(struct rnbd_clt_d=
ev *dev)
> >       blk_queue_logical_block_size(dev->queue, dev->logical_block_size)=
;
> >       blk_queue_physical_block_size(dev->queue, dev->physical_block_siz=
e);
> >       blk_queue_max_hw_sectors(dev->queue, dev->max_hw_sectors);
> > -     blk_queue_max_write_same_sectors(dev->queue,
> > -                                      dev->max_write_same_sectors);
> >
> >       /*
> >        * we don't support discards to "discontiguous" segments
> > @@ -1610,10 +1607,10 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const =
char *sessname,
> >       }
> >
> >       rnbd_clt_info(dev,
> > -                    "map_device: Device mapped as %s (nsectors: %zu, l=
ogical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d,=
 max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, s=
ecure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d, wc=
: %d, fua: %d)\n",
> > +                    "map_device: Device mapped as %s (nsectors: %zu, l=
ogical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, di=
scard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segme=
nts: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
> >                      dev->gd->disk_name, dev->nsectors,
> >                      dev->logical_block_size, dev->physical_block_size,
> > -                    dev->max_write_same_sectors, dev->max_discard_sect=
ors,
> > +                    dev->max_discard_sectors,
> >                      dev->discard_granularity, dev->discard_alignment,
> >                      dev->secure_discard, dev->max_segments,
> >                      dev->max_hw_sectors, dev->rotational, dev->wc, dev=
->fua);
> > diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-cl=
t.h
> > index 0c2cae7f39b9f..6946ba23d62e5 100644
> > --- a/drivers/block/rnbd/rnbd-clt.h
> > +++ b/drivers/block/rnbd/rnbd-clt.h
> > @@ -122,7 +122,6 @@ struct rnbd_clt_dev {
> >       bool                    wc;
> >       bool                    fua;
> >       u32                     max_hw_sectors;
> > -     u32                     max_write_same_sectors;
> >       u32                     max_discard_sectors;
> >       u32                     discard_granularity;
> >       u32                     discard_alignment;
>
> I am planning to remove more members inside struct rnbd_clt_dev.
>
> > diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-=
proto.h
> > index de5d5a8df81d7..3eb8b34bd1886 100644
> > --- a/drivers/block/rnbd/rnbd-proto.h
> > +++ b/drivers/block/rnbd/rnbd-proto.h
> > @@ -249,9 +249,6 @@ static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
> >       case RNBD_OP_SECURE_ERASE:
> >               bio_opf =3D REQ_OP_SECURE_ERASE;
> >               break;
> > -     case RNBD_OP_WRITE_SAME:
> > -             bio_opf =3D REQ_OP_WRITE_SAME;
> > -             break;
> >       default:
> >               WARN(1, "Unknown RNBD type: %d (flags %d)\n",
> >                    rnbd_op(rnbd_opf), rnbd_opf);
> > @@ -284,9 +281,6 @@ static inline u32 rq_to_rnbd_flags(struct request *=
rq)
> >       case REQ_OP_SECURE_ERASE:
> >               rnbd_opf =3D RNBD_OP_SECURE_ERASE;
> >               break;
> > -     case REQ_OP_WRITE_SAME:
> > -             rnbd_opf =3D RNBD_OP_WRITE_SAME;
> > -             break;
> >       case REQ_OP_FLUSH:
> >               rnbd_opf =3D RNBD_OP_FLUSH;
> >               break;
> > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-sr=
v.c
> > index 132e950685d59..0e6b5687f8321 100644
> > --- a/drivers/block/rnbd/rnbd-srv.c
> > +++ b/drivers/block/rnbd/rnbd-srv.c
> > @@ -548,8 +548,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_=
msg_open_rsp *rsp,
> >               cpu_to_le16(rnbd_dev_get_max_segs(rnbd_dev));
> >       rsp->max_hw_sectors =3D
> >               cpu_to_le32(rnbd_dev_get_max_hw_sects(rnbd_dev));
> > -     rsp->max_write_same_sectors =3D
> > -             cpu_to_le32(bdev_write_same(rnbd_dev->bdev));
> > +     rsp->max_write_same_sectors =3D 0;
>
> IIUC, I think we can delete max_write_same_sectors from rsp as well given
> the earlier change in setup_request_queue and rnbd_clt_set_dev_attr.
No, I don't think it's a good idea, we need to keep the protocol
compatible, so client for old kernel version
won't be confused.

The patch looks good to me, but I want to run a regression test before
give an acked.

Thanks!
Jinpu
>
> Thanks,
> Guoqing
