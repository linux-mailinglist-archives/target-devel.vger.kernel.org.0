Return-Path: <target-devel+bounces-1162-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +M7fKMHGHmr6UwAAu9opvQ
	(envelope-from <target-devel+bounces-1162-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Tue, 02 Jun 2026 14:04:17 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2662DCE8
	for <lists+target-devel@lfdr.de>; Tue, 02 Jun 2026 14:04:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1162-lists+target-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="target-devel+bounces-1162-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D8F6301D320
	for <lists+target-devel@lfdr.de>; Tue,  2 Jun 2026 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F0E3438B0;
	Tue,  2 Jun 2026 11:59:08 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766723D7DF
	for <target-devel@vger.kernel.org>; Tue,  2 Jun 2026 11:59:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401548; cv=none; b=WRb4b4cz3Fn7LnR6StoggzQQK6570iCc61TRT3l9B1urrXQYD8nhg0afsyBL7V2Nrt0X5DRptqesGMpibLS1XBdgtotXvjSGvXjnEvAeZOcmGKrhDTeaVbR9ZBmPj2uC2MBcssZuzukNCET6P6IA1tgjqW//z52TLeFED6xEU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401548; c=relaxed/simple;
	bh=Pw7j6rikG76+jCwZbryfmOO5D5knUhDkIZv1O24Hn8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/aX5n7CmsNNfy1A/zI47SOCEKKyYQSdisRrKqdGozkCCJYhd9mEBzlGlDBj5YEigGo3jlfbtr+KESFtgDmF65E9PxVnBa/Tu98UUGM5FxMOpLzbFiJB664KFu4PLapSu7WklG1uKE7jU09NHu2C8IYyqBwPi+QRN5L7zKR6k3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E53686817D;
	Tue,  2 Jun 2026 11:59:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80819779A8;
	Tue,  2 Jun 2026 11:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SIHNDoPFHmpvYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 02 Jun 2026 11:58:59 +0000
From: David Disseldorp <ddiss@suse.de>
To: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] scsi: target: add extract_param_str() helper
Date: Tue,  2 Jun 2026 21:43:57 +1000
Message-ID: <20260602115840.26490-2-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260602115840.26490-1-ddiss@suse.de>
References: <20260602115840.26490-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1162-lists,target-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:target-devel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:ddiss@suse.de,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ddiss@suse.de,target-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,target-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:from_mime,suse.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3E2662DCE8

The existing extract_param() helper, detects and strips any hex (0x/0X)
or base64 (0b/0B). This makes sense for some parameters, but not strings
such as CHAP_N.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/iscsi/iscsi_target_nego.c | 37 ++++++++++++++++++++++++
 drivers/target/iscsi/iscsi_target_nego.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index b03ed154ca34e..53b17d3cc86c3 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -98,6 +98,43 @@ int extract_param(
 	return 0;
 }
 
+/* same as extract_param() above, but don't interpret any type-prefix */
+int extract_param_str(
+	const char *in_buf,
+	const char *pattern,
+	unsigned int max_length,
+	char *out_buf)
+{
+	char *ptr;
+	int len;
+
+	if (!in_buf || !pattern || !out_buf)
+		return -EINVAL;
+
+	ptr = strstr(in_buf, pattern);
+	if (!ptr)
+		return -ENOENT;
+
+	ptr = strstr(ptr, "=");
+	if (!ptr)
+		return -EINVAL;
+
+	ptr += 1;
+	len = strlen_semi(ptr);
+	if (len < 0)
+		return -EINVAL;
+
+	if (len >= max_length) {
+		pr_err("Length of input: %d exceeds max_length:"
+			" %d\n", len, max_length);
+		return -EINVAL;
+	}
+	memcpy(out_buf, ptr, len);
+	out_buf[len] = '\0';
+
+	return 0;
+}
+
 static struct iscsi_node_auth *iscsi_get_node_auth(struct iscsit_conn *conn)
 {
 	struct iscsi_portal_group *tpg;
diff --git a/drivers/target/iscsi/iscsi_target_nego.h b/drivers/target/iscsi/iscsi_target_nego.h
index e60a46d348352..6b72edd2aef2e 100644
--- a/drivers/target/iscsi/iscsi_target_nego.h
+++ b/drivers/target/iscsi/iscsi_target_nego.h
@@ -13,6 +13,7 @@ struct iscsi_np;
 extern void convert_null_to_semi(char *, int);
 extern int extract_param(const char *, const char *, unsigned int, char *,
 		unsigned char *);
+extern int extract_param_str(const char *, const char *, unsigned int, char *);
 extern int iscsi_target_check_login_request(struct iscsit_conn *,
 		struct iscsi_login *);
 extern int iscsi_target_locate_portal(struct iscsi_np *, struct iscsit_conn *,
-- 
2.51.0


