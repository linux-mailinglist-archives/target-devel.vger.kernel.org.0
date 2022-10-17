Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3521960068C
	for <lists+target-devel@lfdr.de>; Mon, 17 Oct 2022 08:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJQGFo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 17 Oct 2022 02:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJQGFj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:05:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151234F19D;
        Sun, 16 Oct 2022 23:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I0h2NuGC5H/Yd3RCfT81o/F9rHsMkK7NhGarQVPkQSw=; b=PKa3SiFqVTSLsKC7Zw6QVCObBq
        j4xOkkCBAgNTfrK44eNofdfDny9WdSjDwZZ9hPt84kn6rE1tKZW/0SELVsndjzS5y+mdXnkN7uWBE
        ybnXUd4KK0aX8tkIpjMXwd2hNpHStzXuH/I0DkSVs5Wm0iBxa55ESq/V+t8shqXBucPcunN3uIQpu
        mXD0T9d5Rtm3YUxyoA8+tQpDc85IRbr4Hp2bgGiytqOzLE5u215dQthPhq81sffHy2Oh20JMAUPyK
        7JHTMQ9L4sDEvD/KwtKS3XDVSwAqqrCfY5BhXEHqFxAYwWAvb00ktUyT3aosbUcu5Fg5d3k5lc5LL
        nwgqjsaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okJFo-007kW3-St; Mon, 17 Oct 2022 06:05:37 +0000
Date:   Sun, 16 Oct 2022 23:05:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anastasia Kovaleva <a.kovaleva@yadro.com>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux@yadro.com
Subject: Re: [v2,PATCH 2/3] target: core: make hw_max_sectors store the
 sectors amount in blocks
Message-ID: <Y0zwsC6UAtdEfeg9@infradead.org>
References: <20221014114549.32888-1-a.kovaleva@yadro.com>
 <20221014114549.32888-3-a.kovaleva@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014114549.32888-3-a.kovaleva@yadro.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Oct 14, 2022 at 02:45:48PM +0300, Anastasia Kovaleva wrote:
> By default, hw_max_sectors stores its value in 512 blocks in iblock,
> despite the fact that the block size can be 4096 bytes. Change
> hw_max_sectors to store the number of sectors in hw_block_size blocks.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
