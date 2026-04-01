Return-Path: <target-devel+bounces-1038-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKJjHTBUzWk3cAYAu9opvQ
	(envelope-from <target-devel+bounces-1038-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Wed, 01 Apr 2026 19:21:52 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B2B37E968
	for <lists+target-devel@lfdr.de>; Wed, 01 Apr 2026 19:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A2F33008CB7
	for <lists+target-devel@lfdr.de>; Wed,  1 Apr 2026 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0947A0BC;
	Wed,  1 Apr 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qih0aonq"
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C547B426
	for <target-devel@vger.kernel.org>; Wed,  1 Apr 2026 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063363; cv=none; b=oUB8QiW9mWUu5SywvY/vhEGAOAZGYGmOzXeumeXRQ5IAoACYa1YZVfjQFa/NUG8n0EHNmNPG/vB8+Vp+gLPRpafRxpE1CZwu8oOGT7r2N3zGEqoby4vHyZ4gGBBMd8MhtBcxOc/R5YnTxn/8ELt/2Xb45wZcq4Lzz0UYw07Sj3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063363; c=relaxed/simple;
	bh=UrlrL3JrdlkwweCdRKeXD8MoN74BHicvKbtfVaI7CU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjYekBBpswoSabYLkiawGM7hrqqksONyb78bgOj49njIKq6RAl+K37kzlYUbavMf+HiMf3crMy18mlr4zoJ+YanATkWWYi2IhJUv3YFfVNacuHo5qmEgOjGiRGfolYw5xktLJ+QUzDS9E9eBGEysCj/jAr4YMaCaiy4g2CDpT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qih0aonq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775063361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UrlrL3JrdlkwweCdRKeXD8MoN74BHicvKbtfVaI7CU8=;
	b=Qih0aonqko9enMhM9/CktAKjcjI0WsEwqD65TThhOBsis9qoKSUOhPg9VnB9UtumcUhDTq
	lX7PNVkHYO/Oke1qQPhcSJ4xqpGWVUPeouZM7TANEVakdiyFiwRU8mkNBO1TFikl8Bd8q1
	n37UCBeWfsd7rd53rW9i7+tUtUlDwdI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-7vDLrfpHP1qNdvQbawMPrg-1; Wed,
 01 Apr 2026 13:09:17 -0400
X-MC-Unique: 7vDLrfpHP1qNdvQbawMPrg-1
X-Mimecast-MFC-AGG-ID: 7vDLrfpHP1qNdvQbawMPrg_1775063356
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 354BE19560B1;
	Wed,  1 Apr 2026 17:09:16 +0000 (UTC)
Received: from localhost (unknown [10.44.32.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 599CE30001A2;
	Wed,  1 Apr 2026 17:09:14 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:09:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: target-devel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: LIO PERSISTENT RESERVE OUT PREEMPT spec compliance
Message-ID: <20260401170912.GA329795@fedora>
References: <20260401124626.GA266484@fedora>
 <9c556370-5e85-4cb6-8f4d-c0361467b2f3@acm.org>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zejTu4YnJbD2u5vy"
Content-Disposition: inline
In-Reply-To: <9c556370-5e85-4cb6-8f4d-c0361467b2f3@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1038-lists,target-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanha@redhat.com,target-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[target-devel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4B2B37E968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--zejTu4YnJbD2u5vy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 08:56:05AM -0700, Bart Van Assche wrote:
> On 4/1/26 5:46 AM, Stefan Hajnoczi wrote:
> > Thoughts?
>=20
> There is a persistent reservation compliance test suite in libiscsi.
> SCST passes that test suite if I remember correctly. It would be great
> if LIO would pass the tests from that test suite too. See also
> https://github.com/sahlberg/libiscsi

Hi Bart,
Thanks for sharing the libiscsi test suite.

Stefan

--zejTu4YnJbD2u5vy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnNUTgACgkQnKSrs4Gr
c8gonQgAxceD3FeX/z3kfqUOYoYBEqUF3P21CdFZSUbSUITCwWPeb5E1wsj8S+Db
poFnup1JfMTUkQ+A1TmzhYmRx8IaNGxZ5EbAVjAfQ+qgIlv88mrEgTeMkIS4zXEZ
anyp24UttTQZMen+vC8NjpP+IOlyaN126jThPtxHgZU62Xilk/GroxYlxhl4cWMA
taahgqZGOomHYfr4FwAg/0oOiOMRuFKiDVn3khKXxH4bSbp9zsRtqaZLQcE/TKnK
tXHKw6NXi5c07C3LAAWssnaRGfNN9quP5kYYrlfbkDpmRfnhx5Gwi2+cwfImCSpA
2t+Y7/2TU0pz8FcmD7vpOo/kpieFzA==
=w7w/
-----END PGP SIGNATURE-----

--zejTu4YnJbD2u5vy--


