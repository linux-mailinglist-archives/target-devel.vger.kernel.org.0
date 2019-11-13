Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B11FB6D0
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 18:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfKMR56 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 12:57:58 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:36034 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728398AbfKMR55 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:57:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id DC07C4120B;
        Wed, 13 Nov 2019 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1573667874;
         x=1575482275; bh=lX0+4kAI+qpibCr3x1y9enV+GQY249KBLq/ueSPYvAk=; b=
        WleTPJOexWeinmUqI89WO5hhZ45VuTKoKJ/vz3eWO3S3mTxSM955rsl4jAbYNikw
        zQrk9H0+vnL6w8quRbISa8ZbfMk81Bv6H0k44SKVqQajCW35ThMXrOpOFuTxfQWW
        pdx4KzdiKqH2mapZC0VArLo46OyoXv/2nruJmJ3qPWM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pTxi2ZlBiDz8; Wed, 13 Nov 2019 20:57:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 7DBBE411D9;
        Wed, 13 Nov 2019 20:57:54 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 13
 Nov 2019 20:57:54 +0300
Date:   Wed, 13 Nov 2019 20:57:53 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, <target-devel@vger.kernel.org>
Subject: Re: [PATCH 2/3] target/core: Fix a use-after-free in the TMF
 handling code
Message-ID: <20191113175753.ezp5z52odf7yrydz@SPB-NB-133.local>
References: <20191112035752.8338-1-bvanassche@acm.org>
 <20191112035752.8338-3-bvanassche@acm.org>
 <20191113120249.bbzvld6yiwxpbobu@SPB-NB-133.local>
 <8e80dd8e-ae1e-1857-2b8c-0f5f341b4e4e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8e80dd8e-ae1e-1857-2b8c-0f5f341b4e4e@acm.org>
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:05:15AM -0800, Bart Van Assche wrote:
> On 11/13/19 4:02 AM, Roman Bolshakov wrote:
> > As far as I understand the change prevents backstore directory removal
> > from TCM configfs when a TMF is processed and targetcli would start
> > to fail sporadically as it tries to delete configfs directories only once:
> >    https://github.com/open-iscsi/rtslib-fb/blob/master/rtslib/node.py#L228
> > 
> > Should we hold se_device device without preventing removal of backstore?
> 
> How about using config_item_get()/config_item_put() instead of
> target_depend_item()/target_undepend_item()?
> 
> Thanks,
> 
> Bart.

Yes,
config_item_get()/config_item_put() or
config_group_get()/config_group_put() seem to be better solutions.

Thanks,
Roman
