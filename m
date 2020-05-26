Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533FC1CD1A8
	for <lists+target-devel@lfdr.de>; Mon, 11 May 2020 08:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgEKGLK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 May 2020 02:11:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:45240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgEKGLK (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 May 2020 02:11:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 44961ABD1;
        Mon, 11 May 2020 06:11:11 +0000 (UTC)
Subject: Re: [PATCH 05/15] vhost scsi: use target_parse_emulated_name
To:     Mike Christie <mchristi@redhat.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20200510215744.21999-1-mchristi@redhat.com>
 <20200510215744.21999-6-mchristi@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <566c4fd4-cd03-1eaa-028b-b634876c3ec1@suse.de>
Date:   Mon, 11 May 2020 08:11:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510215744.21999-6-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/10/20 11:57 PM, Mike Christie wrote:
> Use target_parse_emulated_name so the acl and SCSI names are
> properly formatted.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>   drivers/vhost/scsi.c | 69 +++++++++-------------------------------------------
>   1 file changed, 11 insertions(+), 58 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
