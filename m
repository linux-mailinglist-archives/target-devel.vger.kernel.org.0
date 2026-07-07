Return-Path: <target-devel+bounces-1274-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKPLGTIYTWoEvAEAu9opvQ
	(envelope-from <target-devel+bounces-1274-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Tue, 07 Jul 2026 17:16:02 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 090E671D238
	for <lists+target-devel@lfdr.de>; Tue, 07 Jul 2026 17:16:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=esPo86+J;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1274-lists+target-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="target-devel+bounces-1274-lists+target-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52FEB301B807
	for <lists+target-devel@lfdr.de>; Tue,  7 Jul 2026 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764736A36B;
	Tue,  7 Jul 2026 15:13:38 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6F379C32
	for <target-devel@vger.kernel.org>; Tue,  7 Jul 2026 15:13:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437218; cv=none; b=Q+xBGnldQHj/K4h04uhrOV/ke+pyFpfdt/iYGeqGYOtRBG5D76HU1qcDmA66gcd1IWJuIoNFlwWsromZzAa9TljF40R2K/mW8Z4wS2euVQkPA0fuX2rG7/BSuBZQ7JnHg2YPhk3bU8JHsA86pKuRBeD//DpUE9/JoDUzAqkE/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437218; c=relaxed/simple;
	bh=tNyb5KERqmdGvt814UOI5CF6LIvyKei+Q8ac+RDq/KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmrYNtkZTGfWpLLGzRMMzI84aspn3UenGQ1UpqZ2r2pMFgOS8pQtjpA+m8JLRzwTvzlqapKmSCQvk6KD5NzuvitlrD6wuSA7M3d6As2wJuctoSNQLUTT+JtuUwneaXuuJq+KCl2g/Qy+C8O/N77Eg6HtLMLmdsiM8aM62uIYFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esPo86+J; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-847aa193d98so3470085b3a.3
        for <target-devel@vger.kernel.org>; Tue, 07 Jul 2026 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437216; x=1784042016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KWgWLU531wg7fILloa6RX/bN9zEBjLF+DYHSduibKQw=;
        b=esPo86+JdAUxmjwCXDGZ4O8m8/ybbhYzVUeuBadOFQTxfn0Bj8cAHErCeIrRz0GSeV
         qR4jV6miq/CjJtlOBM6x/wXZ7ec8d4YE8ITCmN0VxG3K7nVrmP/55MoxZyvToj37qbCc
         eMrBwrlu80LOrlXj4/lZ+cuaesdrMvCwjD+j0PWrGZ0lisK5u6mHc2eaiFx6+oqr6mVn
         0d3m6Y7Zljahl9eQKgwE8BjluIqMx+vT0pv+7c+qxgkJ4nczT9lCusUMNuddRZkzB4Pa
         AIySueBgeeFZnlJ+gO7pYGLQRRhSAYkGHpmGuLvC3/Dl0LZBvNH9CRxRGQ/OMBZm6fiC
         qUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437216; x=1784042016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWgWLU531wg7fILloa6RX/bN9zEBjLF+DYHSduibKQw=;
        b=G34MUxGzstthPEpZZqno/T91H4278rXrXWv+S9SrLpTh+ePYTXEZIdxDJT+pYUud0b
         LxoovBg2d1usWrIY8rNhUCZB51dnPcoE7jnCSh3aZNVRAiC8cjq2HqT0yN+ylCqEV4/p
         6lRzz70pgrKspCzSyBzi1T+oXctqWn3ZQ9ZvXhZHVRoMnl/o6ZQfF514fvhhJu++xkiR
         faROl8iN6Q889QRkT2hsE2pHi/I05vu/BjzjMgkitqOHFBrimhNlk609nmUbovaOCh4e
         oyepTW1Vp4rYSXOZKeIaOgBMpKyhBD0ri9pcFlZyXC2yKqhZFlgrq8CZ56o8gFEr68q5
         Ahbw==
X-Forwarded-Encrypted: i=1; AHgh+RpEbRwWGt9aQlFfJ5PtWvUqBb2PUQQwClFvklc/xPlGNIiMCUvOOFAYdtb3Xp1DcSLe/0L5kt7d6ULJRGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDd00zM1S0LgHKCZ1EXU0j/X611QTqKdXXO6SNy6TibFuvbCd
	Fzna+TXvTe3G9eLRkINk3K1pVJwASqyz4HXIu4QLo5rxStmutX7ntzNz
X-Gm-Gg: AfdE7cnXszVTT+ugu0oES0EdjCQEwp2qGTaBBjSVJ/PtD+0cdWVehpXnrSpu6NvuTMc
	Ec7prYcXwyWrz7JrhqFxIVe8Du2lW4E6x33OEaCGOwkk8euGpUjVaBBz+edq3lmDx49T2HVF1X9
	ZXGj8Q1If2qu4kAzZqwHUWlGv5nGz55w+dKP+8knYxjfqhQBhGaxBFSnEaszTqcj9xcTfwUmwAg
	FBHWnOxU5z/EAGcgLbN3fQbhHnxNegKYDSagpQYFPcaH9sg/QVKFx65Qc7x87ffWxsqsZksQxqZ
	ZWmY3L2TDLa4/GnG/lZD0zpd8Gmp1JbRaLRqTvMU9xZtjj9Ed1kbYnk1IWrjkAqlfXUhTl3W6jo
	JCxK7slW89jUHGjSMM9CYkzw3/IfXJZTURLcz0pgWQsZ0rzAPGOomoXyBUEmZoiq9HJ4Eup6IrK
	+h08N5vd35XI2pjg1kizd0+WfYceeHb9uIVRvzwWQhMgs=
X-Received: by 2002:a05:6a00:908d:b0:847:1d73:f753 with SMTP id d2e1a72fcca58-84826df100cmr5597938b3a.45.1783437216361;
        Tue, 07 Jul 2026 08:13:36 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:239e:a31b:1d0d:374f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm5717672b3a.60.2026.07.07.08.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:13:35 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: martin.petersen@oracle.com
Cc: agrover@redhat.com,
	roland@kernel.org,
	nab@linux-iscsi.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] scsi: target: iscsi: Clear sequence list after PDU allocation failure
Date: Tue,  7 Jul 2026 23:13:30 +0800
Message-ID: <20260707151330.2334097-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linux-iscsi.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1274-lists,target-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:agrover@redhat.com,m:roland@kernel.org,m:nab@linux-iscsi.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,target-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,target-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 090E671D238

iscsit_build_pdu_and_seq_lists() publishes cmd->seq_list after the
sequence-list allocation succeeds. If the later PDU-list allocation
fails, the error path frees the local seq pointer and returns with
cmd->seq_list still pointing at that freed memory.

The same command is then converted into a reject command, and its normal
release path frees cmd->seq_list again. Clear the published sequence-list
state after freeing seq so command release does not see a stale cleanup
pointer.

This issue was found by a static analysis checker and confirmed by
manual source review.
Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/target/iscsi/iscsi_target_seq_pdu_list.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
index 75c37c8866c86..2571097436399 100644
--- a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
+++ b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
@@ -549,6 +549,8 @@ int iscsit_build_pdu_and_seq_lists(
 		if (!pdu) {
 			pr_err("Unable to allocate struct iscsi_pdu list.\n");
 			kfree(seq);
+			cmd->seq_list = NULL;
+			cmd->seq_count = 0;
 			return -ENOMEM;
 		}
 		cmd->pdu_list = pdu;
-- 
2.51.0


