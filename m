Return-Path: <target-devel+bounces-1126-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFmNB/alC2qRKQUAu9opvQ
	(envelope-from <target-devel+bounces-1126-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Tue, 19 May 2026 01:51:18 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2FF5752E9
	for <lists+target-devel@lfdr.de>; Tue, 19 May 2026 01:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 174FD3018748
	for <lists+target-devel@lfdr.de>; Mon, 18 May 2026 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA933B6CB;
	Mon, 18 May 2026 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ciah3Nw2"
X-Original-To: target-devel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C71331A41
	for <target-devel@vger.kernel.org>; Mon, 18 May 2026 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148267; cv=none; b=an8w9MWBwY7HwzlaI3FdkSI/uPfnVeRDBLtB79IEh9UH3+IWFohjdO9WHvdrK8Zo5laTiOx1iHWeLQtJlpmXfYWEDibAJNqQQ4EOaWRLdD0NndJzmlQa2OhcQbV38iZ9Ffst7JCsuvSHYINqaLIMzAC/gb5QBw3LOZU8X42OsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148267; c=relaxed/simple;
	bh=oHzqtxHYGtsFWWs1IIVZkaaC0dsURSMDJdI1EptB08Q=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqxKn9hiZ5q9WW1LnNy70ifFGPqwJoL4uK/ArJnQ4fYUQ/URH0ES8jYaE4maVEx5kqjvFWKK/lnnyrJFSpIlEehfRXH5kiUWVH9BEZKiM+JVV0oaG6lgU9Zj+bgrE+M9l6bVUH6YugSeyfPlGRzTyqGply8q33AnrBVXP6DIbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ciah3Nw2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso3752917a12.2
        for <target-devel@vger.kernel.org>; Mon, 18 May 2026 16:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779148264; x=1779753064; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHzqtxHYGtsFWWs1IIVZkaaC0dsURSMDJdI1EptB08Q=;
        b=Ciah3Nw2xdOjcg3w3zBcgShZ+S2a32iIm6TT/7UCDctORSU9A1oFXCLWRiPVu7quwL
         DQnONi/AmCqEf6+i3vfQVAadZsVyW9ulr3FTd3S74EqkIjpUBusmdF7UgMvolLQkW8x3
         FocarObjL7BAof4v287V0tRUiwwKcINFa8q4XgigacbMAoConEBa1vWOkqvtqW7I9lgc
         o1vX/Yi6HtPvE0VmbAl1dgWidsAsmzUSEiyt4Q6Zo1z4fclvpclhGOvK94QOf6C5R4GV
         KFRKKrsfff8gsFRixT5X4B9Fa5+Z5eWztsygea3fKVV2FRFIeThYkwwAqFaJFTWV6fGo
         Ay+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148264; x=1779753064;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHzqtxHYGtsFWWs1IIVZkaaC0dsURSMDJdI1EptB08Q=;
        b=qhkH2RbZYFd2MXCuw+o+2Ka8rfteFxuCKu6pqIKACKvp0nk22tfWCl9iTtYoQA+DAO
         473hBh4awXYPyW4XaybhKDAla5F5QOWGnAyjCOwp8boDeTquIyh50zat5/VxTJAf7UPd
         mag0/b6QBWcBocAwTu35I0jSgMX+T3uJ+yCXZLRwudqysEAuFulIls5s4pECCzAS5X9t
         pZZe75Sc56wmm6BqVVlUtGpa0Q7nONoQhtFtys+NHFOIXZBtqRYZgTxi25tFxf7r4/dp
         Q55oR0xL9R5SHL1b76kT6gdEE4b4NfDbB7zijCjPVETE/R9eaGdSAHnazgOIYpkxi6dt
         ZzOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8M4r8h0eqPVnPYDgPzqdlgEYdNx+5+zJ1Li0wbsVrx5PbuFgaRXviCkMKTGM+YD7CEA/eWMs453B0jP4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fWa19c8tJmpIoyAmzN4KaVizbLycnMDQv/0I3q1EfIN2Oj2V
	NudoGWCLgn1RoPqm5aZ/U5fiF00QgimxcuVaosLMLw8OAWH0xpUHTpCN
X-Gm-Gg: Acq92OGWHfhSTlIyTB3HK21tfPo98HTMKtsv2CO8FII2ez4dcPO8g37hEBHg6yz7YHH
	ntSl8cfDw8nWULkTL1jZEd1rsW99lsfkLB52618Syk8fmjo25SohYIbtvkF+G2FiI5nMx8rPhti
	o3gl7jEcGof1cAHAkahBfgKId0vW0IVm2q0gCbE/LnBqkVzABpZ1tXLBNDP1Cxuku+9RwcgBluB
	t3HO7StkjupOZJI8pWnC+tIn9o79tVSNcAy40RS0c0QehSTaAl1VBCjkb5ZvO/8pFWeG/ZkF8PK
	LvU/CRv5o8WusO5LufTIkVzSeSGy4q4Ktk3606PJyYn7M/s2ZNqDOp1p+cSTMl0COuDm6pRTmhs
	EJ6ohUwmZL6qFcfvAEQVxfbPVBGap/ZsqWMosnFFZKAFX1JG9NtizbUvB5uSs1XlHDBVw/V84Zf
	fH2nOWA5hSwIs3nNn+nFWKAi+cieCn7KERw8HEBbNMh0G6ZGLhBTmqF+I3x6yqTtMX3/W2FiU64
	JeYIs7rfH+dh3qU/nLlfLLM0tNLYK1TROXNEWzlq322h3JKYEMAeL9MnQ+Sq0Slw8AnEx1bD71q
	wFPdqQa7FYmbj36Iry0Z3RJrJ3o6
X-Received: by 2002:a05:6402:46d6:b0:678:b2c5:6915 with SMTP id 4fb4d7f45d1cf-683bd38be0dmr8809786a12.22.1779148264415;
        Mon, 18 May 2026 16:51:04 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d58c79sm5829140a12.12.2026.05.18.16.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 16:51:02 -0700 (PDT)
Message-ID: <6a0ba5e6.cd541789.157749.6e89@mx.google.com>
Date: Mon, 18 May 2026 16:51:02 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: ddiss@suse.de
Cc: martin.petersen@oracle.com, bvanassche@acm.org,
 target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org, hossu.alexandru@gmail.com
Subject:
 Re: [PATCH] scsi: target: iscsi: validate CHAP_R length before base64 decode
In-Reply-To: <20260518121811.385350-1-hossu.alexandru@gmail.com>
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,acm.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1126-lists,target-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,target-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Queue-Id: 8D2FF5752E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 19, 2026, David Disseldorp <ddiss@suse.de> wrote:
> nit: this could be DIV_ROUND_UP(chap->digest_size * 4, 3) to match
> base64.h BASE64_CHARS(), right?

Yes, equivalent and will use it in v2.

> The above check doesn't appear to catch undersize base64 CHAP responses,
> unlike the hex path. How does that affect the handshake?

An undersize response decodes to fewer than digest_size bytes.
chap_base64_decode() returns cp - dst, which is less than digest_size,
so the existing != digest_size check at line 345 fires and the handshake
fails. The result is the same as the hex path.

> Finally, don't we need a similar check for the mutual CHAP code-path?

The mutual path decodes CHAP_C into initiatorchg_binhex, allocated as
kzalloc(CHAP_CHALLENGE_STR_LEN) = kzalloc(4096). extract_param() caps
the input at CHAP_CHALLENGE_STR_LEN characters, so at most 4095 base64
chars reach the decoder, producing at most 3071 decoded bytes. 3071 < 4096,
so the destination cannot overflow. The post-decode > 1024 check is a
semantic limit on challenge size, not a safety net against overflow.

v2 with DIV_ROUND_UP below.

Alexandru

