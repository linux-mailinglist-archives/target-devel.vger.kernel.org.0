Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17855C4B3
	for <lists+target-devel@lfdr.de>; Tue, 28 Jun 2022 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiF1Eyk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 28 Jun 2022 00:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbiF1Eyh (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:54:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB1617F;
        Mon, 27 Jun 2022 21:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eiw957CM/gwUXnbLj6VZ2OQcTI3CRuuAnmCdrsbOSMc=; b=DGIEOuelSOhqKK8BPpC5w4cFpg
        k6R77FU6KtlnQGdWGEiLm2lpIkSJY6hKOir99NyunEKOU0VnzgMiTwFemrN/Evy05E776Bz2eDpu9
        VXaUxfYUbQQygNm6McZ3xnYxb4McHzyglnZBcTOhcwyXi43/a1Yn9/f9t3Bpc3707EfU97hGzooqw
        tvjUdFito8sejY+0avDxNSxY6iu+Kj2E3qSxrtiSwsDESKpfiVHBx5yDCJTv+Z9EroMTGmkjyrBOj
        RGU/eKrtMjo0rI6mmWIQ+vcdRVl5z/ORWbTqhSrF+innbH9e09nl0ycEVNYLkWrWX/KRH5XYLc8yI
        sIOQ2FrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o63F9-004Gqu-4d; Tue, 28 Jun 2022 04:54:31 +0000
Date:   Mon, 27 Jun 2022 21:54:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: target: Fix WRITE_SAME No Data Buffer crash
Message-ID: <YrqJhyzhjaEkTJL/@infradead.org>
References: <20220628022325.14627-1-michael.christie@oracle.com>
 <20220628022325.14627-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628022325.14627-2-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:23:25PM -0500, Mike Christie wrote:
> In newer version of the SBC specs, we have a NDOB bit that indicates there
> is no data buffer that gets written out. If this bit is set using commands
> like "sg_write_same --ndob" we will crash in target_core_iblock/file's
> execute_write_same handlers when we go to access the se_cmd->t_data_sg
> because its NULL.
> 
> This patch adds a check for the NDOB bit in the common WRITE SAME code
> because we don't support it. And, it adds a check for zero SG elements in
> each handler in case the initiator tries to send a normal WRITE SAME with
> no data buffer.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and I wonder if we have similar problems with other commands, the
target code could use same targeted fuzzing..)
