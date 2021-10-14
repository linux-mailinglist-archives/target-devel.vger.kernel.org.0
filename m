Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3804E42D467
	for <lists+target-devel@lfdr.de>; Thu, 14 Oct 2021 10:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJNID7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 14 Oct 2021 04:03:59 -0400
Received: from verein.lst.de ([213.95.11.211]:49062 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJNIDn (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:03:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E1AC68B05; Thu, 14 Oct 2021 10:01:35 +0200 (CEST)
Date:   Thu, 14 Oct 2021 10:01:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/7] sd: implement ->get_unique_id
Message-ID: <20211014080134.GA28835@lst.de>
References: <20211012120445.861860-1-hch@lst.de> <20211012120445.861860-3-hch@lst.de> <0a7d87ef-fff2-6a63-8edd-604ad8868dbd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7d87ef-fff2-6a63-8edd-604ad8868dbd@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Oct 14, 2021 at 09:30:51AM +0200, Hannes Reinecke wrote:
> What's wrong with scsi_vpd_lun_id() ?

It doesn't allow the caller to pick a specific ID type.
