Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69910DADF0
	for <lists+target-devel@lfdr.de>; Thu, 17 Oct 2019 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394294AbfJQNKm (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 17 Oct 2019 09:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfJQNKm (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 541C310C0933;
        Thu, 17 Oct 2019 13:10:42 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-199.brq.redhat.com [10.40.204.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D793600C4;
        Thu, 17 Oct 2019 13:10:38 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     cleech@redhat.com
Cc:     mchristi@redhat.com, target-devel@vger.kernel.org,
        hch@infradead.org
Subject: [PATCH V2 0/3] iscsi: chap: introduce support for SHA1, SHA256 and SHA3-256
Date:   Thu, 17 Oct 2019 15:10:34 +0200
Message-Id: <20191017131037.9903-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 17 Oct 2019 13:10:42 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

iSCSI with the Challenge-Handshake Authentication Protocol is not FIPS compliant.
This is due to the fact that CHAP currently uses MD5 as the only supported
digest algorithm and MD5 is not allowed by FIPS.

When FIPS mode is enabled on the target server, the CHAP authentication
won't work because the target driver will be prevented from using the MD5 module.

Given that CHAP is agnostic regarding the algorithm it uses, this
patchset introduce support for three new alternatives: SHA1, SHA256 and SHA3-256.

They all have their protocol identifiers assigned by IANA:
https://www.iana.org/assignments/ppp-numbers/ppp-numbers.xml#ppp-numbers-9

Initiator-side code for open-iscsi has already been merged:
https://github.com/open-iscsi/open-iscsi/pull/170

V2: adds SHA256

Maurizio Lombardi (3):
  target-iscsi: CHAP: add support to SHA1, SHA256 and SHA3-256 hash
    functions
  target-iscsi: tie the challenge length to the hash digest size
  target-iscsi: rename some variables to avoid confusion.

 drivers/target/iscsi/iscsi_target_auth.c | 232 +++++++++++++++--------
 drivers/target/iscsi/iscsi_target_auth.h |  17 +-
 2 files changed, 161 insertions(+), 88 deletions(-)

-- 
Maurizio Lombardi

