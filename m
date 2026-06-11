Return-Path: <target-devel+bounces-1216-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fh97KEqSKmqYsgMAu9opvQ
	(envelope-from <target-devel+bounces-1216-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Thu, 11 Jun 2026 12:47:38 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DD670F90
	for <lists+target-devel@lfdr.de>; Thu, 11 Jun 2026 12:47:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=TwiesUDN;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1216-lists+target-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="target-devel+bounces-1216-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A09033299A4
	for <lists+target-devel@lfdr.de>; Thu, 11 Jun 2026 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27EE3D0919;
	Thu, 11 Jun 2026 10:44:30 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D03D5226
	for <target-devel@vger.kernel.org>; Thu, 11 Jun 2026 10:44:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174670; cv=none; b=BlVEZTBIJdoMBtpXd1FawVWi2MSUk8OKY+zkrSQvl+VYmj3RaWCAXffTaDUw4FGSpyIovwyXHVoi2NTp30rVMf8NYUySc3J0dwaAC1m3aXTl58NtSV4d3oyicOwLnXgIiHCN2TRNbMDKJcgDUp9WIB0JW/aCOCbB4LrLQ8G1TO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174670; c=relaxed/simple;
	bh=ZUzyYskGb7tcsMeSZ9vDkBoey4WMmE+z84bBrQdt8rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIO2ig1ws3GlIpqdse0McOwPtvdq0l3eqZy1yGOJNcDFl+o3/DYrhm036UmgMXIQLfW7+fNlrB7hj18QEpYFqJI2dUsdafjjvMZPBDKyEDHYOb1kkTGFCvyzR7X82fGHR14Ifd5VV41lSeKen1tSz6yDRYICBd+LwVQk29estR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TwiesUDN; arc=none smtp.client-ip=209.85.210.100
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7e6e2d54d3dso4213991a34.2
        for <target-devel@vger.kernel.org>; Thu, 11 Jun 2026 03:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781174668; x=1781779468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUzyYskGb7tcsMeSZ9vDkBoey4WMmE+z84bBrQdt8rE=;
        b=Mku59JY50MXeEL3e3JLVVDr1zFz8+dBG9K0ENUPjUeZhRctoQ+m7BOLsI8JsfvfVbd
         aRvvhtcxxEq159FgCpM1PFSUNr2+90t38abK78+tPEFRn6Rxz4t5pwQKKJGvk1sMj6VD
         ETu7e7LOiuc6kc6mlPaCjdA5yklQipvljCI5eFn3PlrKDdB+GwCHL4oW7CiKjucOg+Rk
         4Eu4osfKUfrDXBPc307SCt3kOsj40SWjAz3NqZ+zwu1VXwQUa4yowdtZUgwSffmtoqPw
         KWg1+k2J1pQBgg7+0B9L8xZa8frJZDRJOSaHTrG/G25XkSi92Eldi1COULoUyAu3lbkC
         rtdg==
X-Forwarded-Encrypted: i=1; AFNElJ9cpgbCwLkYkGDNqbtkR9fMEUzVONIugGHVEZa33he4k99ED0s4JTUuZxLz7X4v3QeKyRd7A9VDgYwuaq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTvNJQUqkT+eXnFpfcc00uvq07QbBdDXdIxJqsIfx8bM7ks88
	z1zknZ8gk8JflKfrEGufJrFCiQJadZv2OVjFp4BsQwjXTM15zlldiZUh9M9AQb1Fm5jZnxLP7zd
	gv4hrudlv9/el6WlC0gksRgKYP46+1VM7PVFg9q3c6VgbodaRnlO9FVH81NF5B1NXP8oaLjK15h
	GeWMr9iLfwyz45+EJbX8u/8QgkSDZRgI2JeZIVUi2WxSAEVqHZxNjzMS7zjzIEXIUM6kPA50Pbh
	0v9OKoUsTTz2i/DKQc=
X-Gm-Gg: Acq92OHIB/V1lNqCJHxvFiI/IGIiEjRSca5JJ860eGPdOuoB/k3Bs6jeY7I4AvVgiNv
	qlE41k5RgGOL4zZ8p5B+d0reXsUNb2NGCWFrNkNVsY/rz1ub/B/fKBCz5Rx/hb0izgyWU5sfO52
	blMLSfzcJp/rrzCap8msLVo4d6v/jlGjYBazyra7c5KZlz1iCqCJ6C/FK0xyvsa9OjEi1YXxsoI
	9ehzxL6QwC53N39iMf0Q12QffyGlyLfUGPwn2TFZjpxwEpKw75nSLwMAIo/LO7MEyIRJUfosrJC
	A8jsn1j35b+o5/13j52svi2/lU2gQWfy1Uil1roi4cJm2ioo4rk2OOMpT3g+AeusKskk9ghP+hI
	gM97BtTm08DK4cAiXHQPCdB+brjKNdnQLnReyNQpCFUi00n+pIWrgHR5oPsyqXZEQAqInbHhbtU
	DdlSU+Ckm7ugbqWBr4+JEdKxXdQcwh3gOTw4j0aa0VwFw2xT7ZP7aWunQGHZbFe8+fzg0=
X-Received: by 2002:a4a:ee83:0:b0:69d:8555:c458 with SMTP id 006d021491bc7-69ecae7b351mr1533991eaf.24.1781174668161;
        Thu, 11 Jun 2026 03:44:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69ecb4947d5sm91879eaf.9.2026.06.11.03.44.26
        for <target-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2026 03:44:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5aa68dd6dbcso4495969e87.3
        for <target-devel@vger.kernel.org>; Thu, 11 Jun 2026 03:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781174665; x=1781779465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUzyYskGb7tcsMeSZ9vDkBoey4WMmE+z84bBrQdt8rE=;
        b=TwiesUDNfMX0nu8RPC35uEa+4epTYD610cxBEJHkuQyJdKbqbU7zsbiXJPJoHT44Re
         hYTJ6Ff+LuzVbkyKsiI5Zj4X+PFeG96ezPx8Qx7xWuQOSgbqb4aCZwDyRWxD0rXFGXat
         c6vX6gOL7WRfvHX7RDo+gHQ2sPZPFprlRdtJE=
X-Forwarded-Encrypted: i=1; AFNElJ+zs4j9ket2UXSNVlxBeWWlq9BgZ9qDpyysrEKL5e+RPpGZV8mrBMa/JNSVlOnGlwbKxLTk7W4aA8zc7Jg=@vger.kernel.org
X-Received: by 2002:a05:6512:3a8a:b0:5aa:6290:f78d with SMTP id 2adb3069b0e04-5ad27a9c764mr696796e87.2.1781174665037;
        Thu, 11 Jun 2026 03:44:25 -0700 (PDT)
X-Received: by 2002:a05:6512:3a8a:b0:5aa:6290:f78d with SMTP id
 2adb3069b0e04-5ad27a9c764mr696784e87.2.1781174664507; Thu, 11 Jun 2026
 03:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-4-sumit.saxena@broadcom.com> <aikAs4X-2NWTuwCc@infradead.org>
 <CAL2rwxr1uGshb1o=jvP2OnBffNz2cKXj8tHuAUCN5HFuy2vB_g@mail.gmail.com> <aimSb9I0Vl-68hy9@kbusch-mbp>
In-Reply-To: <aimSb9I0Vl-68hy9@kbusch-mbp>
From: Sumit Saxena <sumit.saxena@broadcom.com>
Date: Thu, 11 Jun 2026 16:13:46 +0530
X-Gm-Features: AVVi8Cd88XM9WQCmkDM1ogPmYgU9Pn0rqq_dsX0LdbdBcAzp9xGlrg8ZceRzVXQ
Message-ID: <CAL2rwxqtjjFYkSbBo1VSyw8JQ7JUnX9nqB9twOH9jhuTY1DD2w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] block: drop shared-tag fairness throttling
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, Adam Radford <aradford@gmail.com>, 
	Khalid Aziz <khalid@gonehiking.org>, Adaptec OEM Raid Solutions <aacraid@microsemi.com>, 
	Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.com>, 
	"Juergen E . Fischer" <fischer@norbit.de>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Finn Thain <fthain@linux-m68k.org>, 
	Michael Schmitz <schmitzmic@gmail.com>, Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, Oliver Neukum <oliver@neukum.org>, 
	Ali Akcaagac <aliakc@web.de>, Jamie Lenehan <lenehan@twibble.org>, 
	Ram Vegesna <ram.vegesna@broadcom.com>, target-devel@vger.kernel.org, 
	Bradley Grove <linuxdrivers@attotech.com>, Satish Kharat <satishkh@cisco.com>, 
	Sesidhar Baddela <sebaddel@cisco.com>, Karan Tilak Kumar <kartilak@cisco.com>, 
	Yihang Li <liyihang9@h-partners.com>, Don Brace <don.brace@microchip.com>, 
	storagedev@microchip.com, HighPoint Linux Team <linux@highpoint-tech.com>, 
	Tyrel Datwyler <tyreld@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	Brian King <brking@us.ibm.com>, Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
	Mike Christie <michael.christie@oracle.com>, open-iscsi@googlegroups.com, 
	Justin Tee <justin.tee@broadcom.com>, Paul Ely <paul.ely@broadcom.com>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>, megaraidlinux.pdl@broadcom.com, 
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>, mpi3mr-linuxdrv.pdl@broadcom.com, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
	Ranjan Kumar <ranjan.kumar@broadcom.com>, MPT-FusionLinux.pdl@broadcom.com, 
	Daniel Palmer <daniel@thingy.jp>, GOTO Masanori <gotom@debian.or.jp>, 
	YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>, Jack Wang <jinpu.wang@cloud.ionos.com>, 
	Geoff Levand <geoff@infradead.org>, Michael Reed <mdr@sgi.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Narsimhulu Musini <nmusini@cisco.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	Vishal Bhakta <vishal.bhakta@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, xen-devel@lists.xenproject.org, 
	Bart Van Assche <bvanassche@acm.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000037bc720653f80bd1"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,multipart/alternative,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1216-lists,target-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kbusch@kernel.org,m:hch@infradead.org,m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:James.Bottomley@hansenpartnership.com,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,m:aradford@gmail.com,m:khalid@gonehiking.org,m:aacraid@microsemi.com,m:willy@infradead.org,m:hare@suse.com,m:fischer@norbit.de,m:linux@armlinux.org.uk,m:linux-arm-kernel@lists.infradead.org,m:fthain@linux-m68k.org,m:schmitzmic@gmail.com,m:anil.gurumurthy@qlogic.com,m:sudarsana.kalluru@qlogic.com,m:oliver@neukum.org,m:aliakc@web.de,m:lenehan@twibble.org,m:ram.vegesna@broadcom.com,m:target-devel@vger.kernel.org,m:linuxdrivers@attotech.com,m:satishkh@cisco.com,m:sebaddel@cisco.com,m:kartilak@cisco.com,m:liyihang9@h-partners.com,m:don.brace@microchip.com,m:storagedev@microchip.com,m:linux@highpoint-tech.com,m:tyreld@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@us.ibm.com,m:lduncan@suse.co
 m,m:cleech@redhat.com,m:michael.christie@oracle.com,m:open-iscsi@googlegroups.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:kashyap.desai@broadcom.com,m:shivasharan.srikanteshwara@broadcom.com,m:chandrakanth.patil@broadcom.com,m:megaraidlinux.pdl@broadcom.com,m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:mpi3mr-linuxdrv.pdl@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,m:daniel@thingy.jp,m:gotom@debian.or.jp,m:yokota@netlab.is.tsukuba.ac.jp,m:jinpu.wang@cloud.ionos.com,m:geoff@infradead.org,m:mdr@sgi.com,m:njavali@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:nmusini@cisco.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:pbonzini@redhat.com,m:stefanha@redhat.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:vishal.bhakta@broadcom.co
 m,m:bcm-kernel-feedback-list@broadcom.com,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:xen-devel@lists.xenproject.org,m:bvanassche@acm.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,oracle.com,kernel.dk,hansenpartnership.com,vger.kernel.org,gmail.com,gonehiking.org,microsemi.com,suse.com,norbit.de,armlinux.org.uk,lists.infradead.org,linux-m68k.org,qlogic.com,neukum.org,web.de,twibble.org,broadcom.com,attotech.com,cisco.com,h-partners.com,microchip.com,highpoint-tech.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,us.ibm.com,redhat.com,googlegroups.com,thingy.jp,debian.or.jp,netlab.is.tsukuba.ac.jp,cloud.ionos.com,sgi.com,marvell.com,microsoft.com,lists.linux.dev,epam.com,lists.xenproject.org,acm.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sumit.saxena@broadcom.com,target-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.saxena@broadcom.com,target-devel@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_GT_50(0.00)[83];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[target-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 007DD670F90

--00000000000037bc720653f80bd1
Content-Type: multipart/alternative; boundary="000000000000294eed0653f80b73"

--000000000000294eed0653f80b73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:06=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Wed, Jun 10, 2026 at 09:16:11PM +0530, Sumit Saxena wrote:
> > The motivation for this change stems from performance issue we
> > encountered due to false sharing of the 'nr_active_requests_shared_tags=
'
> > counter
> > on certain CPU architectures. I initially submitted a patch to move tha=
t
> > counter to
> > its own cache line to avoid conflicts with 'nr_requests' and other hot
> > fields
> > (see:
> >
https://patchwork.kernel.org/project/linux-scsi/patch/20260402074637.92417-=
3-sumit.saxena@broadcom.com/
> > ).
> >
> > During the review, Bart shared his work, which eliminates the
> > counter entirely by removing the fairness throttling. My testing
confirmed
> > that
> > this approach resolved the performance issues and improved IOPS.
> > This patch is part of a larger set, and I have reported the cumulative
> > performance
> > improvements in the cover letter.
>
> So the problem is just the atomic operation accounting overhead? I
> previously thought the device just really needed to consume all the tags
> to hit performance.
That's correct, it's the atomic operation accounting overhead.

Thanks,
Sumit

--000000000000294eed0653f80b73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Jun 10, 2026 at 10:06=E2=80=AFPM Keith Bus=
ch &lt;<a href=3D"mailto:kbusch@kernel.org">kbusch@kernel.org</a>&gt; wrote=
:<br>&gt;<br>&gt; On Wed, Jun 10, 2026 at 09:16:11PM +0530, Sumit Saxena wr=
ote:<br>&gt; &gt; The motivation for this change stems from performance iss=
ue we<br>&gt; &gt; encountered due to false sharing of the &#39;nr_active_r=
equests_shared_tags&#39;<br>&gt; &gt; counter<br>&gt; &gt; on certain CPU a=
rchitectures. I initially submitted a patch to move that<br>&gt; &gt; count=
er to<br>&gt; &gt; its own cache line to avoid conflicts with &#39;nr_reque=
sts&#39; and other hot<br>&gt; &gt; fields<br>&gt; &gt; (see:<br>&gt; &gt; =
<a href=3D"https://patchwork.kernel.org/project/linux-scsi/patch/2026040207=
4637.92417-3-sumit.saxena@broadcom.com/">https://patchwork.kernel.org/proje=
ct/linux-scsi/patch/20260402074637.92417-3-sumit.saxena@broadcom.com/</a><b=
r>&gt; &gt; ).<br>&gt; &gt;<br>&gt; &gt; During the review, Bart shared his=
 work, which eliminates the<br>&gt; &gt; counter entirely by removing the f=
airness throttling. My testing confirmed<br>&gt; &gt; that<br>&gt; &gt; thi=
s approach resolved the performance issues and improved IOPS.<br>&gt; &gt; =
This patch is part of a larger set, and I have reported the cumulative<br>&=
gt; &gt; performance<br>&gt; &gt; improvements in the cover letter.<br>&gt;=
<br>&gt; So the problem is just the atomic operation accounting overhead? I=
<br>&gt; previously thought the device just really needed to consume all th=
e tags<br>&gt; to hit performance.<div>That&#39;s correct, it&#39;s the ato=
mic operation accounting overhead.</div><div><br></div><div>Thanks,</div><d=
iv>Sumit</div></div>

--000000000000294eed0653f80b73--

--00000000000037bc720653f80bd1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ifscJ8gSasrjdgcsGC9lCyPXLwfNEU5C3Mbnua8OK6sTBpf6mvY88HW/6AoKiSpfo5jxCZQOm4Zz
oJWD5ea7ThJ2XdDk1rRtGUkwFgN9GRNfOoiIwkkA7EdEfV0eQkVqNgkqUyBSABXcduul2sd4/JQO
SsVmTdSKid7L6yZsqk5b3Xj+GMJwPdRfeKP2SRoys0SVnajc9Di+9Jy7uGKxxtb562egZauDFX/0
o0UgYfZrbwWfzJDYMLKzlrOD0M8yGkD8BnyIiVECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZc3VtaXQuc2F4ZW5hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQURSmmYGaiq6dg3CEvXQGHEXJF
8xwwDQYJKoZIhvcNAQELBQADggIBAAl0pcCjujKdwmgtiGl2naEY5wB4G601Kuu3032tR7wmgZLg
k+lg9fhAA0boPsi1FE1Pwb93YDBGr/naS/oQ9JglSMeEVzeRvCqjFS4FpouBAFHB77c8w3ZwJ3+t
FSRJW9SbW0DADBn5t8GAjv2aSm5vDorqFe9MKOYEe50yYDQEUAsEt5QkrLTcEx9ntvVb25MxI8vM
bdfqna+/TyCmFmnGAz58jiw5DxLn++6wMmAk0SeUEuMrAlRIyhte6BBSBQ5cL1P+DWSqQbm/pwCq
NhySSLNtTi2dKJvvg6Ax9au913KiJj6uZfPlh6/0kaVKM5GhIABUcm3c6g2qD7ITJxB/p1kjYKLa
hVrtrjK7000lHKTPFr6MWB4Ggx7yKQ9yIlPMKKF/Lj8FabYCqeM5ovG7kaK8FYXug5vjNjN0nedR
X3P8o+8aL6WFIAAAKm2DqZh3252Gcken8v5c+f0SXWSJFvemfFNgrJiQFnFVrOE5v7qwvM/KvVCA
dYm4Ph9QYI0sm+Xitx8MkdOJtq5mcPWowGi8UiCgkOidv4ki1SA0wptfquUhbfS9b2M3XUHCEIUX
4ECvIjR3f+E0NbBIfPccWfYUaDLvo2qhLYS3KQbhKdXcJ83ha17mbVNZbDDo9upNcLO/oPyDbCNF
J6UpXZmis1wnCynhK4kQfwFhW7H+MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMdI2Nfq/Vk8dzZMUnMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBgNfCS
txCUmh9RVm3ywWZ+FqUrhzMno4QjbIxP56bEHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA2MTExMDQ0MjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA4a94UH1n8Q6oB/bStbW3ay+559D8DevwSDQGM4pzx
YvFHxranMU8DCmF3wRjpr7OT19xPbxEmYvuFyy1qK8WnJYcZK5+3OaFgW4Q9+M27QrNQuhkeXBsn
KDxNid4QqOD1wDZKmePV3euKKF81Kep8eCZPLII7hVbBQ/OeCd1LU6jde54CMGFm45kIUKgfQxLI
lyXcG/vw10DPi3K6THNvA+QSYWXcyylarB1UgSiRxT/qn2G4JDDpZxGHexmaiqE+UQKDBj8K11k3
9w5dyXpp6wY/Ua9Y99FzSb1fRBZFDcyrRsQr6sn8ZJL5ZvUK93sSc2x59Pc4eIJoehPCE+dU
--00000000000037bc720653f80bd1--

