Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E8F7E5A
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKKTDR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 14:03:17 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:47058 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbfKKTDQ (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:03:16 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9EDE9411F9;
        Mon, 11 Nov 2019 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        user-agent:in-reply-to:content-disposition:content-type
        :content-type:mime-version:references:message-id:subject:subject
        :from:from:date:date:received:received:received; s=mta-01; t=
        1573498993; x=1575313394; bh=p32PQq9ofkgeOqROtBQakS7hx4cQFs3O54b
        qhgId0YM=; b=Qq3H+bWvycjQ/neFSPiyZphOJ5I0EAUPH9yy5hKgY1amegLCT/5
        jAcHguLyrluv0UAVU+3OuV2jrtORbZ06eLMO3bHeGz70xJd1+Tpt7+xSIAfuCdPQ
        pWI3uFTobVJ2199a9bAeTsYZ+OJmVvZX1x6COiLtGUhKGZdjrb8zSNwU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oAeCUce2nrXj; Mon, 11 Nov 2019 22:03:13 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9A747411D9;
        Mon, 11 Nov 2019 22:03:13 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Nov 2019 22:03:13 +0300
Date:   Mon, 11 Nov 2019 22:03:11 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, <target-devel@vger.kernel.org>
Subject: Re: [PATCH 1/2] target/core: Declare target_release_reservation()
 'static'
Message-ID: <20191111190311.bqavf2nydri73u7n@SPB-NB-133.local>
References: <20191111182944.191123-1-bvanassche@acm.org>
 <20191111182944.191123-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191111182944.191123-2-bvanassche@acm.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:29:43AM -0800, Bart Van Assche wrote:
> Since this function is only used inside the source file in which it has
> been defined, declare it 'static'. See also commit fae43461f8f2 ("scsi:
> target/core: Rework the SPC-2 reservation handling code").
> 
> Cc: Mike Christie <mchristi@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/target/target_core_pr.c | 2 +-
>  drivers/target/target_core_pr.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
> index 5e931690e697..6a72b61e0076 100644
> --- a/drivers/target/target_core_pr.c
> +++ b/drivers/target/target_core_pr.c
> @@ -187,7 +187,7 @@ static int target_check_scsi2_reservation_conflict(struct se_cmd *cmd)
>  	return 0;
>  }
>  
> -void target_release_reservation(struct se_device *dev)
> +static void target_release_reservation(struct se_device *dev)
>  {
>  	dev->reservation_holder = NULL;
>  	dev->dev_reservation_flags &= ~DRF_SPC2_RESERVATIONS;
> diff --git a/drivers/target/target_core_pr.h b/drivers/target/target_core_pr.h
> index a31c93e4e19c..198fad5c89dc 100644
> --- a/drivers/target/target_core_pr.h
> +++ b/drivers/target/target_core_pr.h
> @@ -58,7 +58,6 @@ extern struct kmem_cache *t10_pr_reg_cache;
>  
>  extern void core_pr_dump_initiator_port(struct t10_pr_registration *,
>  			char *, u32);
> -extern void target_release_reservation(struct se_device *dev);
>  extern sense_reason_t target_scsi2_reservation_release(struct se_cmd *);
>  extern sense_reason_t target_scsi2_reservation_reserve(struct se_cmd *);
>  extern int core_scsi3_alloc_aptpl_registration(
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman
