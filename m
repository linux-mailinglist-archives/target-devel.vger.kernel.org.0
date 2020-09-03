Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7273625C1BF
	for <lists+target-devel@lfdr.de>; Thu,  3 Sep 2020 15:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgICNhj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Sep 2020 09:37:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgICNB5 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:01:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD318ABED;
        Thu,  3 Sep 2020 13:01:00 +0000 (UTC)
Message-ID: <f1e02a57e5d42c492d89acc2f82809e91e42d2aa.camel@suse.com>
Subject: Re: [PATCH v4 2/4] target: initialize LUN in
 transport_init_se_cmd().
From:   Martin Wilck <mwilck@suse.com>
To:     Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Michael Christie <michael.christie@oracle.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Shirley Ma <shirley.ma@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Arun Easi <aeasi@marvell.com>
Date:   Thu, 03 Sep 2020 15:00:58 +0200
In-Reply-To: <dcc05e5d-5b8f-4ae1-991d-b8d454eff3f0@default>
References: <1591559913-8388-1-git-send-email-sudhakar.panneerselvam@oracle.com>
         <1591559913-8388-3-git-send-email-sudhakar.panneerselvam@oracle.com>
         <cbbd368e6e33af6e22c850192e69b27edd043efd.camel@suse.com>
         <dcc05e5d-5b8f-4ae1-991d-b8d454eff3f0@default>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, 2020-09-02 at 08:14 -0700, Sudhakar Panneerselvam wrote:
> Hi Martin,
> 
> > 
> > AFAICS, your patch breaks the case where the above code is executed
> > to
> > derive unpacked_lun from the tag. The updated value of unpacked_lun
> > is
> > never used. That would break aborts for the qla2xxx target.
> > 
> > Am I overlooking something? Can you please explain?
> > 
> 
> You are right. This change breaks the qlogic abort task code path,
> since it is the only transport that sets the
> TARGET_SCF_LOOKUP_LUN_FROM_TAG flag making that condition true. My
> apologies. I can send out a patch if you have not written one
> already. Please let me know.

Please go ahead. I haven't written a patch - I'm not experienced enough
with the target code to quickly grok whether simply moving the
target_lookup_lun_from_tag() code upward would work, in particular wrt
handling failures and cleaning up.

Regards,
Martin



