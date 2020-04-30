Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF461BFFC4
	for <lists+target-devel@lfdr.de>; Thu, 30 Apr 2020 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgD3PLp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 30 Apr 2020 11:11:45 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:45176 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgD3PLo (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1588259500; i=@ts.fujitsu.com;
        bh=K9cTsEHWtQZINMgB3ZmbIs4Bnsa61dJE7uzpXz56pLU=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=GMpisSoeSgluPb6kFFacHkGnI4xfDa5n/MCqvOc1Hmf4VoErZpEbFpo/ZSQJRuMQe
         3LmsiGJHfByuV8SkPwUIciUbT1ThnNLWAdkns1VELQtNjSOu7y9VqjkH4FdNSl/pYT
         jcZ1LkVcVZEk5g3+zPGoXvIMABE+2b/qPVy1nVENf1ne5YirDtdnZB3iJ1iHR8g8WB
         XSofPcg8Z4auuk0X9zD8pSEXpyCVA0SGlKy46fWOziNNsOaCbKrhja9zE7QkR4k3V2
         7uBbT04IWwnE0T6/7Pl0CJHpxBn5cI/+zvCfkBFdomg6l+gW/hyisgoW6JAEOfr9D2
         n+okCkoo9k+BA==
Received: from [100.113.3.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 60/B0-40520-CAAEAAE5; Thu, 30 Apr 2020 15:11:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRWlGSWpSXmKPExsViZ8MxVXf1q1V
  xBjMarS2WH//HZLH+yAZGi9alb5kcmD0+Pr3F4vF+31U2j8+b5AKYo1gz85LyKxJYM16cXs9Y
  cEmg4v6yLqYGxj+8XYxcHEICkxkl9m85xQLhTGeUePDnDZDDycEmYCCxYtJ9IJuDQ0QgUqL1p
  S9ImFlAT2Lav3XsILawgIPEvpk9YOUsAqoS7y82soHYvAJ2EvNftLGC2BIC8hIdByazTGDkXM
  DIsIrRMqkoMz2jJDcxM0fX0MBA19DQWBdImlroJVbpJuqlluomp+aVFCUCZfUSy4v1iitzk3N
  S9PJSSzYxAv2eUsgwbwfj7LXv9Q4xSnIwKYnyGlxYFSfEl5SfUpmRWJwRX1Sak1p8iFGGg0NJ
  grftJVBOsCg1PbUiLTMHGIIwaQkOHiURXmWQNG9xQWJucWY6ROoUoy7HyVVLFjELseTl56VKi
  fOagxQJgBRllObBjYDFwyVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrx6wOgS4snMK4Hb9A
  roCCagI7KFl4McUZKIkJJqYGoK+vPsfe40Acur/284Bd5hNTdLWGE978ZFvr0n7y2+bLO/u0h
  niXD1galaH9wvBx/ZI3x6U+gt5+ez3jsblC30FXN6YHnfV+TvFW8O3Rm86Ue5lh/V4807MIFz
  Z8YFV+vs3GNZwWX6vYlHFu82e8cZ+NNm2eItd0vWHb1q3XNQ5ceElFsRIk3fhWI9ghcFPzLMF
  Hqw/sn8V9MfFU/5cFkyyjtDcJKVD0uD7JSCN4cFNH/fWe23Rnp22DYOs0/O1+fYNk6cWc5j6f
  537v4VC49+meiiY+9yckrPgsaevE2GWc6qLl2C1wvbV1kuSryT+G6Or05Dwa3PvNM3lJsWTpy
  odWOv5D+2h/onX8k6vrBWYinOSDTUYi4qTgQAkBllEQIDAAA=
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-29.tower-228.messagelabs.com!1588259499!757126!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9739 invoked from network); 30 Apr 2020 15:11:39 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-29.tower-228.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Apr 2020 15:11:39 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 03UFBXYN004245;
        Thu, 30 Apr 2020 16:11:33 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id 6EE2D20347;
        Thu, 30 Apr 2020 17:11:33 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     mchristi@redhat.com, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Cc:     Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [RFC] tcmu: wrong input from userspace can confuse tcmu
Date:   Thu, 30 Apr 2020 17:10:41 +0200
Message-Id: <20200430151041.31053-1-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,

When tcmu queues a new command - no matter whether in command
ring or in qfull_queue - a cmd_id from IDR udev->commands is
assigned to the command.

If userspaces sends a wrong command completion containing the
cmd_id of a command on the qfull_queue, tcmu_handle_completions()
finds the command in the IDR and calls tcmu_handle_completion()
for it. This might do some nasty things, because commands in
qfull_queue do not have a valid dbi list.

Of course this is easy to fix. E.g.:


--- a/drivers/target/target_core_user.c	2020-04-30 14:15:36.177184668 +0200
+++ b/drivers/target/target_core_user.c	2020-04-30 14:29:43.331882066 +0200
@@ -1242,13 +1242,14 @@ static unsigned int tcmu_handle_completi
 		}
 		WARN_ON(tcmu_hdr_get_op(entry->hdr.len_op) != TCMU_OP_CMD);
 
-		cmd = idr_remove(&udev->commands, entry->hdr.cmd_id);
-		if (!cmd) {
+		cmd = idr_find(&udev->commands, entry->hdr.cmd_id);
+		if (!cmd || !test_bit(TCMU_CMD_BIT_INFLIGHT, &cmd->flags)) {
 			pr_err("cmd_id %u not found, ring is broken\n",
 			       entry->hdr.cmd_id);
 			set_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
 			break;
 		}
+		idr_remove(&udev->commands, entry->hdr.cmd_id);
 
 		tcmu_handle_completion(cmd, entry);
 

To avoid the second idr_*() call in main data path, it would also
be possible to not replace the idr_remove() by idr_find(), but
in case cmd was found without TCMU_CMD_BIT_INFLIGHT being set,
during error handling re-add the cmd to the idr with the same id
as before by calling idr_alloc(...,cmd_id, crmdd_id+1, ...).


OTOH, I'm wondering whether the better solution would be to
remove idr_alloc() from tcmu_setup_cmd_timer() and add it
to queue_cmd_ring() immediately before or after it calls
tcmu_setup_cmd_timer().
Doing so would mean that commands in qfull_queue no longer have
a cmd_id (which is not necessary AFAICS) and therefore the problem
cannot happen, because tcmu_handle_completions() cannot find them
in the IDR.

Of course, this change would cause a number of further small
changes in target_core_user.c, but the effort is not too high,
it seems.

What do you think is the best solution?

Thank you,
Bodo
