Return-Path: <target-devel+bounces-1246-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9AZWKPm6RGrfzgoAu9opvQ
	(envelope-from <target-devel+bounces-1246-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Wed, 01 Jul 2026 09:00:09 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 032D56EA66A
	for <lists+target-devel@lfdr.de>; Wed, 01 Jul 2026 09:00:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=eik3WZ68;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1246-lists+target-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="target-devel+bounces-1246-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BA00305DACA
	for <lists+target-devel@lfdr.de>; Wed,  1 Jul 2026 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46523B5DED;
	Wed,  1 Jul 2026 06:58:40 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F013B4EA2
	for <target-devel@vger.kernel.org>; Wed,  1 Jul 2026 06:58:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889120; cv=none; b=bqUGiNWJXV5AKxvn7CHBtf95MBMWkS7By1oKhIYMtl9cycWFNKygOxCXfemSdybSZPLhmCcvZ4gGdQnjJKlgmiflPfWFi1D7Bz81qb7a9g2hi4edy5eBCz82vnCt/hDIRCmQVCAjA6UnH3ftpN+QtXo0KorQb8vojM6FfDGIVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889120; c=relaxed/simple;
	bh=4/PJ5lsWF3Afw+ToM28IlvUIg6tJ1pzhObLbDR7BvMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTalIQmEikuW0j3BJI9rTk9ZpQiFgpuH/HJrKLcA7qK5zwk6TvXsqh1/VUSCUqE603YIEE8CEBsZZdfhYo9/mxHSciMZbL/BEK5+5h7yCv8dj5eVQvAFBW61P5P+R4T8EDEBmbFrDfxgPpHN21iIw1hvsZEfeJwxlPiR36elv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eik3WZ68; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4759b4f0897so185773f8f.1
        for <target-devel@vger.kernel.org>; Tue, 30 Jun 2026 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782889117; x=1783493917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6Htvg5E3KMoFbz7ZumeUAsKal7KTQSoqOUgZpdirn4=;
        b=eik3WZ68aZwuvvJAFOAxtHJVhbCx5343pj2kEwr1pls1NootrMVLmyBnpDZzmE3Wsi
         I9/dbBNuWPV+9X35qY2wUiuYXt6aBfkg6EQxkoE9jBgNyT5sHEJMxyliJVXLTy4ObzO3
         5zTRsequk+bWD0iOrPLihazJ83x/b+eoaZV4l3frRh3s12HwS4DvstylWMcrfBgW/EXY
         SFhzDdAfH2ZT5txtEhgOW2fXY+p/Qd8MJqTVL5EQfw4lbzcBK8vWmq9yyJgBl8/EWMVB
         IL6FeUHM8Z4kUNUfX8E2nWbKVdifvpLHglAqq09yE2ov6YMKh3qxWFqtDrINYS/GGotX
         y1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889117; x=1783493917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6Htvg5E3KMoFbz7ZumeUAsKal7KTQSoqOUgZpdirn4=;
        b=YH9vmoVFvMZ+qmDAUdy1763sj8Ql41tsFKvn5ZGBmjCGLjKbi6RgRln4s0zNMqagT8
         7HEAbZRnlfrPf4ByxbOFUoHmI2Ln+XCVVM8zE96z0ZC1ny9hTYdbwMcBi36IJfNLfeRl
         ltdMOS1mEuvBnxeSHF9W4jxD+RSLCz2INVvpKy4hy9aPI4wGOjiSzldduoGXFT1lco0G
         p5X93jahAZL9EFRLGYFiNLZvwxPCpwtx1IE1zs/Kqri0lPyQvu7sgojH9jkwL5tWyTsH
         SCem5SO5HaaCWHXsftQba47UgmCG0o/P2UExDzcNeT266qmKvErhFV6JBVBb5lp8GG0Q
         VS/A==
X-Forwarded-Encrypted: i=1; AHgh+RqbFOtqoxF0Cu2rOgRqDH1kprh1b5j6kcA8wXdKTW2cDjbYN3el8uM2MzdHrn65qGKE1VgRqSXOUMzxdsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIPQNC+8pvD2p3LN/uWh/4KW87PdZbs/5x4AHpttYE97pNPqYF
	j9ikPVErSnFNw0tO8aWdGel8KMDHjRZk9EvfU6PGCMlmYCGqcFKqNdLDGcpWwymL1vg=
X-Gm-Gg: AfdE7cm25qaq5b3h09ndgzhlIh7nLB/Pni1y2zC58BdDHHwhyQaiTESYRuv/7k8/+Zf
	1RfAM2RSGKidD8Yv4YEsjD8h5bsM/GeKTGgRokrJFrspEVhnXgW966hMaaVUV8oheaC7IOx3J7W
	DijgKEXO3O0LdU1/7cnUErZgxv6AQozaOeUOwF8gbJnBM3BCE/sdGqoErg78cNrdrS45JO7ncq0
	d3YZUCMjXCdOZ91G0VmR5Pkh1IaVnEgxAs88Co0e0Ay428vJHVUNGodqybOtgXT70whHZvySCeH
	7QqGBmbZYkx8NXbJ2a6ter+eTKdR5K1IRJ4B5zq8UuP/nU3hGyeEissFYitu3JGZlby7ZU9gXHg
	KYsQvFIk75kI1nTvMGSHP8rGg1fELPKTGfKUeZXl2NXrPpgE/k90Rq+bWbhrPMwyFtoYWlzHoTW
	rUSDffNMxOkKH7m/fXLjta0msnyktDF2Sd0BY3WBa8Np4dTg4=
X-Received: by 2002:a05:6000:2612:b0:43f:e2b7:7160 with SMTP id ffacd0b85a97d-477574b0599mr505149f8f.4.1782889117243;
        Tue, 30 Jun 2026 23:58:37 -0700 (PDT)
Received: from ?IPV6:2001:a62:1403:d01:fcc2:cfc6:9af3:a0c1? ([2001:a62:1403:d01:fcc2:cfc6:9af3:a0c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-476792758aasm7184096f8f.11.2026.06.30.23.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:58:36 -0700 (PDT)
Message-ID: <a56251e3-0b1c-4844-8b9e-033f77216c63@suse.com>
Date: Wed, 1 Jul 2026 08:58:36 +0200
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] scsi: proc: use kmalloc() in proc writers
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Brian King <brking@us.ibm.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
 <20260630-b4-scsi-v1-2-494fb37ebe7b@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260630-b4-scsi-v1-2-494fb37ebe7b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1246-lists,target-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.com,target-devel@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:martin.petersen@oracle.com,m:brking@us.ibm.com,m:James.Bottomley@HansenPartnership.com,m:willy@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,target-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 032D56EA66A

On 6/30/26 12:54 PM, Mike Rapoport (Microsoft) wrote:
> proc_scsi_host_write(), proc_scsi_write() and proc_scsi_devinfo_write()
> allocate temporary buffers for /proc writes using __get_free_page().
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Replace use of __get_free_page() with kmalloc().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   drivers/scsi/scsi_devinfo.c | 4 ++--
>   drivers/scsi/scsi_proc.c    | 9 +++++----
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

