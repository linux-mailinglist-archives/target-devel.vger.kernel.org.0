Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4245E9A
	for <lists+target-devel@lfdr.de>; Fri, 14 Jun 2019 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfFNNmi (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 14 Jun 2019 09:42:38 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:22443 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfFNNmi (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:42:38 -0400
Received: from localhost (varun.asicdesigners.com [10.193.190.56])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x5EDfkhn025181;
        Fri, 14 Jun 2019 06:41:47 -0700
Date:   Fri, 14 Jun 2019 19:11:44 +0530
From:   Varun Prakash <varun@chelsio.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        varun@chelsio.com
Subject: Re: [PATCH -next] cxgbit: remove set but not used variable 'ppmax'
Message-ID: <20190614134143.GA1630@chelsio.com>
References: <20190614024413.110449-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614024413.110449-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:44:13AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/target/iscsi/cxgbit/cxgbit_ddp.c: In function 'cxgbit_ddp_init':
> drivers/target/iscsi/cxgbit/cxgbit_ddp.c:303:15: warning:
>  variable 'ppmax' set but not used [-Wunused-but-set-variable]
> 
> It's not used since commit a248384e6420 ("cxgb4/libcxgb/cxgb4i/cxgbit:
> enable eDRAM page pods for iSCSI")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/target/iscsi/cxgbit/cxgbit_ddp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
> index 1443ef045a5f..fe1be5feaf21 100644
> --- a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
> +++ b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
> @@ -300,7 +300,6 @@ int cxgbit_ddp_init(struct cxgbit_device *cdev)
>  	struct cxgb4_lld_info *lldi = &cdev->lldi;
>  	struct net_device *ndev = cdev->lldi.ports[0];
>  	struct cxgbi_tag_format tformat;
> -	unsigned int ppmax;
>  	int ret, i;
>  
>  	if (!lldi->vr->iscsi.size) {
> @@ -308,8 +307,6 @@ int cxgbit_ddp_init(struct cxgbit_device *cdev)
>  		return -EACCES;
>  	}
>  
> -	ppmax = lldi->vr->iscsi.size >> PPOD_SIZE_SHIFT;
> -
>  	memset(&tformat, 0, sizeof(struct cxgbi_tag_format));
>  	for (i = 0; i < 4; i++)
>  		tformat.pgsz_order[i] = (lldi->iscsi_pgsz_order >> (i << 3))
> 

Acked-by: Varun Prakash <varun@chelsio.com>

This patch is for net-next tree.
