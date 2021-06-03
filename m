Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F180E399EB8
	for <lists+target-devel@lfdr.de>; Thu,  3 Jun 2021 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhFCKS1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Jun 2021 06:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhFCKSZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622715400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5q6zye8jgaP4kJLBUCQQtBp65dRFCpe6nc6ebA8ldZo=;
        b=RS/QeuII//LwFPjlmWze/R2iWYJB3ger1kUY9V0wInEaKBvP32rpjq4AkldE7CiG2HQt8Y
        +WUZP55TpPse2FYcV9rZjU1+nv14HUzfkN/63c4I3aywELf30461dyAAh8gHMOU/hvyeif
        x3S18A0kgkYiEujNfhFa7iVMM1P/Irs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-ap08A-feNfSxrnRV67tYHw-1; Thu, 03 Jun 2021 06:16:39 -0400
X-MC-Unique: ap08A-feNfSxrnRV67tYHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E3A180FD6D;
        Thu,  3 Jun 2021 10:16:38 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD0E061140;
        Thu,  3 Jun 2021 10:16:34 +0000 (UTC)
Date:   Thu, 3 Jun 2021 11:16:33 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        pbonzini@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/9] vhost: move worker thread fields to new struct
Message-ID: <YLisAZ9rbEYsubwI@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X8EHBs5SNGaS5/wR"
Content-Disposition: inline
In-Reply-To: <20210525180600.6349-2-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


--X8EHBs5SNGaS5/wR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:52PM -0500, Mike Christie wrote:
> This is just a prep patch. It moves the worker related fields to a new
> vhost_worker struct and moves the code around to create some helpers that
> will be used in the next patches.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c | 94 +++++++++++++++++++++++++++++--------------
>  drivers/vhost/vhost.h |  9 ++++-
>  2 files changed, 70 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--X8EHBs5SNGaS5/wR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC4rAEACgkQnKSrs4Gr
c8iIiwgAysz30R4KsMZziyBEl+84TYFQ/urwez3XYLdllPTZPcAwMCED2HhiXcjd
gT4TAnqiTg0ysoReB9qEOsFGH0uNzbZev+F/gRGc1eo5qpx6ZFR2y8AwGrr+ydBf
h3xs4CTctrb+DHfObfkkjPcd5pbQekyEUbzEbZHQAKCmQk+LsNGY3PFVQdwodErA
CVnAJFYPKkxt5vPkYoR3CmYRj/9A1++7W/Egs1Lbb0DGcfpk2GTSdOyK7fRGzN5+
LOyGg51GQoR1j5RaBFSfpRmt6JicZte0C//NjJbvb4PptYbNdxSQwlCe2ddIhI5X
4Qfl2znad0AlqIMvYdxhEyeU2ECFag==
=fCDC
-----END PGP SIGNATURE-----

--X8EHBs5SNGaS5/wR--

