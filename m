Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00A1F0FB2
	for <lists+target-devel@lfdr.de>; Sun,  7 Jun 2020 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgFGUgZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 7 Jun 2020 16:36:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgFGUgX (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 7 Jun 2020 16:36:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 057KX5pY125916;
        Sun, 7 Jun 2020 20:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=v6jxZOi8tREBD/siNCuNcz0iq0JfGXNVyyCVwBym44g=;
 b=JMrJ59jrT0Gn5CwE1kyB2lMUAmExnErgGxIAiVF32QX4Uqm0PlWcBQGvfzzByRQTOdTj
 INt2o46U0D5E9/iCstFB/2mmRHiHFZlbLn5gJRfK1LC1esd/bkFogjzrvRIGv7vYgp8r
 XU2CvgA6i1RJvc4FUUs0NaNTEzpuRCpOQbLPpXdSeOc3XJaiUI7h9UCe+2UHI/IwACsO
 OomZDW46chzn+989Jlq8v3EiG25p9a1qt290cMXCr+2Ly1E0i+iiyuHKDgOOtc9FYBnt
 q3RcN2dqsvOO4GS8sTHIiAZl1tv36OCiE/RH20am3RDF8op2AAHrJVyUYLCkvEMTdcyV qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smkxfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 07 Jun 2020 20:36:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 057KRvWt015877;
        Sun, 7 Jun 2020 20:36:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31gn2u8667-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Jun 2020 20:36:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 057KaHhA024049;
        Sun, 7 Jun 2020 20:36:17 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 13:36:16 -0700
From:   Mike Christie <michael.christie@oracle.com>
To:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH 15/17] iscsi target: hook iscsi target into sysfs API
Date:   Sun,  7 Jun 2020 15:36:02 -0500
Message-Id: <1591562164-9766-16-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
References: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006070161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=2
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006070161
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Have the iscsi target export it's sessions in sysfs.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/target/iscsi/iscsi_target.c      | 2 ++
 drivers/target/iscsi/iscsi_target_nego.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 4c73374..f26d364 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4383,6 +4383,8 @@ int iscsit_close_session(struct iscsi_session *sess)
 		}
 	}
 
+	target_sysfs_remove_session(sess->se_sess);
+
 	if (sess->sess_ops->ErrorRecoveryLevel == 2)
 		iscsit_free_connection_recovery_entries(sess);
 
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index c44613a2..6dcb8ff 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -359,6 +359,13 @@ static int iscsi_target_do_tx_login_io(struct iscsi_conn *conn, struct iscsi_log
 					    ISCSI_LOGIN_STATUS_NO_RESOURCES);
 			return -1;
 		}
+
+		if (target_sysfs_add_session(&conn->tpg->tpg_se_tpg,
+					     conn->sess->se_sess)) {
+			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
+					    ISCSI_LOGIN_STATUS_NO_RESOURCES);
+			return -1;
+		}
 	}
 
 	if (conn->conn_transport->iscsit_put_login_tx(conn, login,
@@ -371,6 +378,8 @@ static int iscsi_target_do_tx_login_io(struct iscsi_conn *conn, struct iscsi_log
 
 err:
 	if (login->login_complete) {
+		target_sysfs_remove_session(conn->sess->se_sess);
+
 		if (conn->rx_thread && conn->rx_thread_active) {
 			send_sig(SIGINT, conn->rx_thread, 1);
 			complete(&conn->rx_login_comp);
-- 
1.8.3.1

