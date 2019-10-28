Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF04FE7194
	for <lists+target-devel@lfdr.de>; Mon, 28 Oct 2019 13:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbfJ1Mie (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 28 Oct 2019 08:38:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43455 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727024AbfJ1Mie (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572266313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wDPft05/phQA5IyXggd56WypTNjTTZkQl1Gm4vgxzwQ=;
        b=Y/xwY5DMh5+jAi/mp+/CtuDxaaseZQDpFGDV3cI3n2bVaSEuZNodx4DOH9p5GMlFeLuPmC
        F2AzjF15xTTtBRvWRaMnGR2hFPJHg6HQ9UWOmzYtlWoFP00F6pax1GYWL1p9vY+4g5qW39
        z+2w6RVKmFvnFUhlSlRGwrtF3ZghIDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-P5oDCJpRNwm-lUXbzz-QGQ-1; Mon, 28 Oct 2019 08:38:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50795107AD28;
        Mon, 28 Oct 2019 12:38:27 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99DB1600C9;
        Mon, 28 Oct 2019 12:38:23 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     cleech@redhat.com
Cc:     mchristi@redhat.com, target-devel@vger.kernel.org,
        hch@infradead.org, martin.petersen@oracle.com
Subject: [PATCH V3 0/3] iscsi: chap: introduce support for SHA1, SHA256 and SHA3-256
Date:   Mon, 28 Oct 2019 13:38:19 +0100
Message-Id: <20191028123822.5864-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: P5oDCJpRNwm-lUXbzz-QGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

iSCSI with the Challenge-Handshake Authentication Protocol is not FIPS comp=
liant.
This is due to the fact that CHAP currently uses MD5 as the only supported
digest algorithm and MD5 is not allowed by FIPS.

When FIPS mode is enabled on the target server, the CHAP authentication
won't work because the target driver will be prevented from using the MD5 m=
odule.

Given that CHAP is agnostic regarding the algorithm it uses, this
patchset introduce support for three new alternatives: SHA1, SHA256 and SHA=
3-256.

They all have their protocol identifiers assigned by IANA:
https://www.iana.org/assignments/ppp-numbers/ppp-numbers.xml#ppp-numbers-9

Initiator-side code for open-iscsi has already been merged:
https://github.com/open-iscsi/open-iscsi/pull/170

V2: adds SHA256
V3: rebased on top of 5.5/scsi-queue
    PATCH 3: renames initiatorchg_* variables to client_challenge_*

Maurizio Lombardi (3):
  target-iscsi: CHAP: add support to SHA1, SHA256 and SHA3-256 hash
    functions
  target-iscsi: tie the challenge length to the hash digest size
  target-iscsi: rename some variables to avoid confusion.

 drivers/target/iscsi/iscsi_target_auth.c | 235 +++++++++++++++--------
 drivers/target/iscsi/iscsi_target_auth.h |  17 +-
 2 files changed, 163 insertions(+), 89 deletions(-)

--=20
Maurizio Lombardi

