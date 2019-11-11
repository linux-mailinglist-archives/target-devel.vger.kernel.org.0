Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F04F7D90
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 19:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfKKS6H (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 13:58:07 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:46908 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730919AbfKKS6G (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:58:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5A73D411F9;
        Mon, 11 Nov 2019 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        user-agent:in-reply-to:content-disposition:content-type
        :content-type:mime-version:references:message-id:subject:subject
        :from:from:date:date:received:received:received; s=mta-01; t=
        1573498684; x=1575313085; bh=ir37MglRiYqOdrP2GJpABVGFJuDK9TZdwLJ
        QOSl/Y7A=; b=fZv55BL850mhWmxU5OcLTgIjRyZSl5pSJPpPa2jwRyt842E5lGG
        rl7o9FFvLGC2GX9jI5NM2OeXIqAifwUkn6jQ1lSj+shH3Dd8yRBQ6lYtZsLMREEV
        yxJkux6VaG2Og854aTE2i2f24eH79m+6FeMumD0+Zr2dMUoATg8imMsQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rZyanrctT-7K; Mon, 11 Nov 2019 21:58:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3878C411D9;
        Mon, 11 Nov 2019 21:58:04 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Nov 2019 21:58:03 +0300
Date:   Mon, 11 Nov 2019 21:58:02 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, <target-devel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Improve SPC-2 reservation support
Message-ID: <20191111185802.fedzop3t6po4mpgp@SPB-NB-133.local>
References: <20191111182944.191123-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191111182944.191123-1-bvanassche@acm.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:29:42AM -0800, Bart Van Assche wrote:
> Hi Martin,
> 
> This patch series improves support for SPC-2 reservations in the SCSI target
> code. Please consider these patches for inclusion in the v5.5 kernel.
> 
> Thanks,
> 
> Bart.
> 
> Bart Van Assche (2):
>   target/core: Declare target_release_reservation() 'static'
>   target/iscsi: Fix a use-after-free while closing a session
> 
>  drivers/target/target_core_pr.c        |  2 +-
>  drivers/target/target_core_pr.h        |  1 -
>  drivers/target/target_core_transport.c | 11 +++++++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)

Hi Bart,

I have missed the second patch, who was it send to?

Thanks,
Roman
