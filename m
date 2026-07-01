Return-Path: <target-devel+bounces-1247-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2DYLMLW7RGoWzwoAu9opvQ
	(envelope-from <target-devel+bounces-1247-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Wed, 01 Jul 2026 09:03:17 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 539246EA6E2
	for <lists+target-devel@lfdr.de>; Wed, 01 Jul 2026 09:03:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=X8zvc0Kw;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1247-lists+target-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="target-devel+bounces-1247-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B44793017BAF
	for <lists+target-devel@lfdr.de>; Wed,  1 Jul 2026 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF23B42EE;
	Wed,  1 Jul 2026 07:03:13 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF433911AA
	for <target-devel@vger.kernel.org>; Wed,  1 Jul 2026 07:03:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889393; cv=none; b=elRMf8a5Yna8bNuq3Hl9dY4xdmv1kGC2oRTTmRrnfb82BIyszdXJUj96bDYHxr3wthahdqZfrZxCL80objYH7vPQmHKGEU19ewyYcyPcBp3YrCuBbgYNigcBAIuLK6QC43KTtDmbXU9bT68YqpVwu2Wi/vy0rAoZzgPRm2W87pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889393; c=relaxed/simple;
	bh=HAGRqxc7KIHCCdEKJ9mGxAxGOM1MdtRInQuffYvOB5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AE5rsmNbwWxjkW7BkdMwfQtCE26kn+GSD3NJKMT5pq7bkjAUo7oLAR4jl6kY1vDdyHMyFzrbb/kEK1g1mhp8llVD1WVrsA4SQQ2xCO6DPTak30N0IJjyLuE4T7zo6nqelPWq1PrTiWahr815v9En91gvfGd0mDnf0f7I0VJsugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X8zvc0Kw; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493be1b9682so1976785e9.2
        for <target-devel@vger.kernel.org>; Wed, 01 Jul 2026 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782889388; x=1783494188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEOzJcjGcAIJl3Tht4vVazVfDVw0cfWuXCgpWa0S2Ng=;
        b=X8zvc0KwsgzjfXbOHm9pCvX7x+IwcXEsYhYcAqoG8ehDir4bg1VUpSTknZbahKjwWV
         EpbFU+Bsw991B5LjBUmJXNKtZfR3NmCXmu3SPNeT/GGtXVzpFm4g/ZS7YkGhAyU7yuCJ
         4wd/itNz+D7TYCx1bt5LqQdRsbZrZ0waAwYAWfeRxLV16fh7U3DKbWI4VwTcsQUM35Uf
         gXdz9mCakGToVkR/+qBTI7hsm/XhGP7e5OckHrv6QUOcX8PUauRXQ+cJwumoER/DN1EX
         e7csiO3c6ReyPPu6J5+WFdk5cln3hgKkN1hP/fVCpVg+eDfeR5OM1G9ZiLu+s9Rqtz09
         i3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889388; x=1783494188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEOzJcjGcAIJl3Tht4vVazVfDVw0cfWuXCgpWa0S2Ng=;
        b=CLlP2OxnMfJS6VVFwayqJTQWheeZc6nkqICNvD49YjsMZFv5J6UgJRKH9Tx3UEZAoC
         LypgRRS2yIG+uSYnEexs149Canp27m/RnRpj/hA5mfUCipnw+/I7X7YBtW3f7ahbhNFP
         +GE6M/Y4MMXi3nFiqSjoFJJern4+69UMqvZeULF50WofrtMPbQnKNgeWJbEbR580/SAi
         nub6zWwyW/Lv7wM2/Pg5nUJMz5o7EqXDNuA2l0P+YsVdiwHQ1SA19fPH2X4KdFIH75qy
         /EPSItdyv7SGW/2kHF30ljE/wpxqnbrd/HDt51/oybDBNf6bciRvMI18INrFQWuUV/5W
         QxXA==
X-Forwarded-Encrypted: i=1; AFNElJ9pbIwoIWiIg/vhK7ASUU0SJ0OXueIyL11pwcUbme78qYN0TSZxz5AzgFtdB0wHS309ZWA9q/XtlCLp8XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6c9lopSeXJR6d3LCd84qP2P4SmJIpU0V5MvTpTT0F5W6s8GD
	pUxm8ZwrhdsaobE2N5U3JvbLMg6+iVhiYulMH7ddGi0RvQd047iBoiVa/70RW80SVfA=
X-Gm-Gg: AfdE7cmulwKSk13ZsgH7/fdYpqbBer75Mv3lHfU1dXyqaAlw1TRdaUcvdygGEZ+DAiU
	Xcamcv4ZxJjdexz9bztbtb4qKRcRmRwcBD8OB6uVBawypPHdQwn0mnMmRZ78XGK+DHZ53mfIA1D
	SR/qNqsSdwqUNSZ1nS01vLw6QNStB3yJr2csJ3Wze2MUQ8meBIZ5A7h9kDCJ7nkbxc7F35Vjvpt
	Alj7g6RbF+BTbz1XgKan6aG2IyY8mV050DLncWEBYJChFRTCY+KV3mB6nRnIM9zvd35kaAddsO4
	qsupYOeAptuZtT6Pdm7WTPJ7VG3CY/CRDm4leYAkBUbMgv96TpQG3DcEn6p+PTCKss3GDb5fgsR
	QTVNHTnoSemVmlmiUFteuypo9MWmJVNtKgREnRFAQ69i5Np4gIxlu8GR5OSMuidLUjdQ0TSeTmc
	joflN9I8ZKqDjGHjZYQUGLsRW1E2I0ngnN7NdL+742shk7Zvw=
X-Received: by 2002:a05:600c:3501:b0:490:d079:2919 with SMTP id 5b1f17b1804b1-493c2b4ce3cmr5715935e9.14.1782889388047;
        Wed, 01 Jul 2026 00:03:08 -0700 (PDT)
Received: from ?IPV6:2001:a62:1403:d01:fcc2:cfc6:9af3:a0c1? ([2001:a62:1403:d01:fcc2:cfc6:9af3:a0c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf98sm10981027f8f.22.2026.07.01.00.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:03:07 -0700 (PDT)
Message-ID: <7c8f0e70-f49c-4614-af95-002fb2be11ba@suse.com>
Date: Wed, 1 Jul 2026 09:03:06 +0200
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] scsi: ipr: use kmalloc() to allocate IPR dump buffer
 memory
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Brian King <brking@us.ibm.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
 <20260630-b4-scsi-v1-3-494fb37ebe7b@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260630-b4-scsi-v1-3-494fb37ebe7b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1247-lists,target-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 539246EA6E2

On 6/30/26 12:54 PM, Mike Rapoport (Microsoft) wrote:
> IPR dump machinery allocates memory to save adapter's crash dump using
> __get_free_page().
> 
> This memory can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Replace use of __get_free_page() with kmalloc().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   drivers/scsi/ipr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index d207e5e81afe..5a212bfdeec2 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -2893,7 +2893,7 @@ static int ipr_sdt_copy(struct ipr_ioa_cfg *ioa_cfg,
>   	       (ioa_dump->hdr.len + bytes_copied) < max_dump_size) {
>   		if (ioa_dump->page_offset >= PAGE_SIZE ||
>   		    ioa_dump->page_offset == 0) {
> -			page = (__be32 *)__get_free_page(GFP_ATOMIC);
> +			page = kmalloc(PAGE_SIZE, GFP_ATOMIC);
>   
>   			if (!page) {
>   				ipr_trace;
> @@ -3226,7 +3226,7 @@ static void ipr_release_dump(struct kref *kref)
>   	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
>   
>   	for (i = 0; i < dump->ioa_dump.next_page_index; i++)
> -		free_page((unsigned long) dump->ioa_dump.ioa_data[i]);
> +		kfree(dump->ioa_dump.ioa_data[i]);
>   
>   	vfree(dump->ioa_dump.ioa_data);
>   	kfree(dump);
> 
I _think_ we can replace this with kvmalloc, and allocate the entire
dump buffer in one go. Once switched to kmalloc() it's kinda pointless
to allocate separate page-sized buffers here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

