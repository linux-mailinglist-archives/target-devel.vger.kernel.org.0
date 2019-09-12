Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8705B0C03
	for <lists+target-devel@lfdr.de>; Thu, 12 Sep 2019 11:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfILJz7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 12 Sep 2019 05:55:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730837AbfILJz7 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:55:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 440ECB008;
        Thu, 12 Sep 2019 09:55:58 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, mchristi@redhat.com, bvanassche@acm.org
Subject: [PATCH 0/3] target: minor iSCSI parameter parsing fixes
Date:   Thu, 12 Sep 2019 11:55:44 +0200
Message-Id: <20190912095547.22427-1-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This patchset includes some minor fixes for parsing iSCSI CHAP_A and
SendTargets fields. Patch 1/3 was already submitted and reviewed by
Lee.
I used the following libiscsi hacks to test for these bugs:
https://github.com/ddiss/libiscsi/commits/bogus_chap_a
https://github.com/ddiss/libiscsi/commits/bogus_sendtarget_key
https://github.com/ddiss/libiscsi/commits/bogus_sendtarget_val
I'll work on turning these into propper libiscsi regression tests
(pending https://github.com/sahlberg/libiscsi/issues/297).

Cheers, David

 drivers/target/iscsi/iscsi_target.c            | 14 ++++++--------
 drivers/target/iscsi/iscsi_target_auth.c       |  2 +-
 drivers/target/iscsi/iscsi_target_parameters.h |  3 ---
 3 files changed, 7 insertions(+), 12 deletions(-)
