Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4501620F2FF
	for <lists+target-devel@lfdr.de>; Tue, 30 Jun 2020 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbgF3Krn (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 30 Jun 2020 06:47:43 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:27916 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732631AbgF3Krj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1593514056; i=@ts.fujitsu.com;
        bh=gQMkEbnPQliZZuub1+zprC/Nu9Y9s2qt+0zyanguP1U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=JghRnR4n+L6vcBwKrIhDqPCop0JXXNEwyQJafKmM9rdEEPUbKBUe2tuOXjlMXCuau
         1scxvEzOmMpX22gSGMWvr8weaWccDeWrzcoZliSzcx4fPNKZXG7125AGGoLiR4DV/K
         ZkpdCZDj1eni2VTu95mTPWav+xy7C/MnH5TejWfzBYY+3B9DrfpGkeH0FAHyhs3MWY
         fhQ21q5YIjcMHOUSoG8Yq5/izy7cRFLSBInMkrX+099bQVipQ2ai8IQ8I/Bsvb1akP
         e2aK5N3VqdxOe4+LU7xkF0n2rfCbA3uuuE3HjpRlIed01+2XFf4Mg1UidHCYIA0+qJ
         IEqN8uthAIcSQ==
Received: from [100.112.197.119] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id 11/88-16187-7481BFE5; Tue, 30 Jun 2020 10:47:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRWlGSWpSXmKPExsViZ8MxRddd4ne
  cwYlPqhbd13ewWSw//o/J4u+kG6wWrUvfMjmweHx8eovF4/MmuQCmKNbMvKT8igTWjJevPrEV
  3OSt2LbmE2sD42fuLkYuDiGByYwSy9/dZ4dwpjNKNHZMZ+5i5ORgEzCQWDHpPgtIQkRgDaPEy
  jvzwBLMAnoS0/6tYwexhQXcJV73HWEFsVkEVCX2LjvFCGLzCthJPD38lg3ElhCQl+g4MJkFxO
  YUsJdYe/g0mC0EVLN280y2CYzcCxgZVjFaJBVlpmeU5CZm5ugaGhjoGhoa6RpaWugaWpjpJVb
  pJumlluqWpxaX6BrqJZYX6xVX5ibnpOjlpZZsYgQGSkrBsV07GN++/qB3iFGSg0lJlPfev19x
  QnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR428V+xwkJFqWmp1akZeYAgxYmLcHBoyTC2y4ElOYtL
  kjMLc5Mh0idYlSUEuddCdInAJLIKM2Da4NFyiVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwr
  wJ4kBTeDLzSuCmvwJazAS0+JrWL5DFJYkIKakGJpVXz05qtfxZLuZYL+K/wzjo0rHdQWfr/n6
  tEbghl6d/y9piQ2uhpNLiQ/qXPv9y8Ph0rPz9/pNZhbsfRXtO0T4f5S75b+fF729P2303eNCX
  HhKRdWQZz7yJGlvVD2ufnXh/yZ6VKU2vGbYVSz1feWWqdliU98tfa8UObGpa0Le/w8mrefGkO
  KmeizqeGfrZpY/PmUU9XTe3c93NZdNdPu2U+T0rJd8tuFTiyARmA2EP7cI5zBVhdty1npE/u+
  KXORi+iVESlyw5M7Ej+Lg6e4yBn6v80YIvvIJTxHl7Lx1S7jkU/GzKa7dZtl9vqIk8meD81fh
  u6Laz7UlTBZ6zKlx51nG48ZGdrhz7h6vf/imxFGckGmoxFxUnAgB0N5PpDwMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-18.tower-291.messagelabs.com!1593514054!485001!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21498 invoked from network); 30 Jun 2020 10:47:35 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-18.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Jun 2020 10:47:35 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 05UAlU9s025883;
        Tue, 30 Jun 2020 11:47:30 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id 7786A20721;
        Tue, 30 Jun 2020 12:47:30 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [RFC PATCH 3/8] scsi: target: tcmu: Use priv pointer in se_cmd
Date:   Tue, 30 Jun 2020 12:47:04 +0200
Message-Id: <20200630104709.23066-4-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20200630104709.23066-1-bstroesser@ts.fujitsu.com>
References: <20200630104709.23066-1-bstroesser@ts.fujitsu.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

We initialize and clean up the se_cmd's priv pointer
under cmd_ring_lock to point to the corresponding tcmu_cmd.

In the patch that implements tmr_notify callback in
tcmu we will use the priv pointer.

Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
---
 drivers/target/target_core_user.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 82e476d48194..c900e3dd25aa 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -541,6 +541,8 @@ tcmu_get_block_page(struct tcmu_dev *udev, uint32_t dbi)
 
 static inline void tcmu_free_cmd(struct tcmu_cmd *tcmu_cmd)
 {
+	if (tcmu_cmd->se_cmd)
+		tcmu_cmd->se_cmd->priv = NULL;
 	kfree(tcmu_cmd->dbi);
 	kmem_cache_free(tcmu_cmd_cache, tcmu_cmd);
 }
@@ -1109,10 +1111,11 @@ tcmu_queue_cmd(struct se_cmd *se_cmd)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
 	mutex_lock(&udev->cmdr_lock);
+	se_cmd->priv = tcmu_cmd;
 	ret = queue_cmd_ring(tcmu_cmd, &scsi_ret);
-	mutex_unlock(&udev->cmdr_lock);
 	if (ret < 0)
 		tcmu_free_cmd(tcmu_cmd);
+	mutex_unlock(&udev->cmdr_lock);
 	return scsi_ret;
 }
 
@@ -1179,7 +1182,6 @@ static void tcmu_handle_completion(struct tcmu_cmd *cmd, struct tcmu_cmd_entry *
 		target_complete_cmd(cmd->se_cmd, entry->rsp.scsi_status);
 
 out:
-	cmd->se_cmd = NULL;
 	tcmu_cmd_free_data(cmd, cmd->dbi_cnt);
 	tcmu_free_cmd(cmd);
 }
@@ -1285,6 +1287,7 @@ static void tcmu_check_expired_ring_cmd(struct tcmu_cmd *cmd)
 	set_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags);
 	list_del_init(&cmd->queue_entry);
 	se_cmd = cmd->se_cmd;
+	se_cmd->priv = NULL;
 	cmd->se_cmd = NULL;
 
 	pr_debug("Timing out inflight cmd %u on dev %s.\n",
-- 
2.12.3

