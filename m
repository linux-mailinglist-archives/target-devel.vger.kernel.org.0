Return-Path: <target-devel+bounces-1062-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAeZIcrP1GksxwcAu9opvQ
	(envelope-from <target-devel+bounces-1062-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Tue, 07 Apr 2026 11:35:06 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A283AC19E
	for <lists+target-devel@lfdr.de>; Tue, 07 Apr 2026 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA05A301EC44
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2026 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09E939B4AB;
	Tue,  7 Apr 2026 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ohY++nDb";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="yF0gIe0p"
X-Original-To: target-devel@vger.kernel.org
Received: from mta-01.yadro.com (mta-01.yadro.com [195.3.219.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25B328243;
	Tue,  7 Apr 2026 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.219.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554360; cv=none; b=Dlgjp94GSpAJzm7xeRTxn5hOy2+VnStdZ1iTxZQ7jGBoOQ9YOhfIiIMtPIP/Fvx6bGQlPMiLV5+YnSqt/DQ4XgquCKP9zUaeIr/eanPXDj5zWBTJJdYRNvXnEkz6v3W51TZuW6tWyRkWmk8/Nj/DYeZmcbKjYm2809kUXmZZG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554360; c=relaxed/simple;
	bh=8vgLIKwJHSQVK84Zdi4dvp/u2JmanG3cbH/E7ax1M+c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUtf5E9aY2AktydeZ+mrGedTt7PhMXVnhbwys9WwDB62Jhzhe8XFaXvuagQ5MZYcGpLTEb7+UP5E5zR5L9Ah+VmRnEkrjSJCGqeB83mnwKgep0pFWe/WKXsxVW5DH1RvUaPNIpEnCM3K+kBhO7HANVCwgYNqMX3e4lbP8Byq8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=ohY++nDb; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=yF0gIe0p; arc=none smtp.client-ip=195.3.219.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 7390420010;
	Tue,  7 Apr 2026 12:23:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com 7390420010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1775553831; bh=DFC5qLBjE0wQFL8BSRIUJ6gmqz4hfjXW0IrN4wNM5PU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ohY++nDb8DsBwsa/tgKLaw8VYl+ID4395glW+lxk81RhOec1UO5MSjPiBULadWIp/
	 iAtmkk52+O4/uj3scQ5S6eWImQHkk7tUThvWqofZOokNJ7+wMkCP3msTa2beOnXErx
	 4nJWxgtWEJhStSs7gCnIJfFfsW3fxej3VtwlfQ6tkOvwzQD1sf7JPYuSG1dJ9WR148
	 Cyl3h24byf3IEs1jDNBolTYhYxoZ4I7E/FPdlMsIuWuFoq4XmLi4K7tqLoZNwOWX2l
	 gju/+0/St3dS6u1EeEXeMN+kItcXJSRU6ivqCwGo/ObI3Tt8zNPMF2KN7huMphe6FA
	 x8/RjTdghtTcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1775553831; bh=DFC5qLBjE0wQFL8BSRIUJ6gmqz4hfjXW0IrN4wNM5PU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=yF0gIe0pak3k6vP7p2DQ+ELda+32LLQShQLmqjEBFSUYsZkWfV/s2NpCrXBiC882O
	 imsAOvI+2rB06IS60VpTeeDpWJqJZkOVdegA8i6KMpr6bL8ek1yoTNmbna+wBoorq2
	 E97XO0Q2PqdZKkxlwp3BXw/LyXuPmgtdeH3UyYTQsGjjwlZyJTBHD0cBqsp9T8P6Ed
	 tryagE1hOtynMGv2gs2oKe47svopZTk3ytbwZhLiKFQFe/g0mBom8QAfowWeKybFyP
	 eRSVa9pziiCUsYeH2vVA/4MC2azE1/ZBqB++d81Vhk2f4Rtr7Badt2D3GXgPyQnIxE
	 X1zfs5SnxnHSQ==
Received: from RTM-EXCH-06.corp.yadro.com (unknown [10.34.9.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 12:23:49 +0300 (MSK)
Received: from yadro.com (10.34.9.247) by RTM-EXCH-06.corp.yadro.com
 (10.34.9.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Apr
 2026 12:23:56 +0300
Date: Tue, 7 Apr 2026 12:23:57 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: <carlos.bilbao@kernel.org>
CC: <martin.petersen@oracle.com>, <kees@kernel.org>, <pabeni@redhat.com>,
	<mlombard@redhat.com>, <kuniyu@google.com>, <michael.christie@oracle.com>,
	<linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bilbao@vt.edu>
Subject: Re: [PATCH] scsi: target: iscsi: reject zero-length Extended CDB AHS
Message-ID: <20260407092357.GA974@yadro.com>
References: <20260404014429.115807-1-carlos.bilbao@kernel.org>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260404014429.115807-1-carlos.bilbao@kernel.org>
X-ClientProxiedBy: RTM-EXCH-04.corp.yadro.com (10.34.9.204) To
 RTM-EXCH-06.corp.yadro.com (10.34.9.206)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/07 08:50:00 #28379041
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yadro.com,reject];
	R_DKIM_ALLOW(-0.20)[yadro.com:s=mta-02,yadro.com:s=mta-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yadro.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1062-lists,target-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d.bogdanov@yadro.com,target-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,yadro.com:dkim,yadro.com:mid]
X-Rspamd-Queue-Id: 00A283AC19E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 06:44:29PM -0700, carlos.bilbao@kernel.org wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> 
> If ecdb_ahdr->ahslength is zero, two bugs follow:
> 
>   kmalloc(be16_to_cpu(ecdb_ahdr->ahslength) + 15, ...)
> 
> allocates 15 bytes, but the immediately following memcpy writes
> ISCSI_CDB_SIZE (16) bytes into it, a one-byte heap overflow. Also:
> 
>   memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
>            be16_to_cpu(ecdb_ahdr->ahslength) - 1);
> 
> (u16)0 - 1 promotes to (int)-1 which converts to SIZE_MAX as size_t,
> causing a massive out-of-bounds write.
> 
> Reject ahslength == 0 with ISCSI_REASON_PROTOCOL_ERROR before the kmalloc.
> 
> Fixes: 8f1f7d297bce ("scsi: target: iscsi: Add support for extended CDB AHS")
> Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
> ---
>  drivers/target/iscsi/iscsi_target.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index e80449f6ce15..8db24d35c762 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -1100,6 +1100,8 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>         cdb = hdr->cdb;
> 
>         if (hdr->hlength) {
> +               u16 ahslength;
> +
>                 ecdb_ahdr = (struct iscsi_ecdb_ahdr *) (hdr + 1);
>                 if (ecdb_ahdr->ahstype != ISCSI_AHSTYPE_CDB) {
>                         pr_err("Additional Header Segment type %d not supported!\n",
> @@ -1108,14 +1110,19 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>                                 ISCSI_REASON_CMD_NOT_SUPPORTED, buf);
>                 }
> 
> -               cdb = kmalloc(be16_to_cpu(ecdb_ahdr->ahslength) + 15,
> -                             GFP_KERNEL);
> +               ahslength = be16_to_cpu(ecdb_ahdr->ahslength);
> +               if (!ahslength) {
> +                       pr_err("Extended CDB AHS with zero length, protocol error.\n");
> +                       return iscsit_add_reject_cmd(cmd,
> +                               ISCSI_REASON_PROTOCOL_ERROR, buf);
> +               }
> +

For a complete solution please add a check that AHS fits in the buffer.
ahslength must be less or equal than ((hdr->hlength * 4) - 3).

> +               cdb = kmalloc(ahslength + 15, GFP_KERNEL);

It took some time to recall what did 15 mean. May be make it clear for
everyone too?

u16 cdb_length = ahslength - 1 + ISCSI_CDB_SIZE;
cdb = kmalloc(cdb_length, GFP_KERNEL);
memcpy(cdb, hdr->cdb, ISCSI_CDB_SIZE);
memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb, cdb_length - ISCSI_CDB_SIZE);

>                 if (cdb == NULL)
>                         return iscsit_add_reject_cmd(cmd,
>                                 ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
>                 memcpy(cdb, hdr->cdb, ISCSI_CDB_SIZE);
> -               memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
> -                      be16_to_cpu(ecdb_ahdr->ahslength) - 1);
> +               memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb, ahslength - 1);
>         }
> 
>         data_direction = (hdr->flags & ISCSI_FLAG_CMD_WRITE) ? DMA_TO_DEVICE :
> --
> 2.43.0
> 

