Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7786007CA
	for <lists+target-devel@lfdr.de>; Mon, 17 Oct 2022 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJQHjC (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 17 Oct 2022 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJQHi4 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:38:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D035A828;
        Mon, 17 Oct 2022 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7C6HILSsm0zPti3gFFq3dVmOst+iU0l3ImM8RtV6lSk=; b=e7K2E0sS66LjvWSYbRo2nylzZg
        cGRWpJDyuoh/Iks/Aa8R6AVFfkw8AXl37BaFPddzjxJNHnwx49l9g3So9OnQjXWt69PNUNKnQINoz
        ytmUjhfB+pDqMuu94IjSL6ee3OjhoD6pwicmwEKjJhg2/c/2DHjbLNvuzfQXCsLYUSpXpnrcSaoVs
        UZW/7HlXMwmpmPwps5OJGkgT7ZYBdGnr3PULCbw9rcqydwIW8HkkQMkw9CLMXHu1UsRY1aalckagl
        TH1kB/8JmNZDN228IGa8QQ3L0WYHSdqQRRFR1envrg9J4HdwutKsq9j8iniWDtEAXi94o423dO7dE
        P0b8VmSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okKi2-008V03-Tp; Mon, 17 Oct 2022 07:38:50 +0000
Date:   Mon, 17 Oct 2022 00:38:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     Martin Petersen <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org, linux@yadro.com
Subject: Re: [PATCH v2 1/5] scsi: target: core: Add RTPI field to target port
Message-ID: <Y00Giu7q4M/jb6mG@infradead.org>
References: <20221006105057.30184-1-d.bogdanov@yadro.com>
 <20221006105057.30184-2-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006105057.30184-2-d.bogdanov@yadro.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

> +DEFINE_XARRAY_ALLOC(tpg_xa);

I think this wants to be marked static.

> +static int core_tpg_register_rtpi(struct se_portal_group *se_tpg)

Can you use target_ instead of the weird historic core_ prefixes for
everything here?

> +int core_tpg_enable(struct se_portal_group *se_tpg, bool enable)
> +{
> +	int ret;
> +
> +	if (enable) {
> +		ret = core_tpg_register_rtpi(se_tpg);
> +		if (ret)
> +			return ret;
> +	} else {
> +		core_tpg_deregister_rtpi(se_tpg);
> +	}
> +	ret = se_tpg->se_tpg_tfo->fabric_enable_tpg(se_tpg, enable);
> +	if (ret) {
> +		core_tpg_deregister_rtpi(se_tpg);
> +		return ret;
> +	}
> +
> +	se_tpg->enabled = enable;

This bool enable logic is a bit weird and splitting the enable and
disable case would seem more sensible to me, but maybe there is
something later on that makes it more relevant.
