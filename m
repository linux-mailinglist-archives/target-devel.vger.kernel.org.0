Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB94842B759
	for <lists+target-devel@lfdr.de>; Wed, 13 Oct 2021 08:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhJMGfM (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Oct 2021 02:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbhJMGfJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:35:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6224C061767
        for <target-devel@vger.kernel.org>; Tue, 12 Oct 2021 23:33:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kk10so1421725pjb.1
        for <target-devel@vger.kernel.org>; Tue, 12 Oct 2021 23:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WOss03228JS+U0E2OXL79/LG2Z2ctX8IyohOEDd3STQ=;
        b=SG8eTx4PGHBkPjipBIRHezrGg40X7FKDH3dcqzGEh0ZG/tSW8qND+TAMrNp3f/wqwx
         MhgHQ6qj4VZF73LZ68/IqBwYNjD0oJqF3VY+z4T9q23FV/6ltSnjivxfcuufOGGKlehP
         NgIRnRpzLQoV7Ik4Dnr+7MYlEdDMy98DEnQAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WOss03228JS+U0E2OXL79/LG2Z2ctX8IyohOEDd3STQ=;
        b=nBHf5F0R6DL/KRpR7ASaSRNR9iWASLytRoFWKD37wvDweD6Iv+PFgmS4KPo8GVE5WR
         InoAT/fTHgzub1ISqCkVe96YKHTdXoGf0LOeQfB8Mi8+zmgKVFlwoUxTudwIhVg6De8a
         40IZP6sy32hcUFuOzyHP0Qbebd5gGnfxL9vvnY7Y18IhXDxh1OPN19ZvDNKIB+6FwaAL
         Y+RtQi7MDjNdhwKDzTI1L2QsUIaq7ayoju1Ix5GC5Nidvkw0nDmUaW9w7YATfls4W1QP
         3A4touh1vlPW5yy/0ZDoJMiTPYQnhgDV/bE6+8u1A08rai47rKzLkmHjGeQR13Z+FqZt
         mvaQ==
X-Gm-Message-State: AOAM53093//5/lzBuc/8l+bcgVGaWGxJ6rlx/YXqBKqTxXnc4mB9FYXi
        +eSrRPL1+JhTaA2Akglo5PzHPQ==
X-Google-Smtp-Source: ABdhPJznx7wYhVexbMFNDV4dCepvElOzihP1I4t7IwLHfcLc7mdWs+S7z03dgD05iBEaGZ31xHHwig==
X-Received: by 2002:a17:90b:368a:: with SMTP id mj10mr2200890pjb.201.1634106786111;
        Tue, 12 Oct 2021 23:33:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r31sm4746519pjg.28.2021.10.12.23.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:33:05 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:33:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 27/29] ntfs: use sb_bdev_nr_blocks
Message-ID: <202110122332.53B5925A@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-28-hch@lst.de>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:40AM +0200, Christoph Hellwig wrote:
> Use the sb_bdev_nr_blocks helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ntfs/super.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 0d7e948cb29c9..5ae8de09b271b 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -2772,13 +2772,12 @@ static int ntfs_fill_super(struct super_block *sb, void *opt, const int silent)
>  	ntfs_debug("Set device block size to %i bytes (block size bits %i).",
>  			blocksize, sb->s_blocksize_bits);
>  	/* Determine the size of the device in units of block_size bytes. */
> -	if (!i_size_read(sb->s_bdev->bd_inode)) {
> +	vol->nr_blocks = sb_bdev_nr_blocks(sb);
> +	if (!vol->nr_blocks) {

I might be worth mentioning in the commit log why this is safe (i.e. the
"side effect" of the assignment doesn't need to be delayed since it will
be thrown away in the failure path).

>  		if (!silent)
>  			ntfs_error(sb, "Unable to determine device size.");
>  		goto err_out_now;
>  	}
> -	vol->nr_blocks = i_size_read(sb->s_bdev->bd_inode) >>
> -			sb->s_blocksize_bits;
>  	/* Read the boot sector and return unlocked buffer head to it. */
>  	if (!(bh = read_ntfs_boot_sector(sb, silent))) {
>  		if (!silent)
> @@ -2816,8 +2815,7 @@ static int ntfs_fill_super(struct super_block *sb, void *opt, const int silent)
>  			goto err_out_now;
>  		}
>  		BUG_ON(blocksize != sb->s_blocksize);
> -		vol->nr_blocks = i_size_read(sb->s_bdev->bd_inode) >>
> -				sb->s_blocksize_bits;
> +		vol->nr_blocks = sb_bdev_nr_blocks(sb);
>  		ntfs_debug("Changed device block size to %i bytes (block size "
>  				"bits %i) to match volume sector size.",
>  				blocksize, sb->s_blocksize_bits);

Reviewed-by: Kees Cook <keescook@chromium.org>


> -- 
> 2.30.2
> 

-- 
Kees Cook
