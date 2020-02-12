Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9D15A0A6
	for <lists+target-devel@lfdr.de>; Wed, 12 Feb 2020 06:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBLFbY (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 12 Feb 2020 00:31:24 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:15573 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgBLFbY (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:31:24 -0500
Received: from localhost (moto.blr.asicdesigners.com [10.193.184.79] (may be forged))
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01C5V85Y031351;
        Tue, 11 Feb 2020 21:31:13 -0800
Date:   Wed, 12 Feb 2020 11:01:08 +0530
From:   Dakshaja Uppalapati <dakshaja@chelsio.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: IOZONE fails intermittently while toggling the interface
Message-ID: <20200212053106.GA18378@chelsio.com>
References: <CH2PR12MB4005D671F3D274C4D5FA0BAEDD1C0@CH2PR12MB4005.namprd12.prod.outlook.com>
 <d397e15d-ab3b-5446-a1e8-c06a1f6c66e8@acm.org>
 <20200210141913.GB11516@chelsio.com>
 <16017b1b-b69f-242d-cee4-7117b3b3742e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16017b1b-b69f-242d-cee4-7117b3b3742e@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Monday, February 02/10/20, 2020 at 19:47:41 -0800, Bart Van Assche wrote:
> On 2020-02-10 06:19, Dakshaja Uppalapati wrote:
> > I had run the test multiple times with the given patch, attached traces are seen.
> 
> Thanks for having tested the patch I had shared. Can you test the
> attached patch on top of v5.6-rc1? It reverts the following two patches:
> * e9d3009cb936 ("scsi: target: iscsi: Wait for all commands to finish
> before freeing a session") # v5.5-rc1.
> * 04060db41178 ("scsi: RDMA/isert: Fix a recently introduced regression
> related to logout") # v5.5

Hi Bart,

With the given patch on 5.6-rc1, the test runs fine overnight.

Thanks,
Dakshaja
