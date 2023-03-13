Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0E6B80B6
	for <lists+target-devel@lfdr.de>; Mon, 13 Mar 2023 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCMSch (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjCMSb7 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:31:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD7E74DD2;
        Mon, 13 Mar 2023 11:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EAAF6144F;
        Mon, 13 Mar 2023 18:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA98C433EF;
        Mon, 13 Mar 2023 18:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732265;
        bh=7ZRV77H3/Rk/VKIst+mj/szmufYFv+bj01MKZJGyaLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKJRsP+S8QrdgdUP2Vse03STXMWfG+LUTy4SaTvA6ICf2sWhjS1CwD6Y1tM1XyuI8
         isU1SG19SMT+pajpJs4nUoVm2Unw0FeTXe+pUtOiTK5yCFuj62pOcvF8okgYSYSz85
         Z97AVvHhNQDtUO60MbVCitwXzlREq31L1vQg0pZI=
Date:   Mon, 13 Mar 2023 19:29:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     Martin Petersen <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Chris Boot <bootc@bootc.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux@yadro.com
Subject: Re: [PATCH v3 07/12] usb: gadget: f_tcm: remove default fabric ops
 callouts
Message-ID: <ZA9roqfJY6pqCPgD@kroah.com>
References: <20230313181110.20566-1-d.bogdanov@yadro.com>
 <20230313181110.20566-8-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313181110.20566-8-d.bogdanov@yadro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Mar 13, 2023 at 09:11:05PM +0300, Dmitry Bogdanov wrote:
> Remove callouts that have the implementation like a
> default implementation in TCM Core.
> 
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
