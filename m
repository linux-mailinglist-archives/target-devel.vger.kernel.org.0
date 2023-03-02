Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882956A7E34
	for <lists+target-devel@lfdr.de>; Thu,  2 Mar 2023 10:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCBJne (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 2 Mar 2023 04:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCBJn0 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:43:26 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927D659B;
        Thu,  2 Mar 2023 01:43:20 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 3A679341E41;
        Thu,  2 Mar 2023 12:43:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-type:content-type:date:from:from:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to; s=mta-01; bh=+C8zYPsyQMChni6wkDNM/fkmkRZQye9VE9GuESYHVBQ=; b=
        ZurdOvdLmmIO83fLNScnXtkpVbPVGo/hiJD+ygRGtBcPB3X21+ihrW+rzcns+aGN
        KR9xcuJ/pj60YyLLf6sNjMtobZZryeIOy2QGwHP5CBSxls/zdpmqOgMZXCwcf/MH
        0JYexJwxRLohesJKXmrLBsPjC7NOHls+6PHQwfR4rko=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 30C8A341ACD;
        Thu,  2 Mar 2023 12:43:18 +0300 (MSK)
Received: from yadro.com (10.178.114.42) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 2 Mar 2023
 12:43:17 +0300
Date:   Thu, 2 Mar 2023 12:43:17 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Mike Christie <michael.christie@oracle.com>
CC:     <mlombard@redhat.com>, <martin.petersen@oracle.com>,
        <mgurtovoy@nvidia.com>, <sagi@grimberg.me>,
        <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>
Subject: Re: [PATCH v3 07/14] scsi: target: Fix multiple LUN_RESET handling
Message-ID: <20230302094317.GB1340@yadro.com>
References: <20230129234441.116310-1-michael.christie@oracle.com>
 <20230129234441.116310-8-michael.christie@oracle.com>
 <20230211085922.GA5419@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230211085922.GA5419@yadro.com>
X-Originating-IP: [10.178.114.42]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Sat, Feb 11, 2023 at 11:59:22AM +0300, Dmitry Bogdanov wrote:
> On Sun, Jan 29, 2023 at 05:44:34PM -0600, Mike Christie wrote:
> > 
> > This fixes a bug where an initiator thinks a LUN_RESET has cleaned
> > up running commands when it hasn't. The bug was added in:
> > 
> > commit 51ec502a3266 ("target: Delete tmr from list before processing")
> > 
> > The problem occurs when:
> > 
> > 1. We have N IO cmds running in the target layer spread over 2 sessions.
> > 2. The initiator sends a LUN_RESET for each session.
> > 3. session1's LUN_RESET loops over all the running commands from both
> > sessions and moves them to its local drain_task_list.
> > 4. session2's LUN_RESET does not see the LUN_RESET from session1 because
> > the commit above has it remove itself. session2 also does not see any
> > commands since the other reset moved them off the state lists.
> > 5. sessions2's LUN_RESET will then complete with a successful response.
> > 6. sessions2's inititor believes the running commands on its session are
> > now cleaned up due to the successful response and cleans up the running
> > commands from its side. It then restarts them.
> > 7. The commands do eventually complete on the backend and the target
> > starts to return aborted task statuses for them. The initiator will
> > either throw a invalid ITT error or might accidentally lookup a new task
> > if the ITT has been reallocated already.
> > 
> > This fixes the bug by reverting the patch.
> > 
> > Fixes: 51ec502a3266 ("target: Delete tmr from list before processing")
> > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> 
> Actually, this patch even fixes a crash that we've just faced.
> The second LUN_RESET moves the first LUN_RESET from tmr_list to its
> drain_tmr_list, then the first LUN_RESET removes itself from second`s
> drain_tmr_list, then the second LUN_RESET tries to remove the first from
> the list and crashes because it was deleted already.
> So,
> 
> Tested-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

Unfortunately, I am revoking my tags. This patch leads to deadlock of two
LUN_RESETs waiting for each other in its drain_tmr_list.

To keep LUN_RESETs ignoring each other something like that is needed:
> ---
>  drivers/target/target_core_tmr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
> index 2b95b4550a63..a60802b4c5a3 100644
> --- a/drivers/target/target_core_tmr.c
> +++ b/drivers/target/target_core_tmr.c
> @@ -188,9 +188,10 @@ static void core_tmr_drain_tmr_list(
>          * LUN_RESET tmr..
>          */
>         spin_lock_irqsave(&dev->se_tmr_lock, flags);
> -       if (tmr)
> -               list_del_init(&tmr->tmr_list);
>         list_for_each_entry_safe(tmr_p, tmr_pp, &dev->dev_tmr_list, tmr_list) {
- > +               if (tmr_p == tmr)
- > +                       continue;
- > +

+		/* Ignore LUN_RESETs to avoid deadlocks */
+		if (tmr_p->function == TMR_LUN_RESET)
+			continue;
+ 


>                 cmd = tmr_p->task_cmd;
>                 if (!cmd) {
>                         pr_err("Unable to locate struct se_cmd for TMR\n");
> --
> 2.25.1



