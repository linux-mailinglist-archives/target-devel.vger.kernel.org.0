Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8815A1F33EF
	for <lists+target-devel@lfdr.de>; Tue,  9 Jun 2020 08:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFIGGA (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 9 Jun 2020 02:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgFIGGA (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:06:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F05207ED;
        Tue,  9 Jun 2020 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591682759;
        bh=WWSavYrkVy2JAdyvHI5Gi44HBCHndpJx+8K3aVnZlJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHDD+W6PgQkMEYp5SsIXrSNBdBsmTkXLB7/3aIs60TVYiP3UmG1WvOYQl6oIWbrXA
         ol62Jgb1GSJ3JSA0wbu+5vBFvZGtZxysF0nw3+43qsjgHmfrSMNw+SSSvymHdOqWjY
         SPON/M5LHn9+EH7/AiDe1UnxBgUS2fvrfg/b43LA=
Date:   Tue, 9 Jun 2020 08:05:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH 11/17] target: add session sysfs class support
Message-ID: <20200609060557.GA498310@kroah.com>
References: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
 <1591562164-9766-12-git-send-email-michael.christie@oracle.com>
 <20200608053259.GA241877@kroah.com>
 <1bb2e8f9-d433-de3b-3c4a-2ded2fa54240@oracle.com>
 <20200608163656.GA425601@kroah.com>
 <e16dedcd-10ae-3d25-c49a-c24b5d964434@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16dedcd-10ae-3d25-c49a-c24b5d964434@oracle.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Jun 08, 2020 at 02:02:16PM -0500, Mike Christie wrote:
> 
> 
> On 6/8/20 11:36 AM, Greg Kroah-Hartman wrote:
> > On Mon, Jun 08, 2020 at 10:35:56AM -0500, Mike Christie wrote:
> > > 
> > > 
> > > On 6/8/20 12:32 AM, Greg Kroah-Hartman wrote:
> > > > On Sun, Jun 07, 2020 at 03:35:58PM -0500, Mike Christie wrote:
> > > > > +int target_sysfs_add_session(struct se_portal_group *se_tpg,
> > > > > +			     struct se_session *se_sess)
> > > > > +{
> > > > > +	struct t10_transport_id *tpt_id = se_sess->tpt_id;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!try_module_get(se_sess->tfo->module))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	ret = target_cp_endpoint_strs(se_tpg, se_sess);
> > > > > +	if (ret)
> > > > > +		goto put_mod;
> > > > > +
> > > > > +	se_sess->dev.groups = se_sess->tfo->session_attr_groups;
> > > > > +	ret = device_add(&se_sess->dev);
> > > > > +	if (ret) {
> > > > > +		pr_err("Could not add session%d to sysfs. Error %d.\n",
> > > > > +		       se_sess->sid, ret);
> > > > > +		goto free_ep_strs;
> > > > > +	}
> > > > > +
> > > > > +	pr_info("TCM added session-%d from [fabric: %s, target: %s, tpg %s, acl: %s] to [initiator port: %s%s%s]",
> > > > > +		se_sess->sid, se_sess->fabric_name, se_sess->target_name,
> > > > > +		se_sess->tpg_name, se_sess->acl_name ? se_sess->acl_name : "dynamic",
> > > > > +		tpt_id->name, tpt_id->session_id ? "," : "",
> > > > > +		tpt_id->session_id ? tpt_id->session_id : "");
> > > > 
> > > > You have a 'struct device', so please use it, no need for pr_info(),
> > > > always use the dev_*() calls instead.
> > > > 
> > > > but, when drivers and kernel code is all working properly, no need to be
> > > > noisy at all, this should just be a dev_dbg() call, right?
> > > 
> > > I liked the info one, because the the code can work correctly, but the
> > > remote devices we are connecting to are normally going to hit issues.
> > > 
> > > For example every time the storage network goes down temporarily the driver
> > > code will call remove function, then call the add again when it comes back
> > > up. Having it always logged helps us figure out the root problem later when
> > > the customer only has logs available.
> > 
> > Then make this a tracepoint or something, again, do not be noisy for
> > normal system operations.  Do you want this to be the case for all of
> 
> What's a special case vs normal?
> 
> I would agree having a SCSI HBA in your system and having it setup during
> system boot up is normal.
> 
> I would agree hardware failing is special.
> 
> Having a remote client connect to us, lose its connected then recover seems
> special, because it's a failure case.
> 
> Even the initial connection seems like a special event, because the user has
> done some extra steps to have the client connect to us. It's like adding a
> new disk to the system which we log today or like plugging in or removing a
> USB device which we also log.
> 
> 
> > your hardware devices all the time?
> > 
> 
> I do, but I'm a kernel developer :)
> 
> For the sys admin and distro debugging type of case, yes, they want this
> type of thing logged, because they have done some extra setup to have a
> remote client connect to us. When the connection is lost and then re-added
> they want all that info logged with the lower level info we are already
> logging, so they can follow the time of events.

Ok, then, if they really need this, use the standard format for logging
and use the dev_info() function instead.  That allows them to properly
determine what device/driver sent that message at that point in time.

thanks,

greg k-h
