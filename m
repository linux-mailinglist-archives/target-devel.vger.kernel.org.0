Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C495399F3A
	for <lists+target-devel@lfdr.de>; Thu,  3 Jun 2021 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFCKq7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Jun 2021 06:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhFCKq4 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622717111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DKnh0uyhdKqoboJLkz1MQbf+CPgU8STex9vsGZAVttw=;
        b=dy08ISs5m4KXakVAwg7VzUy1nzqERUxt+RyIHtaSApPtVJwaSiRJXbo8cbsqwxkTlPo/SY
        tLZWjru+Dy1S1K2XyidNtV3eHTS2TXbUJhN5y4KYmeP1ryQlqr5NuFkwm7MsRiuTbQ8Qgm
        u6QWmsB2oB8wh00ZwNB+FVYN6rCTuDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-rgmo3ZBUPgyy8riSHYsp3g-1; Thu, 03 Jun 2021 06:45:08 -0400
X-MC-Unique: rgmo3ZBUPgyy8riSHYsp3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A950801817;
        Thu,  3 Jun 2021 10:45:07 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01FB350F89;
        Thu,  3 Jun 2021 10:45:02 +0000 (UTC)
Date:   Thu, 3 Jun 2021 11:45:01 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        pbonzini@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 3/9] vhost: modify internal functions to take a
 vhost_worker
Message-ID: <YLiyrRdeD6vQ2VXc@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F7RAaeNOJ2iI4bk5"
Content-Disposition: inline
In-Reply-To: <20210525180600.6349-4-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


--F7RAaeNOJ2iI4bk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:54PM -0500, Mike Christie wrote:
> -void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> +static void vhost_work_queue_on(struct vhost_work *work,
> +				struct vhost_worker *worker)
>  {
> -	if (!dev->worker)
> -		return;
> -
>  	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>  		/* We can only add the work to the list after we're
>  		 * sure it was not in the list.
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
> -		llist_add(&work->node, &dev->worker->work_list);
> -		wake_up_process(dev->worker->task);
> +		llist_add(&work->node, &worker->work_list);
> +		wake_up_process(worker->task);
>  	}
>  }
> +
> +void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)

When should this function still be used? A doc comment contrasting it to
vhost_work_queue_on() would be helpful. I would expect callers to switch
to that instead of queuing work on dev->workers[0].

>  /* A lockless hint for busy polling code to exit the loop */
>  bool vhost_has_work(struct vhost_dev *dev)
>  {
> -	return dev->worker && !llist_empty(&dev->worker->work_list);
> +	int i;
> +
> +	for (i =3D 0; i < dev->num_workers; i++) {
> +		if (!llist_empty(&dev->workers[i]->work_list))
> +			return true;
> +	}
> +
> +	return false;
>  }
>  EXPORT_SYMBOL_GPL(vhost_has_work);

It's probably not necessary to poll all workers:

drivers/vhost/net.c calls vhost_has_work() to busy poll a specific
virtqueue. If the vq:worker mapping is 1:1 or N:1 then vhost_has_work()
should be extended to include the struct vhost_virtqueue so we can poll
just that vq worker's work_list.
>  /* Caller must have device mutex */
>  static int vhost_worker_try_create_def(struct vhost_dev *dev)
>  {
> -	if (!dev->use_worker || dev->worker)
> +	struct vhost_worker *worker;
> +
> +	if (!dev->use_worker || dev->workers)
>  		return 0;
> =20
> -	return vhost_worker_create(dev);
> +	dev->workers =3D kcalloc(1, sizeof(struct vhost_worker *), GFP_KERNEL);

GFP_KERNEL_ACCOUNT so that vhost memory associated with a process (the
one that invoked the ioctl) is accounted? This may get trickier if the
workers are shared between processes.

The same applies for struct vhost_worker in vhost_worker_create().

--F7RAaeNOJ2iI4bk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC4sq0ACgkQnKSrs4Gr
c8gXxgf6AuE6XADmG7si7aHqwcDMJZ+rEPI+I8QDNKz/fJNr65aBbaPl5xrosoaF
gs7CLIEdNshApxvMrB/2AffUwvv8CJYeWjCGtjKZAi5rjM0V0bVomsUEdDMoFlhy
QijVpTOfdY77vZIsjcDWuDA8wfIni6yfFQ4g4Rpnj86qVROK777vzdKkrywqrdtK
ntxM5SK1kWAiD1ulurJ6CgW3tYy7mVFM4pFwEXWmjm8kUmMe9OyQlll7HjUVsxgT
cLQVsVWa64qyZx2etIJLGiQY7cT/6eI+v+9EmxdqEhnUngdLjpawe+Eld3wTffld
rRDnZF8n/R2P0SZbiEPHzqGxMF0sOw==
=xLx3
-----END PGP SIGNATURE-----

--F7RAaeNOJ2iI4bk5--

