Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8992ACF30
	for <lists+target-devel@lfdr.de>; Tue, 10 Nov 2020 06:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgKJFdo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 10 Nov 2020 00:33:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbgKJFdm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 10 Nov 2020 00:33:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA5KFkr034278;
        Tue, 10 Nov 2020 05:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=40yOLbwH8bI/b2UzX7WEuVr/Eyp6wnp0cW6Oj7ayTEA=;
 b=zs9PoixMPxj1Ku0OP2szOSDw07U0ju7bMk06SHpXIGoA+XG1WJwC6SfCs7BlQCurLhSm
 8C3Ct8QHKHWKpAug/03tY7O9gelY6rLAytSxWAeiU0JtaxGloJN8v5vST/7RVymE2Yvp
 nBr84bpfn4aGUPX4FwUV+PQ8e8NVTTCYgTl4+mrT7F+CKxwYTw+JG0yqvU3x1gOhFFAN
 ZvJjp+5ke3d1jUh2jyhN3fAAC4f5L9v9mJ4CN2e+Rh8kaP1gX81uoGPTk9UuwtSlu7GN
 73QqV+MRjM27V4uvKmvmphLWgn8b0FsXgvPhmYMlCjXNdjuEVSSloLSq2f/6x17oCB9t MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34nkhksm31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 05:33:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA5FAnf193309;
        Tue, 10 Nov 2020 05:33:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34p55myv4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 05:33:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AA5XYQS022479;
        Tue, 10 Nov 2020 05:33:34 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 21:33:34 -0800
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH 5/5] vhost scsi: Add support for LUN resets.
Date:   Mon,  9 Nov 2020 23:33:23 -0600
Message-Id: <1604986403-4931-6-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604986403-4931-1-git-send-email-michael.christie@oracle.com>
References: <1604986403-4931-1-git-send-email-michael.christie@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=2 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100037
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

In newer versions of virtio-scsi we just reset the timer when an a
command times out, so TMFs are never sent for the cmd time out case.
However, in older kernels and for the TMF inject cases, we can still get
resets and we end up just failing immediately so the guest might see the
device get offlined and IO errors.

For the older kernel cases, we want the same end result as the
modern virtio-scsi driver where we let the lower levels fire their error
handling and handle the problem. And at the upper levels we want to
wait. This patch ties the LUN reset handling into the LIO TMF code which
will just wait for outstanding commands to complete like we are doing in
the modern virtio-scsi case.

Note: I did not handle the ABORT case to keep this simple. For ABORTs
LIO just waits on the cmd like how it does for the RESET case. If
an ABORT fails, the guest OS ends up escalating to LUN RESET, so in
the end we get the same behavior where we wait on the outstanding
cmds.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 134 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index ed7dc6b..f22fce5 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -139,6 +139,7 @@ struct vhost_scsi_tpg {
 	struct se_portal_group se_tpg;
 	/* Pointer back to vhost_scsi, protected by tv_tpg_mutex */
 	struct vhost_scsi *vhost_scsi;
+	struct list_head tmf_queue;
 };
 
 struct vhost_scsi_tport {
@@ -211,6 +212,20 @@ struct vhost_scsi {
 	int vs_events_nr; /* num of pending events, protected by vq->mutex */
 };
 
+struct vhost_scsi_tmf {
+	struct vhost_work vwork;
+	struct vhost_scsi_tpg *tpg;
+	struct vhost_scsi *vhost;
+	struct vhost_scsi_virtqueue *svq;
+	struct list_head queue_entry;
+
+	struct se_cmd se_cmd;
+	struct vhost_scsi_inflight *inflight;
+	struct iovec resp_iov;
+	int in_iovs;
+	int vq_desc;
+};
+
 /*
  * Context for processing request and control queue operations.
  */
@@ -344,14 +359,32 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 	vhost_scsi_put_inflight(inflight);
 }
 
+static void vhost_scsi_release_tmf_res(struct vhost_scsi_tmf *tmf)
+{
+	struct vhost_scsi_tpg *tpg = tmf->tpg;
+	struct vhost_scsi_inflight *inflight = tmf->inflight;
+
+	mutex_lock(&tpg->tv_tpg_mutex);
+	list_add_tail(&tpg->tmf_queue, &tmf->queue_entry);
+	mutex_unlock(&tpg->tv_tpg_mutex);
+	vhost_scsi_put_inflight(inflight);
+}
+
 static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 {
-	struct vhost_scsi_cmd *cmd = container_of(se_cmd,
+	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB) {
+		struct vhost_scsi_tmf *tmf = container_of(se_cmd,
+					struct vhost_scsi_tmf, se_cmd);
+
+		vhost_work_queue(&tmf->vhost->dev, &tmf->vwork);
+	} else {
+		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
 					struct vhost_scsi_cmd, tvc_se_cmd);
-	struct vhost_scsi *vs = cmd->tvc_vhost;
+		struct vhost_scsi *vs = cmd->tvc_vhost;
 
-	llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
-	vhost_work_queue(&vs->dev, &vs->vs_completion_work);
+		llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
+		vhost_work_queue(&vs->dev, &vs->vs_completion_work);
+	}
 }
 
 static u32 vhost_scsi_sess_get_index(struct se_session *se_sess)
@@ -390,7 +423,10 @@ static int vhost_scsi_queue_status(struct se_cmd *se_cmd)
 
 static void vhost_scsi_queue_tm_rsp(struct se_cmd *se_cmd)
 {
-	return;
+	struct vhost_scsi_tmf *tmf = container_of(se_cmd, struct vhost_scsi_tmf,
+						  se_cmd);
+
+	transport_generic_free_cmd(&tmf->se_cmd, 0);
 }
 
 static void vhost_scsi_aborted_task(struct se_cmd *se_cmd)
@@ -1120,9 +1156,9 @@ static u16 vhost_buf_to_lun(u8 *lun_buf)
 }
 
 static void
-vhost_scsi_send_tmf_reject(struct vhost_scsi *vs,
-			   struct vhost_virtqueue *vq,
-			   struct vhost_scsi_ctx *vc)
+vhost_scsi_send_tmf_resp(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
+			 int in_iovs, int vq_desc, struct iovec *resp_iov,
+			 int tmf_resp_code)
 {
 	struct virtio_scsi_ctrl_tmf_resp rsp;
 	struct iov_iter iov_iter;
@@ -1130,17 +1166,87 @@ static u16 vhost_buf_to_lun(u8 *lun_buf)
 
 	pr_debug("%s\n", __func__);
 	memset(&rsp, 0, sizeof(rsp));
-	rsp.response = VIRTIO_SCSI_S_FUNCTION_REJECTED;
+	rsp.response = tmf_resp_code;
 
-	iov_iter_init(&iov_iter, READ, &vq->iov[vc->out], vc->in, sizeof(rsp));
+	iov_iter_init(&iov_iter, READ, resp_iov, in_iovs, sizeof(rsp));
 
 	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
 	if (likely(ret == sizeof(rsp)))
-		vhost_add_used_and_signal(&vs->dev, vq, vc->head, 0);
+		vhost_add_used_and_signal(&vs->dev, vq, vq_desc, 0);
 	else
 		pr_err("Faulted on virtio_scsi_ctrl_tmf_resp\n");
 }
 
+static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
+{
+	struct vhost_scsi_tmf *tmf = container_of(work, struct vhost_scsi_tmf,
+						  vwork);
+	int resp_code;
+
+	if (tmf->se_cmd.se_tmr_req->response == TMR_FUNCTION_COMPLETE)
+		resp_code = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
+	else
+		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
+
+	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
+				 tmf->vq_desc, &tmf->resp_iov, resp_code);
+	vhost_scsi_release_tmf_res(tmf);
+}
+
+static void
+vhost_scsi_handle_tmf(struct vhost_scsi *vs, struct vhost_scsi_tpg *tpg,
+		      struct vhost_virtqueue *vq,
+		      struct virtio_scsi_ctrl_tmf_req *vtmf,
+		      struct vhost_scsi_ctx *vc)
+{
+	struct vhost_scsi_virtqueue *svq = container_of(vq,
+					struct vhost_scsi_virtqueue, vq);
+	struct vhost_scsi_tmf *tmf;
+
+	if (vhost32_to_cpu(vq, vtmf->subtype) !=
+	    VIRTIO_SCSI_T_TMF_LOGICAL_UNIT_RESET)
+		goto send_reject;
+
+	if (!tpg->tpg_nexus || !tpg->tpg_nexus->tvn_se_sess) {
+		pr_err("Unable to locate active struct vhost_scsi_nexus for LUN RESET.\n");
+		goto send_reject;
+	}
+
+	mutex_lock(&tpg->tv_tpg_mutex);
+	if (list_empty(&tpg->tmf_queue)) {
+		pr_err("Missing reserve TMF. Could not handle LUN RESET.\n");
+		mutex_unlock(&tpg->tv_tpg_mutex);
+		goto send_reject;
+	}
+
+	tmf = list_first_entry(&tpg->tmf_queue, struct vhost_scsi_tmf,
+			       queue_entry);
+	list_del_init(&tmf->queue_entry);
+	mutex_unlock(&tpg->tv_tpg_mutex);
+
+	tmf->tpg = tpg;
+	tmf->vhost = vs;
+	tmf->svq = svq;
+	tmf->resp_iov = vq->iov[vc->out];
+	tmf->vq_desc = vc->head;
+	tmf->in_iovs = vc->in;
+	tmf->inflight = vhost_scsi_get_inflight(vq);
+
+	if (target_submit_tmr(&tmf->se_cmd, tpg->tpg_nexus->tvn_se_sess, NULL,
+			      vhost_buf_to_lun(vtmf->lun), NULL,
+			      TMR_LUN_RESET, GFP_KERNEL, 0,
+			      TARGET_SCF_ACK_KREF) < 0) {
+		vhost_scsi_release_tmf_res(tmf);
+		goto send_reject;
+	}
+
+	return;
+
+send_reject:
+	vhost_scsi_send_tmf_resp(vs, vq, vc->in, vc->head, &vq->iov[vc->out],
+				 VIRTIO_SCSI_S_FUNCTION_REJECTED);
+}
+
 static void
 vhost_scsi_send_an_resp(struct vhost_scsi *vs,
 			struct vhost_virtqueue *vq,
@@ -1166,6 +1272,7 @@ static u16 vhost_buf_to_lun(u8 *lun_buf)
 static void
 vhost_scsi_ctl_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 {
+	struct vhost_scsi_tpg *tpg;
 	union {
 		__virtio32 type;
 		struct virtio_scsi_ctrl_an_req an;
@@ -1247,12 +1354,12 @@ static u16 vhost_buf_to_lun(u8 *lun_buf)
 		vc.req += typ_size;
 		vc.req_size -= typ_size;
 
-		ret = vhost_scsi_get_req(vq, &vc, NULL);
+		ret = vhost_scsi_get_req(vq, &vc, &tpg);
 		if (ret)
 			goto err;
 
 		if (v_req.type == VIRTIO_SCSI_T_TMF)
-			vhost_scsi_send_tmf_reject(vs, vq, &vc);
+			vhost_scsi_handle_tmf(vs, tpg, vq, &v_req.tmf, &vc);
 		else
 			vhost_scsi_send_an_resp(vs, vq, &vc);
 err:
@@ -1913,11 +2020,19 @@ static int vhost_scsi_port_link(struct se_portal_group *se_tpg,
 {
 	struct vhost_scsi_tpg *tpg = container_of(se_tpg,
 				struct vhost_scsi_tpg, se_tpg);
+	struct vhost_scsi_tmf *tmf;
+
+	tmf = kzalloc(sizeof(*tmf), GFP_KERNEL);
+	if (!tmf)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&tmf->queue_entry);
+	vhost_work_init(&tmf->vwork, vhost_scsi_tmf_resp_work);
 
 	mutex_lock(&vhost_scsi_mutex);
 
 	mutex_lock(&tpg->tv_tpg_mutex);
 	tpg->tv_tpg_port_count++;
+	list_add_tail(&tmf->queue_entry, &tpg->tmf_queue);
 	mutex_unlock(&tpg->tv_tpg_mutex);
 
 	vhost_scsi_hotplug(tpg, lun);
@@ -1932,11 +2047,16 @@ static void vhost_scsi_port_unlink(struct se_portal_group *se_tpg,
 {
 	struct vhost_scsi_tpg *tpg = container_of(se_tpg,
 				struct vhost_scsi_tpg, se_tpg);
+	struct vhost_scsi_tmf *tmf;
 
 	mutex_lock(&vhost_scsi_mutex);
 
 	mutex_lock(&tpg->tv_tpg_mutex);
 	tpg->tv_tpg_port_count--;
+	tmf = list_first_entry(&tpg->tmf_queue, struct vhost_scsi_tmf,
+			       queue_entry);
+	list_del(&tmf->queue_entry);
+	kfree(tmf);
 	mutex_unlock(&tpg->tv_tpg_mutex);
 
 	vhost_scsi_hotunplug(tpg, lun);
@@ -2197,6 +2317,7 @@ static ssize_t vhost_scsi_tpg_nexus_store(struct config_item *item,
 	}
 	mutex_init(&tpg->tv_tpg_mutex);
 	INIT_LIST_HEAD(&tpg->tv_tpg_list);
+	INIT_LIST_HEAD(&tpg->tmf_queue);
 	tpg->tport = tport;
 	tpg->tport_tpgt = tpgt;
 
-- 
1.8.3.1

