Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A42A20E3
	for <lists+target-devel@lfdr.de>; Sun,  1 Nov 2020 19:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgKAS7w (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 1 Nov 2020 13:59:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgKAS7v (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:59:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A1ItOs8152790;
        Sun, 1 Nov 2020 18:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=fzt5NevbQReMFhXiJ/Enlt2ogqCHwfGDL8t4GWsr4pc=;
 b=zNjIo9p6UPxzc/kg0PobCZsa37kzqEPkFOQuqrm8//hcMNPIZ+nCEm6LAW8coQa31trK
 kca9Gi9+xBo/4U50uTiqf4n8GhjwHPZ5eB74miWtpEKVC3Q05xTR1rDr/VL5LgVVaMkQ
 eR8txznyob+niydSKJnCVhb8kF3659rQGQbXwQK+rI/x6he5NepE9NClTEJ6IoZR89Nm
 z6OJFpHgHLebixsOlQ9eExTjzEsp5ExVgUmSDJ3MboY7RKOhK34GJT3aasS+XnirPBfs
 M08BeQ9blMRn7C6eFQsR9FoENnFdWK+Bs61qrFVaE+99RPDtk+xp9Hhf+UTe9Y8lvUfU Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34hhvc1arg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 01 Nov 2020 18:59:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A1Isgux091271;
        Sun, 1 Nov 2020 18:59:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34hw0aprdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Nov 2020 18:59:45 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A1Ixghe013094;
        Sun, 1 Nov 2020 18:59:44 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Nov 2020 10:59:41 -0800
From:   Mike Christie <michael.christie@oracle.com>
To:     himanshu.madhani@oracle.com, njavali@marvell.com,
        james.bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH 0/8 v3] target: fix up locking/refcounting in IO paths
Date:   Sun,  1 Nov 2020 12:59:26 -0600
Message-Id: <1604257174-4524-1-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011010154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011010154
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The following patches made over Martin's staging branch fix some
ref counting issues I hit while testing and improves the locking
in the IO paths. To do the latter, the patches:

1. move the sess_cmd_lock to tcm_qla2xxx since it was the only
driver using the sess_cmd_list.

2. makes the execution lock/list per cpu'ish. I just allocate
nr_cpu_ids's worth of lock/lists then make sure we complete
the cmd on the cpu it was started on.

With the patches I'm seeing a 25% improvement in IOPs for small
IO tests like:

fio  --filename=/dev/sdXYZ  --direct=1 --rw=randrw --bs=4k \
--iodepth=128  --numjobs=16

with drivers like vhost (with those other patches on the list to
fix up multiple virtqueue support) and with the included loop
patch when nr hw queues is increased.

v3:
- Fixed issue where qla2xxx's cpuid was overwritten.
- Fixed up email submit prefix to have "qla2xxx".
v2:
- Got access to qla2xxx setup and tested patch. Fixed various issues.
- Added fixes for issues found in the same code paths I was testing:
        - target: fix lun ref count handling
        - target: fix cmd_count ref leak
v1/RFC
- Initial posting.


