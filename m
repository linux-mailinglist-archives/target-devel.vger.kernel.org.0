Return-Path: <target-devel+bounces-124-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C968809C0
	for <lists+target-devel@lfdr.de>; Wed, 20 Mar 2024 03:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DDF2857E9
	for <lists+target-devel@lfdr.de>; Wed, 20 Mar 2024 02:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C4335DB;
	Wed, 20 Mar 2024 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FpK80cf2"
X-Original-To: target-devel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83B2AD13
	for <target-devel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902555; cv=none; b=n1gsEIWcnuIKqYIRPwbuQ02Q2B83daW6qBBZBpdHVHh250bBixczRAegqQZN0Ueg1OBbV3I1CtW+1QRWAJyd3WiwlOgKPCec37tjJZiLYu86sgNGkyDLHucE/hvss1dVNlCEL9LZZOblm3RuQE+PdWEQkf6UbxzDMw8HuVfFs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902555; c=relaxed/simple;
	bh=s7xt3J/x1P5iR0tIyAeOfFanpdd7tKxd4ngYLSRwbIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+b9xI1UWN+RFUikBR8HVjXyBuCrzemwXKPaxe4Xi7LL4HkbGi7UzM3zN3P1UTQ4N3FNLszuPcJyipMNy2frNEEH/sCOSeEjWx+NQRbJtli8ARp8QnLrATL10zKMgbkoUAwS38+5bTWgDlqbLgwHoidemnDwjz0JkRhiSJqIGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FpK80cf2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6aa5c5a6fso5958318b3a.0
        for <target-devel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902552; x=1711507352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2Ii+qg5LzdQ72UpZAw1asNIZXswSUTe3sjnBVEowPI=;
        b=FpK80cf2hM+7NsrMo3H6/99ZxSX+fOtbFEkSaWi8p3DN2NqOxOHPtTOkYEavLFkjT5
         YXJaHKy6FKA12ArFyKOD9WEx+X6Z3d+QJbdN6O6TvYVK3+E1BnOTYovb9pY3ngHxO6Jc
         Fc16DNvtVH5bddpkenEerj37o+ETzsWjyW4dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902552; x=1711507352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2Ii+qg5LzdQ72UpZAw1asNIZXswSUTe3sjnBVEowPI=;
        b=TXzdbmJ45Uy6vLTKDpulMirHnMYMRSg3VkFx8JFLaSMvd2UdN2sCUaWfXRPxjgnfKA
         Miyl8ccRBr8MFPecuQQYbGFmO/HAMR74ouT6aFXyhfCtAcvgKi4QNeM5/ww0JlMC4xk/
         LvNMv109ccTMZsdqRGFn3uwAohfanCyorY3bX56GphwMFjyvBA4YArD8/2GtXh1b9N2B
         BcJcnNMHEBsBmAh7tz6xRe4k2S3tp3KvuDlIYqWw6hMWCWcP8t5B5lU/l23vkESe88Gv
         n7kMsE+zk8SsJDy8lwieB3+rqozaA1Bsft1asSM1atiThRRnkBDYnaWb395izRmDerr2
         En1A==
X-Forwarded-Encrypted: i=1; AJvYcCWVHEVHWWiFXBJhnoFAV/eDKbk1t4CLXzgrMJF9dilGoNwYhS+WcsqGb7HlopJClt9UyFclIYnlngO+PrsfPUDpoTs4vCs4j9xFVhuz
X-Gm-Message-State: AOJu0YwQuH3KC0b/7en1RJMfmR6ZleRK4Tf7sMd44uQRwoFt9EDudI/7
	jMgf1yJju6QYbbbGojVF1M2+T9zvDtQHqfVD0lJXp7ViyHh6WnYvhk7lk4dawg==
X-Google-Smtp-Source: AGHT+IFJ3mimqhyXJl6uZ2iBD7JX313NaQ7js3fa+uG7RNJZ8WFe7D0jn4BJmpYU7bSd6VfpiwLGDg==
X-Received: by 2002:a05:6a00:21cc:b0:6e7:20a7:9fc0 with SMTP id t12-20020a056a0021cc00b006e720a79fc0mr9982708pfj.34.1710902552625;
        Tue, 19 Mar 2024 19:42:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r10-20020a056a00216a00b006e6eb8e07edsm10032341pff.50.2024.03.19.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:42:31 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:42:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: target: core: replace deprecated strncpy with
 strscpy
Message-ID: <202403191941.D2818DB@keescook>
References: <20240318-strncpy-drivers-target-target_core_transport-c-v1-1-a086b9a0d639@google.com>
 <202403191908.1B6BBA3@keescook>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403191908.1B6BBA3@keescook>

On Tue, Mar 19, 2024 at 07:23:43PM -0700, Kees Cook wrote:
> Hm, this actually fixes potential over-reads and potential memory content
> exposures (in the face of malicious/weird hardware) since p_buf_len
> appears to always be sizeof(p_buf) in callers, which means the old use
> of strncpy() could have left the string unterminated.
> 
> In practice I would assume it's not a problem, but, for example, here's
> a place where the 254 p_buf_len could run out when doing the sprintf:
> 
> #define VPD_TMP_BUF_SIZE                      254
> ...
> #define INQUIRY_VPD_DEVICE_IDENTIFIER_LEN       254
> ...
> struct t10_vpd {
>         unsigned char device_identifier[INQUIRY_VPD_DEVICE_IDENTIFIER_LEN];
> 	...
> };
> ...
> int transport_dump_vpd_ident(..., unsigned char *p_buf, int p_buf_len)
> {
> 	...
>         unsigned char buf[VPD_TMP_BUF_SIZE];
> 	...
>                 snprintf(buf, sizeof(buf),
>                         "T10 VPD ASCII Device Identifier: %s\n",
>                         &vpd->device_identifier[0]);
> 	...
>         if (p_buf)
>                 strncpy(p_buf, buf, p_buf_len);	// may write 254 chars and no NUL

Wait, no, it's safe; I got confused by the double buffers. The
snprintf() will always NUL-terminate, so "buf" copied into p_buf will
always be NUL terminated.

So, nevermind! Regardless, still a good conversion. Thank you!

-Kees

-- 
Kees Cook

