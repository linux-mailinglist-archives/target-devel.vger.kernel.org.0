Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF21316134
	for <lists+target-devel@lfdr.de>; Wed, 10 Feb 2021 09:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhBJIij (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 10 Feb 2021 03:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBJIhg (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:37:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3647C061574;
        Wed, 10 Feb 2021 00:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Jf9kK5BwbeodaWWVRp1+fG5UN617NHybGlzbgdtR8Y=; b=QsOlCWtCYJJr2M0srUVdN7vGuf
        lYWu8T7T40V5kchDJavFRETQgZVC1/55M7TNhJNvyyIdjVU2mo9a4BCoqsINILnp/kIPQsnt/Z6k5
        bSzPrCMQarYtQMqK7DiOs3vo4V21C7hH25q7+OCztqPGW+KZvLrj0bxtaGFFmg7Ig3zGuox2nTwvn
        twmzniexSRh19vFgSvGyClo8VKFJcNUm33S31x/9oyAZ6b/bM2nb0CTLsMWoqUxuniz4CCunlVhJT
        KM6ETSUsL0weCi2xKMaZnlNeqFvdQgJojlrH7JA96s5wDCnXNgDPgRU+Ukyad7NpVaDLzzRUNEdFG
        jRBWdepg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9kzK-008aTG-Ea; Wed, 10 Feb 2021 08:36:42 +0000
Date:   Wed, 10 Feb 2021 08:36:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Chaitanya.Kulkarni@wdc.com, loberman@redhat.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 02/13] target: split target_submit_cmd_map_sgls
Message-ID: <20210210083642.GB2045726@infradead.org>
References: <20210209123845.4856-1-michael.christie@oracle.com>
 <20210209123845.4856-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209123845.4856-3-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Can you just kill off target_submit_cmd_map_sgls entirely and just
open code the two calls in the three callers?
