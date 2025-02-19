Return-Path: <target-devel+bounces-328-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2AAA3C52F
	for <lists+target-devel@lfdr.de>; Wed, 19 Feb 2025 17:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA9E189C412
	for <lists+target-devel@lfdr.de>; Wed, 19 Feb 2025 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48B1FE443;
	Wed, 19 Feb 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZGGb0Ind";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r+Zk6/+D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qZC2bNmS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k1MXtq/O"
X-Original-To: target-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B21FDE0E
	for <target-devel@vger.kernel.org>; Wed, 19 Feb 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982954; cv=none; b=dwP9EdtO5ECXgx5uEmKRWsc+zRt9eB8+G12um53CqRS/0o+sX2NznphR/5WKrrAtcc8EMSWvK9KJnO/sujnUWX9b3yE67dqvfkgPvgxiMEWWkn0TUuJmUn4Pfm2rqpVWL4tI50GYpWI+z54o+CxrqNQSj9sj5gCNCVL2Uxxb/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982954; c=relaxed/simple;
	bh=NEy5oRe34vGEgflUHbrnnkMzEbTgbDB08dTN6+k9O+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emeCKuKCqHck840eYj1gks46GJmX75IaGYxs0C62T19Wn+R+TShpu1oiN9PFhouownyDMkOIWJDic2gKCQMCQjZKXaBTM+8p0Q2A7HOpIBEdBtFm0iU0U5KQ23tSYydco7vDxJH3DsEA2HOyz2A3lTjG0S+5gNhf7B2j+sgfEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZGGb0Ind; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r+Zk6/+D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qZC2bNmS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k1MXtq/O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8049E219AE;
	Wed, 19 Feb 2025 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739982949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmRUcqgOK7PL2tXyaSdmnUIS7a25CsYJYS3C0QDMLdY=;
	b=ZGGb0Indd3qBfP/iKMr6zjUkBaKbQdQFBeUgL2Ah+2wjOFEo0naFE2QRD8FKk2Ox4lDxY4
	VChyx+A1ug8cwp9zL9Ruhuyi1HXv99BNjxB28q+6yWC63DiWm03cTkGSAXs3kEZjYNXXUY
	InR4VYYApY26oR10B/BPHa8TpBxHrFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739982949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmRUcqgOK7PL2tXyaSdmnUIS7a25CsYJYS3C0QDMLdY=;
	b=r+Zk6/+D9TjsI+c96ihFYtBPVbF8OoVxisyiXHmPo7UsCr6B0wu/d+ftZjnfG/uKCMVBo/
	sFvEkSxjr204pbDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qZC2bNmS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="k1MXtq/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739982948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmRUcqgOK7PL2tXyaSdmnUIS7a25CsYJYS3C0QDMLdY=;
	b=qZC2bNmSjigIcYoQ468lflUoMszROW+RNNOsZAlzDOjpOkepn8Bj620wI5E2JSJcG8c8hf
	L1neAvqiQdwl/7dckI73xiRnOSSY4DyB8ffWW7LVsZfmRq+g8/C13LFbCNLrLrx3gXuw2Z
	mqzeJCksuyzPjfYmrCr/Sgqsn1uLD00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739982948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmRUcqgOK7PL2tXyaSdmnUIS7a25CsYJYS3C0QDMLdY=;
	b=k1MXtq/OhcgxFEjpYeVpxu8EPzRoKv0YEU8jIcQvyYL4kBd9a0WTeZO15PCwg2rOH664Cd
	FVLxcs60tEyEn7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09ABD137DB;
	Wed, 19 Feb 2025 16:35:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tlCyAGQItmeBSgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Feb 2025 16:35:48 +0000
Message-ID: <4469546d-37a5-4d1b-a74e-792c54e4c794@suse.de>
Date: Wed, 19 Feb 2025 17:35:47 +0100
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: mark bounce buffering as incompatible with
 integrity
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 target-devel@vger.kernel.org
References: <20250218182207.3982214-1-hch@lst.de>
 <20250218182207.3982214-2-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250218182207.3982214-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8049E219AE
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,oracle.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/18/25 19:21, Christoph Hellwig wrote:
> None of the few drivers still using the legacy block layer bounce
> buffering support integrity metadata.  Explicitly mark the features as
> incompatible and stop creating the slab and mempool for integrity
> buffers for the bounce bio_set.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   block/blk-settings.c | 5 +++++
>   block/bounce.c       | 2 --
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

