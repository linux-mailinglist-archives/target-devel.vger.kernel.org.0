Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F83A1084B2
	for <lists+target-devel@lfdr.de>; Sun, 24 Nov 2019 20:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKXTPs (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 24 Nov 2019 14:15:48 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:35420 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbfKXTPs (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:15:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2BF9343D12;
        Sun, 24 Nov 2019 19:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1574622942;
         x=1576437343; bh=SsOll28yhsH0RSENsiT0VG8BZp5o9l5k/Q4ToUgL4o0=; b=
        oIRClJn7ndmXIm+OJZJ0BRmgJt+dKmgJDMTtqkTMDScPpt0XoFdG5b1f7mj8OGj3
        t8gEhjNXZqhVaWOCir+v6vWdvVt1yx1yoJU2wey1IyhXRT2KnZSfkg2KIAcFbpn5
        o25GuGwjJYxFM4WVnfGn+ulDsmXtc83aYeDsgFq8COc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZeYJI5TcxuGJ; Sun, 24 Nov 2019 22:15:42 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2303441240;
        Sun, 24 Nov 2019 22:15:42 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sun, 24
 Nov 2019 22:15:41 +0300
Date:   Sun, 24 Nov 2019 22:15:41 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Mark Harvey <mark.harvey@nutanix.com>
CC:     Quinn Tran <qutran@marvell.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re: [EXT] [PATCH v2 13/15] scsi: qla2xxx: Add async mode for
 qla24xx_els_dcmd_iocb
Message-ID: <20191124191541.ly3kjofunx7lm77q@SPB-NB-133.local>
References: <20191120222723.27779-1-r.bolshakov@yadro.com>
 <20191120222723.27779-14-r.bolshakov@yadro.com>
 <BYAPR18MB2759E4C4CDDA0D5447D7A5BDD54E0@BYAPR18MB2759.namprd18.prod.outlook.com>
 <81096D5B-FEC9-4A40-BE7B-ADB8CA1C5CA2@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81096D5B-FEC9-4A40-BE7B-ADB8CA1C5CA2@nutanix.com>
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Nov 22, 2019 at 05:04:52AM +0000, Mark Harvey wrote:
> Would this not result in a memory leak in the 'else' path - skiping sp->free(sp)?
>   
>   -	wait_for_completion(&elsio->u.els_logo.comp);
>     +	if (wait) {
>     +		wait_for_completion(&elsio->u.els_logo.comp);
>     +	} else {
>     +		goto done;
>     +	}
>      
>      	sp->free(sp);
>     +done:
>      	return rval;
>      }
> 

Hi Mark,

Good catch, it definetely will be a leak. I had this on mind but forgot
while rushing to post v2. I'll add proper cleanup in v3.

Thank you,
Roman
