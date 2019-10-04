Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A359CB332
	for <lists+target-devel@lfdr.de>; Fri,  4 Oct 2019 04:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfJDCBH (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 3 Oct 2019 22:01:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbfJDCBH (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:01:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x941soUE046525;
        Fri, 4 Oct 2019 02:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=yUbC7DOqwA8sfsA7W8voNIuBSJpXNYKqVjNJrxKFYfE=;
 b=jtsDbryLOubmfG6y4Yg0+4a+ITOpH8ZC/5H+CZRLRAO21AW4iOREPx4hKJbtv7ZEut2K
 wLP/tL1PL6oqmupAdIDEGOi7rNTXbWHhv6usN724y/EU+sDwm24G7TFq6vSuqF7FrMZK
 Ejm0j/H2yHD2ATgxrWIqrYu0tuRlHJqqkBAEhoHbzf9ITIUcIRo+LDo+qQGIoBRd/ASH
 Xn9eDc2L58YESpmgUoV9au5dYxB8zbFPzMhTn6jBjLeUnrLQJ4ILCGKs/k9L/ovzQmOl
 jiSxEmaHeCbsfC6u1XemUxStVZftAHlW6N6xbi4ZpLWb1fUjaY15droehJU3f7m1wDc2 zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2va05s833e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 02:00:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x941x487089383;
        Fri, 4 Oct 2019 02:00:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vdk0tbyv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 02:00:54 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9420qG4025358;
        Fri, 4 Oct 2019 02:00:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 19:00:51 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Subject: Re: [PATCH] target: Remove tpg_list and se_portal_group.se_tpg_node
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190930232224.58980-1-bvanassche@acm.org>
Date:   Thu, 03 Oct 2019 22:00:49 -0400
In-Reply-To: <20190930232224.58980-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Mon, 30 Sep 2019 16:22:24 -0700")
Message-ID: <yq14l0ps20e.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040013
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bart,

> Maintaining tpg_list without ever iterating over it is not
> useful. Hence remove tpg_list. This patch does not change the behavior
> of the SCSI target code.

Applied to 5.5/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
