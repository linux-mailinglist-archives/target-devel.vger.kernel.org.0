Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3719CD7F
	for <lists+target-devel@lfdr.de>; Fri,  3 Apr 2020 01:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390217AbgDBXak (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 2 Apr 2020 19:30:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390216AbgDBXak (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:30:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DBC99ADCC;
        Thu,  2 Apr 2020 23:30:38 +0000 (UTC)
Date:   Fri, 3 Apr 2020 01:30:37 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>
Cc:     target-devel@vger.kernel.org, mchristi@redhat.com, hch@lst.de,
        martin.petersen@oracle.com
Subject: Re: [PATCH] target: tcmu: add missing pr attributes to passthrough
 backends
Message-ID: <20200403013037.3da74123@suse.de>
In-Reply-To: <20200401132153.23501-1-bstroesser@ts.fujitsu.com>
References: <20200401132153.23501-1-bstroesser@ts.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,

On Wed,  1 Apr 2020 15:21:53 +0200, Bodo Stroesser wrote:

> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index ff82b21fdcce..c5a974c5b31d 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1203,6 +1203,9 @@ struct configfs_attribute *passthrough_attrib_attrs[] = {
>  	&attr_hw_block_size,
>  	&attr_hw_max_sectors,
>  	&attr_hw_queue_depth,
> +	&attr_emulate_pr,
> +	&attr_enforce_pr_isids,
> +	&attr_force_pr_aptpl,
>  	&attr_alua_support,
>  	&attr_pgr_support,
>  	NULL,

The attr_emulate_pr addition here looks fine. If you and Mike agree to
proceed with the other two attrs then it probably makes sense to add
them via a separate patch.

Cheers, David
