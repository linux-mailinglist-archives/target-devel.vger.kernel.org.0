Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA79319097C
	for <lists+target-devel@lfdr.de>; Tue, 24 Mar 2020 10:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCXJXY (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 24 Mar 2020 05:23:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgCXJXY (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Wy8iZQZzV70sRVTL817gfHxZa0T86F9cB+ut4HSzmc=; b=jbHkQoJW1ml81vD2Pgx0J2HAYA
        JYiB26BZKDnuBEQMlJSxowAYwq7PfOPOcd8mNkibYQzZzawPNrw045HkTxSJ5P2ksOeEerLhH1XvI
        M8nCJkCHCGdgJ16EEUIRqRzPxLsPjMUK4T9i3sYUYCUTtIKstN8RXqLP8tyoEWRcN+hM1Z1sM26FS
        myRJgtQTGleqFqqkDytd5S8Wjl6Mr/N8Ovde7V8x4AViDt9sYWV0+GgNSDYqv7843aepMRttuk5H8
        qJJdFzb9ag8Cn6tWiZMOjmn4gQqqq/TXYtQBBDLfktdRLREmnSXJOXRYUe0ix9Y4DokBoNHI6w5BO
        twFz1OUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGfmN-0002Yg-Kb; Tue, 24 Mar 2020 09:23:23 +0000
Date:   Tue, 24 Mar 2020 02:23:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org
Subject: Re: [RFC PATCH 5/5] scsi: target: avoid XCOPY per-loop read/write
 cmd allocations
Message-ID: <20200324092323.GE18399@infradead.org>
References: <20200323165410.24423-1-ddiss@suse.de>
 <20200323165410.24423-6-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323165410.24423-6-ddiss@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Mar 23, 2020 at 05:54:10PM +0100, David Disseldorp wrote:
> Reads and writes in the XCOPY loop are synchronous, so needn't be
> allocated / freed with each loop.

That is true, but I think with your previous cleanups we can easily
go one step further and just allocate a single command and sense buffer
directly in struct xcopy_op, and just have local completions on the
stack.
