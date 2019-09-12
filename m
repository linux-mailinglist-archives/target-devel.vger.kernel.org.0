Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F9B0C07
	for <lists+target-devel@lfdr.de>; Thu, 12 Sep 2019 11:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfILJ4A (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 12 Sep 2019 05:56:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730580AbfILJz7 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:55:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C4E9B6EC;
        Thu, 12 Sep 2019 09:55:58 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/3] target: remove unused extension parameters
Date:   Thu, 12 Sep 2019 11:55:47 +0200
Message-Id: <20190912095547.22427-4-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190912095547.22427-1-ddiss@suse.de>
References: <20190912095547.22427-1-ddiss@suse.de>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/iscsi/iscsi_target_parameters.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_parameters.h b/drivers/target/iscsi/iscsi_target_parameters.h
index daf47f38e081..240c4c4344f6 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.h
+++ b/drivers/target/iscsi/iscsi_target_parameters.h
@@ -93,9 +93,6 @@ extern void iscsi_set_session_parameters(struct iscsi_sess_ops *,
 #define OFMARKER			"OFMarker"
 #define IFMARKINT			"IFMarkInt"
 #define OFMARKINT			"OFMarkInt"
-#define X_EXTENSIONKEY			"X-com.sbei.version"
-#define X_EXTENSIONKEY_CISCO_NEW	"X-com.cisco.protocol"
-#define X_EXTENSIONKEY_CISCO_OLD	"X-com.cisco.iscsi.draft"
 
 /*
  * Parameter names of iSCSI Extentions for RDMA (iSER).  See RFC-5046
-- 
2.16.4

