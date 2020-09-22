Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB73273A04
	for <lists+target-devel@lfdr.de>; Tue, 22 Sep 2020 07:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgIVFH5 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Sep 2020 01:07:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34688 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgIVFH5 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:07:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3nxFM149327;
        Tue, 22 Sep 2020 03:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ENsNdIxngoDD2Ep7VAATIU/SioAPOAeynj5qP1cu2HI=;
 b=o3vQBw/PIIzShbmbxV1Kwh+BSFd0/D1vC45X1I2z9IIq95U5f2YqpQRXF2Tn7P0Cw24E
 aqLKBXxYFy4m1B3OPOeHNOyXfLeOJ+a1G+4RpRr2c4wNdJsy24NOmxT4oqDl58zaTLr3
 /5Zl5GpBwZocWO4YC1AvXDz1GNvk6ZcsNYEaRk7qx9AzTRuOSdRzGVBgKf+ckQ9gcqB7
 CimFFeHtzTcjVXcnyMRV0uTpFnezfM3wZ2nUBSBrRaNDzgeiYfsG8ub7quvcR8CojFaZ
 14nrv6pncQojyZVcX/PWAYBRKMsyXOGLSApCI71a41WVw36o50UBsx/dLpj2oEFXgSOp yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33n7gad5t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 03:57:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3tKTO020619;
        Tue, 22 Sep 2020 03:57:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nuwxk741-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 03:57:25 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08M3vOga032579;
        Tue, 22 Sep 2020 03:57:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 20:57:24 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: target: tcmu: add a missing newline when printing parameters
Date:   Mon, 21 Sep 2020 23:56:55 -0400
Message-Id: <160074695010.411.10221836550956633689.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1599132573-33818-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1599132573-33818-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=854 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=868 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220030
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, 3 Sep 2020 19:29:33 +0800, Xiongfeng Wang wrote:

> When I cat module paramter 'global_max_data_area_mb' by sysfs, it
> displays as follows. It's better to add a newline for easy reading.
> 
> root@(none):/# cat /sys/module/target_core_user/parameters/global_max_data_area_mb
> 2048noneroot@(none):/#

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: target: tcmu: Add missing newline when printing parameters
      https://git.kernel.org/mkp/scsi/c/6d70cb343484

-- 
Martin K. Petersen	Oracle Linux Engineering
