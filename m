Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC11644E1
	for <lists+target-devel@lfdr.de>; Wed, 19 Feb 2020 14:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBSNBy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 19 Feb 2020 08:01:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:44126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgBSNBx (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:01:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65BE1AD94;
        Wed, 19 Feb 2020 13:01:52 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com, bvanassche@acm.org
Subject: [PATCH v2 0/2] scsi: target: modify boolean configfs attributes
Date:   Wed, 19 Feb 2020 14:01:34 +0100
Message-Id: <20200219130136.18946-1-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This series includes a fix for a regression in the configfs interface
and has a subsequent type cleanup to avoid similar mistakes in future.

Changes since v1:
- change unmap_zeroes_data type from int to bool and do the same for
  other attributes in a follow-up commit

David Disseldorp (2):
      scsi: target: fix unmap_zeroes_data boolean initialisation
      scsi: target: convert boolean se_dev_attrib types to bool

 drivers/target/target_core_device.c |  2 +-
 drivers/target/target_core_tmr.c    |  6 ++---
 include/target/target_core_base.h   | 34 ++++++++++++++---------------
 3 files changed, 21 insertions(+), 21 deletions(-)
