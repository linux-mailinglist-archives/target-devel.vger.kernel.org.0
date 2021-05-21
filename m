Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673D638D1A0
	for <lists+target-devel@lfdr.de>; Sat, 22 May 2021 00:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhEUWjE (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 21 May 2021 18:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhEUWjD (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 21 May 2021 18:39:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC5C061342
        for <target-devel@vger.kernel.org>; Fri, 21 May 2021 15:37:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x188so15939287pfd.7
        for <target-devel@vger.kernel.org>; Fri, 21 May 2021 15:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ccivkmqRxvbEoQM0V9sS14GS9yzetYD2ZYyUao6LYL8=;
        b=HOGxRJT+S3zcq6hG9tZPy7cA+K51TbarsJRrSVikqTSau6Cy77dyYdOclcQ4KvkpHL
         5ki+DoCGpNRtNv4oENFijvD3ZkT/t1aN2qNTMepSrH0L94PGE0RLEjmqtf8E00t3c/86
         CDqc01/JsB/YG4kBmyYNC+6VoiJyGqMitHpngLrllV4yPODbvzUlEsqIsK6f0hlR8Tcb
         C8K/mEhs8pnXSwp444dQA5fcf7dakjkkfbgdlRkymTXroZ2d6+yqAh452WDayssVLPJm
         nhKApahBosgELZ6FlET1/n1KNxZ2IiCLlx/30dQUtLw8acr4TeNRu03XZcXHHQwKaJ3h
         1zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ccivkmqRxvbEoQM0V9sS14GS9yzetYD2ZYyUao6LYL8=;
        b=AHqQWLEK5T5v/zeuFi7od8pSgdPC6lzTdpZRGmBCg66VAp19nEvaESYxgog8T5yvae
         4LLyKWVY7HbEB0hZzH98wHKq7g/mfmZSkBjhg5Hd9ywiznlafiMzOoEfIf6oGohwavs1
         1TJxom+wSD7nSg9VZqlYjh8MXqw1PBM8nobA5JFiNH/J+WD2O9nkQdYxnE2lPUT817Iu
         oIDAtUbhuZteHrRbpQ4yIa3ZSQ11ic2/OjTMOLOlz2/3N1obY+PqFSG+JNdsfttC7iPu
         PHPEN424SZnyiBUfPO3c2TgIo08ccT62bN3GegoNvQgtmmohS7a00OLqI091Rm3pC9Je
         j9FA==
X-Gm-Message-State: AOAM5338L2tZusFHIq2E3fTy21psKrUekr/Y5Lj+KTbG8BmXVNb5ZB9w
        tSdnERzVo+Er4hDa6ByYEWWukA==
X-Google-Smtp-Source: ABdhPJwzK3VZ3KUvllj7T7UMXQIPumDuGJJFVNI/o3u4lcUKHfVMLwumBcQE4Nn84BsmiwpYUjd3Pw==
X-Received: by 2002:a62:3682:0:b029:2dd:ed69:6e85 with SMTP id d124-20020a6236820000b02902dded696e85mr12537608pfa.20.1621636650955;
        Fri, 21 May 2021 15:37:30 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1e18])
        by smtp.gmail.com with ESMTPSA id pg5sm2712122pjb.28.2021.05.21.15.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:29 -0700 (PDT)
Date:   Fri, 21 May 2021 15:37:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Message-ID: <YKg2J5n3oY9RpgVb@relinquished.localdomain>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
 <PH0PR04MB74169D71E3DCB347DFCBFCB59B299@PH0PR04MB7416.namprd04.prod.outlook.com>
 <BYAPR04MB496577D8AC414B1FFD44722486299@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496577D8AC414B1FFD44722486299@BYAPR04MB4965.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, May 21, 2021 at 09:37:43PM +0000, Chaitanya Kulkarni wrote:
> On 5/21/21 03:25, Johannes Thumshirn wrote:
> > I couldn't spot any errors, but I'm not sure it's worth the effort.
> >
> > If Jens decides to take it:
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >
> 
> It does create confusion on the code level which can result in
> invalid error checks.

Do you have any examples of bugs caused by this confusion (whether they
were fixed in the past, currently exist, or were caught in code review)?
That would be good justification for doing this.
