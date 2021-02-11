Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B68C318E20
	for <lists+target-devel@lfdr.de>; Thu, 11 Feb 2021 16:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhBKPVW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 11 Feb 2021 10:21:22 -0500
Received: from verein.lst.de ([213.95.11.211]:55778 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhBKPRm (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:17:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA59E68CEC; Thu, 11 Feb 2021 16:15:08 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:15:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, stefanha@redhat.com, Chris Boot <bootc@bootc.net>
Subject: Re: [PATCH 09/14] sbp_target: Convert to new submission API
Message-ID: <20210211151508.GH22082@lst.de>
References: <20210211122728.31721-1-michael.christie@oracle.com> <20210211122728.31721-10-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211122728.31721-10-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Feb 11, 2021 at 06:27:23AM -0600, Mike Christie wrote:
> target_submit_cmd is now only for simple drivers that do their
> own sync during shutdown and do not use target_stop_session. It
> will never return a failure, so we can remove that code from
> the driver.
> 
> Cc: Chris Boot <bootc@bootc.net>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
