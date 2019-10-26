Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2340E58ED
	for <lists+target-devel@lfdr.de>; Sat, 26 Oct 2019 09:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfJZHDG (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 26 Oct 2019 03:03:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfJZHDG (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 26 Oct 2019 03:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NBIu1meCIEiVRSXZakJToYFJsd4TZapadLVP0vhaOSQ=; b=aHD56RA18nTKlNvpwZstfYGqu
        iJ1PcQ5iZrBBW/YXro/t2QGD4j72cN+pkuVbfkxVgGdTCDqf/H74AQsabGVvm6/hRUVOvziWqTbrY
        20IYnZWo1jybifP54EkFLsR0q3YZC2QfDs54g6fFsrDZZELzg6veoEGynED1AJrNzjRQvwYHq827l
        WIyrA4Dk/2hnF00GQ2F98JkwF7ju1Gz91+OyGf1oYKaEkcz/mUH2NipgclTQ01TnYMGOX8a7lM0Uh
        BMRUUc7eKvGB3wt5Ha/WKUQ6+JNY0mFp/EvG/z2yYS5cutiOv7k4Ni/xrWa+2SP6ocFrI73/56xK5
        LZNsnL0uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iOG6L-0005K1-Vx; Sat, 26 Oct 2019 07:03:05 +0000
Date:   Sat, 26 Oct 2019 00:03:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas <wolverine6218@gmail.com>
Cc:     target-devel@vger.kernel.org
Subject: Re: Possible LIO crash under heavy ESXi 6.7U3 load with iSCSI
Message-ID: <20191026070305.GA20220@infradead.org>
References: <CAHTmSeTfOjVDMMtG6mVPKJyRWeMgvnCowq5Uyze=vMzPiQ4S5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHTmSeTfOjVDMMtG6mVPKJyRWeMgvnCowq5Uyze=vMzPiQ4S5Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Please don't report problems using out of tree modules with incompatible
Licenses to linux lists.  They are entirely your own problem.
