Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB81014BB
	for <lists+target-devel@lfdr.de>; Tue, 19 Nov 2019 06:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfKSFgt (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 19 Nov 2019 00:36:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45982 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbfKSFgs (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:36:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ5Zbpq139137;
        Tue, 19 Nov 2019 05:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=xBKLMH7sCTqLGWbzM0KQG2UkBxsnkJdbBKXUDUMXWA0=;
 b=JCCCxT/oLjHuo9UxrZ8Lq9Z7z93ykbc5GFvU0Lrtr5F//j1oB3HAH3uE2jpiHDqrk46l
 /mDqvCfLoefsMyXQgagB9xKJWVTutHFmwt3gYHTfulyCTt7riISVLN6IV2VsI1SXJfA8
 kYgePBUrt/ewrF8VW0Q8980uB1J0uVHICTEygCNTwD9LoMrw7TShSMOD/jsw6gAMJ7Ov
 aHpQYLLLkWXsd8CX0oeDqPODWp/VJS1Dts4ksYj29rDxWSr9MayHpbSsp6zuZp/Gcgjl
 +jgSzCfZzMp2KHxHR00t8+NhVUG5T1GWq/8sLo2ftfrTVrt/9DDMN9PNyZwSLUrCXvPO kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htmkpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:36:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ5YMJI119778;
        Tue, 19 Nov 2019 05:36:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wc09wsc2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:36:40 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ5acAj007698;
        Tue, 19 Nov 2019 05:36:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 21:36:38 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Two SCSI target reliability improvement patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191113220508.198257-1-bvanassche@acm.org>
Date:   Tue, 19 Nov 2019 00:36:36 -0500
In-Reply-To: <20191113220508.198257-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Wed, 13 Nov 2019 14:05:06 -0800")
Message-ID: <yq17e3wig0r.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190051
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bart,

> The two patches in this series fix complaints that are reported when
> running the libiscsi test tool against the SCSI target code. I'm not
> sure why I hadn't noticed these issues before - maybe new tests have
> been added to the test tool.

Applied to 5.5/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
