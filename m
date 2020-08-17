Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBE2475C6
	for <lists+target-devel@lfdr.de>; Mon, 17 Aug 2020 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbgHQT2d (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 17 Aug 2020 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbgHQT2P (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:28:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1C9C061344
        for <target-devel@vger.kernel.org>; Mon, 17 Aug 2020 12:28:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so2061611plp.4
        for <target-devel@vger.kernel.org>; Mon, 17 Aug 2020 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/K/jgK8f2b3gfIxZCz2aodMs51/j1UmWIbA0xQ4Rg4o=;
        b=lfkmiNvf7aWyMq4W/ABS66AbSGwPDK4/gSe7KpUo1u+V3ZDzJYaa4SZCJM35LFoSeq
         uypWUeCVnbtPuTlC6Lv32YnGX41etwb0Tro5sTqJv62MgvvHNClJfRyjsQ85Ou5LahfA
         L3x2mLvPon1Pa5RiuLmxjerV4ytCXX9sKlZ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/K/jgK8f2b3gfIxZCz2aodMs51/j1UmWIbA0xQ4Rg4o=;
        b=Z5qK/+tzaiy4N5pUkJOSKOVI4DgS62gaZi3U50jw+x1H5VkSYTeax+0v4rbPNVTwJC
         98g++ohLrERVc38+xEleBu4l1FfrHfOe6YEm/IwD7yfVa//LpyZqhJGnh/WA5FVcqzUz
         icQIsQ0XssiImVi8t5S0T2z4geFOFm0P8tUCILJgZwnNYAOZrAVzv5/M6PT6iQ+2vzXb
         MN7kzZej2Kta+1cjQnh0Rp3VwrPRHZ9HvxW/keglxfFre+GdjbuHcmq2w97Y4ylrO4wa
         qqyRVnb1zRBz5rbMhHP3Ux2di1kROwSn3Dl6O0AAJhjnoO0+/ejUGOvfnInsxLU2uNWT
         hMqQ==
X-Gm-Message-State: AOAM532DS3ggMD5V0vBGicDdGnhZaQZh5pFQAtiMXZwyKl24yrKuBHHR
        2DB2jdST808xf6DrG4UGdiliAA==
X-Google-Smtp-Source: ABdhPJxQXWN+Ph7ND4lvHYfqN6PVhgPAKtkPfn8HjEia6Dm6hV0gw3K3eYh80/xzuqoQhRxCjmbyAw==
X-Received: by 2002:a17:902:8210:: with SMTP id x16mr12901228pln.166.1597692494753;
        Mon, 17 Aug 2020 12:28:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b25sm20700960pft.134.2020.08.17.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:28:13 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:28:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Allen Pais <allen.cryptic@gmail.com>, martin.petersen@oracle.com,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, Allen Pais <allen.lkml@gmail.com>
Subject: Re: [PATCH 0/8] scsi: convert tasklets to use new tasklet_setup()
Message-ID: <202008171227.D3A4F454D8@keescook>
References: <20200817085409.25268-1-allen.cryptic@gmail.com>
 <1597675318.4475.11.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597675318.4475.11.camel@linux.ibm.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Aug 17, 2020 at 07:41:58AM -0700, James Bottomley wrote:
> On Mon, 2020-08-17 at 14:24 +0530, Allen Pais wrote:
> > From: Allen Pais <allen.lkml@gmail.com>
> > 
> > Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> > introduced a new tasklet initialization API. This series converts 
> > all the scsi drivers to use the new tasklet_setup() API
> 
> I've got to say I agree with Jens, this was a silly obfuscation:
> 
> +#define from_tasklet(var, callback_tasklet, tasklet_fieldname) \
> +       container_of(callback_tasklet, typeof(*var), tasklet_fieldname)
> 
> Just use container_of directly since we all understand what it does.

But then the lines get really long, wrapped, etc. This is what the
timer_struct conversion did too (added a container_of wrapper), so I
think it makes sense here too.

-- 
Kees Cook
