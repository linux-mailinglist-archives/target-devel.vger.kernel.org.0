Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37615B172E
	for <lists+target-devel@lfdr.de>; Thu,  8 Sep 2022 10:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIHIfC (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 8 Sep 2022 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIHIfB (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:35:01 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691FD47BA2;
        Thu,  8 Sep 2022 01:34:53 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id E318044B1B;
        Thu,  8 Sep 2022 08:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1662626090; x=1664440491; bh=RaG3BW9qxLvlw+Y4apWNRny0+85OCZU/MbA
        1kfaJlpc=; b=EuI200z+FGCJqjc7UVdWaeL/+LX3EAr9CfAwynN9uRv+WmKbhff
        obvsKnrG6agmclNztJPCyyz2E2LJ0jn7PNd993KGUBXjrsCjTZm2r7FEWHTXJTKC
        3Yjw4iSMjQwyut2Dbr7QFlYAveaW4lhpY5wyY1Ef5WYjs+lXTGLqg2b4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gLlJ7zbDL9tC; Thu,  8 Sep 2022 11:34:50 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AAE574131F;
        Thu,  8 Sep 2022 11:34:49 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 8 Sep 2022 11:34:49 +0300
Received: from yadro.com (10.199.18.20) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 8 Sep 2022
 11:34:48 +0300
Date:   Thu, 8 Sep 2022 11:34:48 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Martin Petersen <martin.petersen@oracle.com>,
        <target-devel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux@yadro.com>
Subject: Re: [PATCH 1/4] target: core: fix preempt and abort for allreg res
Message-ID: <20220908083448.GA9218@yadro.com>
References: <20220907135851.3756-1-d.bogdanov@yadro.com>
 <20220907135851.3756-2-d.bogdanov@yadro.com>
 <196c8254-1dcb-1fcf-d746-0bf3a4c12ff4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <196c8254-1dcb-1fcf-d746-0bf3a4c12ff4@acm.org>
X-Originating-IP: [10.199.18.20]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:18:57AM -0700, Bart Van Assche wrote:
> 
> On 9/7/22 06:58, Dmitry Bogdanov wrote:
> > -             if (pr_reg->pr_res_key != sa_res_key)
> > +             if ((sa_res_key) && (pr_reg->pr_res_key != sa_res_key))
> >                       continue;
> 
> Please do not introduce superfluous parentheses. Four parentheses can be
> left out from the above code without affecting readability.
Ok, will remove.

BR,
 Dmitry
