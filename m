Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FEC5F47BA
	for <lists+target-devel@lfdr.de>; Tue,  4 Oct 2022 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiJDQhL (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 4 Oct 2022 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJDQhL (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:37:11 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E25F111;
        Tue,  4 Oct 2022 09:37:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9A8514014D;
        Tue,  4 Oct 2022 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1664901426; x=1666715827; bh=XfD71T5vvN2X0QCgfM/MAyfH/eKivYQ5+0a
        n04TUxr4=; b=BqBO7UARBZWoh9gsVCBJaW6OcZpT+SVNkhFFyVjqajyqu2FtiYE
        /cYLEx4GgbLd3Qv+2D3gXtRZDwIrX4Slo99P56g9YJujbA6LcUdxkU2u686UcZVx
        043G01bwAeEEBe7MOmkCmSLFS76pC7FsaThjPGncHuNEkNMhlsZsHV9o=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mV5E1svy0i7x; Tue,  4 Oct 2022 19:37:06 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (T-EXCH-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 167E8400F8;
        Tue,  4 Oct 2022 19:37:05 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 4 Oct 2022 19:37:04 +0300
Received: from yadro.com (10.199.18.20) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 4 Oct 2022
 19:37:04 +0300
Date:   Tue, 4 Oct 2022 19:37:03 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Mike Christie <michael.christie@oracle.com>
CC:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux@yadro.com>
Subject: Re: [PATCH 7/7] target: core: check RTPI uniquity for enabled TPG
Message-ID: <20221004163703.GD10901@yadro.com>
References: <20220906154519.27487-1-d.bogdanov@yadro.com>
 <20220906154519.27487-8-d.bogdanov@yadro.com>
 <5f730538-6738-86b9-fefe-da09ad9e0a47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f730538-6738-86b9-fefe-da09ad9e0a47@oracle.com>
X-Originating-IP: [10.199.18.20]
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

On Thu, Sep 29, 2022 at 07:02:12PM -0500, Mike Christie wrote:
> 
> On 9/6/22 10:45 AM, Dmitry Bogdanov wrote:
> > Garantee uniquity of RTPI only for enabled target port groups.
> > Allow any RPTI for disabled tpg until it is enabled.
> >
> > Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> > ---
> >  drivers/target/target_core_fabric_configfs.c | 29 +++++++++++++-
> >  drivers/target/target_core_internal.h        |  2 +
> >  drivers/target/target_core_tpg.c             | 40 +++++++++++++-------
> >  3 files changed, 56 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
> > index a34b5db4eec5..fc1b8f54fb54 100644
> > --- a/drivers/target/target_core_fabric_configfs.c
> > +++ b/drivers/target/target_core_fabric_configfs.c
> > @@ -857,6 +857,7 @@ static ssize_t target_fabric_tpg_base_enable_store(struct config_item *item,
> >                                                  size_t count)
> >  {
> >       struct se_portal_group *se_tpg = to_tpg(item);
> > +     struct se_portal_group *tpg;
> >       int ret;
> >       bool op;
> >
> > @@ -867,11 +868,37 @@ static ssize_t target_fabric_tpg_base_enable_store(struct config_item *item,
> >       if (se_tpg->enabled == op)
> >               return count;
> >
> > +     spin_lock(&g_tpg_lock);
> > +
> > +     if (op) {
> > +             tpg = core_get_tpg_by_rtpi(se_tpg->tpg_rtpi);
> > +             if (tpg) {
> > +                     spin_unlock(&g_tpg_lock);
> > +
> > +                     pr_err("TARGET_CORE[%s]->TPG[%u] - RTPI %#x conflicts with TARGET_CORE[%s]->TPG[%u]\n",
> > +                            se_tpg->se_tpg_tfo->fabric_name,
> > +                            se_tpg->se_tpg_tfo->tpg_get_tag(tpg),
> > +                            se_tpg->tpg_rtpi,
> > +                            tpg->se_tpg_tfo->fabric_name,
> > +                            tpg->se_tpg_tfo->tpg_get_tag(tpg));
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     se_tpg->enabled |= 0x10; /* transient state */
> 
> Just use a mutex and hold it the entire time if you can and
> drop this. Or add a proper enum/define for the states and make a real
> API since this is exported to userspace, and it's going to be difficult
> to explain to users that state.

Yes, it looks wierd.
After rewriting to xarray I decided (according to SAM-5) to not allow
to change RTPI on the enabled TPG. And that part will be dropped.
4.6.5.2 Relative Port Identifier attribute
  The relative port identifier for a SCSI port shall not change once
  assigned unless reconfiguration of the SCSI target device occurs.
> 
> > +     spin_unlock(&g_tpg_lock);
> > +
> >       ret = se_tpg->se_tpg_tfo->fabric_enable_tpg(se_tpg, op);
> > -     if (ret)
> > +
> > +     spin_lock(&g_tpg_lock);
> > +     if (ret < 0) {
> > +             se_tpg->enabled &= ~0x10; /* clear transient state */
> > +             spin_unlock(&g_tpg_lock);
> >               return ret;
> > +     }
> >
> >       se_tpg->enabled = op;
> > +     spin_unlock(&g_tpg_lock);
> >
> >       return count;
> >  }
> > diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
> > index d662cdc9a04c..d4ace697edb0 100644
> > --- a/drivers/target/target_core_internal.h
> > +++ b/drivers/target/target_core_internal.h
> > @@ -116,6 +116,7 @@ int       core_tmr_lun_reset(struct se_device *, struct se_tmr_req *,
> >               struct list_head *, struct se_cmd *);
> >
> >  /* target_core_tpg.c */
> > +extern struct spinlock g_tpg_lock;
> >  extern struct se_device *g_lun0_dev;
> >  extern struct configfs_attribute *core_tpg_attrib_attrs[];
> >
> > @@ -131,6 +132,7 @@ void core_tpg_remove_lun(struct se_portal_group *, struct se_lun *);
> >  struct se_node_acl *core_tpg_add_initiator_node_acl(struct se_portal_group *tpg,
> >               const char *initiatorname);
> >  void core_tpg_del_initiator_node_acl(struct se_node_acl *acl);
> > +struct se_portal_group *core_get_tpg_by_rtpi(u16 rtpi);
> >
> >  /* target_core_transport.c */
> >  extern struct kmem_cache *se_tmr_req_cache;
> > diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
> > index 85c9473a38fd..ef2adbe628e0 100644
> > --- a/drivers/target/target_core_tpg.c
> > +++ b/drivers/target/target_core_tpg.c
> > @@ -34,7 +34,7 @@ extern struct se_device *g_lun0_dev;
> >  static u16 g_tpg_count;
> >  static u16 g_tpg_rtpi_counter = 1;
> >  static LIST_HEAD(g_tpg_list);
> > -static DEFINE_SPINLOCK(g_tpg_lock);
> > +DEFINE_SPINLOCK(g_tpg_lock);
> >
> >  /*   __core_tpg_get_initiator_node_acl():
> >   *
> > @@ -476,7 +476,7 @@ static int core_tpg_register_rtpi(struct se_portal_group *se_tpg)
> >                * Make sure RELATIVE TARGET PORT IDENTIFIER is unique
> >                * for 16-bit wrap..
> >                */
> > -             if (se_tpg->tpg_rtpi == tpg->tpg_rtpi)
> > +             if (tpg->enabled && se_tpg->tpg_rtpi == tpg->tpg_rtpi)
> >                       goto again;
> >       }
> >       list_add(&se_tpg->tpg_list, &g_tpg_list);
> > @@ -738,12 +738,26 @@ static ssize_t core_tpg_rtpi_show(struct config_item *item, char *page)
> >       return sprintf(page, "%#x\n", se_tpg->tpg_rtpi);
> >  }
> >
> > +struct se_portal_group *
> > +core_get_tpg_by_rtpi(u16 rtpi)
> > +{
> > +     struct se_portal_group *tpg;
> > +
> > +     lockdep_assert_held(&g_tpg_lock);
> > +
> > +     list_for_each_entry(tpg, &g_tpg_list, tpg_list) {
> > +             if (tpg->enabled && rtpi == tpg->tpg_rtpi)
> > +                     return tpg;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> >  static ssize_t core_tpg_rtpi_store(struct config_item *item,
> >                                  const char *page, size_t count)
> >  {
> >       struct se_portal_group *se_tpg = attrib_to_tpg(item);
> >       struct se_portal_group *tpg;
> > -     bool rtpi_changed = false;
> >       u16 val;
> >       int ret;
> >
> > @@ -753,11 +767,14 @@ static ssize_t core_tpg_rtpi_store(struct config_item *item,
> >       if (val == 0)
> >               return -EINVAL;
> >
> > -     /* RTPI shouldn't conflict with values of existing ports */
> > +     if (se_tpg->tpg_rtpi == val)
> > +             return count;
> 
> This test above and the chunk at the end looks like it should have been
> in patch 6.
> 
This patch will be completely rewritten.

> > +
> >       spin_lock(&g_tpg_lock);
> >
> > -     list_for_each_entry(tpg, &g_tpg_list, tpg_list) {
> > -             if (se_tpg != tpg && val == tpg->tpg_rtpi) {
> > +     if (se_tpg->enabled) {
> > +             tpg = core_get_tpg_by_rtpi(val);
> > +             if (tpg) {
> >                       spin_unlock(&g_tpg_lock);
> >                       pr_err("TARGET_CORE[%s]->TPG[%u] - RTPI %#x conflicts with TARGET_CORE[%s]->TPG[%u]\n",
> >                              se_tpg->se_tpg_tfo->fabric_name,
> > @@ -769,17 +786,12 @@ static ssize_t core_tpg_rtpi_store(struct config_item *item,
> >               }
> >       }
> >
> > -     if (se_tpg->tpg_rtpi != val) {
> > -             se_tpg->tpg_rtpi = val;
> > -             rtpi_changed = true;
> > -     }
> > +     se_tpg->tpg_rtpi = val;
> >       spin_unlock(&g_tpg_lock);
> >
> > -     if (rtpi_changed)
> > -             core_tpg_ua(se_tpg, 0x3f, ASCQ_3FH_INQUIRY_DATA_HAS_CHANGED);
> > -     ret = count;
> > +     core_tpg_ua(se_tpg, 0x3f, ASCQ_3FH_INQUIRY_DATA_HAS_CHANGED);
> >
> > -     return ret;
> > +     return count;
> >  }
> >
> >  CONFIGFS_ATTR(core_tpg_, rtpi);
> 
