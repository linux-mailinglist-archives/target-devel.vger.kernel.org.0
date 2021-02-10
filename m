Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C277B316170
	for <lists+target-devel@lfdr.de>; Wed, 10 Feb 2021 09:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBJIsb (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 10 Feb 2021 03:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhBJIpD (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:45:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC8C061574;
        Wed, 10 Feb 2021 00:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U1BKN3rsCzUiXJC1oe+xxe/ch8raroLfRcCRmI+lPmc=; b=XvqHlN5NIpj3xl6J+TqXD3YNxu
        XO6fUcydTCSufFLJl9tYudCYSn3AZIbJfzKZOSnjalt2CaNozqO/WDiwy3OpJTdLallfXBkn9aj5n
        nae7MvB4m7WO0G0/1uuxmXM6fQu7qJyHlJ3NmK518kiY6WZJpowOsFilcFvohSIO5al5DG/76QQiL
        i8E9iU1y0eJJQ+F+CJHvciw65uhsgjpb0lxtT56Wnn3An6lUBq05EYdAo3rbL82s3+owqvSChGBpT
        o2aQ2oJHkmaYn9wWxY9+omT3ZBwiErI23dfOkkyPvk9ZWdDlL63aad3GXVbuXgn40Ca4KqcJOkCq6
        zkO1DBRQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9l6d-008bBr-LW; Wed, 10 Feb 2021 08:44:16 +0000
Date:   Wed, 10 Feb 2021 08:44:15 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Chaitanya.Kulkarni@wdc.com, loberman@redhat.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 12/13] target, vhost-scsi: don't switch cpus on completion
Message-ID: <20210210084415.GF2045726@infradead.org>
References: <20210209123845.4856-1-michael.christie@oracle.com>
 <20210209123845.4856-13-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209123845.4856-13-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

>  	struct se_device *se_dev = se_cmd->se_dev;
> -	int cpu = se_cmd->cpuid;
> +	int cpu;
> +
> +	if (se_cmd->se_cmd_flags & SCF_IGNORE_CPUID_COMPL)
> +		cpu = smp_processor_id();
> +	else
> +		cpu = se_cmd->cpuid;
>  
>  	target_queue_cmd_work(&se_dev->queues[cpu].cq, se_cmd, cpu,
>  			      target_completion_wq);

Can't we just use se_cmd->cpuid == WORK_CPU_UNBOUND as the no affinity
indicator, which would remove all branches here.
