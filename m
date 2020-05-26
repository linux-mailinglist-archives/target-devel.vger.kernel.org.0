Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C956F1A72DD
	for <lists+target-devel@lfdr.de>; Tue, 14 Apr 2020 07:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405434AbgDNFPa (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 14 Apr 2020 01:15:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405422AbgDNFPY (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586841321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7VwMTKqOzHnCA6UBUgaaMtG4wgfOijE7wLGj2kCnXFo=;
        b=XHSmOWmXWD+PvtRqbdbNtCU0jv+1juYGhqrFKJbj8OnDG/QIkJygzeLuHXyvAJ/0wb2skU
        /T9vimq7ZaGPmyaI6gQhFw+3Ly5zk6xKyu5qXEcZscKEIPCenyqny7iEAqcbNrBRUMw/kQ
        p3Nn775pgoJYEjfWBNTVIpoaqIcYaek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-8Mgbf4rwNSazxXsbe69TNw-1; Tue, 14 Apr 2020 01:15:19 -0400
X-MC-Unique: 8Mgbf4rwNSazxXsbe69TNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBC6013F7;
        Tue, 14 Apr 2020 05:15:17 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-112-105.rdu2.redhat.com [10.10.112.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17D4D1001DDE;
        Tue, 14 Apr 2020 05:15:16 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     jsmart2021@gmail.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        nab@linux-iscsi.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [RFC PATCH 1/5] target: add sysfs support
Date:   Tue, 14 Apr 2020 00:15:10 -0500
Message-Id: <20200414051514.7296-2-mchristi@redhat.com>
In-Reply-To: <20200414051514.7296-1-mchristi@redhat.com>
References: <20200414051514.7296-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

configfs does not work well when the kernel is initiating the creation
of an object we want to export info for and the objects above/below it
are created by the user. There are races/bugs like seen with this patch
and the issue the original bug was trying to fix:

commit f19e4ed1e1edbfa3c9ccb9fed17759b7d6db24c6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Aug 29 23:13:30 2019 -0400

    configfs_register_group() shouldn't be (and isn't) called in
rmdirable parts

The problem is that for many drivers like qla2xxx, iscsi, etc, session
creation is done by the kernel when there is a login initiated by an
initiator, but we need a common way to export the systems sessions so
tools like targetcli can report basic info like what initaitors are
logged in and daemons like tcmu-runner can track sessions for load
balancing and PGRs.

This patch begins to add a sysfs interface that will initially be used
to export LIO's sessions. The general layout will mirror the lio
configfs tree:

target_core/
`-- $fabric_driver
    `-- target_name
        |-- tpgt_1
        |   `-- sessions
        `-- tpgt_2
            `-- sessions

iscsi example:
target_core/
`-- iscsi
    `-- iqn.1999-09.com.lio:tgt1
        |-- tpgt_1
        |   `-- sessions
        `-- tpgt_2
            `-- sessions

This initial patch adds only adds the upper layer dirs above the
sessions.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/target/target_core_configfs.c        | 21 ++++++++++++++++++
 drivers/target/target_core_fabric_configfs.c | 32 ++++++++++++++++++++++=
++++++
 drivers/target/target_core_internal.h        |  1 +
 include/target/target_core_base.h            |  4 ++++
 4 files changed, 58 insertions(+)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/targe=
t_core_configfs.c
index ff82b21f..3fd08c5 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -63,6 +63,8 @@
 	pr_debug("Setup generic %s\n", __stringify(_name));		\
 }
=20
+static struct kobject *tcm_core_kobj;
+
 extern struct t10_alua_lu_gp *default_lu_gp;
=20
 static LIST_HEAD(g_tf_list);
@@ -245,6 +247,11 @@ static struct config_group *target_core_register_fab=
ric(
 	}
 	pr_debug("Target_Core_ConfigFS: REGISTER -> Located fabric:"
 			" %s\n", tf->tf_ops->fabric_name);
+
+	tf->kobj =3D kobject_create_and_add(name, tcm_core_kobj);
+	if (!tf->kobj)
+		goto dec_tf;
+
 	/*
 	 * On a successful target_core_get_fabric() look, the returned
 	 * struct target_fabric_configfs *tf will contain a usage reference.
@@ -261,6 +268,10 @@ static struct config_group *target_core_register_fab=
ric(
 	pr_debug("Target_Core_ConfigFS: REGISTER -> Allocated Fabric: %s\n",
 		 config_item_name(&tf->tf_group.cg_item));
 	return &tf->tf_group;
+
+dec_tf:
+	atomic_dec(&tf->tf_access_cnt);
+	return ERR_PTR(-EINVAL);
 }
=20
 /*
@@ -283,6 +294,9 @@ static void target_core_deregister_fabric(
 	pr_debug("Target_Core_ConfigFS: DEREGISTER -> Releasing ci"
 			" %s\n", config_item_name(item));
=20
+	kobject_del(tf->kobj);
+	kobject_put(tf->kobj);
+
 	configfs_remove_default_groups(&tf->tf_group);
 	config_item_put(item);
 }
@@ -3538,6 +3552,10 @@ static int __init target_core_init_configfs(void)
=20
 	target_init_dbroot();
=20
+	tcm_core_kobj =3D kobject_create_and_add("target_core", NULL);
+	if (!tcm_core_kobj)
+		goto out;
+
 	return 0;
=20
 out:
@@ -3555,6 +3573,9 @@ static int __init target_core_init_configfs(void)
=20
 static void __exit target_core_exit_configfs(void)
 {
+	kobject_del(tcm_core_kobj);
+	kobject_put(tcm_core_kobj);
+
 	configfs_remove_default_groups(&alua_lu_gps_group);
 	configfs_remove_default_groups(&alua_group);
 	configfs_remove_default_groups(&target_core_hbagroup);
diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/targe=
t/target_core_fabric_configfs.c
index ee85602..4d208e4 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -838,6 +838,14 @@ static struct config_group *target_fabric_make_tpg(
 	if (!se_tpg || IS_ERR(se_tpg))
 		return ERR_PTR(-EINVAL);
=20
+	se_tpg->kobj =3D kobject_create_and_add(name, wwn->kobj);
+	if (!se_tpg->kobj)
+		goto drop_tpg;
+
+	se_tpg->sessions_kobj =3D kobject_create_and_add("sessions", se_tpg->ko=
bj);
+	if (!se_tpg->sessions_kobj)
+		goto del_tpg_kobj;
+
 	config_group_init_type_name(&se_tpg->tpg_group, name,
 			&tf->tf_tpg_base_cit);
=20
@@ -872,6 +880,13 @@ static struct config_group *target_fabric_make_tpg(
 			&se_tpg->tpg_group);
=20
 	return &se_tpg->tpg_group;
+
+del_tpg_kobj:
+	kobject_del(se_tpg->kobj);
+	kobject_put(se_tpg->kobj);
+drop_tpg:
+	tf->tf_ops->fabric_drop_tpg(se_tpg);
+	return ERR_PTR(-EINVAL);
 }
=20
 static void target_fabric_drop_tpg(
@@ -881,6 +896,12 @@ static void target_fabric_drop_tpg(
 	struct se_portal_group *se_tpg =3D container_of(to_config_group(item),
 				struct se_portal_group, tpg_group);
=20
+	kobject_del(se_tpg->sessions_kobj);
+	kobject_put(se_tpg->sessions_kobj);
+
+	kobject_del(se_tpg->kobj);
+	kobject_put(se_tpg->kobj);
+
 	configfs_remove_default_groups(&se_tpg->tpg_group);
 	config_item_put(item);
 }
@@ -927,6 +948,7 @@ static struct config_group *target_fabric_make_wwn(
 	struct target_fabric_configfs *tf =3D container_of(group,
 				struct target_fabric_configfs, tf_group);
 	struct se_wwn *wwn;
+	int ret;
=20
 	if (!tf->tf_ops->fabric_make_wwn) {
 		pr_err("tf->tf_ops.fabric_make_wwn is NULL\n");
@@ -938,6 +960,9 @@ static struct config_group *target_fabric_make_wwn(
 		return ERR_PTR(-EINVAL);
=20
 	wwn->wwn_tf =3D tf;
+	wwn->kobj =3D kobject_create_and_add(name, tf->kobj);
+	if (!wwn->kobj)
+		goto drop_wwn;
=20
 	config_group_init_type_name(&wwn->wwn_group, name, &tf->tf_tpg_cit);
=20
@@ -947,7 +972,12 @@ static struct config_group *target_fabric_make_wwn(
=20
 	if (tf->tf_ops->add_wwn_groups)
 		tf->tf_ops->add_wwn_groups(wwn);
+
 	return &wwn->wwn_group;
+
+drop_wwn:
+	tf->tf_ops->fabric_drop_wwn(wwn);
+	return ERR_PTR(ret);
 }
=20
 static void target_fabric_drop_wwn(
@@ -957,6 +987,8 @@ static void target_fabric_drop_wwn(
 	struct se_wwn *wwn =3D container_of(to_config_group(item),
 				struct se_wwn, wwn_group);
=20
+	kobject_del(wwn->kobj);
+	kobject_put(wwn->kobj);
 	configfs_remove_default_groups(&wwn->wwn_group);
 	config_item_put(item);
 }
diff --git a/drivers/target/target_core_internal.h b/drivers/target/targe=
t_core_internal.h
index 8533444..16ae020 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -27,6 +27,7 @@ struct target_backend {
 struct target_fabric_configfs {
 	atomic_t		tf_access_cnt;
 	struct list_head	tf_list;
+	struct kobject		*kobj;
 	struct config_group	tf_group;
 	struct config_group	tf_disc_group;
 	const struct target_core_fabric_ops *tf_ops;
diff --git a/include/target/target_core_base.h b/include/target/target_co=
re_base.h
index 6d4a694..9d38b53 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -8,6 +8,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/semaphore.h>     /* struct semaphore */
 #include <linux/completion.h>
+#include <linux/kobject.h>
=20
 #define TARGET_CORE_VERSION		"v5.0"
=20
@@ -890,6 +891,8 @@ struct se_portal_group {
 	/* Pointer to $FABRIC_MOD dependent code */
 	const struct target_core_fabric_ops *se_tpg_tfo;
 	struct se_wwn		*se_tpg_wwn;
+	struct kobject		*kobj;
+	struct kobject		*sessions_kobj;
 	struct config_group	tpg_group;
 	struct config_group	tpg_lun_group;
 	struct config_group	tpg_np_group;
@@ -928,6 +931,7 @@ struct se_wwn {
 	void			*priv;
 	struct config_group	wwn_group;
 	struct config_group	fabric_stat_group;
+	struct kobject		*kobj;
 };
=20
 static inline void atomic_inc_mb(atomic_t *v)
--=20
1.8.3.1

