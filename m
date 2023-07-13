Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB47752301
	for <lists+target-devel@lfdr.de>; Thu, 13 Jul 2023 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjGMNIb (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 13 Jul 2023 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjGMNIa (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:08:30 -0400
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97649272A;
        Thu, 13 Jul 2023 06:08:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 0D2C2C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
        t=1689253607; bh=UuftEBn/Rh4qaYKGVD8HlBWfUCp6eVO6XdUiiClGjn0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=bnf6afroALiuenpVfZqHDqnzUxw25emenIGEjBsZdN7s1NNi8yhvnzRPlC87T4WlO
         bMbAVsquliPxpLjCyuqDwo/tR6PyzY5R3ilEQf05OqpcRzj+SGIS/HgEKa8S9Pt0ZH
         QJ+TenzfrRdDjXwIYD4EOikTvGl1okxUGpRyLXOKdRgAC6pm3adFHDPYDwuDb+n2PF
         1JNNot6tUghK9toaC4CREyEM+x2bVJC0uqySo4TRTTgOI6epQpI45FrGmWPPUw8iLx
         GpYlUb/+fPvEEqV+NaZZ84lYZ669Kw1HZMlu23put06j5K+Zg0wF0AHdg5dez6LjTp
         sX6uBfkjF6Whg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
        t=1689253607; bh=UuftEBn/Rh4qaYKGVD8HlBWfUCp6eVO6XdUiiClGjn0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=rxzYKUVDteQGbka73O8+TR0g/otnUWaSznNHOVsuaL8scZ2ibDoyzoQL/uQFVTbvs
         HtyUuC/VQY8Qt9RTjjVvpbKBFKxdwljuzs7xWZySguGVN+2I0D2PKLDX5opw1ys8ai
         Ht6V7anTIfijmg3uDuSITKUASho9tgDNgEhLhqqRPR18XcQoDKbrqoELVhbuwAqhpJ
         KCueAbtC/S0HA4zQyHVIrRpj6L2gnfIxAm3Apu7vf2d7DQoi/sPfhSxoBEE5CfCDdv
         Ju7H6EnFA6OuKuwi60FB3UOPai6QbwX3aIrC6iDdpD3frZiPtsgXj2zjlvVBJiPlM+
         ReZMQocQjikQA==
Date:   Thu, 13 Jul 2023 16:06:44 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Mike Christie <michael.christie@oracle.com>
CC:     <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>
Subject: Re: [PATCH 5/5] scsi: target: Export fabric driver direct submit
 settings
Message-ID: <ZK_25KIJw-CudIXw@yadro.com>
References: <20230710214442.6718-1-michael.christie@oracle.com>
 <20230710214442.6718-6-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230710214442.6718-6-michael.christie@oracle.com>
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:44:42PM -0500, Mike Christie wrote:
> +static ssize_t
> +target_fabric_wwn_default_to_direct_submit_show(struct config_item *item,
> +                                               char *page)
> +{
> +       struct se_wwn *wwn = container_of(to_config_group(item), struct se_wwn,
> +                                         param_group);
> +       return sprintf(page, "%u\n", wwn->wwn_tf->tf_ops->default_direct_submit);

I belive we should do the right thing and use sysfs_emit() here. We
already have a bunch of issues with bad sprintf() usage and I think it
would be wise to promote safer interfaces.

> +static ssize_t
> +target_fabric_wwn_direct_submit_supported_show(struct config_item *item,
> +                                              char *page)
> +{
> +       struct se_wwn *wwn = container_of(to_config_group(item), struct se_wwn,
> +                                         param_group);
> +       return sprintf(page, "%u\n", wwn->wwn_tf->tf_ops->direct_submit_supp);

Same.
