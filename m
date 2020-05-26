Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC131DDA02
	for <lists+target-devel@lfdr.de>; Fri, 22 May 2020 00:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgEUWNh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 21 May 2020 18:13:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgEUWNg (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 21 May 2020 18:13:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LMDXWb059175;
        Thu, 21 May 2020 22:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=RQ2C7FnbPSYIwbPTG05e0XXleG+erbn2rt5WqAx+uLw=;
 b=p+yVAsbOSEmjMebJq2nMdOpGOdtlyFPxiPy7uT/tOtnYzc1FVnrJ3Homsk+3cAEUtUPB
 6bx4h8DTcMLS/efzZ6cwY+j8S47LInfD4io2XIzS9WK+ZYXLBe5qKL58lDwQcuc2RWbj
 vD7m/fP906EXNH6IrLcAG6q9s4dUhe8soxYosP9e+qR2dP9uG3izIucSY9tHc/xSj2FH
 MxNrKFo/iXwKvluzCOILMMRa8AL8YIMiby0pSBko2jTOTUMtxJ3BtBKMdn0dgw6NANV/
 ZzqVYq0kPqrgvv+MU4SSSpIPBMcSp+x0y26pvOQwYAevgxXG3kwZuD1zDLZgWljpcoUA 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31501rhfg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 22:13:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LMCgD6187487;
        Thu, 21 May 2020 22:13:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 313gj6d2cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 22:13:32 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04LMDVTI005377;
        Thu, 21 May 2020 22:13:31 GMT
Received: from supannee-devvm-ol7.osdevelopmeniad.oraclevcn.com (/100.100.231.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 15:13:31 -0700
From:   Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>
To:     martin.petersen@oracle.com, mchristi@redhat.com,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     shirley.ma@oracle.com
Subject: [PATCH v2 0/3] target: fix NULL pointer dereference
Date:   Thu, 21 May 2020 22:13:22 +0000
Message-Id: <1590099205-7997-1-git-send-email-sudhakar.panneerselvam@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210165
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The following set of commits address a NULL pointer dereference and some
refactoring around this issue.

v2:
 - new helper is named as target_cmd_init_cdb()
 - existing function, target_setup_cmd_from_cdb is renamed as
   target_cmd_parse_cdb()

Sudhakar Panneerselvam (3):
  target: factor out a new helper, target_cmd_init_cdb()
  target: fix NULL pointer dereference
  target: rename target_setup_cmd_from_cdb() to target_cmd_parse_cdb()

 drivers/target/iscsi/iscsi_target.c    | 21 +++++++++++++--------
 drivers/target/target_core_transport.c | 27 +++++++++++++++++++++------
 drivers/target/target_core_xcopy.c     |  5 ++++-
 include/target/target_core_fabric.h    |  3 ++-
 4 files changed, 40 insertions(+), 16 deletions(-)

-- 
1.8.3.1

