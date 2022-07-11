Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7908C569B26
	for <lists+target-devel@lfdr.de>; Thu,  7 Jul 2022 09:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiGGHAg (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 7 Jul 2022 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiGGG7m (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1724BC36;
        Wed,  6 Jul 2022 23:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A82E060C8B;
        Thu,  7 Jul 2022 06:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382D5C3411E;
        Thu,  7 Jul 2022 06:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657177159;
        bh=XlNQqjf0ksWiZi+hsaIA7m16PFq5Rzl5s9SH0aJuo+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/SBbJqwuttQy+nqjvkSb27SYVy6E3MAXd/zLxlkID1MuCtnlOUdQH+uX2zvDXLWI
         ehqoQJqvTCktRrP7SSvbRNlrFP3OaT5Uw6nMYRDSDD+8VEDsmJB/ybsRQNclFLMB8p
         iZsUbeuBkIlUCZs98COv2Yh8VcPAD0LuG4Ww6HIw=
Date:   Thu, 7 Jul 2022 08:59:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
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
Message-ID: <YsaEQto3Iygj1S2Q@kroah.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:34:20PM -0700, Thinh Nguyen wrote:
> The Linux UASP gadget driver is incomplete and remained broken for a long time.
> It was not implemented for performance either. This series adds some of the
> required features for the UASP driver to work. It also makes some fixes to the
> target core.

So I can't take the USB changes without a change to the target code?
Some of these seem like I can, so I do not understand the dependancy
here.

Can you split this into at least 2 series?  One for just target, one for
just USB, and maybe one for the remaining bits that require both?

thanks,

greg k-h
