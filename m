Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD84E184D39
	for <lists+target-devel@lfdr.de>; Fri, 13 Mar 2020 18:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCMRHF (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 13 Mar 2020 13:07:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39140 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726414AbgCMRHF (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584119224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C09/kK1JKf6yKpRHFjnUjEmRt4toB3/ooSemF6QDK28=;
        b=F9w3oRMOjlZhYvzQUKEOk2Z6FDoiY+8CGknMJk6RyzD0E6QCfDW3GOWAJMkimiU9Gh6ECa
        BU2vroggX3MaF4cg+aY2SIbsxyxfvdHToh5UqcGkUlCJilLUbcakx2DvKHD7W0qL/lYLUE
        Bs5JknCcW3r60ws7Ha1OrWKK+7GldoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-LQ85yy5pMYy76cp1CTMMdQ-1; Fri, 13 Mar 2020 13:07:02 -0400
X-MC-Unique: LQ85yy5pMYy76cp1CTMMdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0945100726B;
        Fri, 13 Mar 2020 17:07:00 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-206-24.brq.redhat.com [10.40.206.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E867173862;
        Fri, 13 Mar 2020 17:06:58 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, bvanassche@acm.org, ddiss@suse.de,
        mcoleman@datto.com, linux-scsi@vger.kernel.org
Subject: [PATCH RESEND 0/3] Fix a race condition in the target driver
Date:   Fri, 13 Mar 2020 18:06:53 +0100
Message-Id: <20200313170656.9716-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Multiple threads may try to destroy the same iscsi session
structure by calling iscsit_close_session() and then end
up hanging.

This patchset modifies the driver so the session
structure is destroyed by iscsit_close_connection() when
the last connection gets closed, thus preventing
the race condition.

Maurizio Lombardi (3):
  target: remove boilerplate code
  target: fix target hang when multiple threads try to destroy the same
    iscsi session.
  iscsi target: calling iscsit_stop_session() inside
    iscsit_close_session() has no effect

 drivers/target/iscsi/iscsi_target.c          | 82 ++++++--------------
 drivers/target/iscsi/iscsi_target.h          |  1 -
 drivers/target/iscsi/iscsi_target_configfs.c |  5 +-
 drivers/target/iscsi/iscsi_target_login.c    |  5 +-
 include/target/iscsi/iscsi_target_core.h     |  2 +-
 5 files changed, 32 insertions(+), 63 deletions(-)

--=20
2.21.0

