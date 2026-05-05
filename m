Return-Path: <target-devel+bounces-1116-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIZeBuT6+WmNFgMAu9opvQ
	(envelope-from <target-devel+bounces-1116-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Tue, 05 May 2026 16:12:52 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFEF4CF262
	for <lists+target-devel@lfdr.de>; Tue, 05 May 2026 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF8BE301436A
	for <lists+target-devel@lfdr.de>; Tue,  5 May 2026 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640748032B;
	Tue,  5 May 2026 14:12:48 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B247F2EA;
	Tue,  5 May 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990368; cv=none; b=S4TnVcxdqCB2tsvxGe/wMzcYhD0M2+zrVSqhfr28Ou+LTOQvQRglUuRZ6fqHTtIByQTLL2agN4wavbec933MRy8lf5Pp2ToRqlvXZpZ+zmEiGhF3SS5U4MC82jgpziOSL1VQN7hq+NGN0ltLfBeQooYW0SbjJ5tQLuh5cn0UfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990368; c=relaxed/simple;
	bh=PQn62JhwDz9Sa7flQCbe72MOhKpt47xC2HlEX38VAEg=;
	h=Message-Id:From:Date:Subject:To:Cc; b=tlpcfz24kcqwONr7e9foTecHp4yPFbUjNFg6yrqNyvRbCnHO428H4NFxz/dIFjPGeezBD98GeprPSHvqzbSk2SYG3jODZitp+XPoppcOdOP25QKzypK60RoLH0A/tx4NbaboaADO+kKvjBjQzBuTH9CtK/1WkxjK707DpE0cy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 97422313;
	Tue, 05 May 2026 16:12:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 91C21602D0D2; Tue,  5 May 2026 16:12:34 +0200 (CEST)
Message-Id: <c57e018b4dee8d9d913870b8101ee9357c0c4a55.1777989011.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 5 May 2026 16:12:36 +0200
Subject: [PATCH] scsi: elx: efct: Restore config space after error-induced
 reset
To: Ram Vegesna <ram.vegesna@broadcom.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Mike Christie <michael.christie@oracle.com>, James Smart <jsmart2021@gmail.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: DBFEF4CF262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-1116-lists,target-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.906];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,target-devel@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wunner.de:mid,wunner.de:email]

When a Fatal Error is handled by AER or DPC, the error-reporting PCIe
device is reset and its driver's ->slot_reset() callback is invoked to
bring the device back to working state.

That callback first needs to call pci_restore_state() to re-initialize
BAR assignments and other bits in config space.

The Emulex/Broadcom EFCT driver neglects to do that.  Fix it.

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.14+
---
Compile-tested only, I do not have this hardware available for testing.
That said, it seems the code path has never been tested anyway.
If you have the hardware, consider injecting a Fatal Error as described
in Documentation/PCI/pcieaer-howto.rst and see if the hardware recovers
successfully.

 drivers/scsi/elx/efct/efct_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index 07c2f45..fe45009 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -688,6 +688,8 @@
 	int rc;
 	struct efct *efct = pci_get_drvdata(pdev);
 
+	pci_restore_state(pdev);
+
 	rc = pci_enable_device_mem(pdev);
 	if (rc) {
 		efc_log_err(efct, "failed to enable PCI device after reset\n");
-- 
2.51.0


