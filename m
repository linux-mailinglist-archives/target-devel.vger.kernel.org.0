Return-Path: <target-devel+bounces-373-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BFCA7D703
	for <lists+target-devel@lfdr.de>; Mon,  7 Apr 2025 09:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097FE3B9F0A
	for <lists+target-devel@lfdr.de>; Mon,  7 Apr 2025 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9BE227BA5;
	Mon,  7 Apr 2025 07:53:39 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from bsdbackstore.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39694224B1B;
	Mon,  7 Apr 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012419; cv=none; b=D4G601GnpjP4/CzaRuAt5E8K0YnYVpxWm0jkWyUuCZzkAhTxOAXMr6xY/FppdYADzLI41/AecEcfaE2vGu5biebnF7jeSU89Eqvc9Trkt3YJj/NVxerzQ7zJNqwNWBvXl+cOPDQKwidLKQ6jyTLmLBY1o20qpd48ioQKRSbViSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012419; c=relaxed/simple;
	bh=kQpk2AEhWdEDddyXK5JyOrU800Y1u3TPWe1XZ7f8JmU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Co4Y3AsN1AfP59QhKRjnf1h5buPep6wHAoVaP9UM4OgbFNqZx4/plRzSgir0r37i1N9a/pUvb0/WSWnwiRawPVEVrKC8LBLRWMdsTEFqiiK+VR/42FPmFDG/7BB0gts0BrjdGO+LW+cGGZAyGAim+iYOr8wN3GJ9OjhFzto2roE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu; spf=pass smtp.mailfrom=bsdbackstore.eu; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdbackstore.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsdbackstore.eu
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 42774c35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 09:53:22 +0200 (CEST)
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Apr 2025 09:53:20 +0200
Message-Id: <D908SSFL0E9D.24WXC0I3O6AQB@bsdbackstore.eu>
Cc: <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v4] scsi: target: transform strncpy into strscpy
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Baris Can Goral" <goralbaris@gmail.com>, <martin.petersen@oracle.com>
X-Mailer: aerc
References: <20250402204554.205560-1-goralbaris@gmail.com>
 <20250405143646.10722-1-goralbaris@gmail.com>
In-Reply-To: <20250405143646.10722-1-goralbaris@gmail.com>

On Sat Apr 5, 2025 at 4:36 PM CEST, Baris Can Goral wrote:
> The strncpy() function is actively dangerous to use since it may not
> NULL-terminate the destination string,resulting in potential memory
> content exposures, unbounded reads, or crashes.
>
> Link:https://github.com/KSPP/linux/issues/90
> Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
> ---
> Changes from v4:
> 	-Description added
> 	-User name corrected
> 	-formatting issues.
> 	-commit name changed
>  drivers/target/target_core_configfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/targe=
t_core_configfs.c
> index c40217f44b1b..5c0b74e76be2 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -143,7 +143,7 @@ static ssize_t target_core_item_dbroot_store(struct c=
onfig_item *item,
>  	}
>  	filp_close(fp, NULL);
> =20
> -	strncpy(db_root, db_root_stage, read_bytes);
> +	strscpy(db_root, db_root_stage, read_bytes);
>  	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
> =20
>  	r =3D read_bytes;
> @@ -3664,7 +3664,7 @@ static void target_init_dbroot(void)
>  	}
>  	filp_close(fp, NULL);
> =20
> -	strncpy(db_root, db_root_stage, DB_ROOT_LEN);
> +	strscpy(db_root, db_root_stage, DB_ROOT_LEN);
>  	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
>  }
> =20

This patch doesn't apply anymore.
strncpy() has already been replaced with strscpy()
in version 6.14-rc2.


Maurizio

