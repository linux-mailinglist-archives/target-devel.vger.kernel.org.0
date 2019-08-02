Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FAF7ED77
	for <lists+target-devel@lfdr.de>; Fri,  2 Aug 2019 09:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389656AbfHBHbC (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 2 Aug 2019 03:31:02 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:36481 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389673AbfHBHbC (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:31:02 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 048C03D7;
        Fri,  2 Aug 2019 03:31:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Aug 2019 03:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=m
        KzwcXDAdBNsMtNsjdLVDI0JTCoeMFKC4syHQz3UtRU=; b=PTyFZhCTFIj6ChVqG
        0K6FpX7+lzS/cjSvzc+LEKiduyC0yX17mn0z6DaydY3qHfBdpD6mIAl241d0eITL
        Dll9r7V9z7xEDPXV1S9j1KduIqNHxeiBaHBFZMlRyrb31of2csQFFIowUDE21NE5
        AIuJqOyQagA4BMq5q2LWY0JPWczMIz6ngtwwf/MTulbVtSQ/yn+1hrCHG3GfcIR1
        WBC9UwigiNLx6dHPA2zCTSh9WIwoCtYh6bHlaiDDuH+1X3QzdPN0zdGO9RNXgGec
        l7+awxb17wWfaO4kgAY3gpMmEa81Xc1J/MwU5gvx5yuxkoVONskqm17JdQeEQG8t
        ApAyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=mKzwcXDAdBNsMtNsjdLVDI0JTCoeMFKC4syHQz3Ut
        RU=; b=sWpVlIFJsuGFJVBztJazZzPS7Hgw8TRG+t+bWNe3eZs0qpO3zX6e7zPIs
        U+Oah/lpv6nSnKqtrc3AtqzWHLH0W8NHxCSGhxXW/0oEth2yn3eVzgUwv8EdJUNz
        LV+vfWxSb3/Kj38pjBF+k68hznldLgHYIq44++32pp8Hj3Rmv3QaQMzkZNyG3OZd
        p2GQrEazwmkqcDfWZz7Fa5mjqK4Xs6FYpsrXbX5fw8oBK8EJdUHLSzr2iWRKEa80
        2VBLmdzmQopD+8BaXw9N6wGTo33sOiDs9Lp5UIxZjgTdGDmqG/S2Pwqti4epgaPr
        f4pSmxSq0gh1eg1jbSUrhNTrruKAw==
X-ME-Sender: <xms:s-ZDXasaN0JHdwDeq7nrp70oeBSC0Ai8vGp512hiDaTf-cjEFyWiDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleekgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:s-ZDXa6uQV30lf9aBMqfonAD_5ZOpt-l1263qIKTHt8hwdtmscg7oA>
    <xmx:s-ZDXZVJ6HTyTQPngGdYpfDpmmXJOFx6VN6lQlpjjON7VbGQj15Zlg>
    <xmx:s-ZDXeNRZleGnG8HyYAlMK_JMv7xYnU_reTTceTcHgjTGEDazS8eKA>
    <xmx:tOZDXS_cAE2Px0cSuICfIL-LfptcEvD1KYS1_eSeihMmiGfyHrh2eg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4BC6780060;
        Fri,  2 Aug 2019 03:30:59 -0400 (EDT)
Date:   Fri, 2 Aug 2019 09:30:57 +0200
From:   Greg KH <greg@kroah.com>
To:     laokz <laokz@foxmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, security@kernel.org,
        stefani <stefani@seibold.net>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
Message-ID: <20190802073057.GD26174@kroah.com>
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
 <20190722114700.GE3089@kadam>
 <20190722115010.GF3089@kadam>
 <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:26:23PM +0800, laokz wrote:
> Hello Dan,
> 
> On Mon, Jul 22, 2019 at 14:50 +0300，Dan Carpenter wrote:
> > > It looks like you're right.  Probably the fix is to:
> > > 1) Change INITIAL_SRP_LIMIT to 8192
> > 
> > I meant 1024 not 8192.
> 
> Nice to see that. It really helped for me. Thank you very much.

Did anything ever happen with this?  Was a patch submitted to resolve
this issue?

thanks,

greg k-h
