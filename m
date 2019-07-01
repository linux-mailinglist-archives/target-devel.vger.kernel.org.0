Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAF4B079
	for <lists+target-devel@lfdr.de>; Wed, 19 Jun 2019 05:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfFSDjI (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 18 Jun 2019 23:39:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40222 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDjI (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 18 Jun 2019 23:39:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J3cgJj008198;
        Wed, 19 Jun 2019 03:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=b5qN28LGBy9a7xOcap+Wk6iZCiRNojShvf2zriROB8Q=;
 b=dfsDAJn00iF/8pZ/i8qowCY4c9XARIhuNj7lp+jFphCgBHrCUqRE81UOsE5jWX57mJ+s
 YEJgOigIbXJLegb35IRZYYPcGeKgtz4fdo6v36W8NzUrwKLgamWgUs2WBwZgxWZ2RYdS
 P+zMURl8Qcoew4upstNreEAY3f9L4qBhT9QfMw/cuJ7je3qVn7ZYALsxlqSWMYdjJ8Yt
 WnSwZJGgqBy1XzSIzh4fv4qpyUTStQOYIgW2Lpi9P/tXB9APfxKVFQkWNu8k5CCjcoJZ
 E72ZvyaINjuc8UUsjH+J64EKlubW+xsdKkTeXdoCf5pbhNZ2AO46bL0dM79ugipNUq+j 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t78098tmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:38:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J3bdfZ049730;
        Wed, 19 Jun 2019 03:38:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t77ymu9fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:38:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J3cfb8019954;
        Wed, 19 Jun 2019 03:38:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 20:38:40 -0700
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v4 23/28] docs: target: convert docs to ReST and rename to *.rst
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
        <9c58d2f3478126736e69b688a7dbf0da26ba2285.1560361364.git.mchehab+samsung@kernel.org>
Date:   Tue, 18 Jun 2019 23:38:37 -0400
In-Reply-To: <9c58d2f3478126736e69b688a7dbf0da26ba2285.1560361364.git.mchehab+samsung@kernel.org>
        (Mauro Carvalho Chehab's message of "Wed, 12 Jun 2019 14:52:59 -0300")
Message-ID: <yq1imt2utvm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190028
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Mauro,

> Convert the TCM docs to ReST format and add them to the
> bookset.

Looks good to me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
