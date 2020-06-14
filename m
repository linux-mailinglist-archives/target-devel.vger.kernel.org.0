Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227A81F8B50
	for <lists+target-devel@lfdr.de>; Mon, 15 Jun 2020 01:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgFNX3A (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 14 Jun 2020 19:29:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35186 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgFNX3A (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 14 Jun 2020 19:29:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id BFEE1272D7;
        Sun, 14 Jun 2020 19:28:56 -0400 (EDT)
Date:   Mon, 15 Jun 2020 09:28:56 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Chris Boot <bootc@boo.tc>
cc:     Chris Boot <bootc@bootc.net>, linuxppc-dev@lists.ozlabs.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] scsi: target/sbp: remove firewire SBP target driver
In-Reply-To: <7ad14946-5c25-fc49-1e48-72d37a607832@boo.tc>
Message-ID: <alpine.LNX.2.22.394.2006150919110.8@nippy.intranet>
References: <01020172acd3d10f-3964f076-a820-43fc-9494-3f3946e9b7b5-000000@eu-west-1.amazonses.com> <alpine.LNX.2.22.394.2006140934520.15@nippy.intranet> <7ad14946-5c25-fc49-1e48-72d37a607832@boo.tc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Sun, 14 Jun 2020, Chris Boot wrote:

> I expect that if someone finds this useful it can stick around (but 
> that's not my call).

Who's call is that? If the patch had said "From: Martin K. Petersen" and 
"This driver is being removed because it has the following defects..." 
that would be some indication of a good-faith willingness to accept users 
as developers in the spirit of the GPL, which is what you seem to be 
alluding to (?).

> I just don't have the time or inclination or hardware to be able to 
> maintain it anymore, so someone else would have to pick it up.
> 

Which is why most drivers get orphaned, right?
