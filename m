Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473AE16415E
	for <lists+target-devel@lfdr.de>; Wed, 19 Feb 2020 11:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgBSKUX (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 19 Feb 2020 05:20:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:52378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgBSKUW (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:20:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE9D3AD19;
        Wed, 19 Feb 2020 10:20:20 +0000 (UTC)
Date:   Wed, 19 Feb 2020 11:20:20 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     target-devel@vger.kernel.org, martin.petersen@oracle.com,
        mchristi@redhat.com
Subject: Re: [PATCH] scsi: target: fix unmap_zeroes_data boolean
 initialisation
Message-ID: <20200219112020.62a6c5c2@suse.de>
In-Reply-To: <9ae08fa6-ebfe-4488-df32-5d34122c68bd@acm.org>
References: <20200218180546.21313-1-ddiss@suse.de>
        <9ae08fa6-ebfe-4488-df32-5d34122c68bd@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Thanks for the feedback, Bart...

On Tue, 18 Feb 2020 10:18:51 -0800, Bart Van Assche wrote:

> On 2/18/20 10:05 AM, David Disseldorp wrote:

> > --- a/drivers/target/target_core_device.c
> > +++ b/drivers/target/target_core_device.c
> > @@ -829,7 +829,7 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
> >   	attrib->unmap_granularity = q->limits.discard_granularity / block_size;
> >   	attrib->unmap_granularity_alignment = q->limits.discard_alignment /
> >   								block_size;
> > -	attrib->unmap_zeroes_data = (q->limits.max_write_zeroes_sectors);
> > +	attrib->unmap_zeroes_data = !!(q->limits.max_write_zeroes_sectors);
> >   	return true;
> >   }
> >   EXPORT_SYMBOL(target_configure_unmap_from_queue);  
> 
> Hi David,
> 
> How about changing the datatype of unmap_zeroes_data from 'int' into 
> 'bool'? I think that change would have the same effect as this patch and 
> additionally would make it clear that 'true' and 'false' are the only 
> allowed variables for that struct member.

Yes, that'd also be an option, although my preference would be to change
the type *and* carry the above hunk for readability.
There are plenty of other configfs attrs which are validated via
strtobool() and stored in an int. I guess it makes sense to also change
them as a follow up.

There's also still a question of how we deal with fixing configfs
parsing tools which may have obtained an incorrect (> 1)
unmap_zeroes_data value and expect to be able to write it back - should
we relax the strtobool() check in unmap_zeroes_data_store() to handle
mapping from >1 to true, or just leave it up to them to deal with? I'm
leaning towards the latter.

Cheers, David
