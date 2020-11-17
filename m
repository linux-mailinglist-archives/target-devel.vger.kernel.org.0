Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECBD2B6953
	for <lists+target-devel@lfdr.de>; Tue, 17 Nov 2020 17:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKQQEk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 17 Nov 2020 11:04:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgKQQEj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605629078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAvCna+clDX4lZQI5nvorTls2cvWVMz8okgtfWJTHKI=;
        b=gl3d7vL8EzbOzWsXKpBoa4MBnMZKCBksmaqipPn9Gv7e99M56vCxepQn4xKuR8xTeBps4B
        Kf/h7J/+Dy0mXGAUfJ0t0vqPNaXl8rvbWMD++rI6DBHK2bvQ9VokAdwWupQQ7RvgmcmNd2
        DIoSa5r6yVkpfqv6OxfnDGYOT4a7sBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-Rvj2yrciNbW8ZnE6T7_S1Q-1; Tue, 17 Nov 2020 11:04:32 -0500
X-MC-Unique: Rvj2yrciNbW8ZnE6T7_S1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA53A8042A7;
        Tue, 17 Nov 2020 16:04:30 +0000 (UTC)
Received: from localhost (ovpn-115-113.ams2.redhat.com [10.36.115.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 452BD1841D;
        Tue, 17 Nov 2020 16:04:27 +0000 (UTC)
Date:   Tue, 17 Nov 2020 16:04:26 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     qemu-devel@nongnu.org, fam@euphon.net, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 06/10] vhost scsi: make SCSI cmd completion per vq
Message-ID: <20201117160426.GO131917@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-8-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-8-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/UvyDgxjlFfP/4zZ"
Content-Disposition: inline
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--/UvyDgxjlFfP/4zZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 05:19:06PM -0600, Mike Christie wrote:
> In the last patches we are going to have a worker thread per IO vq.
> This patch separates the scsi cmd completion code paths so we can
> complete cmds based on their vq instead of having all cmds complete
> on the same worker thread.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 48 +++++++++++++++++++++++++---------------------=
--
>  1 file changed, 25 insertions(+), 23 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/UvyDgxjlFfP/4zZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+z9IoACgkQnKSrs4Gr
c8j3GQf/Qf0GdIULIC6ID0rnGPCWs44LKDFOtvHlByy3GfUC9uN86EvbUUVr//2v
sWCmnejk/fX8lr9iwwbw3v2LBio+avFi47iOd5HxLRW23EAHdkzbgP4DPQDQGVGg
RW5h5+SJFSvsZavgx58zu2zKIIEL7zmJ/ik57DqjmDyDEBeBZmibE/PNdeHLzlt4
/nWAIdG2eFuNP8vXPy49799ilcJd5A6ONmNwie9Xve7ptRWM4SLU32Jb6yPDsL6W
AHwTMdvcWbTxjGJuUdIhtnwivYUP203mX2EMxW2x/29t02eULUDIww/4Bj4RoC7F
FmaH54Wk0eoNDs+DYLL9Y3+VQkeL5Q==
=5DGA
-----END PGP SIGNATURE-----

--/UvyDgxjlFfP/4zZ--

