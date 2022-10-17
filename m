Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D460068E
	for <lists+target-devel@lfdr.de>; Mon, 17 Oct 2022 08:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJQGGI (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 17 Oct 2022 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJQGGH (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:06:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD84E635;
        Sun, 16 Oct 2022 23:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xDVuUIrzqw5r44syzdWvgV71Vu
        +zCQpc/6jzpWQhW5ESJcCI0KXOKhF1AiL5u1lmx43D5ptVDTwPBu/tAirfonHaO36j86OZPGPUDGd
        Ud/rmy1lCobJKteTsgU/+cclYwFZSnDNq4b6A5os77spjn7BK/B3VP3p/jCxdfzVWyNwjPCvE7To/
        dvbL28qm4lCFMSEUkTcfZal25ijITpBv69yNs5NSf7oJx4vh1Q7XKXkstPtgt9eAHMmP750S42kAy
        yuMyFH91lnFJTtegQtKMjcbuISt3XHt1fAVppmg2hy8ack9cYoWDh+8z36G4S1mMMc4Fg2yz+CYbH
        t/ZkoUjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okJGJ-007kxg-1Q; Mon, 17 Oct 2022 06:06:07 +0000
Date:   Sun, 16 Oct 2022 23:06:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anastasia Kovaleva <a.kovaleva@yadro.com>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux@yadro.com
Subject: Re: [v2,PATCH 3/3] target: core: Change the way target_xcopy_do_work
 sets restiction on max io
Message-ID: <Y0zwz2uPhfOpnfTI@infradead.org>
References: <20221014114549.32888-1-a.kovaleva@yadro.com>
 <20221014114549.32888-4-a.kovaleva@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014114549.32888-4-a.kovaleva@yadro.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
