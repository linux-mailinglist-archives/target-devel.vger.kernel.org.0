Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAD957A0D5
	for <lists+target-devel@lfdr.de>; Tue, 19 Jul 2022 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiGSOLs (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 19 Jul 2022 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiGSOLc (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:11:32 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8872A8048D;
        Tue, 19 Jul 2022 06:31:48 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id DC4CA41259;
        Tue, 19 Jul 2022 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1658237505; x=1660051906; bh=XrITR47fnf2t0wVK0wpJtyPLqiFPHKFv2Pe
        EYhpbtT8=; b=lETh2L0p0YLl36RJW3PihKh7l/ldkPpWB00hTVrgupEbajUZblJ
        /qaHacLJB5T2pEkczNRC1rkdsSXtS+MSmGYLv0qbve0B4RoILXcA9vRIL7dYuGzT
        jMM9Nd93BTRSEUhxbIUUe/qty181hA6LsVLF1LC81VsFzSQ1Bzl/QedU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ep4OKdx950dO; Tue, 19 Jul 2022 16:31:45 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id F3A47411FB;
        Tue, 19 Jul 2022 16:31:44 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 19 Jul 2022 16:31:44 +0300
Received: from yadro.com (10.199.20.241) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 19 Jul
 2022 16:31:43 +0300
Date:   Tue, 19 Jul 2022 16:31:42 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Youn <John.Youn@synopsys.com>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] target: Handle MI_REPORT_SUPPORTED_OPERATION_CODES
Message-ID: <YtayPpMGagzPSff+@yadro.com>
References: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
 <41806206e78812afe97101a11881f5a33092a93b.1658195608.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <41806206e78812afe97101a11881f5a33092a93b.1658195608.git.Thinh.Nguyen@synopsys.com>
X-Originating-IP: [10.199.20.241]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Jul 18, 2022 at 07:07:00PM -0700, Thinh Nguyen wrote:
> Microsoft Windows checks for MI_REPORT_SUPPORTED_OPERATION_CODES. Let's
> handle this MAINTENANCE_IN command and report supported commands.

Please see the RSOC patch series[1].

[1]: https://lore.kernel.org/target-devel/20220718120117.4435-1-d.bogdanov@yadro.com/T/#t
