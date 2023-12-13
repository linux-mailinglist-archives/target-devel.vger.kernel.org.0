Return-Path: <target-devel+bounces-28-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256FC808EF4
	for <lists+target-devel@lfdr.de>; Thu,  7 Dec 2023 18:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DFBB20B08
	for <lists+target-devel@lfdr.de>; Thu,  7 Dec 2023 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A773D4AF92;
	Thu,  7 Dec 2023 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RutsjKBL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RutsjKBL"
X-Original-To: target-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB105D53;
	Thu,  7 Dec 2023 09:43:01 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 610211FB6B;
	Thu,  7 Dec 2023 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701970980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnqBvZFGGapAam3PA5Wilpg22t/C/Ylx6D9WYq0yH4M=;
	b=RutsjKBL5wyuX6KcwJHx50c3BRbS6GzYvrVjsckfvcvvDaVN7MRpHclSryoiYB5yt8+tFg
	LHoYtIrXc78qvZxid2kBP2PyjdyqdyrVfqEFoOKAnqJR1NEmStCtzVcxNljc6653lgV2hV
	eovAV4YDcNtcfKzy9aqeMXAUUCRqPVY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701970980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnqBvZFGGapAam3PA5Wilpg22t/C/Ylx6D9WYq0yH4M=;
	b=RutsjKBL5wyuX6KcwJHx50c3BRbS6GzYvrVjsckfvcvvDaVN7MRpHclSryoiYB5yt8+tFg
	LHoYtIrXc78qvZxid2kBP2PyjdyqdyrVfqEFoOKAnqJR1NEmStCtzVcxNljc6653lgV2hV
	eovAV4YDcNtcfKzy9aqeMXAUUCRqPVY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 66CDB13907;
	Thu,  7 Dec 2023 17:42:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +LDjDiIEcmUeYwAAn2gu4w
	(envelope-from <lduncan@suse.com>); Thu, 07 Dec 2023 17:42:58 +0000
From: <lduncan@suse.com>
To: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbond@suse.com,
	hare@suse.de,
	cleech@redhat.com,
	michael.christie@oracle.com,
	Lee Duncan <lduncan@suse.com>
Subject: [PATCH 2/2] scsi: target: iscsi: don't warn of R/W when no data
Date: Thu,  7 Dec 2023 09:42:35 -0800
Message-Id: <437f863520874ee386b6882ef749bf8d988839ca.1701540918.git.lduncan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701540918.git.lduncan@suse.com>
References: <cover.1701540918.git.lduncan@suse.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.70
X-Spam-Flag: NO
X-Spamd-Result: default: False [4.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[mac.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 FROM_NO_DN(0.00)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[48.15%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 4.89

From: Lee Duncan <lduncan@suse.com>

The LIO target code has a warning about setting the
read and/or write header bits with a PDU that has zero
transfer length, even though the code mentions that the
SPEC (RFC 3720) allows this, and that some initiators
set these bits. But in practice such initiators end up
flooding the logs with thousands of warning messages for
IO that is allowed.

So change this to a debug message, and clean up the wording
just a little bit while at it.

Signed-off-by: Lee Duncan <lduncan@suse.com>
Reviewed-by: David Bond <dbond@suse.com>
---
 drivers/target/iscsi/iscsi_target.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index f246e5015868..c82dc2cd08b3 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1039,9 +1039,10 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 		hdr->flags &= ~ISCSI_FLAG_CMD_READ;
 		hdr->flags &= ~ISCSI_FLAG_CMD_WRITE;
 
-		pr_warn("ISCSI_FLAG_CMD_READ or ISCSI_FLAG_CMD_WRITE"
+		pr_debug("ISCSI_FLAG_CMD_READ or ISCSI_FLAG_CMD_WRITE"
 			" set when Expected Data Transfer Length is 0 for"
-			" CDB: 0x%02x, Fixing up flags\n", hdr->cdb[0]);
+			" CDB: 0x%02x, cleared READ/WRITE flag(s)\n",
+			hdr->cdb[0]);
 	}
 
 	if (!(hdr->flags & ISCSI_FLAG_CMD_READ) &&
-- 
2.43.0


