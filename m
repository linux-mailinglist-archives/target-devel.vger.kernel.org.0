Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD07E2B5EB5
	for <lists+target-devel@lfdr.de>; Tue, 17 Nov 2020 12:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgKQLxP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 17 Nov 2020 06:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727267AbgKQLxP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605613993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORGIWbDZHVGHQKz+yXjGHqNxxtUKUaElXUNeXuBfTrk=;
        b=MkrUBti728nzp9WpB2n+gQN9WYWUfhNbkOtgov+AvB9BpZdJYopVn1k/6+MMMn5hVt0Pqv
        xmXff3UocDFOGZ9Z8irJVirKJA7hBxG8L1SY2pWkye91FXiXvNyxPdSI/tM5Dc9SXoJDv3
        b/SNDeI9aHxIO8WX7jduDmj5ohnlg6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-DCiX4ymnPyG1vYC0E1eKrQ-1; Tue, 17 Nov 2020 06:53:11 -0500
X-MC-Unique: DCiX4ymnPyG1vYC0E1eKrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 286778018A1;
        Tue, 17 Nov 2020 11:53:10 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC17010013D0;
        Tue, 17 Nov 2020 11:53:06 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:53:05 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     qemu-devel@nongnu.org, fam@euphon.net, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/1] qemu vhost scsi: add VHOST_SET_VRING_ENABLE support
Message-ID: <20201117115305.GJ131917@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-2-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-2-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Content-Disposition: inline
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2020 at 05:19:00PM -0600, Mike Christie wrote:
> +static int vhost_kernel_set_vring_enable(struct vhost_dev *dev, int enable)
> +{
> +    struct vhost_vring_state s;
> +    int i, ret;
> +
> +    s.num = 1;
> +    for (i = 0; i < dev->nvqs; ++i) {
> +        s.index = i;
> +
> +        ret = vhost_kernel_call(dev, VHOST_SET_VRING_ENABLE, &s);
> +        /* Ignore kernels that do not support the cmd */
> +        if (ret == -EPERM)
> +            return 0;
> +        if (ret)
> +            goto disable_vrings;
> +    }

The 'enable' argument is ignored and this function acts on all
virtqueues, while the ioctl acts on a single virtqueue only.

This function's behavior is actually "vhost_kernel_enable_vrings()"
(plural), not "vhost_kernel_set_vring_enable()" (singular).

Please rename this function and drop the enable argument.

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+zuaEACgkQnKSrs4Gr
c8ggbgf/amsccaIgLNwt7fBI9E5/mNlfsgJGbQlcgWAJWJ6giGQfPamIN2qEFbS9
TbTbc8ng7fqj3q9VA/QSYqqGT4o4S3ejHaluLfL8OG3NQhjB1jl1tv1B1hqUpbjh
7BvoLZvmN4mEBCwTMInavK7mBXwgIJX6dxAZdU6ZGiW3KjlNQQK01erQax/PFvrz
siTJLUyQP6RiIctvZ3TREgvdoCo7iS1YkxcDtRQU3Y1aVUSg49pUaq/oeLg5FMDi
HoIqvlqazYoI/asj1Fgli1qtZMX2tPom7IwdxPc+5pmyHkh4lT1JR0wwulWnwapb
x/T7SH6sVbYXRrs+JlLTrw7yvtAZwg==
=9dMr
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--

