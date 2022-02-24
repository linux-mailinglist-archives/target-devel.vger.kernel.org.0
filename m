Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AAE4C275A
	for <lists+target-devel@lfdr.de>; Thu, 24 Feb 2022 10:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiBXJBZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Feb 2022 04:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiBXJBZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BDC1156C7F
        for <target-devel@vger.kernel.org>; Thu, 24 Feb 2022 01:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645693255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmXcQuSsrm+NZgvxKh/c/Y+56HsYbAsoh2iH7I4Nk5A=;
        b=ONPSjVFi5ux/ekHscfvwfwOqDqCCv49IQda8oqnj2IUKtyhDNFVF+iN+eBYMbB7wbaA0l7
        Ypa9YrCLA8AXUb8n68o4EhmeUabG1m5bBObqxR27gF5LHYHuehHf+G7k1NTysYfQnb33VH
        fXDevaVsStzdAatL9D84WmpvokaXwx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-yvmukoBqMxihyMhLaco2yQ-1; Thu, 24 Feb 2022 04:00:51 -0500
X-MC-Unique: yvmukoBqMxihyMhLaco2yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC461091DA1;
        Thu, 24 Feb 2022 09:00:50 +0000 (UTC)
Received: from raketa (unknown [10.40.193.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7211873DAB;
        Thu, 24 Feb 2022 09:00:49 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:00:46 +0100
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     martin.petersen@oracle.com, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] target: allow changing dbroot if there are no registered
 devices
Message-ID: <20220224090046.GC650728@raketa>
References: <20220107151054.29734-1-mlombard@redhat.com>
 <e77b17da-f3cd-3a89-c46b-67dadae359ed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77b17da-f3cd-3a89-c46b-67dadae359ed@oracle.com>
User-Agent: Mutt/1.14.7 (f34d0909) (2020-08-29)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:57:30PM -0600, Mike Christie wrote:
> On 1/7/22 9:10 AM, Maurizio Lombardi wrote:
> > The target driver prevents the users from changing
> > the database root directory if a target module like ib_srpt has
> > been registered, this makes it difficult for users to
> > set their preferred database directory if the module
> > gets loaded during the system boot.
> > 
> > Let the users modify dbroot if there are no registered devices
> > 
> > Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> > ---
> >  drivers/target/target_core_configfs.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> > index 023bd4516a68..cba10829e62f 100644
> > --- a/drivers/target/target_core_configfs.c
> > +++ b/drivers/target/target_core_configfs.c
> > @@ -72,6 +72,8 @@ static struct config_group target_core_hbagroup;
> >  static struct config_group alua_group;
> >  static struct config_group alua_lu_gps_group;
> >  
> > +static unsigned int target_devices;
> > +
> >  static inline struct se_hba *
> >  item_to_hba(struct config_item *item)
> >  {
> > @@ -106,38 +108,32 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
> >  	ssize_t read_bytes;
> >  	struct file *fp;
> >  
> > -	mutex_lock(&g_tf_lock);
> > -	if (!list_empty(&g_tf_list)) {
> > -		mutex_unlock(&g_tf_lock);
> > -		pr_err("db_root: cannot be changed: target drivers registered");
> > +	if (target_devices) {
> > +		pr_err("db_root: cannot be changed because it's in use\n");
> >  		return -EINVAL;
> >  	}
> >  
> 
> How does the locking work for this patch?
> 
> The configfs subsys mutex handles the make and drop callouts below.
> 
> For this part though, it didn't look like we are holding the same mutex,
> so can target_devices increase after we've passed that check? If so, was
> the idea that it's one of those things where if it races then it doesn't
> really matter because it's rare and nothing is really hurt?

Thanks for the review, Mike.

There is, indeed, a small window where a race condition is possible;
when "target_devices" is 0, a module gets loaded by the kernel and at the same time a userspace process
writes to dbroot, before the "target_devices" variable gets incremented to 1.

I guess it's extremely rare but maybe it's better to simply add a "target_devices_lock" mutex
to be safe.

Maurizio

