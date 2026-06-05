Return-Path: <target-devel+bounces-1173-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GZvxB+bBImojdQEAu9opvQ
	(envelope-from <target-devel+bounces-1173-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Fri, 05 Jun 2026 14:32:38 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3486482E6
	for <lists+target-devel@lfdr.de>; Fri, 05 Jun 2026 14:32:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XDDERx9H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Xa/EAFdk";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XDDERx9H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Xa/EAFdk";
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1173-lists+target-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="target-devel+bounces-1173-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99A533019100
	for <lists+target-devel@lfdr.de>; Fri,  5 Jun 2026 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF394DC524;
	Fri,  5 Jun 2026 12:20:49 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F24DC539
	for <target-devel@vger.kernel.org>; Fri,  5 Jun 2026 12:20:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662049; cv=none; b=JMrYTgqLZyUdQxzrQtj3AbEgE9mVKHytaj7KOGK6t7cEyVHRbdKokg5RTdDeNYHnGn8pFckcGFmM/Oe2PX5eFnKURcJJ5Y8oYovcRtcl4BCq4/8rGuOjmwvfUv0csYJJAdpMOTRoI61Jl89SPWLg3+Z7wUD70GgDov5KCdl+LPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662049; c=relaxed/simple;
	bh=ibKNO52YGT6WNEblHTxWIVM60UYi/hMbFlTX1NjpUaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRfh+eU/VIik7zED0V+8cHzVGfC08NIywvIPyqtjXiabBQ3dTmnMngfGmCW23fepzmrlAQyRpE0I2i57IhbVMQwq+TnGhTMyrpvPI1Ig7DS/QtCFmEF6HrWxjMQzj9smbjKRPnIYFUURQNJ8/C+oCtc/eNpXhwiTwIs0evMCKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XDDERx9H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xa/EAFdk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XDDERx9H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xa/EAFdk; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC6AF6B32D;
	Fri,  5 Jun 2026 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780662041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on5GKOOQpZJuM+ohg7G3v4T9lq9wS2TTONgaTri1Y3Q=;
	b=XDDERx9Huw9V18tzVDWOjRSiSOVJKOeeYrgA1guQJkbhv1gWigSURi4/tiKaO0dNnusCM8
	pORnCQB31xYMLVjSBgiI1NiIDW1trre8X9jvkRXuL6wNvabb//bob3ycO2DrphkHjMnfWT
	gb6oz52Tsrg9pCfuGI9E38TXPoYADBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780662041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on5GKOOQpZJuM+ohg7G3v4T9lq9wS2TTONgaTri1Y3Q=;
	b=Xa/EAFdkUjul/Gww2pjjSC3SenmZ1vQ7QlZ7DeWglp689qzjqRrw6OeGlSEfLyp3ilKbtJ
	eZ6LmjA8dm4z7ZBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780662041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on5GKOOQpZJuM+ohg7G3v4T9lq9wS2TTONgaTri1Y3Q=;
	b=XDDERx9Huw9V18tzVDWOjRSiSOVJKOeeYrgA1guQJkbhv1gWigSURi4/tiKaO0dNnusCM8
	pORnCQB31xYMLVjSBgiI1NiIDW1trre8X9jvkRXuL6wNvabb//bob3ycO2DrphkHjMnfWT
	gb6oz52Tsrg9pCfuGI9E38TXPoYADBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780662041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on5GKOOQpZJuM+ohg7G3v4T9lq9wS2TTONgaTri1Y3Q=;
	b=Xa/EAFdkUjul/Gww2pjjSC3SenmZ1vQ7QlZ7DeWglp689qzjqRrw6OeGlSEfLyp3ilKbtJ
	eZ6LmjA8dm4z7ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68ED1779A8;
	Fri,  5 Jun 2026 12:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6CivCBi/Imr3TwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 05 Jun 2026 12:20:40 +0000
From: David Disseldorp <ddiss@suse.de>
To: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/2] scsi: target: use constant-time crypto_memneq for CHAP digests
Date: Fri,  5 Jun 2026 22:16:48 +1000
Message-ID: <20260605122019.24146-3-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605122019.24146-1-ddiss@suse.de>
References: <20260605122019.24146-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1173-lists,target-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:target-devel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:ddiss@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ddiss@suse.de,target-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,target-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,suse.de:mid,suse.de:dkim,suse.de:from_mime,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE3486482E6

A constant-time memory comparison is more suitable than plain memcmp()
for authentication digest comparison.
CHAP digests use an authenticator-provided random challenge, so any
timing side-channel shouldn't be easily exploitable.

Reported-by: Sashiko (gemini/gemini-3.1-pro-preview)
Link: https://sashiko.dev/#/patchset/20260521151121.808477-1-hossu.alexandru%40gmail.com
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/iscsi/iscsi_target_auth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index 5858cc3089796..f3c0cdd318300 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -9,6 +9,7 @@
  ******************************************************************************/
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/err.h>
@@ -408,7 +409,7 @@ static int chap_server_compute_hash(
 	pr_debug("[server] %s Server Digest: %s\n",
 		chap->digest_name, response);
 
-	if (memcmp(server_digest, client_digest, chap->digest_size) != 0) {
+	if (crypto_memneq(server_digest, client_digest, chap->digest_size)) {
 		pr_debug("[server] %s Digests do not match!\n\n",
 			chap->digest_name);
 		goto out;
-- 
2.51.0


