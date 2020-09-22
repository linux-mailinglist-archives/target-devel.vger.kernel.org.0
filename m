Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801302739D4
	for <lists+target-devel@lfdr.de>; Tue, 22 Sep 2020 06:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgIVE1D (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Sep 2020 00:27:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50608 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgIVE1D (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Sep 2020 00:27:03 -0400
X-Greylist: delayed 1765 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 00:27:02 EDT
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3xPfA159635;
        Tue, 22 Sep 2020 03:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=MU7vMfEG7uHngKI/Ec05AQOxUFlYKEr4CiXVKbCfj6s=;
 b=xs2GZd9zUrU5eBesTxFNjhJTmZD7nYpFct4IkqLuP4Z996yTZ3p5ZEghK6oK3c4jC/6V
 iX6q1748Y0VbCP0XbNCwT5wEEpx+U4cB5kYzJ1nEoGV8U6xGTKT2AOBBJHXxmLYzUypf
 feWsMntnQJr1B+WJw+V6ZWuLFwFqBv8gRiYPGwztY8cU1pFm/V8Q7FCiudpW8TM8LUUi
 LUpNtaOdAsemKbpWXEHos07g6uEYy0l0/jr5dORWAYiXaY1iR6qwd8nCXx7HwirUN7D0
 74238Qm8RqjLNtupiL9X35Dp1aoQF8xpb5t23bBZMHyxfcp3aSq8IgTFw1rdOUQjIr3I XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33n7gad5y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 03:59:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3tsKr017547;
        Tue, 22 Sep 2020 03:57:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33nuw2pke0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 03:57:19 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08M3vInr019130;
        Tue, 22 Sep 2020 03:57:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 20:57:18 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     mlombard@redhat.com, ddiss@suse.de, gustavoars@kernel.org,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        michael.christie@oracle.com, sudhakar.panneerselvam@oracle.com,
        bvanassche@acm.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: target: remove redundant assignment to variable 'ret'
Date:   Mon, 21 Sep 2020 23:56:49 -0400
Message-Id: <160074695008.411.535339245470908448.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914023207.113792-1-jingxiangfeng@huawei.com>
References: <20200914023207.113792-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=962 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=989 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220031
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, 14 Sep 2020 10:32:07 +0800, Jing Xiangfeng wrote:

> The variable ret has been initialized with a value '0'. The assignment
> in switch-case is redundant. So remove it.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: target: Remove redundant assignment to variable 'ret'
      https://git.kernel.org/mkp/scsi/c/1c370903d12d

-- 
Martin K. Petersen	Oracle Linux Engineering
