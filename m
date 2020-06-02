Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A691EC1D4
	for <lists+target-devel@lfdr.de>; Tue,  2 Jun 2020 20:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgFBSeC (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 2 Jun 2020 14:34:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSeC (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:34:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052IWIEW025403;
        Tue, 2 Jun 2020 18:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=EjxpJO2tn9rcgu9xQome5Q58wfb1d+BrE0+x1mPUCIE=;
 b=ICxfzS50RyCy4tLpoHVcmA32iC1GRA/fdQtznjaR0wfd894gaTBiu1pE3AfZrxiV8nPd
 KUcCHVgfokvEpCgIMvar3SPDYSzLCeb5rUp/msSxNuBTshG3JvGScultFlttwfWQJw+t
 8179VtiLYHCLGi/jvGvDTOAdf9nfSAb7X1yn3rXhU3EbMhK874SeADXmAOzfbDDmbse3
 HGjTxT/BcN0kg/5N3zxOnXTjcS06xk5SIzRSIKmkwFajQPoq8fhEfN8YuOSX9Funwk9l
 fOLqJuurh5ThJCmvHOglEGC24hWobgjXBVHINYm40fm0grvfY3m9c2LLV3JhnosesD+b xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31dkrujk2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 18:34:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052IXxiT106484;
        Tue, 2 Jun 2020 18:34:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31c25ppp6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 18:33:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052IXqSW004623;
        Tue, 2 Jun 2020 18:33:52 GMT
Received: from supannee-devvm-ol7.osdevelopmeniad.oraclevcn.com (/100.100.231.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 11:33:51 -0700
From:   Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>
To:     martin.petersen@oracle.com, michael.christie@oracle.com,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     shirley.ma@oracle.com
Subject: [PATCH v3 0/3] target: fix NULL pointer dereference
Date:   Tue,  2 Jun 2020 18:33:42 +0000
Message-Id: <1591122825-2652-1-git-send-email-sudhakar.panneerselvam@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020134
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The following set of commits address a NULL pointer dereference and some
refactoring around this issue.

v3:
 - fix NULL pointer dereference when cdb initialization fails

v2:
 - new helper is named as target_cmd_init_cdb()
 - existing function, target_setup_cmd_from_cdb is renamed as
   target_cmd_parse_cdb()

Sudhakar Panneerselvam (3):
  target: factor out a new helper, target_cmd_init_cdb()
  target: fix NULL pointer dereference
  target: rename target_setup_cmd_from_cdb() to target_cmd_parse_cdb()

 drivers/target/iscsi/iscsi_target.c    | 21 +++++++++++-------
 drivers/target/target_core_transport.c | 40 +++++++++++++++++++++++++++-------
 drivers/target/target_core_xcopy.c     |  5 ++++-
 include/target/target_core_fabric.h    |  3 ++-
 4 files changed, 51 insertions(+), 18 deletions(-)

-- 
1.8.3.1

