Return-Path: <target-devel+bounces-1293-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 690PFw3LVWqdtQAAu9opvQ
	(envelope-from <target-devel+bounces-1293-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Tue, 14 Jul 2026 07:37:17 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB14751333
	for <lists+target-devel@lfdr.de>; Tue, 14 Jul 2026 07:37:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=suksangroup.co.th header.s=default header.b=fJnf1HKX;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1293-lists+target-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="target-devel+bounces-1293-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=inbox.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4971A301830C
	for <lists+target-devel@lfdr.de>; Tue, 14 Jul 2026 05:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB39299A87;
	Tue, 14 Jul 2026 05:31:37 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC5332610
	for <target-devel@vger.kernel.org>; Tue, 14 Jul 2026 05:31:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007097; cv=none; b=pCNqPNoEdcAzvH2ozc0Rd4FKUN4lRL0PX8oYaTZQzARugEULvEKgROR6kkmM/Uv9Jc3vCSp5Rq+LrcvAXb7NBkYm72jOypLWFKakYrYIqK24lxMksaY6ISDwczB0yzd4lsF9tLsQX5QJMc+r0M6DcBdDi4NKovIUo+0xEHGH6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007097; c=relaxed/simple;
	bh=bGYUnpSQpEquBQPwRF8fR1SDGghdQ+6rKQPPerlf8FI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mm7bN5f7E2A8JaovV3ebtHdYdwqvoAug+AJq+PfnXmERha7Hw85vswD55fBYrPjWyoeBAl98X1JVxQo9QmsmCp67S+ZohbOEp+lJM8KqLKPfYNGIY2wFbwz5XH2uB0CdwJoMjwmaoAXdVS1m0mmE8tqSMAiGQO+oGfcnxf9KOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=fJnf1HKX; arc=none smtp.client-ip=103.13.31.55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bGYUnpSQpEquBQPwRF8fR1SDGghdQ+6rKQPPerlf8FI=; b=fJnf1HKX+Z5Fw+mUa5/MI3fB7A
	+HuA1ubqab1y8pP7ZKvu1BhLzfM+C07B1MfRqYqrJ6XliNYuo3R41xr/Y7PY/dVzEn2rINmO/I0aQ
	VwVEYKhBI8qyqFf/0nUM2YKTDjkgGbqB/KtRZqLFbavYjziFtH1iPuipKSwnWGrVSdZ9Mn5yxzy/a
	iaHP1HWzvLthVX3gjfWsyhnI/VRMF2d+gDWndJ6j7b7wW6zcHbg0ax7GujOYVbEft/MfGS2y5EPee
	hGHzx0zsZghg6LgoTfK26x0zayDxA6oZdLYuUuTo3NVGkYrsKOvYNwWTksiCs7vS3WEVdXIBFQf93
	ePVXlfbQ==;
Received: from [207.189.26.187] (port=65383)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVjz-0000000G25b-0SP9
	for target-devel@vger.kernel.org;
	Tue, 14 Jul 2026 12:31:34 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: target-devel@vger.kernel.org
Subject: Dear target-devel@vger.kernel.org, 
Date: 14 Jul 2026 00:31:30 -0500
Message-ID: <20260714003130.E72555F637C9528D@inbox.org>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: add header
X-Spamd-Result: default: False [6.44 / 15.00];
	ABUSE_SURBL(5.00)[lexcapitalgrowth.com:replyto];
	R_DKIM_REJECT(1.00)[suksangroup.co.th:s=default];
	SUBJECT_ENDS_SPACES(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[inbox.org : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:target-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-1293-lists,target-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[smtp@suksangroup.co.th];
	GREYLIST(0.00)[pass,body];
	HAS_X_SOURCE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_GMSV(0.00)[smtp@suksangroup.co.th];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[info@inbox.org,target-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[hanns.schofield@lexcapitalgrowth.com];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@inbox.org,target-devel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[suksangroup.co.th:-];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lexcapitalgrowth.com:replyto,vger.kernel.org:from_smtp,inbox.org:from_mime,inbox.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEB14751333
X-Spam: Yes


Re:Good day target-devel,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA



