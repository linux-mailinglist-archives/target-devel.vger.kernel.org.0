Return-Path: <target-devel+bounces-394-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52DA9DD36
	for <lists+target-devel@lfdr.de>; Sat, 26 Apr 2025 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775AB92380A
	for <lists+target-devel@lfdr.de>; Sat, 26 Apr 2025 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467EF1F91C5;
	Sat, 26 Apr 2025 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g83zWtzu"
X-Original-To: target-devel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69318C01D
	for <target-devel@vger.kernel.org>; Sat, 26 Apr 2025 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745702688; cv=none; b=OHioQRJBummX9rUFhSf6ivbnp9pKebmHyWwYOUGMdOTwDn/Zbmqkinj+ZE8jVi4q3X9vc/0N56H6UBkZVogzNAYNQLtQNvhlvGHFvNijesl+x0ymhAYnmBCrw5ze9qt4FcwuRkYaxxD1tjSeydPaX9OIxoYF5a19HWmXdLeWm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745702688; c=relaxed/simple;
	bh=Dg3fCarQHR/JTqvGhOBfZR+xsGq8DTqd0lvEpfJG5Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkPz699UZyi+az+ChFbmbHqObEC0uqbP1K0fDaL/yGdVIOnr99lfBiYNifhd6oFzt3M4mcHx0s+r39nwf0/NPq8knkpRwXR8tZihWkM/mUyCOOCEX9vS+pzeJbYvlCTB9nm2jMLU08KxTPk+SHy01rPHyMLp/ojDdFwbV7kGnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g83zWtzu; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso35825931fa.1
        for <target-devel@vger.kernel.org>; Sat, 26 Apr 2025 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745702683; x=1746307483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1mqAIBnp7KMTnNYtwdmaVxEXl0tUjHzIuN2rlUSfs8=;
        b=g83zWtzuFZFO+Vqj29C01+uQQf515igBwWI/IV3sCGAgUyki5q20OgFlJhio7tTuuK
         k4TqMJKLQcKcciKqJtytQF52SCqGO2wb6XDeYXBZEDIgBoPPGYl7ZehnVaFSjuqK3ZnR
         +Y9u7A5nwkZfKjmXmROG2h0lZUQr4/0Y9JhgCeJOJks0lQrEIBMch4XdS10QPSy0J/bp
         DOvCxeaTL/br3NuP/1pHZJkseo/1z19VaNPltTvSHrhgg3N8bUCZtc1MmL6JGN4oiIn+
         2bS6I2sOmJQWR7rMt4AkebVr2GJG3+vjR16/dOU1cmJhcDQ+h80YKJZ+clyC+2zG9Wz4
         2N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745702683; x=1746307483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1mqAIBnp7KMTnNYtwdmaVxEXl0tUjHzIuN2rlUSfs8=;
        b=XSkJNFuVHlTgTBlnyEzER9ZeOMlrGAeJsJPvWWiH6vqem1BQCxehwX5+AMerHox7lV
         2fOiVX6Dr7s8S0fdzD46Z7Uku0L4D6Ycwh+EU2CzL5QUJ2b0oxyn6ph5DkvxSmzSGAcA
         8vDFZ9uEdvgRlPOMw6Z4iNytz0qpoHQ7Yluhc3h834L2tpZmagYBtwQjQ+X7ZlL9e1oX
         J2nzdJ0rrCPPn5hwInEI2fHDvxfzo6MfvQK35OPIQPEriTUkOTyX1kL5X1Q5t8ybfjo2
         Uqr6lEtt0jA3rXfLA17nV8utgirjo3zgOm262nQDBQ59d1FB3fmYiqpGQDt2OzaaQiE6
         01nw==
X-Forwarded-Encrypted: i=1; AJvYcCU0bdxWhh4jcmEtJl561xah0yEwE+TdEOMJnUiRhd1SsMzDnKyGPchoJTBys9DUJRA/2Dj+dSQEn5poGSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2oGTl5p+IDzBLtlWLWiMRAANlmdqOB3doBJia5vaqfQxN/j1J
	Ot0kL0SCNFi2NsWZ9RggWD7aKCzWos63u7hdIi6qthdfxTeQ40jOYcoY9fSbnY6gol50E3uN6Vm
	fVld2NQumeTY5Y1Mkwn7uiWtbn4vJxnVgVyAA5w==
X-Gm-Gg: ASbGncvT1r169jjCoRKyMESD/+5S+PB/JT30celjyl3Bp6BltHASNgDVTGbAtMvWlVB
	5/iYU/k79saH1b2aaHtpp+x3dhOxaZjoI4b81+hD6qSXenB7uEIdo2dnr1Jpuyh8VPGi+lqpoLn
	MTDTw43PE1hNvf/n932V7Vy7zKSHUaoQiMYw==
X-Google-Smtp-Source: AGHT+IFJMmStyVBuIyxQECB5iELQPgDUnywD2WJ46nDL9IgJLHD7iPOWbRPUoe3umTLlnkE5eoleE6r364MYg9Jxl1Q=
X-Received: by 2002:a05:651c:222a:b0:30b:9f7b:c186 with SMTP id
 38308e7fff4ca-317cc3b4c3dmr33874231fa.1.1745702683231; Sat, 26 Apr 2025
 14:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304181400.78325-1-thorsten.blum@linux.dev>
In-Reply-To: <20250304181400.78325-1-thorsten.blum@linux.dev>
From: Lee Duncan <lduncan@suse.com>
Date: Sat, 26 Apr 2025 14:24:32 -0700
X-Gm-Features: ATxdqUFRXwxiD0AZ10vGLZVX25IArlcs-9mCmM5d-L5qj3q4zIK9ecGpSwHodS0
Message-ID: <CAPj3X_VKZz_8oq0puSuh96_=ozR+t8xL_whb5+UaNYS0MOrpKw@mail.gmail.com>
Subject: Re: [PATCH] scsi: target: Remove size arguments when calling strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:30=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> The size parameter of strscpy() is optional because strscpy() uses
> sizeof() to determine the length of the destination buffer if it is not
> provided as an argument. Remove it to simplify the code.
>
> Remove some unnecessary curly braces.
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/target/target_core_configfs.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/targe=
t_core_configfs.c
> index c40217f44b1b..9b2b9786ce2f 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -673,12 +673,10 @@ static ssize_t emulate_model_alias_store(struct con=
fig_item *item,
>                 return ret;
>
>         BUILD_BUG_ON(sizeof(dev->t10_wwn.model) !=3D INQUIRY_MODEL_LEN + =
1);
> -       if (flag) {
> +       if (flag)
>                 dev_set_t10_wwn_model_alias(dev);
> -       } else {
> -               strscpy(dev->t10_wwn.model, dev->transport->inquiry_prod,
> -                       sizeof(dev->t10_wwn.model));
> -       }
> +       else
> +               strscpy(dev->t10_wwn.model, dev->transport->inquiry_prod)=
;
>         da->emulate_model_alias =3D flag;
>         return count;
>  }
> @@ -1433,7 +1431,7 @@ static ssize_t target_wwn_vendor_id_store(struct co=
nfig_item *item,
>         ssize_t len;
>         ssize_t ret;
>
> -       len =3D strscpy(buf, page, sizeof(buf));
> +       len =3D strscpy(buf, page);
>         if (len > 0) {
>                 /* Strip any newline added from userspace. */
>                 stripped =3D strstrip(buf);
> @@ -1464,7 +1462,7 @@ static ssize_t target_wwn_vendor_id_store(struct co=
nfig_item *item,
>         }
>
>         BUILD_BUG_ON(sizeof(dev->t10_wwn.vendor) !=3D INQUIRY_VENDOR_LEN =
+ 1);
> -       strscpy(dev->t10_wwn.vendor, stripped, sizeof(dev->t10_wwn.vendor=
));
> +       strscpy(dev->t10_wwn.vendor, stripped);
>
>         pr_debug("Target_Core_ConfigFS: Set emulated T10 Vendor Identific=
ation:"
>                  " %s\n", dev->t10_wwn.vendor);
> @@ -1489,7 +1487,7 @@ static ssize_t target_wwn_product_id_store(struct c=
onfig_item *item,
>         ssize_t len;
>         ssize_t ret;
>
> -       len =3D strscpy(buf, page, sizeof(buf));
> +       len =3D strscpy(buf, page);
>         if (len > 0) {
>                 /* Strip any newline added from userspace. */
>                 stripped =3D strstrip(buf);
> @@ -1520,7 +1518,7 @@ static ssize_t target_wwn_product_id_store(struct c=
onfig_item *item,
>         }
>
>         BUILD_BUG_ON(sizeof(dev->t10_wwn.model) !=3D INQUIRY_MODEL_LEN + =
1);
> -       strscpy(dev->t10_wwn.model, stripped, sizeof(dev->t10_wwn.model))=
;
> +       strscpy(dev->t10_wwn.model, stripped);
>
>         pr_debug("Target_Core_ConfigFS: Set emulated T10 Model Identifica=
tion: %s\n",
>                  dev->t10_wwn.model);
> @@ -1545,7 +1543,7 @@ static ssize_t target_wwn_revision_store(struct con=
fig_item *item,
>         ssize_t len;
>         ssize_t ret;
>
> -       len =3D strscpy(buf, page, sizeof(buf));
> +       len =3D strscpy(buf, page);
>         if (len > 0) {
>                 /* Strip any newline added from userspace. */
>                 stripped =3D strstrip(buf);
> @@ -1576,7 +1574,7 @@ static ssize_t target_wwn_revision_store(struct con=
fig_item *item,
>         }
>
>         BUILD_BUG_ON(sizeof(dev->t10_wwn.revision) !=3D INQUIRY_REVISION_=
LEN + 1);
> -       strscpy(dev->t10_wwn.revision, stripped, sizeof(dev->t10_wwn.revi=
sion));
> +       strscpy(dev->t10_wwn.revision, stripped);
>
>         pr_debug("Target_Core_ConfigFS: Set emulated T10 Revision: %s\n",
>                  dev->t10_wwn.revision);
> --
> 2.48.1
>
>

Reviewed-by: Lee Duncan <lduncan@suse.com>

