Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02E542B669
	for <lists+target-devel@lfdr.de>; Wed, 13 Oct 2021 08:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhJMGLo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Oct 2021 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbhJMGLm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:11:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9461C061749
        for <target-devel@vger.kernel.org>; Tue, 12 Oct 2021 23:09:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n11so1084478plf.4
        for <target-devel@vger.kernel.org>; Tue, 12 Oct 2021 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z0+/l2JzZcIMvRxuVnPDxpTt0N87/VTetFSC9UipIbo=;
        b=dDm5KKH54Cm+jQj+Mhb1k8rvRxfJNbsL/HRxrPpWdrzH1k+JCSsBgY9A1wItnAnyuP
         9ultcLUzRn7czy1OW9j2NX2hgXb5hjl16HGUd04L8fCWxy7FcQb0Xj95F86MpdxVurhd
         +Yoq3Vcva7UyTZ4UkXIHSgLR2MTnO/N9XCsr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z0+/l2JzZcIMvRxuVnPDxpTt0N87/VTetFSC9UipIbo=;
        b=kdqosJJSNnO9+rqYS3yeAT2coiVcrgWFlDq6TycFz1UM7+4707yoOkqlGc/erHuKr9
         J9nsc3O38I/aPg3+qIQOanmAJTqe3VWDsp9Q7wfOwDDVF8zk4o70nIMFWXl93Au/4Ur6
         r90rjzUNJjVqKbZepjvRhcwzt/dnnz4KIPBr8Hq8yu4muPBxniD4f9T3ETX/sEOLP41y
         hs4y7JzhLcj72+u4smPs/CPvsiiDWjcdAc9jhgc/FmRnoI3XXeTt+jQrJcVUrafNER7V
         SqGjPEWelV1qYYBOzn1KkcgxZv4orOGJ/IhS2B2fdDEV4vxCmRJ3iXaL0JB3rtUUWFkz
         GTmA==
X-Gm-Message-State: AOAM533n2JGjik/iHL30Qrh9yyEglVgFtrKyBdxgC5RZODngtndp6tap
        82p0i5OpaQmi6vTFOovWY51M1Q==
X-Google-Smtp-Source: ABdhPJx1Mq3qptD5w3g2Y6okZL9tWnjLnFrTXEu5gKzk6Wq6AX2hVHSkDjnl1IkjZGDzNZT+Poo5bw==
X-Received: by 2002:a17:902:b593:b0:12d:7aa5:de2d with SMTP id a19-20020a170902b59300b0012d7aa5de2dmr34892215pls.31.1634105379132;
        Tue, 12 Oct 2021 23:09:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nn14sm5323477pjb.27.2021.10.12.23.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:09:38 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:09:38 -0700
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
Subject: Re: [PATCH 02/29] drbd: use bdev_nr_sectors instead of open coding it
Message-ID: <202110122309.FB5CB2DE3@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-3-hch@lst.de>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:15AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
