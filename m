Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0CE55110D
	for <lists+target-devel@lfdr.de>; Mon, 20 Jun 2022 09:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiFTHMh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 20 Jun 2022 03:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiFTHMe (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:12:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40751DFFE;
        Mon, 20 Jun 2022 00:12:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F79668AA6; Mon, 20 Jun 2022 09:12:29 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:12:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/8] Use block pr_ops in LIO
Message-ID: <20220620071229.GB11418@lst.de>
References: <20220603065536.5641-1-michael.christie@oracle.com> <20220603114645.GA14309@lst.de> <2634b3ae-f63d-c711-36cd-bf8f56ecc43b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2634b3ae-f63d-c711-36cd-bf8f56ecc43b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:55:33PM -0500, Mike Christie wrote:
> However, for nvme and for the interface we want to provide to userspace,
> do we want to implement an interface like READ_FULL_STATUS and report
> reservations where we report the host/controller/port info? If so, below
> is a patch I started.

If we wire the ops up to the nvme target we'd need that.  But for now
I think the more useful case would be to use nvme as the underlying
devices for the scsi target that already has all the PR infrastructure
and helps to validate the interface.

> Notes:
> 1. I hit some issues with SCSI targets not reporting the IDs sometimes or
> sometimes they report it incorrectly. For nvme, it seems easier. SCSI has 
> to handle a hand full of ways to report the ID where nvme has 2 ways to
> do the host ID.

Yeah.

> 2. I couldn't find a nvme device to test. Qemu and nvmet don't seem to
> support reservations.

Basically any dual ported PCIe SSD should support them, typically those
are the U.2 format factor ones found in servers or enclosures.
