Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BFA316136
	for <lists+target-devel@lfdr.de>; Wed, 10 Feb 2021 09:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhBJIik (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 10 Feb 2021 03:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhBJIi1 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:38:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB4C061574;
        Wed, 10 Feb 2021 00:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1r0irMz2N0yyYbwfbWnEViPW0NRdXGASq84W3NqA1ik=; b=dUsRsSif+hnZBSGbN83obM3tgZ
        lVJf3UfphZrzmkM9NIeDnz/SGWiRL/ljUp7J+g26OUepT8HFRSEGzduFv2CakNSqNVwAQkOD4R1zT
        dPVq094moraofb+zWnciYZ3MlejLVB93UJOWw/KUXFGxLYFYZr+TkyRf0lqq8HjedKzgXDEf2oJ6P
        YaLlIsw/PtWml9+0q9mUvH15xyzIG0ReK4fd+McYEbZHbyDUqHSZDmk/KJYgz+LY3j+EjsMiynSdr
        +uQjh8PD1M3wm1KXeH9IOUIawIc5pVsdmIMBlz5bAhZwIe2/NX5X8mHLpNrwrpfCbHzdffMsekX21
        QnRiOWZA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9l0G-008akL-Mb; Wed, 10 Feb 2021 08:37:41 +0000
Date:   Wed, 10 Feb 2021 08:37:40 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Chaitanya.Kulkarni@wdc.com, loberman@redhat.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 05/13] tcm loop: use blk cmd allocator for se_cmds
Message-ID: <20210210083740.GC2045726@infradead.org>
References: <20210209123845.4856-1-michael.christie@oracle.com>
 <20210209123845.4856-6-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209123845.4856-6-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, Feb 09, 2021 at 06:38:37AM -0600, Mike Christie wrote:
> This just has tcm loop use the block layer cmd allocator for se_cmds
> instead of using the tcm_loop_cmd_cache. In future patches when we
> can use the host tags for internal requests like TMFs we can completely
> kill the tcm_loop_cmd_cache.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
