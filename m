Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7896156A0F2
	for <lists+target-devel@lfdr.de>; Thu,  7 Jul 2022 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiGGLPy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 7 Jul 2022 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiGGLPx (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:15:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4002E2C109;
        Thu,  7 Jul 2022 04:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE28CB82104;
        Thu,  7 Jul 2022 11:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA987C3411E;
        Thu,  7 Jul 2022 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657192550;
        bh=u9MP+xLs/y0J/Wa5UFNHRllrOUHwldwpgdt1sliED8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASmXMcbwyfNNAovLc//FeeN1YnQVDXsQPj3G0IhYlkJbfoNQ5cUYJpEXP1sKZLolm
         CvKepwLIQY8Asj7mxy1g+nITcCuW94M6yj2qPUkQC2UO6N6aqgf6+9OZDGyU6iLymU
         Jz58OpOOBQ+atU76YexFT3LX4Jo8oIu9/+M4kUhs=
Date:   Thu, 7 Jul 2022 13:15:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        John Youn <John.Youn@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/36] usb: gadget: f_tcm: Enhance UASP driver
Message-ID: <YsbAY4iaqWZm6sQJ@kroah.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
 <YsaEQto3Iygj1S2Q@kroah.com>
 <9f9d35b1-8d39-7413-88f6-b26e61a75bf7@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9d35b1-8d39-7413-88f6-b26e61a75bf7@synopsys.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:15:53AM +0000, Thinh Nguyen wrote:
> On 7/6/2022, Greg Kroah-Hartman wrote:
> > On Wed, Jul 06, 2022 at 04:34:20PM -0700, Thinh Nguyen wrote:
> >> The Linux UASP gadget driver is incomplete and remained broken for a long time.
> >> It was not implemented for performance either. This series adds some of the
> >> required features for the UASP driver to work. It also makes some fixes to the
> >> target core.
> > So I can't take the USB changes without a change to the target code?
> > Some of these seem like I can, so I do not understand the dependancy
> > here.
> 
> Without the entire series, UASP Compliant Verification test will fail. 

It fails today, right?  So it's not an issue.

> The dependency is more for the CV test.

That's independant of getting patches merged, correct?

> > Can you split this into at least 2 series?  One for just target, one for
> > just USB, and maybe one for the remaining bits that require both?
> >
> 
> Ok, I can split them base on compilation dependency.

You also have to realize there are maintainer and subsystem dependencies
that you are crossing.

thanks,

greg k-h
