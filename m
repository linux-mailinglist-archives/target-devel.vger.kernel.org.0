Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BE36B9CD1
	for <lists+target-devel@lfdr.de>; Tue, 14 Mar 2023 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCNRRP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 14 Mar 2023 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCNRRP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:17:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EFDAB0B6;
        Tue, 14 Mar 2023 10:16:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 60CDA68BFE; Tue, 14 Mar 2023 18:16:56 +0100 (CET)
Date:   Tue, 14 Mar 2023 18:16:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v4 11/18] nvme: Add pr_ops read_keys support
Message-ID: <20230314171656.GH6780@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-12-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224174502.321490-12-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Feb 24, 2023 at 11:44:55AM -0600, Mike Christie wrote:
> +	/*
> +	 * Assume we are using 128-bit host IDs and allocate a buffer large
> +	 * enough to get enough keys to fill the return keys buffer.
> +	 */
> +	rs_len = sizeof(*rs) +
> +			num_keys * sizeof(struct nvme_registered_ctrl_ext);

Any reason not to use struct_size() here?  Or does the union prevent
us from doing so?

Otherwise this looks good to me.
