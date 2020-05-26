Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB011D6E66
	for <lists+target-devel@lfdr.de>; Mon, 18 May 2020 03:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgERBC1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 17 May 2020 21:02:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56852 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726665AbgERBC1 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 17 May 2020 21:02:27 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-4JzaRyvBOUKOHEemSFbP9g-1; Sun, 17 May 2020 21:02:25 -0400
X-MC-Unique: 4JzaRyvBOUKOHEemSFbP9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29B68474;
        Mon, 18 May 2020 01:02:24 +0000 (UTC)
Received: from ldigby.remote.csb (vpn2-54-25.bne.redhat.com [10.64.54.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 907A1398;
        Mon, 18 May 2020 01:02:22 +0000 (UTC)
From:   Lance Digby <lance.digby@gmail.com>
To:     mchristi@redhat.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 target] target: Add initiatorname to NON_EXISTENT_LUN error
Date:   Mon, 18 May 2020 11:02:16 +1000
Message-Id: <9b13bb2e1f52f1792cd81850ee95bf3781bb5363.1589759816.git.lance.digby@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The NON_EXISTENT_LUN error can be written without an error condition
on the initiator responsible. Adding the initiatorname to this message
will reduce the effort required to fix this when many initiators are
supported by a target.

This version ensures the initiator name is also printed on the same
message in transport_lookup_tmr_lun for consistency.

Signed-off-by: Lance Digby <lance.digby@gmail.com>
---
 drivers/target/target_core_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_co=
re_device.c
index 4cee113..15064a5 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -100,9 +100,10 @@
 =09=09 */
 =09=09if (unpacked_lun !=3D 0) {
 =09=09=09pr_err("TARGET_CORE[%s]: Detected NON_EXISTENT_LUN"
-=09=09=09=09" Access for 0x%08llx\n",
+=09=09=09=09" Access for 0x%08llx from %s\n",
 =09=09=09=09se_cmd->se_tfo->fabric_name,
-=09=09=09=09unpacked_lun);
+=09=09=09=09unpacked_lun,
+=09=09=09=09nacl->initiatorname);
 =09=09=09return TCM_NON_EXISTENT_LUN;
 =09=09}
=20
@@ -174,9 +175,10 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd, u6=
4 unpacked_lun)
=20
 =09if (!se_lun) {
 =09=09pr_debug("TARGET_CORE[%s]: Detected NON_EXISTENT_LUN"
-=09=09=09" Access for 0x%08llx\n",
+=09=09=09" Access for 0x%08llx for %s\n",
 =09=09=09se_cmd->se_tfo->fabric_name,
-=09=09=09unpacked_lun);
+=09=09=09unpacked_lun,
+=09=09=09nacl->initiatorname);
 =09=09return -ENODEV;
 =09}
 =09se_cmd->se_dev =3D rcu_dereference_raw(se_lun->lun_se_dev);
--=20
1.8.3.1

