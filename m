Return-Path: <target-devel+bounces-1218-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QsJ9MwOyKmqfvAMAu9opvQ
	(envelope-from <target-devel+bounces-1218-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Thu, 11 Jun 2026 15:02:59 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA56672224
	for <lists+target-devel@lfdr.de>; Thu, 11 Jun 2026 15:02:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=W0SkKk5j;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1218-lists+target-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="target-devel+bounces-1218-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E69322B9EB
	for <lists+target-devel@lfdr.de>; Thu, 11 Jun 2026 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D22DA76C;
	Thu, 11 Jun 2026 12:58:01 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1E3F4DD5
	for <target-devel@vger.kernel.org>; Thu, 11 Jun 2026 12:57:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182680; cv=none; b=udOXsT+sisxqd8Hzhu4FqBtFdszQFmQ5ckHkyQ+wIdWsvKqgMJg9fkbBn3IG6YPQaGbwBsbGVDwCfdAm6hYRX3GRDfs3C43bjIHLjHw2PajI5EkSPumvK4AHmKzUnA2pnn4AItXZ/SBLxznRfPWDvXyCbiWlBl0fhD3mm8JI67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182680; c=relaxed/simple;
	bh=pMz0XopnIHTyXSKV4o5NA6+8Cj6CQUbxxVzNeeDGF4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYfLJOE6a2n0NLtohQkEnfS4y2HUndncqyHr3aLl4orC5sDNJ304EWeuEQIn9lskU3WrqcP+C5AJPvItZxA8G/POeow0JQgehCUugpybU8EXWcNIk4tdsBNovsNL6/QGTc0bCTPsmYzU6e3ObMAP3NWgKbwwU9AeG3/ethVOt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0SkKk5j; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781182678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wutI1NEOrxe0Ga9sQ5pG620uXi0d0C5Aj7NTI3FNepo=;
	b=W0SkKk5jYdQquYbnTdIYUo3eQ225xFkvB8S6n4ciMOZKKoT15x3KmIwQl9w1lBlIr9cUTr
	IWLyJpJc0hf0EnUzEaVnjNL4AU5cPV9UFApWRIxMgS9OST0NWHS55VAKY6z1EyHTwfw8Gc
	xJSpjjkujGfMQ+EZNUOjN9pe3M77jiI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-_h9LaK_xPp-Cw2A3pjQP9w-1; Thu,
 11 Jun 2026 08:57:51 -0400
X-MC-Unique: _h9LaK_xPp-Cw2A3pjQP9w-1
X-Mimecast-MFC-AGG-ID: _h9LaK_xPp-Cw2A3pjQP9w_1781182668
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1984519775EB;
	Thu, 11 Jun 2026 12:57:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.137])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 179B1180057F;
	Thu, 11 Jun 2026 12:57:43 +0000 (UTC)
Date: Wed, 10 Jun 2026 11:37:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sumit Saxena <sumit.saxena@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Khalid Aziz <khalid@gonehiking.org>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	"Juergen E . Fischer" <fischer@norbit.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	target-devel@vger.kernel.org,
	Bradley Grove <linuxdrivers@attotech.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Yihang Li <liyihang9@h-partners.com>,
	Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Brian King <brking@us.ibm.com>,
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	open-iscsi@googlegroups.com, Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	megaraidlinux.pdl@broadcom.com,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com, Daniel Palmer <daniel@thingy.jp>,
	GOTO Masanori <gotom@debian.or.jp>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Geoff Levand <geoff@infradead.org>, Michael Reed <mdr@sgi.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Narsimhulu Musini <nmusini@cisco.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 2/4] scsi: host: allocate struct Scsi_Host on the NUMA
 node of the host adapter
Message-ID: <20260610153747.GA121666@fedora>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-3-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="57Se20/pMUpk+P8R"
Content-Disposition: inline
In-Reply-To: <20260609121806.2121755-3-sumit.saxena@broadcom.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1218-lists,target-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sumit.saxena@broadcom.com,m:mst@redhat.com,m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:James.Bottomley@hansenpartnership.com,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,m:aradford@gmail.com,m:khalid@gonehiking.org,m:aacraid@microsemi.com,m:willy@infradead.org,m:hare@suse.com,m:fischer@norbit.de,m:linux@armlinux.org.uk,m:linux-arm-kernel@lists.infradead.org,m:fthain@linux-m68k.org,m:schmitzmic@gmail.com,m:anil.gurumurthy@qlogic.com,m:sudarsana.kalluru@qlogic.com,m:oliver@neukum.org,m:aliakc@web.de,m:lenehan@twibble.org,m:ram.vegesna@broadcom.com,m:target-devel@vger.kernel.org,m:linuxdrivers@attotech.com,m:satishkh@cisco.com,m:sebaddel@cisco.com,m:kartilak@cisco.com,m:liyihang9@h-partners.com,m:don.brace@microchip.com,m:storagedev@microchip.com,m:linux@highpoint-tech.com,m:tyreld@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@us.ibm.com,m:lduncan@su
 se.com,m:cleech@redhat.com,m:michael.christie@oracle.com,m:open-iscsi@googlegroups.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:kashyap.desai@broadcom.com,m:shivasharan.srikanteshwara@broadcom.com,m:chandrakanth.patil@broadcom.com,m:megaraidlinux.pdl@broadcom.com,m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:mpi3mr-linuxdrv.pdl@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,m:daniel@thingy.jp,m:gotom@debian.or.jp,m:jinpu.wang@cloud.ionos.com,m:geoff@infradead.org,m:mdr@sgi.com,m:njavali@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:nmusini@cisco.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:jasowang@redhat.com,m:pbonzini@redhat.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:vishal.bhakta@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:jgross@suse.com,m:sstab
 ellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:xen-devel@lists.xenproject.org,m:john.g.garry@oracle.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[oracle.com,kernel.dk,hansenpartnership.com,vger.kernel.org,gmail.com,gonehiking.org,microsemi.com,infradead.org,suse.com,norbit.de,armlinux.org.uk,lists.infradead.org,linux-m68k.org,qlogic.com,neukum.org,web.de,twibble.org,broadcom.com,attotech.com,cisco.com,h-partners.com,microchip.com,highpoint-tech.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,us.ibm.com,redhat.com,googlegroups.com,thingy.jp,debian.or.jp,cloud.ionos.com,sgi.com,marvell.com,microsoft.com,lists.linux.dev,epam.com,lists.xenproject.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[stefanha@redhat.com,target-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanha@redhat.com,target-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_GT_50(0.00)[81];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[target-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFA56672224


--57Se20/pMUpk+P8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 05:48:01PM +0530, Sumit Saxena wrote:
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 5fdaa71f0652..88375574cb18 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -929,7 +929,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	num_targets =3D virtscsi_config_get(vdev, max_target) + 1;
> =20
>  	shost =3D scsi_host_alloc(&virtscsi_host_template,
> -				struct_size(vscsi, req_vqs, num_queues));
> +				struct_size(vscsi, req_vqs, num_queues), NULL);

A virtio_device has a parent (this is the virtio transport, like
virtio_pci) and that may have NUMA node.

drivers/virtio/virtio.c:register_virtio_device() could call
set_dev_node(dev, dev_to_node(dev->parent)) to propagate the NUMA node
to the virtio_device if it is not already automatically propagated.

Stefan

--57Se20/pMUpk+P8R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmophMsACgkQnKSrs4Gr
c8h+7Af/Yl5xc4DOlpzwRNKEPqqogmtmADQbRI91eNljCoArG1qdxcTTSKksIgWC
5g0jjNOCwbOatljS+FxPkDgpPYoZbsIv+K4p/D6UyHLP+Dff2FQhwPaAKkOvJi6k
9BoNOORgp8ZKrf0RrCTr2M5clKgG0GT+5WxgezSZtTh6wSoN0ksL5kwqx+8B4sWw
irnTFz4hZhKlUsYHWWYvNhiq0ChdmzYMdxw6GFwIWrRpNcElfSmOAMBE12bJeqIi
u2/3ah3cSSanhmuITCC+dXImHUlYtxtFRBowqsxCEtdiRFs5srPStR/WW8yyZoXe
mhXbMPjGmQXNdAT61yT9lw+ZVx2y1w==
=kfg0
-----END PGP SIGNATURE-----

--57Se20/pMUpk+P8R--


