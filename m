Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98BE10B456
	for <lists+target-devel@lfdr.de>; Wed, 27 Nov 2019 18:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK0RYe (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 27 Nov 2019 12:24:34 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:58550 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbfK0RYe (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:24:34 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1F75941908;
        Wed, 27 Nov 2019 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1574875471;
         x=1576689872; bh=AhReUaPK4yzFFhByAiDOHhPyhZ6Oy4WFZuybvftsJl8=; b=
        HQXPAekij1T6OIxiYaLtnpBOLp8p0EOhOYLR+lk9BIdBJKY3e5dpF91YIdrNNGIQ
        9LVaF9OF/4E5F7PHSBfAhoQp9tAmNOlBMVhzmmcngziE02uqTMLG0d6JJcEYctL/
        2EbYy6mPVDpJ8baaEjHjdLs5ARGehWkDzTYgG8LJUcI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xFRllGOoIWWR; Wed, 27 Nov 2019 20:24:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3A863412D2;
        Wed, 27 Nov 2019 20:24:31 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 27
 Nov 2019 20:24:30 +0300
Date:   Wed, 27 Nov 2019 20:24:27 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux@yadro.com>
Subject: Re: [PATCH v3 00/13] scsi: qla2xxx: Bug fixes
Message-ID: <20191127172427.jpqfopou7y6kyrev@SPB-NB-133.local>
References: <20191125165702.1013-1-r.bolshakov@yadro.com>
 <347fd571-89d7-2b7e-fd88-1711002c3fb9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <347fd571-89d7-2b7e-fd88-1711002c3fb9@acm.org>
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, Nov 26, 2019 at 12:56:51PM -0800, Bart Van Assche wrote:
> On 11/25/19 8:56 AM, Roman Bolshakov wrote:
> > The patch series contains fixes for qla2xxx and solves two visible
> > issues: [ ... ]
> 
> As explained in Documentation/process/2.Process.rst, please post patches
> outside the merge window.
> 
> Thanks,
> 
> Bart.

Hi Bart,

Thank you for the reference. Could you please assess if my understanding
of the document is correct:
	The fixes might go into 5.5-rc2 after the release of rc1 which
	closes the merge window.

	No patches except critical for -rc1 should be posted when the
	merge window is opened.

Best regards,
Roman
