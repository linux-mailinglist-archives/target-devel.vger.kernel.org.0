Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C122B0AE1
	for <lists+target-devel@lfdr.de>; Thu, 12 Nov 2020 18:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgKLRAW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 12 Nov 2020 12:00:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgKLRAW (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605200420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WtHXC8mKlk3syV9475opWWmZkifxuDIS56d7hfYA+k=;
        b=IAAmFC7HghmJdmsTjPWn9/6gwmzSvifnnYQ4ft/VWLps2FvIXrl/BBJTsNzKZhqiJSAxEz
        4n+bKF0S5KZHYWTdS3Bk8kb0y7+P3SheZGADIcCa4PE8rhymjEXA6K013M3uSevH79LWRU
        ErJ8FJFz9XpvPAGfSWP5xw9SsFk8tuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-m8IZqujcOuig-QSbHXoMFw-1; Thu, 12 Nov 2020 12:00:16 -0500
X-MC-Unique: m8IZqujcOuig-QSbHXoMFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34FA9100E349;
        Thu, 12 Nov 2020 17:00:10 +0000 (UTC)
Received: from localhost (ovpn-115-122.ams2.redhat.com [10.36.115.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C22525577D;
        Thu, 12 Nov 2020 17:00:09 +0000 (UTC)
Date:   Thu, 12 Nov 2020 17:00:08 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/5 V5] vhost-scsi: IO error fixups
Message-ID: <20201112170008.GB1555653@stefanha-x1.localdomain>
References: <1604986403-4931-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1604986403-4931-1-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 11:33:18PM -0600, Mike Christie wrote:
> The following patches were made over Michael's vhost branch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=3Dvh=
ost
>=20
> They fixe a couple issues where the guest is getting IO errors:
> 1. The admin may set num_queues and cmd_per_lun/virtqueue_size
> in a way that allows the guest to send more IO that vhost-scsi
> was coded for.
>=20
> 2. A race where vhost-scsi completes the cmd to the guest before
> it's fully completed in the target/vhost-scsi layers so if the
> guest sends a new IO too quicky we fail it.
>=20
> 3. If the real/physical storage (lio backend device) hits a transient
> error then vhost-scsi would fail commands instead of relying on
> the lower levels error recovery to do what the admin had set up.
>=20
> V5:
> - Bring back V1 but move flush patches to a separate clean up set
> - Modify test in vhost_vq_is_setup
>=20
> V4:
> - really really fix compile errors
> - dropped threading patches so we can figure that out separately.
>=20
> V3:
> - fix compile errors
> - fix possible crash where cmd could be freed while adding it to
> completion list
> - fix issue where we added the worker thread to the blk cgroup but
> the blk IO was submitted by a driver workqueue.
>=20
> V2:
> - fix use before set cpu var errors
> - drop vhost_vq_is_setup
> - include patches to do a worker thread per scsi IO vq
>=20
>=20

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+tahgACgkQnKSrs4Gr
c8itSwf9GVyHTRV2sAUjFG8BDBKEP3l/jOvX8Fd3PEaYkAfmmX+WgGtTbq1JHFLU
5YpudBKY56GIhQv2gQtzy6yG0IGZLgRfgNSJMIbD3OEdRIfXiwqZXqtmPGyDG8mh
yLK98M0I1dkEV0UTtyMDizZHlJGvDierunEbtAgw0gijw2tZZ4siWtPkvHRUKPX+
vFLB14FoAOEX88ykHQYoN/AgfS4WM4FPhRZ3jy67IK5HwrS5uK/rdGy/bkVx+V0R
NQDlP1FsYGABk6rFD/yK5zFwuJNIqSS+vSxFhdcZkVYczlJkxrY38XCQZTgEmSb/
uMx/xfUfsNad2GEOLlz3rAa3gJUCwQ==
=ERi/
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--

