Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450694B995F
	for <lists+target-devel@lfdr.de>; Thu, 17 Feb 2022 07:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiBQGoJ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 17 Feb 2022 01:44:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBQGoI (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:44:08 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D2178386;
        Wed, 16 Feb 2022 22:43:54 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AD69868B05; Thu, 17 Feb 2022 07:43:49 +0100 (CET)
Date:   Thu, 17 Feb 2022 07:43:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        target-devel@vger.kernel.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, manoj@linux.ibm.com, mrochs@linux.ibm.com,
        ukrishn@linux.ibm.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com
Subject: Re: remove REQ_OP_WRITE_SAME v2
Message-ID: <20220217064349.GA374@lst.de>
References: <20220209082828.2629273-1-hch@lst.de> <yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com> <20220210055151.GA3491@lst.de> <2f3f1c98-e013-ee03-2ffb-3a14730b13b9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3f1c98-e013-ee03-2ffb-3a14730b13b9@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Feb 16, 2022 at 08:07:56PM -0700, Jens Axboe wrote:
> Let's just use the SCSI tree - I didn't check if it throws any conflicts
> right now, so probably something to check upfront...

There is a minor conflict because the __blkdev_issue_write_same
function removed by this series is affected by the blk_next_bio calling
convention change in the block tree, but the fixup is trivial.

Martin: do you want to fix that up when applying, or do you want me
to resend?  If you have your discard rework ready you can also send
that now and I'll rebase on top of that.
