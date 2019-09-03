Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83EAA6219
	for <lists+target-devel@lfdr.de>; Tue,  3 Sep 2019 09:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfICHAP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 3 Sep 2019 03:00:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICHAP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wil6AO2oBVMQPREyKIWUgqGbJAZF6Tw7SfTSvs/pGMc=; b=EMh48YXQlepNJCSHtBZ31cWS+
        VRYlDcbDiJp/DzJfucyF7AT8nr0eVW/ph4yvd33u6yzPdxnKx4SFMJN4gvc6mRM7eLecOXM6VgxhK
        HBgfloiAhZ8R1j0dLH3j/JtVrfbwtbt8LVee+OkScwKOx6tK0Gv1SLeqaujsDeXCYoVtPZZmMW8EC
        p3WBMGxjTOH3izTS9cOg46q7Lpv4un6nJ4U9cbocKrX23W1YT3WcWrEO0TzC5n0G81xn5syEfVQoS
        usafRXnOaS/7c4fEOxEGk0ra1vKoKWYZfV1o+IfLDLu12oj+C64G6ckrZ79jSqlRmqQxKZxXxhvOy
        94GsVYPZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i52nV-0004hM-RK; Tue, 03 Sep 2019 07:00:13 +0000
Date:   Tue, 3 Sep 2019 00:00:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     cleech@redhat.com, mchristi@redhat.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, "Black, David" <David.Black@dell.com>
Subject: Re: [RFC PATCH 0/4] iscsi: chap: introduce support for SHA1 and
 SHA3-256
Message-ID: <20190903070013.GA12256@infradead.org>
References: <20190829155929.27701-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829155929.27701-1-mlombard@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Aug 29, 2019 at 05:59:25PM +0200, Maurizio Lombardi wrote:
> iSCSI with the Challenge-Handshake Authentication Protocol is not FIPS compliant.
> This is due to the fact that CHAP currently uses MD5 as the only supported
> digest algorithm and MD5 is not allowed by FIPS.
> 
> When FIPS mode is enabled on the target server, the CHAP authentication
> won't work because the target driver will be prevented from using the MD5 module.
> 
> Given that CHAP is agnostic regarding the algorithm it uses, this
> patchset introduce support for two new alternatives: SHA1 and SHA3-256.
> 
> SHA1 has already its own assigned value for its use in CHAP, as reported by IANA:
> https://www.iana.org/assignments/ppp-numbers/ppp-numbers.xml#ppp-numbers-9
> On the other hand the use of SHA1 on FIPS-enabled systems has been deprecated
> and therefore it's not a vialable long term option.
> 
> We could consider introducing a more modern hash algorithm like SHA3-256, as
> this patchset does.

But we'll need IANA assignments and IETF consensus before adding new
algorithms to ensure we have interoperable implementations.

Adding Dave Black who has helped with IANA interaction in NVMe recently.
