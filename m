Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DEF194A68
	for <lists+target-devel@lfdr.de>; Thu, 26 Mar 2020 22:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgCZVUs (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 26 Mar 2020 17:20:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZVUs (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:20:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C991B03D;
        Thu, 26 Mar 2020 21:20:46 +0000 (UTC)
Date:   Thu, 26 Mar 2020 22:20:44 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org
Subject: Re: [RFC PATCH 5/5] scsi: target: avoid XCOPY per-loop read/write
 cmd allocations
Message-ID: <20200326222044.06e3d5c9@suse.de>
In-Reply-To: <20200324092323.GE18399@infradead.org>
References: <20200323165410.24423-1-ddiss@suse.de>
        <20200323165410.24423-6-ddiss@suse.de>
        <20200324092323.GE18399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Christoph,

Thanks for the feedback...

On Tue, 24 Mar 2020 02:23:23 -0700, Christoph Hellwig wrote:

> On Mon, Mar 23, 2020 at 05:54:10PM +0100, David Disseldorp wrote:
> > Reads and writes in the XCOPY loop are synchronous, so needn't be
> > allocated / freed with each loop.  
> 
> That is true, but I think with your previous cleanups we can easily
> go one step further and just allocate a single command and sense buffer
> directly in struct xcopy_op, and just have local completions on the
> stack.

I'm probably missing something, but having the (stack) completion
separate to the se_cmd and sense buffer would mean that it's no longer a
straightforward container_of() in the .check_stop_free() callback.

I've reworked this patch to put the entire xcopy_pt_cmd on the stack and
will send it out with v2.

Cheers, David
