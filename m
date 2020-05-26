Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06AC1CD1A2
	for <lists+target-devel@lfdr.de>; Mon, 11 May 2020 08:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgEKGJq (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 May 2020 02:09:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgEKGJp (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 May 2020 02:09:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AAE42AD2A;
        Mon, 11 May 2020 06:09:46 +0000 (UTC)
Subject: Re: [PATCH 03/15] target: add helper to parse acl and transport name
To:     Mike Christie <mchristi@redhat.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Juergen Gross <jgross@suse.com>
References: <20200510215744.21999-1-mchristi@redhat.com>
 <20200510215744.21999-4-mchristi@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3f0bf2d4-330a-f2a8-edaf-6f449f549f49@suse.de>
Date:   Mon, 11 May 2020 08:09:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510215744.21999-4-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/10/20 11:57 PM, Mike Christie wrote:
> The drivers that emulate the initiator port id (loop, scsi vhost, xen scsiback)
> do almost the extact same parsing when making their I_T_nexus. This adds a
> helper that parses out the acl name and port name from the user buffer, so
> these types of drivers drop prefixes like "naa." when they need to for the
> SCSI SPC4 TransportID SAS address, but then keep it for the LIO ACL name.
> 
> The next patches will then convert those drivers.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>   drivers/target/target_core_fabric_lib.c | 73 +++++++++++++++++++++++++++++++++
>   include/target/target_core_fabric.h     |  2 +
>   2 files changed, 75 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
