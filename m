Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F861F0FBC
	for <lists+target-devel@lfdr.de>; Sun,  7 Jun 2020 22:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgFGUg3 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 7 Jun 2020 16:36:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42520 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgFGUgZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 7 Jun 2020 16:36:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 057KX6rl018275;
        Sun, 7 Jun 2020 20:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=jgyr2JkDKp3PUXRDBjruBVSLsx2itMrxKqHT7pKRPis=;
 b=rC+itO+gAb1QW22+nYvN7Yus9DDz8K4X9ZpQI32mK4NP9kDHRFemIb+9DaI2exA9HeHq
 6mp84lH/9oHZ9DtIAhPbj2jVO2FjlfLdmLGhloKOfW8XXblQA5MnZdN/ua+jteS0y2ak
 txs7Hs2D0vKpKQJOZLpGvtgoreyIRbKWywG8rtrKR/cf2Vl37aGCEv5g3yhMyCDej7h0
 2xFbasrQ+6AVkAjeKFuUP/fCfezqULFZAHjiu9VbFwMHLDxWXCP8mkwKcSkEd4hCRIN8
 /FpyFCXItspVstUO1h2aYty5u99x9nlh0Ze6UymqnrpDghAiV6oNJTcevEc+JA/at4jU KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31g33kv0qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 07 Jun 2020 20:36:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 057KS5v2076497;
        Sun, 7 Jun 2020 20:36:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31gmqk8a5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Jun 2020 20:36:12 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 057KaAsR003534;
        Sun, 7 Jun 2020 20:36:10 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 13:36:10 -0700
From:   Mike Christie <michael.christie@oracle.com>
To:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 02/17] target: separate acl name from port ids
Date:   Sun,  7 Jun 2020 15:35:49 -0500
Message-Id: <1591562164-9766-3-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
References: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=2 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006070161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006070161
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The PGR code assumes the ACL name is going to be based on the SPC4
transportID type of values. The problem is that for iSCSI we have an extra
session id as part of the SCSI port id and some fabric modules support or
would like to support non transportID values for the ACL name. For example,
iSCSI and SRP would like to use the source address for the ACL name, but
that is not a valud transportID value that you can get in a PGR request.

This patch adds a new transport_id struct which maps to the SPC4
transportID. In the future it will be used for PGR commands instead of the
ACL name. In this patchset it is used to export the initiator info in the
session's sysfs dir, so tools can display the info and daemons that execute
commands like PGRs in userspace can build a session id to I_T nexus mapping.

In this patch only srp is passing in different values for the transport id
and acl name. The next patches will convert loop, scsi vhost and xen
scsiback that are more complex due to their initiator name emulation.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Lee Duncan <lduncan@suse.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c    | 10 +++++---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |  4 +--
 drivers/scsi/qla2xxx/tcm_qla2xxx.c       |  2 +-
 drivers/target/loopback/tcm_loop.c       |  3 ++-
 drivers/target/sbp/sbp_target.c          |  2 +-
 drivers/target/target_core_fabric_lib.c  | 41 +++++++++++++++++++++++++++++++
 drivers/target/target_core_transport.c   | 42 ++++++++++++++++++++++++--------
 drivers/target/tcm_fc/tfc_sess.c         |  3 ++-
 drivers/usb/gadget/function/f_tcm.c      |  3 ++-
 drivers/vhost/scsi.c                     |  1 +
 drivers/xen/xen-scsiback.c               |  3 ++-
 include/target/target_core_base.h        | 12 +++++++++
 include/target/target_core_fabric.h      |  5 +++-
 13 files changed, 108 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9855274..d107f63 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2320,7 +2320,8 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 			break;
 		ch->sess = target_setup_session(&stpg->tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
-						ch->sess_name, ch, NULL);
+						i_port_id + 2, ch->sess_name,
+						ch, NULL);
 	}
 	mutex_unlock(&sport->port_guid_id.mutex);
 
@@ -2329,14 +2330,15 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 		if (!IS_ERR_OR_NULL(ch->sess))
 			break;
 		ch->sess = target_setup_session(&stpg->tpg, tag_num,
-					tag_size, TARGET_PROT_NORMAL, i_port_id,
-					ch, NULL);
+					tag_size, TARGET_PROT_NORMAL,
+					i_port_id + 2, i_port_id, ch, NULL);
 		if (!IS_ERR_OR_NULL(ch->sess))
 			break;
 		/* Retry without leading "0x" */
 		ch->sess = target_setup_session(&stpg->tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
-						i_port_id + 2, ch, NULL);
+						i_port_id + 2, i_port_id + 2,
+						ch, NULL);
 	}
 	mutex_unlock(&sport->port_gid_id.mutex);
 
diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index d9e94e8..31459f3 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -2223,8 +2223,8 @@ static int ibmvscsis_make_nexus(struct ibmvscsis_tport *tport)
 	}
 
 	nexus->se_sess = target_setup_session(&tport->se_tpg, 0, 0,
-					      TARGET_PROT_NORMAL, name, nexus,
-					      NULL);
+					      TARGET_PROT_NORMAL, name, name,
+					      nexus, NULL);
 	if (IS_ERR(nexus->se_sess)) {
 		rc = PTR_ERR(nexus->se_sess);
 		goto transport_init_fail;
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 1f0a185..7b21809 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -1483,7 +1483,7 @@ static int tcm_qla2xxx_check_initiator_node_acl(
 	 */
 	se_sess = target_setup_session(&tpg->se_tpg, num_tags,
 				       sizeof(struct qla_tgt_cmd),
-				       TARGET_PROT_ALL, port_name,
+				       TARGET_PROT_ALL, port_name, port_name,
 				       qlat_sess, tcm_qla2xxx_session_cb);
 	if (IS_ERR(se_sess))
 		return PTR_ERR(se_sess);
diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 3305b47..74aded7 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -742,7 +742,8 @@ static int tcm_loop_make_nexus(
 
 	tl_nexus->se_sess = target_setup_session(&tl_tpg->tl_se_tpg, 0, 0,
 					TARGET_PROT_DIN_PASS | TARGET_PROT_DOUT_PASS,
-					name, tl_nexus, tcm_loop_alloc_sess_cb);
+					name, name, tl_nexus,
+					tcm_loop_alloc_sess_cb);
 	if (IS_ERR(tl_nexus->se_sess)) {
 		ret = PTR_ERR(tl_nexus->se_sess);
 		kfree(tl_nexus);
diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index e4a9b9f..2cac4d9 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -199,7 +199,7 @@ static struct sbp_session *sbp_session_create(
 	sess->se_sess = target_setup_session(&tpg->se_tpg, 128,
 					     sizeof(struct sbp_target_request),
 					     TARGET_PROT_NORMAL, guid_str,
-					     sess, NULL);
+					     guid_str, sess, NULL);
 	if (IS_ERR(sess->se_sess)) {
 		pr_err("failed to init se_session\n");
 		ret = PTR_ERR(sess->se_sess);
diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index 1e031d8..e89b3d8 100644
--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -422,3 +422,44 @@ const char *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
 	*out_tid_len = 24;
 	return buf + offset;
 }
+
+struct t10_transport_id *target_create_transport_id(u8 proto, const char *name,
+						    const char *session_id)
+{
+	struct t10_transport_id *tpt_id;
+
+	tpt_id = kzalloc(sizeof(*tpt_id), GFP_KERNEL);
+	if (!tpt_id)
+		return NULL;
+	tpt_id->proto = proto;
+
+	tpt_id->name = kstrdup(name, GFP_KERNEL);
+	if (!tpt_id->name)
+		goto free_tpt_id;
+
+	if (session_id) {
+		tpt_id->session_id = kstrdup(session_id, GFP_KERNEL);
+		if (!tpt_id->session_id)
+			goto free_name;
+	}
+
+	return tpt_id;
+
+free_name:
+	kfree(tpt_id->name);
+free_tpt_id:
+	kfree(tpt_id);
+	return NULL;
+}
+EXPORT_SYMBOL(target_create_transport_id);
+
+void target_free_transport_id(struct t10_transport_id *tpt_id)
+{
+	if (!tpt_id)
+		return;
+
+	kfree(tpt_id->name);
+	kfree(tpt_id->session_id);
+	kfree(tpt_id);
+}
+EXPORT_SYMBOL(target_free_transport_id);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 264a822..c1b0d15 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -413,15 +413,27 @@ void transport_register_session(
 }
 EXPORT_SYMBOL(transport_register_session);
 
+/**
+ * target_setup_session - alloc and add a session to lio core
+ * @tpg: parent tpg
+ * @tag_num: if non-zero max num in-flight commands.
+ * @tag_size: if tag_num is non-zero, fabric driver's per cmd data in bytes.
+ * @prot_op: bitmask that defines which T10-PI modes are supported.
+ * @tpt_id_name: SCSI TransportID name/address/identifier
+ * @acl_name: name used for se_node_acl
+ * @private: storage for fabric driver accessible via fabric_sess_ptr
+ * @callback: opt function called before session has been added to lio core.
+ */
 struct se_session *
 target_setup_session(struct se_portal_group *tpg,
 		     unsigned int tag_num, unsigned int tag_size,
-		     enum target_prot_op prot_op,
-		     const char *initiatorname, void *private,
+		     enum target_prot_op prot_op, const char *tpt_id_name,
+		     const char *acl_name, void *private,
 		     int (*callback)(struct se_portal_group *,
 				     struct se_session *, void *))
 {
 	struct se_session *sess;
+	int rc;
 
 	/*
 	 * If the fabric driver is using percpu-ida based pre allocation
@@ -435,26 +447,35 @@ struct se_session *
 	if (IS_ERR(sess))
 		return sess;
 
+	sess->tpt_id = target_create_transport_id(tpg->proto_id, tpt_id_name,
+						  NULL);
+	if (!sess->tpt_id) {
+		rc = -ENOMEM;
+		goto free_sess;
+	}
+
 	sess->se_node_acl = core_tpg_check_initiator_node_acl(tpg,
-					(unsigned char *)initiatorname);
+					(unsigned char *)acl_name);
 	if (!sess->se_node_acl) {
-		transport_free_session(sess);
-		return ERR_PTR(-EACCES);
+		rc = -EACCES;
+		goto free_sess;
 	}
 	/*
 	 * Go ahead and perform any remaining fabric setup that is
 	 * required before transport_register_session().
 	 */
 	if (callback != NULL) {
-		int rc = callback(tpg, sess, private);
-		if (rc) {
-			transport_free_session(sess);
-			return ERR_PTR(rc);
-		}
+		rc = callback(tpg, sess, private);
+		if (rc)
+			goto free_sess;
 	}
 
 	transport_register_session(tpg, sess->se_node_acl, sess, private);
 	return sess;
+
+free_sess:
+	transport_free_session(sess);
+	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL(target_setup_session);
 
@@ -579,6 +600,7 @@ void transport_free_session(struct se_session *se_sess)
 		sbitmap_queue_free(&se_sess->sess_tag_pool);
 		kvfree(se_sess->sess_cmd_map);
 	}
+	target_free_transport_id(se_sess->tpt_id);
 	percpu_ref_exit(&se_sess->cmd_count);
 	kmem_cache_free(se_sess_cache, se_sess);
 }
diff --git a/drivers/target/tcm_fc/tfc_sess.c b/drivers/target/tcm_fc/tfc_sess.c
index 4fd6a1d..1d1c460 100644
--- a/drivers/target/tcm_fc/tfc_sess.c
+++ b/drivers/target/tcm_fc/tfc_sess.c
@@ -230,7 +230,8 @@ static struct ft_sess *ft_sess_create(struct ft_tport *tport, u32 port_id,
 	sess->se_sess = target_setup_session(se_tpg, TCM_FC_DEFAULT_TAGS,
 					     sizeof(struct ft_cmd),
 					     TARGET_PROT_NORMAL, &initiatorname[0],
-					     sess, ft_sess_alloc_cb);
+					     &initiatorname[0], sess,
+					     ft_sess_alloc_cb);
 	if (IS_ERR(sess->se_sess)) {
 		int rc = PTR_ERR(sess->se_sess);
 		kfree(sess);
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 3650493..cab3036 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1583,7 +1583,8 @@ static int tcm_usbg_make_nexus(struct usbg_tpg *tpg, char *name)
 						     USB_G_DEFAULT_SESSION_TAGS,
 						     sizeof(struct usbg_cmd),
 						     TARGET_PROT_NORMAL, name,
-						     tv_nexus, usbg_alloc_sess_cb);
+						     name, tv_nexus,
+						     usbg_alloc_sess_cb);
 	if (IS_ERR(tv_nexus->tvn_se_sess)) {
 #define MAKE_NEXUS_MSG "core_tpg_check_initiator_node_acl() failed for %s\n"
 		pr_debug(MAKE_NEXUS_MSG, name);
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index c399522..15aabc2 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1964,6 +1964,7 @@ static int vhost_scsi_make_nexus(struct vhost_scsi_tpg *tpg,
 					VHOST_SCSI_DEFAULT_TAGS,
 					sizeof(struct vhost_scsi_cmd),
 					TARGET_PROT_DIN_PASS | TARGET_PROT_DOUT_PASS,
+					(unsigned char *)name,
 					(unsigned char *)name, tv_nexus,
 					vhost_scsi_nexus_cb);
 	if (IS_ERR(tv_nexus->tvn_se_sess)) {
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 75c0a2e..93cb386 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1531,7 +1531,8 @@ static int scsiback_make_nexus(struct scsiback_tpg *tpg,
 						     VSCSI_DEFAULT_SESSION_TAGS,
 						     sizeof(struct vscsibk_pend),
 						     TARGET_PROT_NORMAL, name,
-						     tv_nexus, scsiback_alloc_sess_cb);
+						     name, tv_nexus,
+						     scsiback_alloc_sess_cb);
 	if (IS_ERR(tv_nexus->tvn_se_sess)) {
 		kfree(tv_nexus);
 		ret = -ENOMEM;
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 6d4a694..2e79cce 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -331,6 +331,17 @@ struct t10_wwn {
 	struct list_head t10_vpd_list;
 };
 
+struct t10_transport_id {
+	/* The format=0 transport specific port id/name value. */
+	char *name;
+	/*
+	 * If proto is iSCSI and it's using format=1, then this is set to the
+	 * initiator session id string defined in spc4r37 table 508.
+	 */
+	char *session_id;
+	u8 proto;
+};
+
 struct t10_pr_registration {
 	/* Used for fabrics that contain WWN+ISID */
 #define PR_REG_ISID_LEN				16
@@ -610,6 +621,7 @@ static inline struct se_node_acl *fabric_stat_to_nacl(struct config_item *item)
 struct se_session {
 	unsigned		sess_tearing_down:1;
 	u64			sess_bin_isid;
+	struct t10_transport_id	*tpt_id;
 	enum target_prot_op	sup_prot_ops;
 	enum target_prot_type	sess_prot_type;
 	struct se_node_acl	*se_node_acl;
diff --git a/include/target/target_core_fabric.h b/include/target/target_core_fabric.h
index 063f133..af1dd81 100644
--- a/include/target/target_core_fabric.h
+++ b/include/target/target_core_fabric.h
@@ -125,9 +125,12 @@ struct target_core_fabric_ops {
 int target_depend_item(struct config_item *item);
 void target_undepend_item(struct config_item *item);
 
+struct t10_transport_id *target_create_transport_id(u8, const char *,
+						    const char *);
+void target_free_transport_id(struct t10_transport_id *);
 struct se_session *target_setup_session(struct se_portal_group *,
 		unsigned int, unsigned int, enum target_prot_op prot_op,
-		const char *, void *,
+		const char *, const char *, void *,
 		int (*callback)(struct se_portal_group *,
 				struct se_session *, void *));
 void target_remove_session(struct se_session *);
-- 
1.8.3.1

