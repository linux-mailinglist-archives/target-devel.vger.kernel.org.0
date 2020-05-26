Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36C1CD1B7
	for <lists+target-devel@lfdr.de>; Mon, 11 May 2020 08:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgEKGO3 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 May 2020 02:14:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbgEKGO3 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 May 2020 02:14:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A748AC6D;
        Mon, 11 May 2020 06:14:30 +0000 (UTC)
Subject: Re: [PATCH 10/15] target: drop sess_get_initiator_sid
To:     Mike Christie <mchristi@redhat.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200510215744.21999-1-mchristi@redhat.com>
 <20200510215744.21999-11-mchristi@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5dee32d3-7e41-eaab-2544-c73bc9aaf0af@suse.de>
Date:   Mon, 11 May 2020 08:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510215744.21999-11-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/10/20 11:57 PM, Mike Christie wrote:
> sess_get_initiator_sid is no longer used. Drop it.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c        |  1 -
>   drivers/scsi/qla2xxx/tcm_qla2xxx.c           |  2 --
>   drivers/target/iscsi/iscsi_target_configfs.c | 13 -------------
>   drivers/target/tcm_fc/tfc_conf.c             |  1 -
>   drivers/usb/gadget/function/f_tcm.c          |  1 -
>   drivers/vhost/scsi.c                         |  1 -
>   drivers/xen/xen-scsiback.c                   |  1 -
>   include/target/target_core_fabric.h          |  6 ------
>   8 files changed, 26 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
