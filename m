Return-Path: <target-devel+bounces-857-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNhzIBJusWlVvAIAu9opvQ
	(envelope-from <target-devel+bounces-857-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Wed, 11 Mar 2026 14:28:50 +0100
X-Original-To: lists+target-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F62E264872
	for <lists+target-devel@lfdr.de>; Wed, 11 Mar 2026 14:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A0931225F5
	for <lists+target-devel@lfdr.de>; Wed, 11 Mar 2026 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161421EEA3C;
	Wed, 11 Mar 2026 13:22:37 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE1257825
	for <target-devel@vger.kernel.org>; Wed, 11 Mar 2026 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235357; cv=none; b=qQh4Kl/fjIhf87NNWXq/6Va5Eb4Sv2EHayr+3pFQ1bPdncl2hY6sRnxM8TEqRTXQrrNIUf+NX6trcyWuH7Tdy2cBAK0JQlhRodvGmPwHz2EZopi/jkZrBGJWQxV8kn31T4+Pka+VWOZFhLemwgu79uzmJhLZ69Z0b2KswP7/cVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235357; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exFlEHrklQ/48Rc/W+gv4e7pBD/oiAdpgcHrVtOmwfLLeDFkFhvtKVQkkS8WTilC6xIZiEsYVTaTenslzbGqosgNIPBBSXBvg920z9T1E19evedL3zlh2lLGbil+Ybkx0xkd7qMoMox3GT5BwSRmC7v3dXalOl64+x+a1nlO5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so8316851241.3
        for <target-devel@vger.kernel.org>; Wed, 11 Mar 2026 06:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235355; x=1773840155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=rBB7Lh2LjzZLxkJ+vd8bK+LYk8rTtqiGsCEMSXm0GcGDpoB5EgflVC5RaxdLXXBAmg
         W/OQ9dzhjZAJD//mO9xU8IuvkZjiqW0Kb+1JHTWIi4POlSBTAHkcezfFF4G1T4VtNHdY
         wTjcPPlqrStQ4NZdMvdH53YFeC1F2FlJY/I5Es+GdGoZ15u+1wJrrbxxcVD6xN+gVyrs
         5ywnMKBDwHjM7pvdg8kAVOtl6TvXwI7Y7qtiBUc71JiXWHo+bGrjL1VpIBoVlceEmENX
         Dv5z3C6RcymP8GYtuTcI/pK4Jo4AbFc3k0elv4TbZO/PB4r6L8YRhO+VjQxBFkE0ypX5
         5gAA==
X-Forwarded-Encrypted: i=1; AJvYcCX4UIakHexqKMXOsM7C2uXBkkBDCAmqMKUZeEI6cxxzKEBI25UbsOYMjecoPA4oFNMb1P8wHXnuN1JTUOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyib7aLJv86LVVbCG1lEu+4E7MczWaBImBD5PsC+Ou9CAz+b0bd
	LBEltX8wfb2D4tZcy6O3e+/Vn1lalYQN120kqjYTVQkpao40+9blr7AJsCaBiPE1ErA=
X-Gm-Gg: ATEYQzx9anxX2mxzemLsRVibe3KfvrxZ/lyWC2JfF1nJLO0JaDIsmoEMwYprEoC7vHF
	eA1cfz5xCwsGC6Ai4BB1vgeE3xjeMLHxS/ct0vn3Amgo8PqcTYz4+X73dGdK1UAeu2S/I0yGLh4
	iSzaMtdnBuMQIl2WRoDpSvIVQ30Jh1ZOWkWliK/XA2N57rocIQngerW0o9h6ZdQagFf10qkliUX
	s6EAFyJ1dNWCE5Hpr2h+llBSGjHqwYUZQlGnwxmAIxNy9fIzzlHUKf0e8S9VSt05D8J0+INpoZm
	tydRXSL2cktPyh8wcZM2QNC0G37+8qyztjkk2l0sdiPraiveXItTuIc2Oxyt57bUUp4S1uaAUE6
	NrHu3kUm/q94KCtYUSke9RC0+lE9tTbnNUPaSaymqR0EoFshJDd40xXkLPCd0PTBemtmyiujvi0
	Zg914K0oMgAQfzXwH5af9PwJMh/GTsv+U3FoEIERG86p2Y7eqs89aFMeyMcNYG
X-Received: by 2002:a05:6102:e07:b0:5ff:b684:f7c5 with SMTP id ada2fe7eead31-601debd34b6mr1005503137.8.1773235354757;
        Wed, 11 Mar 2026 06:22:34 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601deb0278csm662272137.11.2026.03.11.06.22.34
        for <target-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:22:34 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94acb3d6cceso7780763241.2
        for <target-devel@vger.kernel.org>; Wed, 11 Mar 2026 06:22:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqgYamiLMhEKYBdhz3pDzKwl6Ma0dlDouGEUZVtCIlibhncYkscIPcqCS4etcOPjln8N/PF9gaTgiTDIo=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0F62E264872
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-857-lists,target-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,target-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourceforge.jp:email,linux-m68k.org:email,avm.de:email,glider.be:email,mail.gmail.com:mid,libc.org:email,fu-berlin.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

