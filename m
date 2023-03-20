Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22896C12AC
	for <lists+target-devel@lfdr.de>; Mon, 20 Mar 2023 14:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjCTNGc (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 20 Mar 2023 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjCTNGb (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:06:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBAD1C7D9;
        Mon, 20 Mar 2023 06:06:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA35E68AFE; Mon, 20 Mar 2023 14:06:25 +0100 (CET)
Date:   Mon, 20 Mar 2023 14:06:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, bvanassche@acm.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: Re: [PATCH v4 02/18] block: Rename BLK_STS_NEXUS to
 BLK_STS_RESV_CONFLICT
Message-ID: <20230320130625.GA11908@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-3-michael.christie@oracle.com> <20230314171119.GB6780@lst.de> <33ed9615-b570-03c7-9a7a-d07f020d3222@linux.ibm.com> <20230315133039.GA24533@lst.de> <4484f553-84c1-5402-4f52-c2972ad3e496@linux.ibm.com> <6da0ec0a-d465-fec4-0ca5-96b2ffb7be7a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da0ec0a-d465-fec4-0ca5-96b2ffb7be7a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Mar 16, 2023 at 11:36:12AM -0500, Mike Christie wrote:
> I think we are ok for dasd using BLK_STS_RESV_CONFLICT.
> 
> It thought it sounded similar to SCSI/NVMe and userspace will still
> see -EBADE because the blk_status_to_errno/errno_to_blk_status will
> handle this.
> 
> There was no internal dasd code checking for BLK_STS_NEXUS.
> 
> There is a pr_ops API, but dasd is not hooked into it so we don't
> have to worry about behavior changes.

Yes, we don't have to worry about it.  I just find a bit confusing
to have a PR-related error in a driver that doesn't use PRs.

Maybe add a little comment that it is used for some s390 or DASD
specific locking instead.
