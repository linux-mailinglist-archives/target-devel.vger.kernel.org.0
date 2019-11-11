Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008D8F8054
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 20:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKKTlT (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 14:41:19 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:47746 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbfKKTlT (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:41:19 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 879BB411F9;
        Mon, 11 Nov 2019 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        user-agent:in-reply-to:content-disposition:content-type
        :content-type:mime-version:references:message-id:subject:subject
        :from:from:date:date:received:received:received; s=mta-01; t=
        1573501276; x=1575315677; bh=UAYK9Q4PAO8RVwAgKVKUsysnVACwDYhxCSd
        2kobwlg0=; b=NT94RmN1gXt4+Wx05ekQ0v6QkS6aN48XbPiTKNCaKw6jBl2j0wT
        aUEhxF6lsBd6ik0DRdrv+BdRcBaEuvUOYgGizR8ZRIb2P2m6V0eo1RoQWjKpdN8H
        kqDXB2ciUIPmHk7c+hbNOYVewoUsqckh7s5dF/jjeP22GGwQmVt+13Ao=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wUq381LUVPjS; Mon, 11 Nov 2019 22:41:16 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3D62C404CF;
        Mon, 11 Nov 2019 22:41:16 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Nov 2019 22:41:15 +0300
Date:   Mon, 11 Nov 2019 22:41:14 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, <target-devel@vger.kernel.org>
Subject: Re: [PATCH 2/2] target/iscsi: Fix a use-after-free while closing a
 session
Message-ID: <20191111194114.yckp2zkraulvl7hz@SPB-NB-133.local>
References: <20191111182944.191123-1-bvanassche@acm.org>
 <20191111182944.191123-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191111182944.191123-3-bvanassche@acm.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:29:44AM -0800, Bart Van Assche wrote:
> This patch fixes the following use-after-free in the code that supports
> SPC-2 reservations:
> 
> BUG: KASAN: use-after-free in target_check_reservation+0x171/0x980 [target_core_mod]
> Read of size 8 at addr ffff88802ecd1878 by task iscsi_trx/17200
> 
> CPU: 0 PID: 17200 Comm: iscsi_trx Not tainted 5.4.0-rc1-dbg+ #1
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> Call Trace:
>  dump_stack+0x8a/0xd6
>  print_address_description.constprop.0+0x40/0x60
>  __kasan_report.cold+0x1b/0x34
>  kasan_report+0x16/0x20
>  __asan_load8+0x58/0x90
>  target_check_reservation+0x171/0x980 [target_core_mod]
>  __target_execute_cmd+0xb1/0xf0 [target_core_mod]
>  target_execute_cmd+0x22d/0x4d0 [target_core_mod]
>  transport_generic_new_cmd+0x31f/0x5b0 [target_core_mod]
>  transport_handle_cdb_direct+0x6f/0x90 [target_core_mod]
>  iscsit_execute_cmd+0x381/0x3f0 [iscsi_target_mod]
>  iscsit_sequence_cmd+0x13b/0x1f0 [iscsi_target_mod]
>  iscsit_process_scsi_cmd+0x4c/0x130 [iscsi_target_mod]
>  iscsit_get_rx_pdu+0x8e8/0x15f0 [iscsi_target_mod]
>  iscsi_target_rx_thread+0x105/0x1b0 [iscsi_target_mod]
>  kthread+0x1bc/0x210
>  ret_from_fork+0x24/0x30
> 
> Allocated by task 1079:
>  save_stack+0x23/0x90
>  __kasan_kmalloc.constprop.0+0xcf/0xe0
>  kasan_slab_alloc+0x12/0x20
>  kmem_cache_alloc+0xfe/0x3a0
>  transport_alloc_session+0x29/0x80 [target_core_mod]
>  iscsi_target_login_thread+0xceb/0x1920 [iscsi_target_mod]
>  kthread+0x1bc/0x210
>  ret_from_fork+0x24/0x30
> 
> Freed by task 17193:
>  save_stack+0x23/0x90
>  __kasan_slab_free+0x13a/0x190
>  kasan_slab_free+0x12/0x20
>  kmem_cache_free+0xc8/0x3e0
>  transport_free_session+0x179/0x2f0 [target_core_mod]
>  transport_deregister_session+0x121/0x170 [target_core_mod]
>  iscsit_close_session+0x12c/0x350 [iscsi_target_mod]
>  iscsit_logout_post_handler+0x136/0x380 [iscsi_target_mod]
>  iscsit_response_queue+0x8fa/0xc00 [iscsi_target_mod]
>  iscsi_target_tx_thread+0x28e/0x390 [iscsi_target_mod]
>  kthread+0x1bc/0x210
>  ret_from_fork+0x24/0x30
> 
> The buggy address belongs to the object at ffff88802ecd1860
>  which belongs to the cache se_sess_cache of size 352
> The buggy address is located 24 bytes inside of
>  352-byte region [ffff88802ecd1860, ffff88802ecd19c0)
> The buggy address belongs to the page:
> page:ffffea0000bb3400 refcount:1 mapcount:0 mapping:ffff8880bef2ed00 index:0x0 compound_mapcount: 0
> flags: 0x1000000000010200(slab|head)
> raw: 1000000000010200 dead000000000100 dead000000000122 ffff8880bef2ed00
> raw: 0000000000000000 0000000080270027 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff88802ecd1700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88802ecd1780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88802ecd1800: fb fb fb fb fc fc fc fc fc fc fc fc fb fb fb fb
>                                                                 ^
>  ffff88802ecd1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88802ecd1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> 
> Cc: Mike Christie <mchristi@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/target/target_core_transport.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
> index ba7a01bcad7c..12bc8545f91b 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
> @@ -584,6 +584,15 @@ void transport_free_session(struct se_session *se_sess)
>  }
>  EXPORT_SYMBOL(transport_free_session);
>  
> +static int target_release_res(struct se_device *dev, void *data)
> +{
> +	struct se_session *sess = data;
> +
> +	if (dev->reservation_holder == sess)
> +		dev->reservation_holder = NULL;


Hi Bart,

Does it worth to use target_release_reservation() when the session is
reserveration holder instead of the explicit assignment? That would also
reset reservation flags of the se_device.

> +	return 0;
> +}
> +
>  void transport_deregister_session(struct se_session *se_sess)
>  {
>  	struct se_portal_group *se_tpg = se_sess->se_tpg;
> @@ -600,6 +609,8 @@ void transport_deregister_session(struct se_session *se_sess)
>  	se_sess->fabric_sess_ptr = NULL;
>  	spin_unlock_irqrestore(&se_tpg->session_lock, flags);
>  
> +	target_for_each_device(target_release_res, se_sess);
> +
>  	pr_debug("TARGET_CORE[%s]: Deregistered fabric_sess\n",
>  		se_tpg->se_tpg_tfo->fabric_name);
>  	/*
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 

IMO the code is not specific to iscsi and the tag should be changed to
"target/core:"


Thanks,
Roman
