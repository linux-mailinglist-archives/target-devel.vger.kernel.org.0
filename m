Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C634FB021
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 13:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfKMMCx (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 07:02:53 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:50570 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbfKMMCw (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:02:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 990354120B;
        Wed, 13 Nov 2019 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1573646570;
         x=1575460971; bh=uJOzzEd0UM9zu9+rg+hyPoypZlCCmgg611KCMpecAHM=; b=
        IIbA6OLkK3n9z5LzqJmOSw7iYAzMeCEX+xVgcYMNyQub+wK4IwK5zgUBIEqmC8zq
        1ZLuY/+qoKK/yMJOsGtcZqzWIJaX1tuFeS4CN4kecOIqhRQIApDLrh1Ni64mTNmx
        LnqlQnKTIXJlsLaRUrPbY4GsS60AUGawt0djxjutCGE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d_tNfpyvphO8; Wed, 13 Nov 2019 15:02:50 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 07CFD411D9;
        Wed, 13 Nov 2019 15:02:50 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 13
 Nov 2019 15:02:49 +0300
Date:   Wed, 13 Nov 2019 15:02:49 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, <target-devel@vger.kernel.org>
Subject: Re: [PATCH 2/3] target/core: Fix a use-after-free in the TMF
 handling code
Message-ID: <20191113120249.bbzvld6yiwxpbobu@SPB-NB-133.local>
References: <20191112035752.8338-1-bvanassche@acm.org>
 <20191112035752.8338-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191112035752.8338-3-bvanassche@acm.org>
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Nov 11, 2019 at 07:57:51PM -0800, Bart Van Assche wrote:
> The target_remove_from_state_list() call uses the cmd->dev pointer. Make
> sure that that pointer remains valid as long as TMF processing is in
> progress.  This patch fixes the following KASAN complaint:
> 
> BUG: KASAN: use-after-free in target_remove_from_state_list+0x22/0x130 [target_core_mod]
> Read of size 8 at addr ffff8880b110cf80 by task kworker/0:1/12
> 
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.4.0-rc1-dbg+ #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> Workqueue: events target_tmr_work [target_core_mod]
> Call Trace:
>  dump_stack+0x8a/0xd6
>  print_address_description.constprop.0+0x40/0x60
>  __kasan_report.cold+0x1b/0x33
>  kasan_report+0x16/0x20
>  __asan_load8+0x58/0x90
>  target_remove_from_state_list+0x22/0x130 [target_core_mod]
>  transport_cmd_check_stop_to_fabric+0x17/0xe0 [target_core_mod]
>  target_tmr_work+0xe2/0x1a0 [target_core_mod]
>  process_one_work+0x549/0xa40
>  worker_thread+0x7a/0x5d0
>  kthread+0x1bc/0x210
>  ret_from_fork+0x24/0x30
> 
> The buggy address belongs to the page:
> page:ffffea0002c44300 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x1fff000000000000()
> raw: 1fff000000000000 0000000000000000 ffffea0002c44308 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8880b110ce80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8880b110cf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >ffff8880b110cf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff8880b110d000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8880b110d080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/target/target_core_transport.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
> index 09f833c1de8a..ba6bd73fe63b 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
> @@ -3256,6 +3256,8 @@ static void target_tmr_work(struct work_struct *work)
>  	struct se_tmr_req *tmr = cmd->se_tmr_req;
>  	int ret;
>  
> +	target_depend_item(&dev->dev_group.cg_item);
> +
>  	if (cmd->transport_state & CMD_T_ABORTED)
>  		goto aborted;
>  
> @@ -3297,10 +3299,14 @@ static void target_tmr_work(struct work_struct *work)
>  	cmd->se_tfo->queue_tm_rsp(cmd);
>  
>  	transport_cmd_check_stop_to_fabric(cmd);
> +
> +out:
> +	target_undepend_item(&dev->dev_group.cg_item);
>  	return;
>  
>  aborted:
>  	target_handle_abort(cmd);
> +	goto out;
>  }
>  
>  int transport_generic_handle_tmr(
> -- 
> 2.23.0
> 

Hi Bart,

As far as I understand the change prevents backstore directory removal
from TCM configfs when a TMF is processed and targetcli would start
to fail sporadically as it tries to delete configfs directories only once:
  https://github.com/open-iscsi/rtslib-fb/blob/master/rtslib/node.py#L228

Should we hold se_device device without preventing removal of backstore?

Thanks,
Roman
