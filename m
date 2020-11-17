Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F55C2B6958
	for <lists+target-devel@lfdr.de>; Tue, 17 Nov 2020 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKQQFp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 17 Nov 2020 11:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgKQQFo (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605629143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ed1LhVKjQj2PeSGWg14twvLm6/KTivQ3jK64P+HzZhQ=;
        b=dByNIVjEv778UVCtiv1W9ysjazwRKEHAHy+yS7YZVjW6N3QEVkEeRdUK7EKk5LLQ/Jsn1h
        D103RtdeCDJQI6nHTk2xhAyX2HgSZPvh3a3ETqr5NgFrq7MSrcl1volz1Uue/2y+02GQGn
        m01R3xRw8OjOaHNVFoP7BT4gQnxorTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-BpNF29LAMia3uJ9rQX57TA-1; Tue, 17 Nov 2020 11:05:39 -0500
X-MC-Unique: BpNF29LAMia3uJ9rQX57TA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31A8D11BD341;
        Tue, 17 Nov 2020 16:05:37 +0000 (UTC)
Received: from localhost (ovpn-115-113.ams2.redhat.com [10.36.115.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75CDD1001E73;
        Tue, 17 Nov 2020 16:05:33 +0000 (UTC)
Date:   Tue, 17 Nov 2020 16:05:32 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     qemu-devel@nongnu.org, fam@euphon.net, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 07/10] vhost, vhost-scsi: flush IO vqs then send TMF rsp
Message-ID: <20201117160532.GP131917@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-9-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-9-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+gHRqQ1BTyNna/y8"
Content-Disposition: inline
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--+gHRqQ1BTyNna/y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 05:19:07PM -0600, Mike Christie wrote:
> With one worker we will always send the scsi cmd responses then send the
> TMF rsp, because LIO will always complete the scsi cmds first which
> calls vhost_scsi_release_cmd to add them to the work queue.
>=20
> When the next patch adds multiple worker support, the worker threads
> could still be sending their responses when the tmf's work is run.
> So this patch has vhost-scsi flush the IO vqs on other worker threads
> before we send the tmf response.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c  | 16 ++++++++++++++--
>  drivers/vhost/vhost.c |  6 ++++++
>  drivers/vhost/vhost.h |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+gHRqQ1BTyNna/y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+z9MwACgkQnKSrs4Gr
c8gaqgf/ezD3eMZkmyNkKq/TS6tnuCAH04YabhXKm+dLdSH9xZvaLGPKG/CnwF6o
/gS0CjOu5YrvXmP+VlZ+uwaOIqOHgxP79NAm57j5mPXi6VLcz3tK7ctF8jrGDqYH
wzSkCP2Wjr0Dvc3t2d5gAyggrabBtyPzuT9oUjolzEo6DXKQQXN3Ok3sVDDinQ2d
/jF39oufcFmWT3+EeUEBXr2MHtC7ccx3ZFCCASkNznT5s+CuwLrLeqVIS+2wC9FK
x4XdBOvZ0qy/rggn3UAmDQe2cfuaU28vwZhddyVjeBjSyimYbnoSQT1XheHB/45v
MyMI5NxDJBU3WStraKoA/MQRSYcB8A==
=IxzD
-----END PGP SIGNATURE-----

--+gHRqQ1BTyNna/y8--

