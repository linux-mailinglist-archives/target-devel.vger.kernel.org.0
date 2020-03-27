Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00381958CE
	for <lists+target-devel@lfdr.de>; Fri, 27 Mar 2020 15:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgC0OUM (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 27 Mar 2020 10:20:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbgC0OUM (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:20:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0DC63AFFD;
        Fri, 27 Mar 2020 14:20:11 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        bvanassche@acm.org
Subject: [PATCH v3 0/5] scsi: target: XCOPY performance
Date:   Fri, 27 Mar 2020 15:19:49 +0100
Message-Id: <20200327141954.955-1-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

These changes remove unnecessary heap allocations in the XCOPY
READ/WRITE dispatch loop.

Synthetic benchmarks on my laptop using the libiscsi iscsi-dd utility
(--xcopy --max 1 --blocks 65535 src=dst) against a target backed by an
8G zram (DEBUG_KMEMLEAK=y) iblock backstore (avg across four runs) show:
before: 5.30845G/s
after:  5.99056G/s (approx. +12.8%)

Changes since v2:
- 5/5: incorporate Christoph's clean up suggestions

Changes since v1:
- drop RFC
- rework 3/5 and 5/5 following Christoph's feedback

Feedback appreciated.

Cheers, David

----------------------------------------------------------------
David Disseldorp (5):
      scsi: target: use #def for xcopy descriptor len
      scsi: target: drop xcopy DISK BLOCK LENGTH debug
      scsi: target: avoid per-loop XCOPY buffer allocations
      scsi: target: increase XCOPY I/O size
      scsi: target: use the stack for XCOPY passthrough cmds

 drivers/target/target_core_xcopy.c | 187 ++++++++++-------------------
 drivers/target/target_core_xcopy.h |   9 +-
 2 files changed, 64 insertions(+), 132 deletions(-)
