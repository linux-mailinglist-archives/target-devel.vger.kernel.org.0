Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288EC42B6A8
	for <lists+target-devel@lfdr.de>; Wed, 13 Oct 2021 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhJMGQf (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Oct 2021 02:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbhJMGQb (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:16:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C18C061767
        for <target-devel@vger.kernel.org>; Tue, 12 Oct 2021 23:14:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y1so1076926plk.10
        for <target-devel@vger.kernel.org>; Tue, 12 Oct 2021 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cU/dcevRRiOMyYUwUWALBmXmlvE8es1M77S7S7Vy3hg=;
        b=V/PklmmvmwB6oF28+X9W5oSqUy3MEBQUnBb4J2bRKEg/eIXO/xXpeqqwQGZrKIWhNv
         T8ctXe4hPipGRmAP9ugd0bC7MXlyH2K83qjMXuuXIhufHwq0vvnSHMGq1LP/1SN2Yv7x
         bKng84M/wOhI7OL1CmIwsfNERqhd12BkP84hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cU/dcevRRiOMyYUwUWALBmXmlvE8es1M77S7S7Vy3hg=;
        b=YLP0qosYfIRaNMdKe2gJBLDOE2Qtd0WZKbPiqKLF7BeoRhFgUPiIk2lkOKttfpcOOC
         QBsTqnxOwsiCL07UTV6qxvXKQ/7hEi7xVzf5rGuVXQmLrPJnKj+4zVidleDXz1P/P/z2
         W9kA2YO6mBp+pr8SIASTnovG32Q/eBQktNMX5hY4ePnKC07KK4fNU1Cm4qZR3IroOe4O
         cRjcKbwyA5TRYXG8sTJtAyIK4W91SVbPFH3IXHjzBr84+5paPm7mTTLOAfZZwmiWGEw5
         en4ndS6VzUEBMfUwElw5eSyDfOzC9+GCBEwJxtW4UBFhMS2MmvznY7WREi8rad1SF4+S
         KhDA==
X-Gm-Message-State: AOAM531J6nowvzoaE5zt8JhPCLR9KzI/xTnV3KW0x/eCddrkTvGowoRv
        Io1T1Bh+xH+p0v/RFdnKo31ALA==
X-Google-Smtp-Source: ABdhPJzB9T5WPRLBzlHsv86tToIXEU4uRcFKAiECkCtvwz0iUp/WDY5ZssCw0V4lwGrfF5Bgew0Phw==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr10958091pjn.69.1634105664752;
        Tue, 12 Oct 2021 23:14:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o6sm12981960pfp.79.2021.10.12.23.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:14:24 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:14:23 -0700
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
Subject: Re: [PATCH 10/29] affs: use bdev_nr_sectors instead of open coding it
Message-ID: <202110122314.6BE3F05AA3@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-11-hch@lst.de>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:23AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
