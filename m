Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53419093B
	for <lists+target-devel@lfdr.de>; Tue, 24 Mar 2020 10:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCXJQd (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 24 Mar 2020 05:16:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgCXJQd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gu/aFLNeKNaDA9VCsrtN6ktJgZOVNLP4YwZWT8UQvJI=; b=NingwP9Xk/TtlDiFgl4359BAaQ
        QOUHMLv19JTr+JpFYA8egpu48vWqVYEqYxwwK/mPn4gDR7S5ofKgDO8JE9m794HB7+FGOrmkluccb
        x3drRZ0utKbQvgiQOgql0W+6d2CV8YEmfFHtdBHXJA8htd18xp/YTrjRa1+0Y3djaDXBmxJSjC7CH
        R8aCeXURJczRHRzC3dDxxrGzFWWy8ZROJZxe/ohXtBbje4fRe3UPJ6PEs37/D+d/zBLM8MBYCH1hu
        19ArvpJk0UYV0uG1kaxB3zkgLEeq0dnlh7NvTL45kZr2ga2lSo++fek2oCur8Ft28pmDSrT9oXNxp
        zFgvzazg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGffl-0000OF-5H; Tue, 24 Mar 2020 09:16:33 +0000
Date:   Tue, 24 Mar 2020 02:16:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org
Subject: Re: [RFC PATCH 3/5] scsi: target: avoid per-loop XCOPY buffer
 allocations
Message-ID: <20200324091633.GC18399@infradead.org>
References: <20200323165410.24423-1-ddiss@suse.de>
 <20200323165410.24423-4-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323165410.24423-4-ddiss@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

> +	/*
> +	 * Here the previously allocated SGLs for the XCOPY are mapped zero-copy
> +	 * to the internal READ or WRITE.
> +	 */

This comments is rather pointless and a little confusing.  I'd use the
chance to kill it rather than bringing it over from the previous code.

> +	sense_rc = transport_generic_map_mem_to_cmd(cmd,
> +				xop->xop_data_sg, xop->xop_data_nents,
> +				NULL, 0);
> +	if (sense_rc) {
> +		ret = -EINVAL;
> +		goto out;
>  	}

This could simply be:

	if (transport_generic_map_mem_to_cmd(cmd, xop->xop_data_sg,
			xop->xop_data_nents, NULL, 0))
		return -EINVAL;

> +			rc = target_alloc_sgl(&xop->xop_data_sg,
> +					      &xop->xop_data_nents,
> +					      cur_bytes,
> +					      false, false);
> +			if (rc < 0) {
> +				goto out;
> +			}

			rc = target_alloc_sgl(&xop->xop_data_sg,
					&xop->xop_data_nents, cur_bytes,
					false, false);
			if (rc < 0)
				goto out;

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
