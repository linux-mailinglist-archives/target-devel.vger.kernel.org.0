Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26711DB8AB
	for <lists+target-devel@lfdr.de>; Wed, 20 May 2020 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETPu7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 20 May 2020 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgETPu7 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 20 May 2020 11:50:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E5C061A0E
        for <target-devel@vger.kernel.org>; Wed, 20 May 2020 08:50:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so1617459pgn.5
        for <target-devel@vger.kernel.org>; Wed, 20 May 2020 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphix.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=AJ91uDJq6cCqGMpL0BXEw564VCz+2fshNlTbazaFFes=;
        b=LkJjckvYAVH0TkzbjkvitNgRyPkT1rrS/oEDy18OHSMjH9xRIVO1M7q/izfzoCzaKj
         RtNXhkqLWrg7XdrCxaqn6938T3KA3msgxobYbSdCc1SjnTUKuFowIbYGVWbBPIDpH+Hd
         v++fBcwfoAAHI4r9KV9/jbNEpPIJtVPkyHll0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=AJ91uDJq6cCqGMpL0BXEw564VCz+2fshNlTbazaFFes=;
        b=OY/1gEBYjxAUdJMBFFD5t5lQMGiEb+1w30kZ1bKFkIZssCN/TIKUllSHIUPR4s2CEr
         2pYhXbNkngFil34wjjNowid8tcyLsewIc1mq0xVZZVkvyFQfMWaZlucp70Q1CfpMZscV
         thcuCYopxCFdcFJMtxS1AE7PYgzNN5e+9g5NR3htfIS78PoA8cEtxbTuV1Rrxlcx0EVg
         OFcJSyK8hqP+G6z6DSd0zI65WcU5Eq+NkrLV1QAVVOmIPyXyIKcf2Kc+k74FoSeEYghr
         69DW923EycFMHp4GcakIfahPeivev0dkK1Fi2C8gzr+u2dGHaylUhVj4EEvgFBGylADX
         BqTA==
X-Gm-Message-State: AOAM532ARB3o8Jxcf2YPFVcKjcmRc0+KEDw9Xa+PQJA1M/cmLzKSxXZM
        Fc6gpqW1XnvLLmbdsJ1k/gzUL6jV+Ksyaw==
X-Google-Smtp-Source: ABdhPJzJvAqXz8/w48aKBTehID9poGEetL11rLwMHdtTamKUnCUYexjr6R+7cmoxZe5FfO7h1A/oQA==
X-Received: by 2002:a63:d84e:: with SMTP id k14mr4532774pgj.91.1589989857887;
        Wed, 20 May 2020 08:50:57 -0700 (PDT)
Received: from [192.168.0.105] (modemcable127.167-81-70.mc.videotron.ca. [70.81.167.127])
        by smtp.gmail.com with ESMTPSA id a196sm2403988pfd.184.2020.05.20.08.50.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 08:50:57 -0700 (PDT)
From:   Pavel Zakharov <pavel.zakharov@delphix.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] scsi: target: put lun_ref at end of tmr processing
Message-Id: <96A62932-C9F9-4BB3-88B4-9B0A879A155E@delphix.com>
Date:   Wed, 20 May 2020 11:50:54 -0400
To:     bstroesser@ts.fujitsu.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        bvanassche@acm.org, mchristi@redhat.com,
        linux-scsi@vger-kernel.org, target-devel@vger.kernel.org,
        bly@catalogicsoftware.com
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hopefully I didn=E2=80=99t mess-up the recipients/Subject list as I just =
subscribed to target-devel and so following-up to an email I found in =
the archive.

Bodo, I happened to have run into the same issue and was just about to =
submit a similar patch when I randomly stumbled on yours.
I think we can improve on that patch by moving the call to =
transport_lun_remove_cmd() into transport_cmd_check_stop_to_fabric().

Here=E2=80=99s the patch I was about to propose. Let me know what you =
think.
Note that we could also do this simplification as a separate patch later =
if you think it=E2=80=99s better.

---
When ABORT and LUN RESET were made synchronous, a call to
transport_lun_remove_cmd() was acidentally removed. This caused a =
lun_ref
to be leaked every time an ABORT or LUN RESET was processed in
target_tmr_work().

Given that transport_lun_remove_cmd() should always be called before
transport_cmd_check_stop_to_fabric(), move that call into this function.
This ensures that the lun_ref is released before setting .se_lun to =
NULL.

Signed-off-by: Pavel Zakharov <pavel.zakharov@delphix.com>
---
 drivers/target/target_core_transport.c | 36 ++++++++++++--------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/target/target_core_transport.c =
b/drivers/target/target_core_transport.c
index 594b724bbf79..ec578822709a 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -653,6 +653,17 @@ static void target_remove_from_state_list(struct =
se_cmd *cmd)
 	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
 }

+static void transport_lun_remove_cmd(struct se_cmd *cmd)
+{
+	struct se_lun *lun =3D cmd->se_lun;
+
+	if (!lun)
+		return;
+
+	if (cmpxchg(&cmd->lun_ref_active, true, false))
+		percpu_ref_put(&lun->lun_ref);
+}
+
 /*
  * This function is called by the target core after the target core has
  * finished processing a SCSI command or SCSI TMF. Both the regular =
command
@@ -664,6 +675,11 @@ static int =
transport_cmd_check_stop_to_fabric(struct se_cmd *cmd)
 {
 	unsigned long flags;

+	/*
+	 * Remove cmd ref from lun if needed before clearing the se_lun.
+	 */
+	transport_lun_remove_cmd(cmd);
+
 	target_remove_from_state_list(cmd);

 	/*
@@ -698,17 +714,6 @@ static int =
transport_cmd_check_stop_to_fabric(struct se_cmd *cmd)
 	return cmd->se_tfo->check_stop_free(cmd);
 }

-static void transport_lun_remove_cmd(struct se_cmd *cmd)
-{
-	struct se_lun *lun =3D cmd->se_lun;
-
-	if (!lun)
-		return;
-
-	if (cmpxchg(&cmd->lun_ref_active, true, false))
-		percpu_ref_put(&lun->lun_ref);
-}
-
 static void target_complete_failure_work(struct work_struct *work)
 {
 	struct se_cmd *cmd =3D container_of(work, struct se_cmd, work);
@@ -799,8 +804,6 @@ static void target_handle_abort(struct se_cmd *cmd)

 	WARN_ON_ONCE(kref_read(&cmd->cmd_kref) =3D=3D 0);

-	transport_lun_remove_cmd(cmd);
-
 	transport_cmd_check_stop_to_fabric(cmd);
 }

@@ -1726,7 +1729,6 @@ static void target_complete_tmr_failure(struct =
work_struct *work)
 	se_cmd->se_tmr_req->response =3D TMR_LUN_DOES_NOT_EXIST;
 	se_cmd->se_tfo->queue_tm_rsp(se_cmd);

-	transport_lun_remove_cmd(se_cmd);
 	transport_cmd_check_stop_to_fabric(se_cmd);
 }

@@ -1918,7 +1920,6 @@ void transport_generic_request_failure(struct =
se_cmd *cmd,
 		goto queue_full;

 check_stop:
-	transport_lun_remove_cmd(cmd);
 	transport_cmd_check_stop_to_fabric(cmd);
 	return;

@@ -2216,7 +2217,6 @@ static void transport_complete_qf(struct se_cmd =
*cmd)
 		transport_handle_queue_full(cmd, cmd->se_dev, ret, =
false);
 		return;
 	}
-	transport_lun_remove_cmd(cmd);
 	transport_cmd_check_stop_to_fabric(cmd);
 }

@@ -2311,7 +2311,6 @@ static void target_complete_ok_work(struct =
work_struct *work)
 		if (ret)
 			goto queue_full;

-		transport_lun_remove_cmd(cmd);
 		transport_cmd_check_stop_to_fabric(cmd);
 		return;
 	}
@@ -2337,7 +2336,6 @@ static void target_complete_ok_work(struct =
work_struct *work)
 			if (ret)
 				goto queue_full;

-			transport_lun_remove_cmd(cmd);
 			transport_cmd_check_stop_to_fabric(cmd);
 			return;
 		}
@@ -2373,7 +2371,6 @@ static void target_complete_ok_work(struct =
work_struct *work)
 			if (ret)
 				goto queue_full;

-			transport_lun_remove_cmd(cmd);
 			transport_cmd_check_stop_to_fabric(cmd);
 			return;
 		}
@@ -2409,7 +2406,6 @@ static void target_complete_ok_work(struct =
work_struct *work)
 		break;
 	}

-	transport_lun_remove_cmd(cmd);
 	transport_cmd_check_stop_to_fabric(cmd);
 	return;

--
2.21.1 (Apple Git-122.3)=
