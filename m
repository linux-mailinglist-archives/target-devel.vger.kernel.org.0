Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A16B9CEA
	for <lists+target-devel@lfdr.de>; Tue, 14 Mar 2023 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCNRVI (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 14 Mar 2023 13:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCNRVI (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:21:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159597F008;
        Tue, 14 Mar 2023 10:21:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20C4B68AA6; Tue, 14 Mar 2023 18:21:01 +0100 (CET)
Date:   Tue, 14 Mar 2023 18:21:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v4 13/18] nvme: Add pr_ops read_reservation support
Message-ID: <20230314172100.GA7909@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-14-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224174502.321490-14-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Same comment on struct_size() as two patches earlier, but otherwise
this looks good to me.
