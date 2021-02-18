Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5331E75F
	for <lists+target-devel@lfdr.de>; Thu, 18 Feb 2021 09:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBRIWS (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 18 Feb 2021 03:22:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:44672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhBRITw (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C000EAFA0;
        Thu, 18 Feb 2021 08:19:10 +0000 (UTC)
Subject: Re: Can LIO configfs handle concurrent changes independently
To:     tasleson@redhat.com, target-devel@vger.kernel.org
References: <94b1290f-4713-460a-43b8-ff00402c64dd@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1044e9fe-f5ec-d7d8-b6f6-2f0ee9cc0fd7@suse.de>
Date:   Thu, 18 Feb 2021 09:19:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <94b1290f-4713-460a-43b8-ff00402c64dd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2/17/21 5:10 PM, Tony Asleson wrote:
> Can configfs for lio can handle multiple containers making changes
> concurrently and independently?
> 
> ref. https://github.com/open-iscsi/targetd/issues/77#issuecomment-757087879
> 
> Thanks!
> 
Not to my knowledge. Neither sysfs nor configfs are namespace aware.

Should be doable for configfs, as this is a stand-along 'filesystem' 
which could be made namespace-aware.

The implications of this, however, will be challenging as quite some 
internal structures using configfs are currently programmed for a
single user.

Still, interesting project, and one should be looking into it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
