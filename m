Return-Path: <target-devel+bounces-256-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A99E2CC4
	for <lists+target-devel@lfdr.de>; Tue,  3 Dec 2024 21:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0DDB21832
	for <lists+target-devel@lfdr.de>; Tue,  3 Dec 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F99201006;
	Tue,  3 Dec 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OdgkzgCm"
X-Original-To: target-devel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43E1FF7C3
	for <target-devel@vger.kernel.org>; Tue,  3 Dec 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253447; cv=none; b=XTbX/daWwIw/0pmfRW9pNfWY73BxEPY1Gf7inthIsQL3ZtBF1qlDxy/z1vP6cI96/F4NoBAB5QeOhkepH/PVHZ1LGVTbzLTnVAzqw5eYAKwFh7a2zNhp+LPQ8g6V5TNTkVWRf59yocPj7+gKQiIJJ24lxRVJS23hzCAg4VAoLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253447; c=relaxed/simple;
	bh=g5KAPpaVIq6iI5mLGXo4f1TQI4CCX9dFFZ8275I9w90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7gt935+0e725NMjPY2cRpJixVH98LfWGoGADPpJkyQ6JK+lyfMVisHXqrQyVxnqPMPOCxrMD7tjlJxQ6hF1N0vCizbm4dzu/2myb28KJLrzpKnXEInzDL3IkwoLf2h6Sb7cf+45eU9BUqRsBCGN4Eh2sq1+GHq/QeHaWuJ4FeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OdgkzgCm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtXWQ006127;
	Tue, 3 Dec 2024 19:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=S6kl/
	Ro/QOX5/UZ2gQNW2GNyiNg+zdzde9cm+ggPlw4=; b=OdgkzgCmb+h2+PmUHQV8k
	uiqEFeuwKY5JOHuQffYUcidVJDeosppN+YyCJxaoOFCATMWdZvsV8/0LC1PpfRRE
	5TLILzbsZOAAnqx1vwmXzXc/4WiqmMobH5x/X2jSFtkbUer7VK5sC9E/Y/7KgObJ
	ir2kgogrQWxcS+IbXZH+jjWV7+tpeYnq7JIcIKyLO2HDBdWrgDF+yViMc3MEodJZ
	YahfXiSMDZ9EiM8byxCoLsIX8yjLX+jmb3RHhxaZFlTgcE4y4vh6TMntR4MsoqzV
	MxWT5X71ukIQw1h+doUOTd2fxqyOQLZuK/cuyc6aTqPKFexIkm6nwAvqfIrZjP/8
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbpw2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 19:17:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HYaM6001920;
	Tue, 3 Dec 2024 19:17:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s58akh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 19:17:19 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B3JH9MO021603;
	Tue, 3 Dec 2024 19:17:19 GMT
Received: from mnc-mac.us.oracle.com (dhcp-10-65-163-31.vpn.oracle.com [10.65.163.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 437s58ak94-9;
	Tue, 03 Dec 2024 19:17:19 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, pbonzini@redhat.com, target-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 8/8] vhost-scsi: Reduce response iov mem use
Date: Tue,  3 Dec 2024 13:15:15 -0600
Message-ID: <20241203191705.19431-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203191705.19431-1-michael.christie@oracle.com>
References: <20241203191705.19431-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_08,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030159
X-Proofpoint-GUID: oEZQfg7-4mWY3P5-6oNmkOvrg92PMkEG
X-Proofpoint-ORIG-GUID: oEZQfg7-4mWY3P5-6oNmkOvrg92PMkEG

We have to save N iov entries to copy the virtio_scsi_cmd_resp struct
back to the guest's buffer. The difficulty is that we can't assume the
virtio_scsi_cmd_resp will be in 1 iov because older virtio specs allowed
you to break it up.

The worst case is that the guest was doing something like breaking up
the virtio_scsi_cmd_resp struct into 108 (the struct is 108 bytes)
byte sized vecs like:

iov[0].iov_base = ((unsigned char *)virtio_scsi_cmd_resp)[0]
iov[0].iov_len = 1
iov[1].iov_base =  ((unsigned char *)virtio_scsi_cmd_resp)[1]
iov[1].iov_len = 1
....
iov[107].iov_base = ((unsigned char *)virtio_scsi_cmd_resp)[107]
iov[1].iov_len = 1

Right now we allocate UIO_MAXIOV vecs which is 1024 and so for a small
device with just 1 queue and 128 commands per queue, we are wasting

1.8 MB = (1024 current entries - 108) * 16 bytes per entry * 128 cmds

The most common case is going to be where the initiator puts the entire
virtio_scsi_cmd_resp in the first iov and does not split it. We've
always done it this way for Linux and the windows driver looks like
it's always done the same. It's highly unlikely anyone has ever split
the response and if they did it might just be where they have the
sense in a second iov but that doesn't seem likely as well.

So to optimize for the common implementation, this has us only
pre-allocate the single iovec. If we do hit the split up response case
this has us allocate the needed iovec when needed.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 82 ++++++++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 22 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index ca93089c9f8e..9a4cbdc607fa 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -45,6 +45,11 @@
 #define VHOST_SCSI_PREALLOC_SGLS 2048
 #define VHOST_SCSI_PREALLOC_UPAGES 2048
 #define VHOST_SCSI_PREALLOC_PROT_SGLS 2048
+/*
+ * For the legacy descriptor case we allocate an iov per byte in the
+ * virtio_scsi_cmd_resp struct.
+ */
+#define VHOST_SCSI_MAX_RESP_IOVS sizeof(struct virtio_scsi_cmd_resp)
 
 static unsigned int vhost_scsi_inline_sg_cnt = VHOST_SCSI_PREALLOC_SGLS;
 
@@ -106,8 +111,6 @@ struct vhost_scsi_inflight {
 struct vhost_scsi_cmd {
 	/* Descriptor from vhost_get_vq_desc() for virt_queue segment */
 	int tvc_vq_desc;
-	/* virtio-scsi response incoming iovecs */
-	int tvc_in_iovs;
 	/* The number of scatterlists associated with this cmd */
 	u32 tvc_sgl_count;
 	u32 tvc_prot_sgl_count;
@@ -118,8 +121,12 @@ struct vhost_scsi_cmd {
 	struct sg_table table;
 	struct scatterlist *prot_sgl;
 	struct sg_table prot_table;
-	/* Pointer to response header iovec */
-	struct iovec *tvc_resp_iov;
+	/* Fast path response header iovec used when only one vec is needed */
+	struct iovec tvc_resp_iov;
+	/* Number of iovs for response */
+	unsigned int tvc_resp_iovs_cnt;
+	/* Pointer to response header iovecs if more than one is needed */
+	struct iovec *tvc_resp_iovs;
 	/* Pointer to vhost_virtqueue for the cmd */
 	struct vhost_virtqueue *tvc_vq;
 	/* The TCM I/O descriptor that is accessed via container_of() */
@@ -391,6 +398,8 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 		sg_free_table_chained(&tv_cmd->prot_table, vs->inline_sg_cnt);
 	}
 
+	if (tv_cmd->tvc_resp_iovs != &tv_cmd->tvc_resp_iov)
+		kfree(tv_cmd->tvc_resp_iovs);
 	sbitmap_clear_bit(&svq->scsi_tags, se_cmd->map_tag);
 	vhost_scsi_put_inflight(inflight);
 }
@@ -638,8 +647,8 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 			       se_cmd->scsi_sense_length);
 		}
 
-		iov_iter_init(&iov_iter, ITER_DEST, cmd->tvc_resp_iov,
-			      cmd->tvc_in_iovs, sizeof(v_rsp));
+		iov_iter_init(&iov_iter, ITER_DEST, cmd->tvc_resp_iovs,
+			      cmd->tvc_resp_iovs_cnt, sizeof(v_rsp));
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
 			signal = true;
@@ -662,7 +671,6 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, u64 scsi_tag)
 					struct vhost_scsi_virtqueue, vq);
 	struct vhost_scsi_cmd *cmd;
 	struct scatterlist *sgl, *prot_sgl;
-	struct iovec *tvc_resp_iov;
 	int tag;
 
 	tag = sbitmap_get(&svq->scsi_tags);
@@ -674,13 +682,11 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, u64 scsi_tag)
 	cmd = &svq->scsi_cmds[tag];
 	sgl = cmd->sgl;
 	prot_sgl = cmd->prot_sgl;
-	tvc_resp_iov = cmd->tvc_resp_iov;
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->sgl = sgl;
 	cmd->prot_sgl = prot_sgl;
 	cmd->tvc_se_cmd.map_tag = tag;
 	cmd->inflight = vhost_scsi_get_inflight(vq);
-	cmd->tvc_resp_iov = tvc_resp_iov;
 
 	return cmd;
 }
@@ -1124,6 +1130,43 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
 	return ret;
 }
 
+static int
+vhost_scsi_setup_resp_iovs(struct vhost_scsi_cmd *cmd, struct iovec *in_iovs,
+			   unsigned int in_iovs_cnt)
+{
+	int i, cnt;
+
+	if (!in_iovs_cnt)
+		return 0;
+	/*
+	 * Initiator's normally just put the virtio_scsi_cmd_resp in the first
+	 * iov, but just in case they wedged in some data with it we check for
+	 * greater than or equal to the response struct.
+	 */
+	if (in_iovs[0].iov_len >= sizeof(struct virtio_scsi_cmd_resp)) {
+		cmd->tvc_resp_iovs = &cmd->tvc_resp_iov;
+		cmd->tvc_resp_iovs_cnt = 1;
+	} else {
+		/*
+		 * Legacy descriptor layouts didn't specify that we must put
+		 * the entire response in one iov. Worst case we have a
+		 * iov per byte.
+		 */
+		cnt = min(VHOST_SCSI_MAX_RESP_IOVS, in_iovs_cnt);
+		cmd->tvc_resp_iovs = kcalloc(cnt, sizeof(struct iovec),
+					     GFP_KERNEL);
+		if (!cmd->tvc_resp_iovs)
+			return -ENOMEM;
+
+		cmd->tvc_resp_iovs_cnt = cnt;
+	}
+
+	for (i = 0; i < cmd->tvc_resp_iovs_cnt; i++)
+		cmd->tvc_resp_iovs[i] = in_iovs[i];
+
+	return 0;
+}
+
 static u16 vhost_buf_to_lun(u8 *lun_buf)
 {
 	return ((lun_buf[2] << 8) | lun_buf[3]) & 0x3FFF;
@@ -1141,7 +1184,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 	struct iov_iter in_iter, prot_iter, data_iter;
 	u64 tag;
 	u32 exp_data_len, data_direction;
-	int ret, prot_bytes, i, c = 0;
+	int ret, prot_bytes, c = 0;
 	u16 lun;
 	u8 task_attr;
 	bool t10_pi = vhost_has_feature(vq, VIRTIO_SCSI_F_T10_PI);
@@ -1303,9 +1346,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 			goto err;
 		}
 		cmd->tvc_vq = vq;
-		for (i = 0; i < vc.in ; i++)
-			cmd->tvc_resp_iov[i] = vq->iov[vc.out + i];
-		cmd->tvc_in_iovs = vc.in;
+
+		ret = vhost_scsi_setup_resp_iovs(cmd, &vq->iov[vc.out], vc.in);
+		if (ret) {
+			vq_err(vq, "Failed to alloc recv iovs\n");
+			vhost_scsi_release_cmd_res(&cmd->tvc_se_cmd);
+			goto err;
+		}
 
 		pr_debug("vhost_scsi got command opcode: %#02x, lun: %d\n",
 			 cdb[0], lun);
@@ -1686,7 +1733,6 @@ static void vhost_scsi_destroy_vq_cmds(struct vhost_virtqueue *vq)
 
 		kfree(tv_cmd->sgl);
 		kfree(tv_cmd->prot_sgl);
-		kfree(tv_cmd->tvc_resp_iov);
 	}
 
 	sbitmap_free(&svq->scsi_tags);
@@ -1735,14 +1781,6 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
 			}
 		}
 
-		tv_cmd->tvc_resp_iov = kcalloc(UIO_MAXIOV,
-					       sizeof(struct iovec),
-					       GFP_KERNEL);
-		if (!tv_cmd->tvc_resp_iov) {
-			pr_err("Unable to allocate tv_cmd->tvc_resp_iov\n");
-			goto out;
-		}
-
 		if (vhost_has_feature(vq, VIRTIO_SCSI_F_T10_PI) &&
 		    vs->inline_sg_cnt) {
 			tv_cmd->prot_sgl = kcalloc(vs->inline_sg_cnt,
-- 
2.34.1


