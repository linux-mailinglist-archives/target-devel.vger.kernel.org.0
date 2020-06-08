Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F5A1F12BD
	for <lists+target-devel@lfdr.de>; Mon,  8 Jun 2020 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgFHGQZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 8 Jun 2020 02:16:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:32876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHGQZ (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:16:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D148EACAE;
        Mon,  8 Jun 2020 06:16:26 +0000 (UTC)
Subject: Re: [PATCH 13/17] iscsi target: replace module sids with lio's sid
To:     Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
 <1591562164-9766-14-git-send-email-michael.christie@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8f729965-7954-6c96-de78-ea30013659e2@suse.de>
Date:   Mon, 8 Jun 2020 08:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591562164-9766-14-git-send-email-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 6/7/20 10:36 PM, Mike Christie wrote:
> This is the first phase in hooking iscsi into the sysfs API. This patch
> has it use lio core's sid instead of its internal ones.
> 
> We have 2 sids in the iscsi target layer:
> - module sid: int id that is unique across all iscsi targets. Used for
>    sess_get_index().
> - iscsi target port group sid: int id that is unique in the tpg. Uses
>    for logging.
> 
> The lio one works exactly like the iscsi target module one, and the iscsi
> tpg one is not very useful because when you have multiple tpgs you can't
> tell which tpg the session is under. In the latter case the lio core one
> is more useful, because it matches what we see in userspace and logs and
> we can distinguish what fabric/target/tpg the session is under.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/target/iscsi/iscsi_target.c          |  6 ++----
>   drivers/target/iscsi/iscsi_target_configfs.c |  6 ++----
>   drivers/target/iscsi/iscsi_target_erl0.c     | 11 ++++++-----
>   drivers/target/iscsi/iscsi_target_erl2.c     |  8 ++++----
>   drivers/target/iscsi/iscsi_target_login.c    | 20 ++------------------
>   drivers/target/iscsi/iscsi_target_stat.c     |  3 +--
>   drivers/target/iscsi/iscsi_target_tmr.c      |  2 +-
>   drivers/target/iscsi/iscsi_target_tpg.c      | 16 +++++++---------
>   drivers/target/iscsi/iscsi_target_util.c     |  2 +-
>   include/target/iscsi/iscsi_target_core.h     |  6 ------
>   10 files changed, 26 insertions(+), 54 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
