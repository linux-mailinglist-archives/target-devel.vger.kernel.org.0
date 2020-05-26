Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7E1DF758
	for <lists+target-devel@lfdr.de>; Sat, 23 May 2020 15:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgEWNDH (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 23 May 2020 09:03:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:50564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731227AbgEWNDH (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Sat, 23 May 2020 09:03:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA3DCAC2C;
        Sat, 23 May 2020 13:03:08 +0000 (UTC)
Date:   Sat, 23 May 2020 15:03:03 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        Mike Christie <mchristi@redhat.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: target: tcmu: Fix a use after free in
 tcmu_check_expired_queue_cmd()
Message-ID: <20200523150303.5bd1d24a@suse.de>
In-Reply-To: <20200523101129.GB98132@mwanda>
References: <20200523101129.GB98132@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Sat, 23 May 2020 13:11:29 +0300, Dan Carpenter wrote:

> The pr_debug() dereferences "cmd" after we already freed it by calling
> tcmu_free_cmd(cmd).  The debug printk needs to be done earlier.
> 
> Fixes: 61fb24822166 ("scsi: target: tcmu: Userspace must not complete queued commands")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: David Disseldorp <ddiss@suse.de>

Looks like this could be squashed in with the change that it fixes,
given that 5.8/scsi-queue hasn't gone out yet.

Cheers, David
