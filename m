Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0A1F12BA
	for <lists+target-devel@lfdr.de>; Mon,  8 Jun 2020 08:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgFHGPR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 8 Jun 2020 02:15:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHGPR (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:15:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24FC0ACAE;
        Mon,  8 Jun 2020 06:15:19 +0000 (UTC)
Subject: Re: [PATCH 12/17] target: hook most target users into sysfs API
To:     Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
 <1591562164-9766-13-git-send-email-michael.christie@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <593715ed-874f-79a9-0db9-b4563cf77baf@suse.de>
Date:   Mon, 8 Jun 2020 08:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591562164-9766-13-git-send-email-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 6/7/20 10:35 PM, Mike Christie wrote:
> This hooks lio core and all the targets but iscsi into the sysfs API.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/target/Makefile                |  1 +
>   drivers/target/target_core_configfs.c  |  3 +++
>   drivers/target/target_core_internal.h  |  1 +
>   drivers/target/target_core_transport.c | 38 ++++++++++++++++++++++++++++------
>   4 files changed, 37 insertions(+), 6 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
