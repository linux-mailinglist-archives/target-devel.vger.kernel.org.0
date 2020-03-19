Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39118BE9F
	for <lists+target-devel@lfdr.de>; Thu, 19 Mar 2020 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgCSRpj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 19 Mar 2020 13:45:39 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:6751 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgCSRpj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:45:39 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02JHjHlB015035;
        Thu, 19 Mar 2020 10:45:18 -0700
Date:   Thu, 19 Mar 2020 23:15:11 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: Connection errors with ISER IO
Message-ID: <20200319174510.GB29063@chelsio.com>
References: <20200226155241.GA28594@chelsio.com>
 <d655f85f-d910-a77b-1672-0fbb919e5d9a@grimberg.me>
 <20200227140045.GA2029@chelsio.com>
 <b021295a-cc41-d8e9-8605-cfbc77cead80@grimberg.me>
 <20200304182612.GA6665@chelsio.com>
 <20200310120150.GA7669@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310120150.GA7669@chelsio.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tuesday, March 03/10/20, 2020 at 17:31:51 +0530, Potnuri Bharat Teja wrote:
> On Wednesday, March 03/04/20, 2020 at 23:56:12 +0530, Potnuri Bharat Teja wrote:
> > On Friday, February 02/28/20, 2020 at 05:12:32 +0530, Sagi Grimberg wrote:
> > > 
> > > >>> Hi All,
> > > >>> I observe connection errors almost immediately after I start iozone over iser
> > > >>> luns. Atached are the connection error and hung task traces on initator and
> > > >>> target respecively.
> > > >>> Interestingly, I see connection errors only if LUN size is less than 512MB.
> > > >>> In my case I could consistently reproduce the issue with 511MB LUN and 300MB
> > > >>> lun size. Connections errors are not seen if I create 512MB or greated LUN.
> > > >>
> > > >> Can you share log output on the target to before hung tasks?
> > > > 
> > > > Sure, Attached are the target and initiator dmesg logs.
> > > >>
> > > >>> Further, after the connection errors, I noticed that the poll work queue is
> > > >>> stuck and never processes drain CQE resulting in hung tasks on the target side.
> > > >>
> > > >> Is the drain CQE actually generated?
> > > >>
> > > > 
> > > > Yes it is generated. I was able to track it with prints until queue_work() in
> > > > ib_cq_completion_workqueue(). Work Function ib_cq_poll_work() is never getting
> > > > scheduled. Therefore, I see drain CQE unpolled and hung task due to
> > > > __ib_drain_sq() waiting forever for complete() to be called from drain CQE
> > > > done() handler.
> > > 
> > > Hmm, that is interesting. This tells me that cq->work is probably
> > > blocked by another completion invokation (which hangs), which means that
> > > queuing the cq->work did not happen as workqueues are not re-entrant.
> > > 
> > > Looking at the code, nothing should be blocking in the isert ->done()
> > > handlers, so its not clear to me how this can happen.
> > > 
> > > Would it be possible to run:
> > > echo t > /proc/sysrq-trigger when this happens? I'd like to see where
> > > that cq->work is blocking.
> > >
> > Attached file t_sysrq-trigger_and_dmesg.txt is the triggered output. Please let 
> > me know if that is timed correctly as I triggered it a little after login timeout.
> > I'll try getting a better one meanwhile.
> > > I'd also enable pr_debug on iscsi_traget.c
> > > 
> > Attached files are with debug enabled:
> > tgt_discovery_and_login_dmesg.txt -> dmesg just after login for reference
> > tgt_IO_511MB_8target_1lun_each_iozone_dmesg_untill_hang.txt -> dmesg untill connection error.
> > 
> > Please let me know if there is anything that I could check.
> 
Hi All,
any suggestions on what to check?

I tried limiting max_data_sg_nnets to 32 as T6 has relatively lower resources 
and I dont see the issue with the patch.

Though the visible effect is at the workqueue, I think there is something to do 
iscsi/iser flow control mechanism, which is failing and overwhelming the target.
I am not sure how to verify this exactly. I appreciate any suggestions on the debug.

diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 0ebc4818e132..a15a2a6adf65 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1553,6 +1553,7 @@ const struct target_core_fabric_ops iscsi_ops = {
 	.module				= THIS_MODULE,
 	.name				= "iscsi",
 	.node_acl_size			= sizeof(struct iscsi_node_acl),
+	.max_data_sg_nents              = 32,
 	.get_fabric_name		= iscsi_get_fabric_name,
 	.tpg_get_wwn			= lio_tpg_get_endpoint_wwn,
 	.tpg_get_tag			= lio_tpg_get_tag,

> > > > 
> > > >>> I tried changing the CQ poll workqueue to be UNBOUND but it did not fix the issue.
> > > >>>
> > > >>> Here is what my test does:
> > > >>> Create 8 targets with 511MB lun each, login and format disks to ext3, mount the
> > > >>> disks and run iozone over them.
> > > >>> #iozone -a -I -+d -g 256m
> > > >>
> > > >> Does it happen specifically with iozone? or can dd/fio also
> > > >> reproduce this issue? on which I/O pattern do you see the issue?
> > > >>
> > > > I see it with iozone. I am trying with fio, shall soon update.
> > > > I see issue with at iosizes around 128k/256k block sizes of iozone. Its not
> > > > consistent.
> > > >>> I am not sure how LUN size could cause the connection errors. I appreciate any
> > > >>> inputs on this.
> > > >>
> > > >> I imagine that a single LUN is enough to reproduce the issue?
> > > >>
> > > > 
> > > > yes, attached is the target conf.
> > > >> btw, I tried reproducing the issue with rxe (couldn't setup an iser
> > > >> listener with siw) in 2 VMs on my laptop using lio to a file backend but
> > > >> I cannot reproduce the issue..
> > > > I see the issue quickly with 40G/25G links. I have not seen the issue on a 100G
> > > > link. BTW i a trying iwarp(T6/t5)
> > > > 
> > > > Thanks for looking into it.
> > > > 
> > > 
> > >  From the log, looks like the hang happens when the initiator tries to
> > > login after the failure (trace starts in iscsi_target_do_login). and
> > > looks like the target gave up on login timeout, but what is not
> > > indicated is why did the initiator got a ping timeout in the
> > > first place...
> 
