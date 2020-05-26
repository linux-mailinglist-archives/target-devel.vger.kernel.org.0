Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA31CD19E
	for <lists+target-devel@lfdr.de>; Mon, 11 May 2020 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEKGIn (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 May 2020 02:08:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:44376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgEKGIm (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 May 2020 02:08:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5806DABD1;
        Mon, 11 May 2020 06:08:44 +0000 (UTC)
Subject: Re: [PATCH 01/15] target: check enforce_pr_isids during registration
To:     Mike Christie <mchristi@redhat.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200510215744.21999-1-mchristi@redhat.com>
 <20200510215744.21999-2-mchristi@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c9634d6d-36f8-d47a-90b2-6cf91fb4fb22@suse.de>
Date:   Mon, 11 May 2020 08:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510215744.21999-2-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/10/20 11:57 PM, Mike Christie wrote:
> Move the check for enforce_pr_isids to the registration code where we
> can fail at the time an initiator tries to register a path without an
> isid. In its current place in __core_scsi3_locate_pr_reg, it is too
> late because it can be registered and be reported in PR in commands and
> it is stuck in this state because we cannot unregister it.
> 
> Note.
> I am including in this patchset, because the 5th patch is built on top.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>   drivers/target/target_core_pr.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
