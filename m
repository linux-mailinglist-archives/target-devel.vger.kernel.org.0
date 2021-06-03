Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0D39A346
	for <lists+target-devel@lfdr.de>; Thu,  3 Jun 2021 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhFCOfK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Jun 2021 10:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhFCOfJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622730804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffqU2pTHvgdCYPe0Q2G5XamulxR8bjf1k2Ncp4K3ymc=;
        b=BwwmHBsJNvdSPk+5zyPdg5A4B4qCcGaEE0hnRyU8uu70h0cNI3RgfgZen6iI7LAl4en/8t
        GbQicKjHnxNWJ3r0PsRaTl5rcRsN2RH7br21cv4O/kKxetCLRzzC3WVDyaDdUNpE+FZW/A
        VRGYWSKby9DxMD1BLO3x9gHbYTXV1MI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-ixezL8r6NLerul-0h_8Tvg-1; Thu, 03 Jun 2021 10:32:53 -0400
X-MC-Unique: ixezL8r6NLerul-0h_8Tvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6FC319251AF;
        Thu,  3 Jun 2021 14:32:51 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F05EF10023AB;
        Thu,  3 Jun 2021 14:32:47 +0000 (UTC)
Date:   Thu, 3 Jun 2021 15:32:46 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        pbonzini@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 9/9] vhost: support sharing workers across devs
Message-ID: <YLjoDjas6ga3Ovad@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-10-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z17amfYzuCxbaWBX"
Content-Disposition: inline
In-Reply-To: <20210525180600.6349-10-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


--Z17amfYzuCxbaWBX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:06:00PM -0500, Mike Christie wrote:
> This allows a worker to handle multiple device's vqs.
>=20
> TODO:
> - The worker is attached to the cgroup of the device that created it. In
> this patch you can share workers with devices with different owners which
> could be in different cgroups. Do we want to restict sharing workers with
> devices that have the same owner (dev->mm value)?

Question for Michael or Jason.

--Z17amfYzuCxbaWBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC46A4ACgkQnKSrs4Gr
c8gPmgf/Vvk8j1U+cTELBrRn7FiW5F0i56uYi7uGSqGO7nC1ceRKUTl4kdOEdCJh
M7CtuhHM4rGFqReb68IKB6isGdJbobo9RA42azy4Jz60BZu1fPRzdF9Hqts+cAnW
2a74nuPIpys+Sr6QWcOOzayd7SJCYGIQqhPKEE3WmMMLMGfZqB3KDhPrBUSZGmf8
A6vCH6KhCv6NytVOsvlqNmHr2UHN+sxm91igFwIqajYwlbpZIo/4KI64Ttw+98RF
VfqHxb1QlVbLOIQyvrRAvbUcK/HdmyRezFPZ6gxGQkdIykvOAJnRXHujxYX4VzsI
V0rDVjKF3kmoDcSjt25mI9po/PHYbQ==
=7Wkj
-----END PGP SIGNATURE-----

--Z17amfYzuCxbaWBX--

