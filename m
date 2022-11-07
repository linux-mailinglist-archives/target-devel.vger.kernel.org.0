Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C321661EE91
	for <lists+target-devel@lfdr.de>; Mon,  7 Nov 2022 10:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiKGJQu (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 7 Nov 2022 04:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiKGJQg (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:16:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7466E15FE8;
        Mon,  7 Nov 2022 01:16:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50E4B67373; Mon,  7 Nov 2022 10:16:31 +0100 (CET)
Date:   Mon, 7 Nov 2022 10:16:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, bvanassche@acm.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 12/19] block,nvme,scsi,dm: Add blk_status to pr_ops
 callouts
Message-ID: <20221107091631.GA3663@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-13-michael.christie@oracle.com> <20221030082020.GC4774@lst.de> <a7e447b5-b26e-7aa0-ab6a-3463b8497d26@oracle.com> <20221101101511.GA13304@lst.de> <7762a877-9a5f-4dee-6dfc-c2e1fcb8a66a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7762a877-9a5f-4dee-6dfc-c2e1fcb8a66a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Sat, Nov 05, 2022 at 01:36:18PM -0500, Mike Christie wrote:
> Do you mean just doing this:

That would be the minimal fix.  We'd then still need to enumerate
the allowed positive return values and check noting else is returned.

I don't like the opt in in the other version.  The SCSI return values are
the defactor API, and we need to switch NVMe to align with it ASAP
instead of keeping the broken old version around.
