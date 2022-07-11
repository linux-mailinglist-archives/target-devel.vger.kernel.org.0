Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6953656994C
	for <lists+target-devel@lfdr.de>; Thu,  7 Jul 2022 06:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiGGEie (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 7 Jul 2022 00:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGGEid (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 7 Jul 2022 00:38:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC7A474;
        Wed,  6 Jul 2022 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bc3tDYkfIItiaG+hm2NxNZurGkQ6HmmInzDZ/5y0u0U=; b=TekAsi+GHhxkYKxyPSnPrqBFib
        Z9ELFm64IIa1moavS1o6iWhzT4LUUbN9xeP3DJQYrhZ2Y2p4q35egA7rQS8r0WehyLoseLZwYr/q3
        ZEQmzRgujtExGwolVGysFCcW3LZQ9QxQ6RGWDIR120Qi5DdgeSwRXOHbm2I6L2clUuZaXDnovX59B
        roSCa9ugpDA4UvBlD7b3zgfUGRXYQFRMe7IaZCn79nnJbsCw0Yj5T/WQk9oZbGBRyxlBdtQ38Ioid
        RTQG3gORFr/mzh0fhQs6+2W7yhm30s/3uIh/Vpk88SNfl6vgKsiABa/OnqFA2kZtcHLzIupbGpgMP
        g5NksOJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9JHR-00DVk5-Tm; Thu, 07 Jul 2022 04:38:21 +0000
Date:   Wed, 6 Jul 2022 21:38:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        John Youn <John.Youn@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Subject: Re: [PATCH 00/36] usb: gadget: f_tcm: Enhance UASP driver
Message-ID: <YsZjPZxQZYhZ34Vh@infradead.org>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

You probably want to split this up a bit to make review easier, a
natural first series would be target core improvements that can be
used as-is.  Also please don't just Cc people on individual patches,
which makes reviewinging impossible.
