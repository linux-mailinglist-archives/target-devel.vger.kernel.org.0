Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4157926244D
	for <lists+target-devel@lfdr.de>; Wed,  9 Sep 2020 02:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgIIA4D (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 8 Sep 2020 20:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIIA4B (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 8 Sep 2020 20:56:01 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9626421D40;
        Wed,  9 Sep 2020 00:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599612960;
        bh=RvzjuGzz/kTSEdxXHggSfWjCrdq+3b4CqDYSDYaXs48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QCrNHxqhyTNUbEUBWg7m5RppKYxhztDiw//6ubU7/VQofyzcTv22t1N98zavCtLup
         QysnOQsfy4G3tScSXrtRl0tR2KP2W+WLMdIRlzmAp5TUK0MJw/rxTcC/h816xb25+8
         K183C1Rs3MqMJKmfCbVj974g3dCS/0aa3QBb0zJU=
Received: by mail-lj1-f173.google.com with SMTP id a15so1304276ljk.2;
        Tue, 08 Sep 2020 17:56:00 -0700 (PDT)
X-Gm-Message-State: AOAM532WrJ4gIibYUTQl9nOlAcrxw9EtcERfolk57Gmhgq+WaeAMceDL
        0x38q0EWLgveQT4DskbpHXZ+OS3051v6kqNMutM=
X-Google-Smtp-Source: ABdhPJxM7jCblK+I3K12WYnFdTKastGkaOpZLr2TCZ6RdAZ0LK1RcX7wDsfx2yoNcvq/FpYJy3EsInbbGExnKObCwTE=
X-Received: by 2002:a2e:9c8d:: with SMTP id x13mr523960lji.392.1599612958934;
 Tue, 08 Sep 2020 17:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200903054104.228829-1-hch@lst.de> <20200903054104.228829-5-hch@lst.de>
In-Reply-To: <20200903054104.228829-5-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 8 Sep 2020 17:55:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW62Cd329s-LUR9uQVcFvn4pbOj7H0434P7zwRhbNVScgA@mail.gmail.com>
Message-ID: <CAPhsuW62Cd329s-LUR9uQVcFvn4pbOj7H0434P7zwRhbNVScgA@mail.gmail.com>
Subject: Re: [PATCH 4/9] md: don't detour through bd_contains for the gendisk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-ide@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Sep 2, 2020 at 10:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> bd_disk is set on all block devices, including those for partitions.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md.c | 2 +-
>  drivers/md/md.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 3f33562d10d6f5..5a0fd93769a70e 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8444,7 +8444,7 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>         idle = 1;
>         rcu_read_lock();
>         rdev_for_each_rcu(rdev, mddev) {
> -               struct gendisk *disk = rdev->bdev->bd_contains->bd_disk;
> +               struct gendisk *disk = rdev->bdev->bd_disk;
>                 curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
>                               atomic_read(&disk->sync_io);
>                 /* sync IO will cause sync_io to increase before the disk_stats
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index f9e2ccdd22c478..2175a5ac4f7c68 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -551,7 +551,7 @@ extern void mddev_unlock(struct mddev *mddev);
>
>  static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
>  {
> -       atomic_add(nr_sectors, &bdev->bd_contains->bd_disk->sync_io);
> +       atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
>  }
>
>  static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
> --
> 2.28.0
>
