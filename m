Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7A2312FA1
	for <lists+target-devel@lfdr.de>; Mon,  8 Feb 2021 11:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhBHKv7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 8 Feb 2021 05:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232240AbhBHKtt (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612781302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iNzlRFhQZaxFEKuPUnwd+9/Xj6+WqNNpq8/o5MV2DOw=;
        b=WSvJJ6wxBic9gBVIlzv0iAx8iMuVkBMyEv/x9HxgnK1it9zZL6S9yuF3DHXF3IRb7Vbesl
        SUSbiSVF+2MMlXnImOWH+ODjExyMy5Im/qk0IA0H7g9/F5pfbApv80Unbm73vMBLZza2VR
        98IsZOQUWX/OqMRTaATfZvBPqhaNdVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-p3m4eQSOMi266MvNmx7SQQ-1; Mon, 08 Feb 2021 05:48:18 -0500
X-MC-Unique: p3m4eQSOMi266MvNmx7SQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3A87801A97;
        Mon,  8 Feb 2021 10:48:16 +0000 (UTC)
Received: from localhost (ovpn-115-153.ams2.redhat.com [10.36.115.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AAF51A863;
        Mon,  8 Feb 2021 10:48:15 +0000 (UTC)
Date:   Mon, 8 Feb 2021 10:48:14 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 00/11] target: fix cmd plugging and completion
Message-ID: <20210208104814.GA4349@stefanha-x1.localdomain>
References: <20210204113513.93204-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20210204113513.93204-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2021 at 05:35:02AM -0600, Mike Christie wrote:
> The following patches made over Martin's 5.12 branches fix two
> issues:
>=20
> 1. target_core_iblock plugs and unplugs the queue for every
> command. To handle this issue and handle an issue that
> vhost-scsi and loop were avoiding by adding their own workqueue,
> I added a new submission workqueue to LIO. Drivers can pass cmds
> to it, and we can then submit batches of cmds.
>=20
> 2. vhost-scsi and loop on the submission side were doing a work
> per cmd and on the lio completion side it was doing a work per
> cmd. The cap on running works is 512 (max_active) and so we can
> end up end up using a lot of threads when submissions start blocking
> because they hit the block tag limit or the completion side blocks
> trying to send the cmd. In this patchset I just use a cmd list
> per session to avoid abusing the workueue layer.
>=20
> The combined patchset fixes a major perf issue we've been hitting
> where IOPs is stuck at 230K when running:
>=20
>     fio --filename=3D/dev/sda  --direct=3D1 --rw=3Drandrw --bs=3D4k
>     --ioengine=3Dlibaio --iodepth=3D128  --numjobs=3D8 --time_based
>     --group_reporting --runtime=3D60
>=20
> The patches in this set get me to 350K when using devices that
> have native IOPs of around 400-500K.
>=20
> Note that 5.12 has some interrupt changes that my patches
> collide with. Martin's 5.12 branches had the changes so I
> based my patches on that.

For vhost-scsi:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAhFuwACgkQnKSrs4Gr
c8i9fggAxfNpzkdi1bqBFj4YY9e2IC1HyxNIRjrtAAPSooPVaY+tv01MPVM3htRJ
OuMToi1R0kjYsjxMfxJ4nfaY3iCBHNsEf+LAwuRYxFRFnXR+iEbhR804bxak9epk
QwIClSa432iA8GMvah7xzr0+HQVxEIwGezl45l8Gn408z0KmB5MQjGGK2+ARE7QS
IYRUr2J7ny3hOpWJ+roj4812Oka+iEOgdjc3ijOpDd9bETMobZ0f9qlJN+OSyB2Q
gpzx6tyHxTN9uzBNSqF+81y00EKqJhT6AQY+vh6MIXXFEz5diunGBOo+uQRIKG/j
4e/Qytom81tfCAdDf2bxX8LC8kg8IA==
=DOyd
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

