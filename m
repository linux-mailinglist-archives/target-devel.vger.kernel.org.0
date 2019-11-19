Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A4110145D
	for <lists+target-devel@lfdr.de>; Tue, 19 Nov 2019 06:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfKSFdJ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 19 Nov 2019 00:33:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54404 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfKSFdJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:33:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ5TEh2109141;
        Tue, 19 Nov 2019 05:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=pHx3xMppjxpg1z8WMJA8WR+oGxLeAGxwOjDcOiBftwU=;
 b=io9JdYuUbE8UVYJ3Ej24lTU1QvLz4tVkG68sRuxDDX8fVPUeDcR97m1aNtz1jocGM9J/
 LglYN/NjrKpGUF3x+gsdr2s2xxZriAJRf3jAoRdc5FtwK6C4VoeS5kwwpZlEulPMlr67
 HF6iScry3qBBhljnbSIFuj6SnfXEThsqGE/pB2XBfxWlHO9NUEokJf070uBvHsnWaBzJ
 QOt8rfLGkVr4rn0PEaxvcozfph23yGMxrSOeqv0d7VzLvKPQ3PO7o82LchCKcuDx4Mn5
 aUmBK9eV8eKDWTgTkLxPbuofIrmaymuvi1VnFCjFAWPrwZuLccYjvwGGzYttJHFW+ovN 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rqcf98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:33:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ5TEJW135109;
        Tue, 19 Nov 2019 05:33:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wc0afrsj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:33:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ5X0CB006123;
        Tue, 19 Nov 2019 05:33:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 21:32:59 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
Subject: Re: [PATCH] target: Fix a pr_debug() argument
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191107215525.64415-1-bvanassche@acm.org>
Date:   Tue, 19 Nov 2019 00:32:57 -0500
In-Reply-To: <20191107215525.64415-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Thu, 7 Nov 2019 13:55:25 -0800")
Message-ID: <yq1blt8ig6u.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190050
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Hi Bart!

> Print the string for which conversion failed instead of printing the
> function name twice.

What do you mean wrt. printing the function name twice?

> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 2650d71e244f ("target: move transport ID handling to the core")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/target/target_core_fabric_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
> index 3c79411c4cd0..6b4b354c88aa 100644
> --- a/drivers/target/target_core_fabric_lib.c
> +++ b/drivers/target/target_core_fabric_lib.c
> @@ -118,7 +118,7 @@ static int srp_get_pr_transport_id(
>  	memset(buf + 8, 0, leading_zero_bytes);
>  	rc = hex2bin(buf + 8 + leading_zero_bytes, p, count);
>  	if (rc < 0) {
> -		pr_debug("hex2bin failed for %s: %d\n", __func__, rc);
> +		pr_debug("hex2bin failed for %s: %d\n", p, rc);
>  		return rc;
>  	}

-- 
Martin K. Petersen	Oracle Linux Engineering
