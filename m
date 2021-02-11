Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7E318EAA
	for <lists+target-devel@lfdr.de>; Thu, 11 Feb 2021 16:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhBKPcB (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 11 Feb 2021 10:32:01 -0500
Received: from verein.lst.de ([213.95.11.211]:55832 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhBKP3r (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:29:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9419868C4E; Thu, 11 Feb 2021 16:13:33 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:13:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, stefanha@redhat.com,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 05/14] srpt: Convert to new submission API
Message-ID: <20210211151333.GD22082@lst.de>
References: <20210211122728.31721-1-michael.christie@oracle.com> <20210211122728.31721-6-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211122728.31721-6-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Feb 11, 2021 at 06:27:19AM -0600, Mike Christie wrote:
> target_submit_cmd_map_sgls is being removed, so convert srpt to
> the new submission API.
> 
> srpt uses target_stop_session to sync session shutdown with lio core,
> so we use target_init_cmd/target_submit_prep/target_submit, because
> target_init_cmd will detect the target_stop_session call and return
> an error.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
