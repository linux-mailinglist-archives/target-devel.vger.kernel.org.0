Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F711953E7
	for <lists+target-devel@lfdr.de>; Fri, 27 Mar 2020 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgC0JYm (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 27 Mar 2020 05:24:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0JYl (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eoJVYstuGih97vsIi4nkaGvZb5n7wsiVmVMmb6gbZMs=; b=JHnR4wNgWjU4wvcGYRqpjfhrD7
        IvtfX0LkSt47jj93Oi0xBXKOs8XbWViL90q9aljIDDaaVhZ3yKYOrGJMDdhLvtWRAKDO4UpzgDods
        2/HH3PveGWW5QyDBt6O+/QzFuhUk/963l/d82vF6AWVvqXRz7ogz1GoinVrBAkju3YqMb11u1Ypsm
        rCqCWAMm16W7B+silhECbyCVyvMW/JoBLuX98ihqVzWeeHo2MzyqwNjMQo8Z+dwR+zN3/tInUAfN6
        GU21/onSJT6gRNlJbarBCsagKebIC3QQiYnscbNDvdXq9mRIrcoywBDm1uuTweQ26w7bLqDMIJrsz
        ceL+PFaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHlEH-0002go-JL; Fri, 27 Mar 2020 09:24:41 +0000
Date:   Fri, 27 Mar 2020 02:24:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org
Subject: Re: [PATCH v2 3/5] scsi: target: avoid per-loop XCOPY buffer
 allocations
Message-ID: <20200327092441.GA7952@infradead.org>
References: <20200326221505.5303-1-ddiss@suse.de>
 <20200326221505.5303-4-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326221505.5303-4-ddiss@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Mar 26, 2020 at 11:15:03PM +0100, David Disseldorp wrote:
> The main target_xcopy_do_work() loop unnecessarily allocates an I/O
> buffer with each synchronous READ / WRITE pair. This commit
> significantly reduces allocations by reusing the XCOPY I/O buffer when
> possible.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
