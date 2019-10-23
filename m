Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACAAE0FE7
	for <lists+target-devel@lfdr.de>; Wed, 23 Oct 2019 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfJWCFf (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Oct 2019 22:05:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44860 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJWCFf (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:05:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N24ePc017040;
        Wed, 23 Oct 2019 02:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=lY4zP94alq01uAWKdV/BiL6+B7d28BacWcxtzqymDMw=;
 b=Nnhbb/QJGkog+ByHqz8O6vTBjnMDrjH5K0ycSCbI27QV6tDcnWXoxNUD9pY7zrZnUGTM
 R0pLz0Xojg0OOWUUnOJLCTT4AfOtgWwNTSQUV1XCCOvvOGMpJMl1BXOH6GaDl0SsNIi3
 KmQPMNHtlHybEm7o07GRVVyTHLfZzKwq5wtgC/LZV0WW012+u5n060dGYwEOtZRmq/NF
 V1ctCpZR55wKNaBPhmJMmAvdSlLkgnmuD4t+awkjv3zKAMu8CpIfbE4gXX+sz3zS1ByL
 +oCPXt+er23HalqbOeAmptB0fwZ88fyPPx91F8c+KrbltGcQTgYsdugMo7R5giyyHyij 2w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vqtept956-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 02:05:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N24iRi019900;
        Wed, 23 Oct 2019 02:05:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vsx240vdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 02:05:29 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9N25QBf013342;
        Wed, 23 Oct 2019 02:05:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 19:05:26 -0700
To:     bvanassche@acm.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        target-devel@vger.kernel.org
Subject: Re: [bug report] target/cxgbit: Fix endianness annotations
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191014115025.GA9350@mwanda>
Date:   Tue, 22 Oct 2019 22:05:24 -0400
In-Reply-To: <20191014115025.GA9350@mwanda> (Dan Carpenter's message of "Mon,
        14 Oct 2019 14:50:25 +0300")
Message-ID: <yq1tv80dxnf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=775
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=857 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230018
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bart?

> This is a semi-automatic email about new static checker warnings.
>
> The patch 5cadafb236df: "target/cxgbit: Fix endianness annotations"
> from Jan 13, 2017, leads to the following Smatch complaint:
>
>     drivers/target/iscsi/cxgbit/cxgbit_cm.c:1836 cxgbit_fw4_ack()
>     warn: variable dereferenced before check 'p' (see line 1834)
>
> drivers/target/iscsi/cxgbit/cxgbit_cm.c
>   1833			struct sk_buff *p = cxgbit_sock_peek_wr(csk);
>   1834			const u32 csum = (__force u32)p->csum;
>                                                       ^^^^^^^
> We moved this dereference earlier
>
>   1835	
>   1836			if (unlikely(!p)) {
>                                       ^
> so now it's before the NULL check
>
>   1837				pr_err("csk 0x%p,%u, cr %u,%u+%u, empty.\n",
>   1838				       csk, csk->tid, credits,
>

-- 
Martin K. Petersen	Oracle Linux Engineering
