Return-Path: <target-devel+bounces-1281-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id awZvITYGUWpz+AIAu9opvQ
	(envelope-from <target-devel+bounces-1281-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Fri, 10 Jul 2026 16:48:22 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C573BE4C
	for <lists+target-devel@lfdr.de>; Fri, 10 Jul 2026 16:48:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arkamax.eu header.s=mail1 header.b=czEvk0s9;
	dmarc=pass (policy=quarantine) header.from=arkamax.eu;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1281-lists+target-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="target-devel+bounces-1281-lists+target-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4380330238D0
	for <lists+target-devel@lfdr.de>; Fri, 10 Jul 2026 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF332C957;
	Fri, 10 Jul 2026 14:44:57 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CBA29D260
	for <target-devel@vger.kernel.org>; Fri, 10 Jul 2026 14:44:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694697; cv=none; b=bWyhlnhqbJXM0sknJQ0Z3BEfyOWjETsG5hRMGaniCa3CjqBuwyo46/nFBJie8U/y14ll5+5QXnX+hhWIP4QDud2xZmn5WqOft3wr/0hCy54DfYDURnoFiIwsQ09l01zpO3f2C8ezevSgXkVDKxIf20lygjvVS0tz/HizSCHuhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694697; c=relaxed/simple;
	bh=mIxkibzeJC+U/zrP4DQQcWaSCK26u2bHcYe7Ycxupkk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=Bunlw1kxdffqro58msHDdvacOnTiBWajoQUvyIf3JHvcVfvxKgj0DWym+ylE3Op/3sBPlHCkl6F0G3NJnaFPomtpNETZaVA8GVXO34qN5KHyjOmnS5PyMX7sEUC7lP/Gri/L8KWKgvqbV6DR7DcWAe/tCcgZFarDrfUqkK1dMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu; spf=pass smtp.mailfrom=arkamax.eu; dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.b=czEvk0s9; arc=none smtp.client-ip=128.116.240.228
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=mIxkibzeJC+U/z
	rP4DQQcWaSCK26u2bHcYe7Ycxupkk=; h=in-reply-to:references:subject:to:
	from:date; d=arkamax.eu; b=czEvk0s9muV2WxaCrytfvV92rln5B9h1trJkJ/vATg0
	vkwfesF5Zg+quXZHV2dDWaFQNhjocdwhRwv79neDuYtgTn5UN4RdPgrg/zneZ8ubImmUsG
	cL0gg7GeRe7R/RMIffdJupJFTrSsYykYAlpJSf3qD6axp348pKbeJX7ZrVozK5VRpy61AT
	/XmknEoVCN4UPGKwK+jfrwZr2B9iVx4wq/vW6HvV8lqV0LjCq7tKnhYEjwc+Fwt/lZetZ6
	8LMCK+0YsHksLpcCad8dHU5L8deVm8GaYsy69QjsYEgYYAzDUaUPmK8cCFyPhGujPtaCJc
	jSnUWt4X0MHiNfDd79A==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 64c612a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 16:38:11 +0200 (CEST)
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 16:38:10 +0200
Message-Id: <DJUYUT1XN1D5.13A59JJEDQ1IN@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Russel Moos" <rmoos@dunaway.com>, "target-devel@vger.kernel.org"
 <target-devel@vger.kernel.org>
Subject: Re: TargetCli issue / bug
X-Mailer: aerc 0.21.0
References: <DM6PR13MB3907DA980830B2383DAB09EDA8FE2@DM6PR13MB3907.namprd13.prod.outlook.com>
In-Reply-To: <DM6PR13MB3907DA980830B2383DAB09EDA8FE2@DM6PR13MB3907.namprd13.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arkamax.eu,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[arkamax.eu:s=mail1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rmoos@dunaway.com,m:target-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mlombard@arkamax.eu,target-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1281-lists,target-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlombard@arkamax.eu,target-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[arkamax.eu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arkamax.eu:from_mime,arkamax.eu:dkim,arkamax.eu:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C80C573BE4C

Hello,

On Fri Jul 10, 2026 at 12:26 AM CEST, Russel Moos wrote:
> Hello,
>
> I was using your guide and discovered that when I try to create a portal =
for iscsi, I can create any portal I want except one with port 3260.
>
> For instance, I can create 10.2.70.250 3261 just fine, but if I try to us=
e 3260, I get errors like "Could not create NetworkPortal in configFS"

Could you look in dmesg if you see any error?
Can you tell me the targetcli and rtslib package versions installed on
your distro?

I tried the latest version of targetcli and I don't see any error:

/iscsi/iqn.20...5f3cdaaa/tpg1> portals/ delete ::0 3260
Deleted network portal ::0:3260
/iscsi/iqn.20...5f3cdaaa/tpg1> portals/ create 10.8.3.73 3260
Using default IP port 3260
Created network portal 10.8.3.73:3260.
/iscsi/iqn.20...5f3cdaaa/tpg1> portals/ delete 10.8.3.73 3260
Deleted network portal 10.8.3.73:3260
/iscsi/iqn.20...5f3cdaaa/tpg1> portals/ create ::0 3260
Using default IP port 3260
Binding to INADDR_ANY (::0)
Created network portal ::0:3260.
/iscsi/iqn.20...5f3cdaaa/tpg1> portals/ delete ::0 3260
Deleted network portal ::0:3260
/iscsi/iqn.20...5f3cdaaa/tpg1> portals/ create 0.0.0.0 3260
Using default IP port 3260
Created network portal 0.0.0.0:3260.

Thanks,
Maurizio

