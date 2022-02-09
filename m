Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427514AF3D3
	for <lists+target-devel@lfdr.de>; Wed,  9 Feb 2022 15:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiBIOMc (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 9 Feb 2022 09:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiBIOMa (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:12:30 -0500
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 06:12:25 PST
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD681C05CB89;
        Wed,  9 Feb 2022 06:12:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 35FB767373; Wed,  9 Feb 2022 15:04:49 +0100 (CET)
Date:   Wed, 9 Feb 2022 15:04:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, target-devel@vger.kernel.org,
        haris.iqbal@ionos.com, manoj@linux.ibm.com, mrochs@linux.ibm.com,
        ukrishn@linux.ibm.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com
Subject: Re: [PATCH 3/7] rnbd: drop WRITE_SAME support
Message-ID: <20220209140448.GA20765@lst.de>
References: <20220209082828.2629273-1-hch@lst.de> <20220209082828.2629273-4-hch@lst.de> <CAMGffE=GMYNsw+mDt1h-BDh3JXkdrP9v2AUF7z0xE7jkumM+RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=GMYNsw+mDt1h-BDh3JXkdrP9v2AUF7z0xE7jkumM+RQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Feb 09, 2022 at 11:16:13AM +0100, Jinpu Wang wrote:
> Hi Christoph,
> 
> 
> On Wed, Feb 9, 2022 at 9:28 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > REQ_OP_WRITE_SAME was only ever submitted by the legacy Linux zeroing
> > code, which has switched to use REQ_OP_WRITE_ZEROES long before rnbd was
> > even merged.
> 
> Do you think if it makes sense to instead of removing
> REQ_OP_WRITE_SAME, simply convert it to REQ_OP_WRITE_ZEROES?

Well, they have different semantics, so you can't just "convert" it.
But it might make sense to add REQ_OP_WRITE_ZEROES.
