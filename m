Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67D1FB19F
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 14:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKMNm7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 08:42:59 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:54506 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbfKMNm7 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:42:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2D2D9411D9;
        Wed, 13 Nov 2019 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1573652574;
         x=1575466975; bh=gI16uiUJlkbWnvTOD9AOK+yu9d4HCnPr7BGDz26eAuw=; b=
        AISIKjFbs/Qa7DPz45/7CxHpDrxfhSphsi3ZBWKs0cA12ibZIp59Jjkb6By3zK3l
        d3dIVE5D+B26Pvqu6VxAxkWvzmkNwxzAQCQEg08Uqimu70VTSqOPRLUaXDdEr7uL
        8mR4xbD7IEsFh8Q9cksrH2t2WdsFFpE/O3jIg6LFNyw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VvHqZRDV8QA0; Wed, 13 Nov 2019 16:42:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4936341293;
        Wed, 13 Nov 2019 16:42:54 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 13
 Nov 2019 16:42:53 +0300
Date:   Wed, 13 Nov 2019 16:42:53 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, <target-devel@vger.kernel.org>
Subject: Re: [PATCH 3/3] target/iscsi: Wait for all commands to finish before
 freeing a session
Message-ID: <20191113134253.rlypgdve7qwfynjz@SPB-NB-133.local>
References: <20191112035752.8338-1-bvanassche@acm.org>
 <20191112035752.8338-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191112035752.8338-4-bvanassche@acm.org>
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Nov 11, 2019 at 07:57:52PM -0800, Bart Van Assche wrote:
> This patch fixes the following KASAN complaint:
> 
> BUG: KASAN: use-after-free in __lock_acquire+0xb1a/0x2710
> Read of size 8 at addr ffff8881154eca70 by task kworker/0:2/247
> 
> CPU: 0 PID: 247 Comm: kworker/0:2 Not tainted 5.4.0-rc1-dbg+ #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> Workqueue: target_completion target_complete_ok_work [target_core_mod]
> Call Trace:
>  dump_stack+0x8a/0xd6
>  print_address_description.constprop.0+0x40/0x60
>  __kasan_report.cold+0x1b/0x33
>  kasan_report+0x16/0x20
>  __asan_load8+0x58/0x90
>  __lock_acquire+0xb1a/0x2710
>  lock_acquire+0xd3/0x200
>  _raw_spin_lock_irqsave+0x43/0x60
>  target_release_cmd_kref+0x162/0x7f0 [target_core_mod]
>  target_put_sess_cmd+0x2e/0x40 [target_core_mod]
>  lio_check_stop_free+0x12/0x20 [iscsi_target_mod]
>  transport_cmd_check_stop_to_fabric+0xd8/0xe0 [target_core_mod]
>  target_complete_ok_work+0x1b0/0x790 [target_core_mod]
>  process_one_work+0x549/0xa40
>  worker_thread+0x7a/0x5d0
>  kthread+0x1bc/0x210
>  ret_from_fork+0x24/0x30
> 
> Allocated by task 889:
>  save_stack+0x23/0x90
>  __kasan_kmalloc.constprop.0+0xcf/0xe0
>  kasan_slab_alloc+0x12/0x20
>  kmem_cache_alloc+0xf6/0x360
>  transport_alloc_session+0x29/0x80 [target_core_mod]
>  iscsi_target_login_thread+0xcd6/0x18f0 [iscsi_target_mod]
>  kthread+0x1bc/0x210
>  ret_from_fork+0x24/0x30
> 
> Freed by task 1025:
>  save_stack+0x23/0x90
>  __kasan_slab_free+0x13a/0x190
>  kasan_slab_free+0x12/0x20
>  kmem_cache_free+0x146/0x400
>  transport_free_session+0x179/0x2f0 [target_core_mod]
>  transport_deregister_session+0x130/0x180 [target_core_mod]
>  iscsit_close_session+0x12c/0x350 [iscsi_target_mod]
>  iscsit_logout_post_handler+0x136/0x380 [iscsi_target_mod]
>  iscsit_response_queue+0x8de/0xbe0 [iscsi_target_mod]
>  iscsi_target_tx_thread+0x27f/0x370 [iscsi_target_mod]
>  kthread+0x1bc/0x210
>  ret_from_fork+0x24/0x30
> 
> The buggy address belongs to the object at ffff8881154ec9c0
>  which belongs to the cache se_sess_cache of size 352
> The buggy address is located 176 bytes inside of
>  352-byte region [ffff8881154ec9c0, ffff8881154ecb20)
> The buggy address belongs to the page:
> page:ffffea0004553b00 refcount:1 mapcount:0 mapping:ffff888101755400 index:0x0 compound_mapcount: 0
> flags: 0x2fff000000010200(slab|head)
> raw: 2fff000000010200 dead000000000100 dead000000000122 ffff888101755400
> raw: 0000000000000000 0000000080130013 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8881154ec900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8881154ec980: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> >ffff8881154eca00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                              ^
>  ffff8881154eca80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8881154ecb00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
> 
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/target/iscsi/iscsi_target.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index 09e55ea0bf5d..2486fc5a92c5 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -1165,7 +1165,9 @@ int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
>  		hdr->cmdsn, be32_to_cpu(hdr->data_length), payload_length,
>  		conn->cid);
>  
> -	target_get_sess_cmd(&cmd->se_cmd, true);
> +	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
> +		return iscsit_add_reject_cmd(cmd,
> +				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
>  
>  	cmd->sense_reason = transport_lookup_cmd_lun(&cmd->se_cmd,
>  						     scsilun_to_int(&hdr->lun));
> @@ -2002,7 +2004,9 @@ iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
>  			      conn->sess->se_sess, 0, DMA_NONE,
>  			      TCM_SIMPLE_TAG, cmd->sense_buffer + 2);
>  
> -	target_get_sess_cmd(&cmd->se_cmd, true);
> +	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
> +		return iscsit_add_reject_cmd(cmd,
> +				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
>  

Hi Bart,

Sending the reject reason implies initiator can resend original PDU,
according to https://tools.ietf.org/html/rfc7143#section-11.17.1

Is it intended, i.e. do we want the retry?

Thanks,
Roman

>  	/*
>  	 * TASK_REASSIGN for ERL=2 / connection stays inside of
> @@ -4230,6 +4234,8 @@ int iscsit_close_connection(
>  	 * must wait until they have completed.
>  	 */
>  	iscsit_check_conn_usage_count(conn);
> +	target_sess_cmd_list_set_waiting(sess->se_sess);
> +	target_wait_for_sess_cmds(sess->se_sess);
>  
>  	ahash_request_free(conn->conn_tx_hash);
>  	if (conn->conn_rx_hash) {
> -- 
> 2.23.0
> 
