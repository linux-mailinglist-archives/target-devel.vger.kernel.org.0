Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551761FC506
	for <lists+target-devel@lfdr.de>; Wed, 17 Jun 2020 06:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgFQEVm (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 17 Jun 2020 00:21:42 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40716 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgFQEVm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:21:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 020AA27F1F;
        Wed, 17 Jun 2020 00:21:37 -0400 (EDT)
Date:   Wed, 17 Jun 2020 14:21:39 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Chris Boot <bootc@bootc.net>, linuxppc-dev@lists.ozlabs.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] scsi: target/sbp: remove firewire SBP target driver
In-Reply-To: <yq18sgml9ds.fsf@ca-mkp.ca.oracle.com>
Message-ID: <alpine.LNX.2.22.394.2006171310520.11@nippy.intranet>
References: <01020172acd3d10f-3964f076-a820-43fc-9494-3f3946e9b7b5-000000@eu-west-1.amazonses.com>        <alpine.LNX.2.22.394.2006140934520.15@nippy.intranet> <yq18sgml9ds.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, 16 Jun 2020, Martin K. Petersen wrote:

> > I haven't used this driver for a long time, but I still own PowerMacs 
> > with firewire, and I know I'm not the only one.
> 

I need to correct what I wrote above. I recall that years ago, when I 
needed to share storage from my Linux box to my PowerBook pismo, I used 
ethernet and the globalSAN iSCSI initiator for Mac OS X (which is no 
longer freely available AFAICS). When I said that I had used the SBP 
target driver before, I misremembered that iSCSI target setup. I've 
actually never used the SBP target driver.

> I also have old 1394 hardware kicking around in the basement. But having 
> worked with FireWire shared storage targets in the past, I have zero 
> desire to ever touch any of that again.
> 
> I could understand an objection if we were to entertain removing sbp2. 
> But really, how many people are setting up FireWire targets?
> 

It's a good question. I don't know the answer.

I have successfully used the Linux sbp2 host driver in the past, and will 
probably need to use it again. Likewise, I can see myself using the sbp 
target driver in the future because that might interoperate with MacOS 9, 
and might provide a bootable device to the PowerMac ROM. iSCSI cannot do 
those things.
