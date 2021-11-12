Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23E044E9DF
	for <lists+target-devel@lfdr.de>; Fri, 12 Nov 2021 16:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhKLPW2 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 12 Nov 2021 10:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229975AbhKLPW1 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636730376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFN3YfKrrN4rviirmH1lG0NY9uufAM6YHK0vPxccEaw=;
        b=IEmTYYOVu8mnNf8dncwvv63iPXnTzw+SDFVpHEr5SCq5O1ZxbPCmPqq7Wdw97KhFccVCcs
        PpvF0X6sLfvePo+htyPszZOVP9OPJFw+TC9+/jUt+DHqLVkcJdZ2V8c3AfrjHJX4R0Iaf/
        vTUFGcudgKajU4OGV7+iJCc739D3CyQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-4WKBf9p7Nd2MyhIqVyBosw-1; Fri, 12 Nov 2021 10:19:35 -0500
X-MC-Unique: 4WKBf9p7Nd2MyhIqVyBosw-1
Received: by mail-qv1-f72.google.com with SMTP id kl17-20020a056214519100b003ba5b03606fso8738727qvb.0
        for <target-devel@vger.kernel.org>; Fri, 12 Nov 2021 07:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VFN3YfKrrN4rviirmH1lG0NY9uufAM6YHK0vPxccEaw=;
        b=KPMJpWxJr3EwNTZlOLW873V2Rps74Hoo/B7hHAXqAcRjol3U/eDiYHca9eBCRJvI6+
         qIu41MwC293ILyVRvsFHW1Swji5sAppvKmzOpMXUFOcZXEdnnLddpZ+CWWOSrR6plch5
         xZ9ba26I2xIA6vJ/mAfdIrW/8NUC9qbgR4Pyb5WRVF8zyXFieVMfX9WQfrnYKYrt9XhV
         RPyCt7bQkdgMSNDfNqjEQiETRZWOBdTwLWtbJaKVKGT4KGWNdFDwM5w20Q7+YHCIW9FC
         sxUsnIFl5Turce0aHuqTpqWFmoxlfiVgM/rMcwd+OutmoctUygL8BV5NQ2LGs6cThEvY
         WG+w==
X-Gm-Message-State: AOAM530wFLPjxkNzK5bDReSVvhpB+xkR1/t/4z2fcETo6O7Z6CALeulm
        98/rF5VnOkqvdpLc7unEdKLcXuC8P8laMEdb6jIiwHsV+Ovkz7xAtD9DiyomLDyfDEHtINTclrN
        H4pZC59P7V2Xe+SkdQPx29xg=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr13127476qkh.232.1636730375040;
        Fri, 12 Nov 2021 07:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk6sSDPzw7jrkKAxFn/K0PAx9HKUToVCIsJBG7fV34DkkAlHg0N9AMoil4JWoJAqjFdQQ15g==
X-Received: by 2002:a37:2f02:: with SMTP id v2mr13127438qkh.232.1636730374828;
        Fri, 12 Nov 2021 07:19:34 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id az14sm2791255qkb.125.2021.11.12.07.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:19:34 -0800 (PST)
Date:   Fri, 12 Nov 2021 10:19:33 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 8/8] md: add support for REQ_OP_VERIFY
Message-ID: <YY6GBaSypKNPZnBj@redhat.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-9-chaitanyak@nvidia.com>
 <d770a769-7f2c-bb10-a3bd-0aca371a724e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d770a769-7f2c-bb10-a3bd-0aca371a724e@nvidia.com>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Nov 11 2021 at  3:13P -0500,
Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:

> On 11/3/2021 11:46 PM, Chaitanya Kulkarni wrote:
> > From: Chaitanya Kulkarni <kch@nvidia.com>
> > 
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> I want to make sure the new REQ_OP_VERIFY is compatible with the
> dm side as it is a generic interface.
> 
> Any comments on the dm side ? It will help me to respin the series for
> V1 of this proposal.

I can review, but have you tested your XFS scrub usecase ontop of
the various DM devices you modified?

Also, you seem to have missed Keith's suggestion of using io_uring to
expose this capability.  If you happen to go that route: making sure
DM has required io_uring capabilities would be needed (IIRC there
were/are some lingering patches from Ming Lei to facilitate more
efficient io_uring on DM.. I'll try to find, could be I'm wrong).

Mike

