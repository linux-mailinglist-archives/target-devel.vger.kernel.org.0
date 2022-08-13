Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401C5591950
	for <lists+target-devel@lfdr.de>; Sat, 13 Aug 2022 09:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiHMHtw (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 13 Aug 2022 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMHtw (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 13 Aug 2022 03:49:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662915F79;
        Sat, 13 Aug 2022 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=996nTc1Rzd0p7dmFxUJd/OrFv7UQBU3m78hDVoUU6E4=; b=GrccNOnV3cMbFoojV0nJqmx1on
        QUAll3CgXBLia56NswHWJVEHw1sfSAUCh4dnXqIIpi9/fqLbXI/XdsWGl2a1+p1ARypMnEW/cT3mI
        hKXZO19/ob5pNPbb6ZoAV5RsAJj5T/hyW4QZrzHya0r6f6XOgTQCBSH3t9GT3Y+Vh2xxJhEiAtkpX
        rkb6ssEVaXe795LJ1C1vTio7KM77A/55i9d8Et+E3DAvO1ToLzGK/cDVX6o8dAIcDOvwjWfFt0hG4
        bO6gbgk47GLNxmVgDVy45SBLw0u9HntEBAMtmN6YHPJUBpoDfrUfhQELRyqgX0dJXcXgQsyQPPOGG
        dXO1Ac1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMltv-00C94Z-SQ; Sat, 13 Aug 2022 07:49:43 +0000
Date:   Sat, 13 Aug 2022 00:49:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux@yadro.com, Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH 2/6] scsi: target: core: add list of opcodes for RSOC
Message-ID: <YvdXl/H1etXxeTqN@infradead.org>
References: <20220718120117.4435-1-d.bogdanov@yadro.com>
 <20220718120117.4435-3-d.bogdanov@yadro.com>
 <99508f9b-46cb-b696-a5c4-3874b4d08355@oracle.com>
 <20220812080307.GA29582@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812080307.GA29582@yadro.com>
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

On Fri, Aug 12, 2022 at 11:03:07AM +0300, Dmitry Bogdanov wrote:
> > > +     .support = SCSI_SUPPORT_FULL,
> > > +     .opcode = XDWRITEREAD_10,
> > > +     .cdb_size = 10,
> > > +     .usage_bits = {XDWRITEREAD_10, 0x18, 0xff, 0xff,
> > > +                    0xff, 0xff, SCSI_GROUP_NUMBER_MASK, 0xff,
> > > +                    0xff, SCSI_CONTROL_MASK},
> > > +};

> > one of Martin's tree after you made this patch.
> Yes, I saw,  Iwill remove XDWRITEREAD_* in the next revision.

What this does point out is that the way the patches are done,
we have a fundamental issue with these descriptors being potentially
out of sync with the actually supported commands. Once way to fix
this would be to add a parse callback to these dscriptors to unwind
sbc_parse_cdb.  The big downside would be an extra expensive indirect
call per command, though.
