Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E43437509
	for <lists+target-devel@lfdr.de>; Fri, 22 Oct 2021 11:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhJVJwA (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 22 Oct 2021 05:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231992AbhJVJv7 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634896182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8GQKppheBF6fDbGjh9hPnqTzIvDSzCMC2uK5p0nE1Jk=;
        b=gq5LwWQFHBaY2sClr6FAcaA3pmiS8tMRCpT3iRsq5l2EQjtqX1irQbCdzpvcrMAr0qHI9Y
        KIUNoJKzQb+5jnq29kuDar0S7B+vJ0w0oxG/+hAANrV7gVbJ01ETb0ynrzCoh6d2Wjm+dd
        5cW7bKuqs0zgkcUBKBJI1TTJtM6BBuU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-lbNT4t1rOtyjQQgziAyhuA-1; Fri, 22 Oct 2021 05:49:41 -0400
X-MC-Unique: lbNT4t1rOtyjQQgziAyhuA-1
Received: by mail-wr1-f71.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so775566wrc.22
        for <target-devel@vger.kernel.org>; Fri, 22 Oct 2021 02:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8GQKppheBF6fDbGjh9hPnqTzIvDSzCMC2uK5p0nE1Jk=;
        b=C3X5WByRmxOhUVb8+dsn+EjE4VOuPiksWu8YCtBNIG5QAt7BnmHb+338Xx/maBHe5f
         7PGQc+6i6wUBE4u2wQYuME0wgkLd0wKGJ3Rv7ux1LEude+N84Xe6ng+HmFEqcXEhHdDK
         kx6avmQKEs388wNFKbVyw85vDIZK8c/09PREycS3xCxGedTLvIlss3pGT+Tx/91HT6kD
         nqekjY7GPxbOa2m3cflmyZQRWk1ojGWa83bCmY3eY5yl1aSnRiTfPVo2fgtfYiTaDL/D
         XvMWCg3WFyTXn/7hPPtT64CCJxDapH7TIZX6ZqJkOYAcfqIAgd37KilhO47Wn7O7SIvj
         uHKA==
X-Gm-Message-State: AOAM531GOPaXDdwPamw2ICH+uFFRjJqPpaNX95vUmJw/bUUsQhZRUJfM
        +6pRn5doy0edvxlcFuig+Mc0WWxOLD1NrUmVteQYumPtiKoVOgcgWrblpryQDn5+jtCRYnUf3um
        LFp/e3HZZ4NMuvwQbw8xVWlJK
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr14156233wri.57.1634896179876;
        Fri, 22 Oct 2021 02:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydGc0dTBclPLb5hwyVCsVnp0bj4JEx8cjQdxlE6fuA1aB91KuOmS/N126HwQ7g8P66GvYmRg==
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr14156214wri.57.1634896179741;
        Fri, 22 Oct 2021 02:49:39 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
        by smtp.gmail.com with ESMTPSA id k8sm10435791wms.41.2021.10.22.02.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:49:39 -0700 (PDT)
Date:   Fri, 22 Oct 2021 05:49:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     michael.christie@oracle.com
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V3 00/11] vhost: multiple worker support
Message-ID: <20211022054830-mutt-send-email-mst@kernel.org>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <14dc15ba-5888-a43d-6a9a-8b5165620d57@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14dc15ba-5888-a43d-6a9a-8b5165620d57@oracle.com>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Oct 22, 2021 at 01:02:19AM -0500, michael.christie@oracle.com wrote:
> On 10/22/21 12:18 AM, Mike Christie wrote:
> > Results:
> > --------
> > 
> > fio jobs        1       2       4       8       12      16
> > ----------------------------------------------------------
> > 1 worker        84k    492k    510k    -       -       -
> 
> That should be 184k above.

Nice. I'd like to merge this but blocked because of a dependency
(since we can't allow userspace to create threads without any limit).

> > worker per vq   184k   380k    744k    1422k   2256k   2434k

