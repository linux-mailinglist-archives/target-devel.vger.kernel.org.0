Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3729539A284
	for <lists+target-devel@lfdr.de>; Thu,  3 Jun 2021 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFCNxS (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Jun 2021 09:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229744AbhFCNxS (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622728293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wKYE2aHzUmRDWCFqUk0v5VcoRnS1iPBP5mOxwGvsWI=;
        b=PNEPbv/PYB5OXir7U5fSWo3KhicSxgrOsOqZ79bXjSuA+oFgNwjHQ+rjUXJoBlaSCVC+yw
        NOsGRmBgZdDcnE665AmSr27XE6crh3xsiTPoQsLg133vZZN+Sfl0IpVHd8UQobxkxBLgPH
        CBrF7uob1ElpGwZxIrOKYVf80K0uCOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-Cte7uI84PzeTyJAWf9YCXw-1; Thu, 03 Jun 2021 09:51:29 -0400
X-MC-Unique: Cte7uI84PzeTyJAWf9YCXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60DB6180FD70;
        Thu,  3 Jun 2021 13:51:28 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA0F061008;
        Thu,  3 Jun 2021 13:51:24 +0000 (UTC)
Date:   Thu, 3 Jun 2021 14:51:23 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        pbonzini@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 4/9] vhost: allow vhost_polls to use different
 vhost_workers
Message-ID: <YLjeW6ueJlbVXuWB@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-5-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8DbeKzXGg/TrwsJe"
Content-Disposition: inline
In-Reply-To: <20210525180600.6349-5-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


--8DbeKzXGg/TrwsJe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:55PM -0500, Mike Christie wrote:
> This allows vhost_polls to use the worker the vq the poll is associated
> with.
>=20
> This also exports a helper vhost_vq_work_queue which is used here
> internally, and will be used in the vhost-scsi patches.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/net.c   |  6 ++++--
>  drivers/vhost/vhost.c | 19 ++++++++++++++++---
>  drivers/vhost/vhost.h |  6 +++++-
>  3 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8DbeKzXGg/TrwsJe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC43lsACgkQnKSrs4Gr
c8hYewf/UmNcYo5fLhwnWpuFJ21tNHZofqURelQ2HtDD4nzZiK9JGJy4fLtX2Zxv
s2cX/WKG9s04USJ27h9BsH0+4bQRvGWu5uphV1vEisvyuPxIRgsoCD0TrFroPt74
1CQkdsVh4WM0ABny15Z0byw0gt7axXCgcW+GlkEWZrXllOuQWF+4JyQZt0MKkuDw
lv9ql4oy0O8cUJCar6T54WaJHJy1d7a3UPU4mrqDyC499ml+Ngz+WWk02led6l1e
01OE8fUb5vn3el/x/2YRVWsD8b+lPDK9Mch4N7Th+qqHhdAxMpdMvmDLWFQPP7Jm
Qv3b7PIa5K8yWO9mTiYhFOvfhGOebA==
=i0pa
-----END PGP SIGNATURE-----

--8DbeKzXGg/TrwsJe--

