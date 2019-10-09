Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A6BD07BD
	for <lists+target-devel@lfdr.de>; Wed,  9 Oct 2019 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfJIHAI (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 9 Oct 2019 03:00:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIHAI (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vTpP7T8ls6P4B+jFusLV7n8DZP2sTeJwQIF8d4aNHLE=; b=A3BnKtNxaeArwl3c92K6UAMW/
        7A+lbHZh//EO05YOD12D31rF34LRWblZoytY63lgxERgUcM/MI/sTrKI+/yRfjTSkduZulnTXp8Xt
        mWa2NdZY6r8NaV8Lw9IhX9edujJq0Sk+WHm3kMVyj98I+Z3xbn5Qeis4DNVEXr/QsenLrP7hJ3fyB
        Pq/1ShTceG5H2wTd9YfC/rOCcMQ3RwDnQeOqwkQHwQLCv/yP1WedJM9tDlTVwyXpBNcEn49P/2uNN
        2uwgjBDYXmHBy8IrMQwg99OGDSdUc38FEEfSES3+m3s+XcZ6y1Szq6lmpHWc+5xa+PPrBK3hUVGOE
        n3aWZPUfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iI5x9-00066T-SR; Wed, 09 Oct 2019 07:00:07 +0000
Date:   Wed, 9 Oct 2019 00:00:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "bodo.stroesser@ts.fujitsu.com" <bodo.stroesser@ts.fujitsu.com>
Cc:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Mike Christie (mchristi@redhat.com)" <mchristi@redhat.com>
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
Message-ID: <20191009070007.GA19629@infradead.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:20:12PM +0000, bodo.stroesser@ts.fujitsu.com wrote:
> 1) Scan the SCSI specs and add all other missing command codes to the list of
>    Codes to skip
> 
> 2) Create a list of commands that definitely have the LUN field in byte 1 and
>    reset the bits only in those. (Might be better than 1), because I expect new
>    commands to not have the LUN field.)
> 
> 3) Remove the code entirely, because it is no longer needed / useful (?)
> 
> For 1) and 2) an additionally question is, based on what SCSI version the lists would
> have to be created?

(4) limit the clearing of the LUN field to devices that claim
a compliance to SCSI-2 or earlier, as those use the LUN field.
