Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF96A1A20
	for <lists+target-devel@lfdr.de>; Thu, 29 Aug 2019 14:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfH2McG (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Aug 2019 08:32:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbfH2McF (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:32:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 741ECAFB6;
        Thu, 29 Aug 2019 12:32:04 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH 0/3] Fix fallthrough warnings.
Date:   Thu, 29 Aug 2019 14:31:59 +0200
Message-Id: <cover.1567081143.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Build with recent compiler results in numerous fallthrough warnings.

The code looks correct to me so just adding the comments to quiet gcc.

Please review if the fallthrough was really intentional.

Thanks

Michal

Michal Suchanek (3):
  scsi: cxlflash: Fix fallthrough warnings.
  scsi: ibmvfc: Fix fallthrough warnings.
  scsi: ibmvscsi: tgt: Fix fallthrough warnings.

 drivers/scsi/cxlflash/main.c             | 8 ++++++++
 drivers/scsi/ibmvscsi/ibmvfc.c           | 3 +++
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +++
 3 files changed, 14 insertions(+)

-- 
2.12.3

