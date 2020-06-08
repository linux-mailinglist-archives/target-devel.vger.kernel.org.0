Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF61F12C8
	for <lists+target-devel@lfdr.de>; Mon,  8 Jun 2020 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFHGVN (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 8 Jun 2020 02:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:34280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHGVM (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:21:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B935BAEAC;
        Mon,  8 Jun 2020 06:21:14 +0000 (UTC)
Subject: Re: [PATCH 16/17] iscsi target: export session state and alias in
 sysfs
To:     Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
 <1591562164-9766-17-git-send-email-michael.christie@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0df57c39-48f5-d257-3d76-0dc2bb4ff305@suse.de>
Date:   Mon, 8 Jun 2020 08:21:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591562164-9766-17-git-send-email-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 6/7/20 10:36 PM, Mike Christie wrote:
> Export the session state and alias in sysfs.
> 
> Note:
> It does not export the per connection state. In the future we can
> have the iscsi target add/rm an attribute group directly for each
> connection when we login and logout/drop a connection. Since those
> are dynamic and can change while the session exists, we don't need
> them at device addition so it can be done directly from the module.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/target/iscsi/iscsi_target_configfs.c | 97 ++++++++++++++++++++++------
>   1 file changed, 76 insertions(+), 21 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
