Return-Path: <target-devel+bounces-578-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF81BA9947
	for <lists+target-devel@lfdr.de>; Mon, 29 Sep 2025 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D834C189E30C
	for <lists+target-devel@lfdr.de>; Mon, 29 Sep 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497512D0267;
	Mon, 29 Sep 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="A5ck5Oso"
X-Original-To: target-devel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919401F03C5
	for <target-devel@vger.kernel.org>; Mon, 29 Sep 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.71.130.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156231; cv=none; b=WqbumiGTkEms9eGGGYcc7ahNGS3YFuJkIas3Jmrhw97iT/rEx7tQcCninjgOBY7USun9ncmiPcP2KtNBMN3yeIJxf3ehmwNw4WB1XAPsfZJJtPU6ij58sWh9+54RQVMsrL2cSIaV2HcvLmzylc2FAQRwEA8Z3+Ml7U+V2kLHbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156231; c=relaxed/simple;
	bh=kLzwDfi9hHuZ0JYFHtKKaF2/Zh/ir2DqJazGhsuDLcs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eR7l1vnvRwqcy643kElxQF4kNBCSjw44W0XlPduloSKTnM0ft57K2n+/g/vcXYWaSTdUt1fRaLNlEoZ0K7pQ/EUwDilfmBiv5NvflFdNU8mFnCvUnDSb5n3PKDYshyBUG7PuKp6cO9LOlarsu2l7a/x9FNeoqfTZJF89R4Pp2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=A5ck5Oso; arc=none smtp.client-ip=173.71.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id EdReLiLUuM23czLG; Mon, 29 Sep 2025 10:30:28 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=tebo2dUFTHeYeP42mbNTFyE3siOJRa3RaJWFQkL+ywI=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=A5ck5OsoglEpRApn73VZ
	0WhbF2dJ4ZjYbTOyMO0OfCNyvKpE0M+ZMjUxqV/LjE/q4qs78eQWszwa4qh2Kts9eBqfsQGxoHsE1
	4kIRYVs4jZVMdAuqS9gH+gnMKIhMe/fwMJvEpBRW9zp1qQ8ipbzFbr3wb/EgAaAtnUGraS0i78=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14216462; Mon, 29 Sep 2025 10:30:28 -0400
Message-ID: <de6e63c5-abd3-4a19-956d-aea5dfc68f6a@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 29 Sep 2025 10:30:27 -0400
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 01/16] Revert "scsi: qla2xxx: Perform lockless command
 completion in abort path"
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v2 01/16] Revert "scsi: qla2xxx: Perform lockless command
 completion in abort path"
From: Tony Battersby <tonyb@cybernetics.com>
To: Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, target-devel@vger.kernel.org,
 scst-devel@lists.sourceforge.net,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Xose Vazquez Perez <xose.vazquez@gmail.com>
References: <e95ee7d0-3580-4124-b854-7f73ca3a3a84@cybernetics.com>
In-Reply-To: <e95ee7d0-3580-4124-b854-7f73ca3a3a84@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1759156228
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3587
X-Barracuda-BRTS-Status: 1
X-ASG-Debug-ID: 1759156228-1cf43947df3c00c0001-W1KF7h

This reverts commit 0367076b0817d5c75dfb83001ce7ce5c64d803a9.

The commit being reverted added code to __qla2x00_abort_all_cmds() to
call sp->done() without holding a spinlock.  But unlike the older code
below it, this new code failed to check sp->cmd_type and just assumed
TYPE_SRB, which results in a jump to an invalid pointer in target-mode
with TYPE_TGT_CMD:

qla2xxx [0000:65:00.0]-d034:8: qla24xx_do_nack_work create sess success
  0000000009f7a79b
qla2xxx [0000:65:00.0]-5003:8: ISP System Error - mbx1=1ff5h mbx2=10h
  mbx3=0h mbx4=0h mbx5=191h mbx6=0h mbx7=0h.
qla2xxx [0000:65:00.0]-d01e:8: -> fwdump no buffer
qla2xxx [0000:65:00.0]-f03a:8: qla_target(0): System error async event
  0x8002 occurred
qla2xxx [0000:65:00.0]-00af:8: Performing ISP error recovery -
  ha=0000000058183fda.
BUG: kernel NULL pointer dereference, address: 0000000000000000
PF: supervisor instruction fetch in kernel mode
PF: error_code(0x0010) - not-present page
PGD 0 P4D 0
Oops: 0010 [#1] SMP
CPU: 2 PID: 9446 Comm: qla2xxx_8_dpc Tainted: G           O       6.1.133 #1
Hardware name: Supermicro Super Server/X11SPL-F, BIOS 4.2 12/15/2023
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90001f93dc8 EFLAGS: 00010206
RAX: 0000000000000282 RBX: 0000000000000355 RCX: ffff88810d16a000
RDX: ffff88810dbadaa8 RSI: 0000000000080000 RDI: ffff888169dc38c0
RBP: ffff888169dc38c0 R08: 0000000000000001 R09: 0000000000000045
R10: ffffffffa034bdf0 R11: 0000000000000000 R12: ffff88810800bb40
R13: 0000000000001aa8 R14: ffff888100136610 R15: ffff8881070f7400
FS:  0000000000000000(0000) GS:ffff88bf80080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000010c8ff006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die+0x4d/0x8b
 ? page_fault_oops+0x91/0x180
 ? trace_buffer_unlock_commit_regs+0x38/0x1a0
 ? exc_page_fault+0x391/0x5e0
 ? asm_exc_page_fault+0x22/0x30
 __qla2x00_abort_all_cmds+0xcb/0x3e0 [qla2xxx_scst]
 qla2x00_abort_all_cmds+0x50/0x70 [qla2xxx_scst]
 qla2x00_abort_isp_cleanup+0x3b7/0x4b0 [qla2xxx_scst]
 qla2x00_abort_isp+0xfd/0x860 [qla2xxx_scst]
 qla2x00_do_dpc+0x581/0xa40 [qla2xxx_scst]
 kthread+0xa8/0xd0
 </TASK>

Then commit 4475afa2646d ("scsi: qla2xxx: Complete command early within
lock") added the spinlock back, because not having the lock caused a
race and a crash.  But qla2x00_abort_srb() in the switch below already
checks for qla2x00_chip_is_down() and handles it the same way, so the
code above the switch is now redundant and still buggy in target-mode.
Remove it.

Cc: stable@vger.kernel.org
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

v1 -> v2: no changes

 drivers/scsi/qla2xxx/qla_os.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d4b484c0fd9d..a52293972e10 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1862,12 +1862,6 @@ __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
 	for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
 		sp = req->outstanding_cmds[cnt];
 		if (sp) {
-			if (qla2x00_chip_is_down(vha)) {
-				req->outstanding_cmds[cnt] = NULL;
-				sp->done(sp, res);
-				continue;
-			}
-
 			switch (sp->cmd_type) {
 			case TYPE_SRB:
 				qla2x00_abort_srb(qp, sp, res, &flags);
-- 
2.43.0


