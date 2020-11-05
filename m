Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDED2A761B
	for <lists+target-devel@lfdr.de>; Thu,  5 Nov 2020 04:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbgKEDlk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 4 Nov 2020 22:41:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47314 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733135AbgKEDlk (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:41:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A53P7ja028859;
        Thu, 5 Nov 2020 03:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ziJqP69rbY2z7tN+5/qbBLCt0pQOEeJ3Phbzv7Dsw8Y=;
 b=LE3k4flXyhFKdSd3qUR3tlHEPJldHRw121eJ2KWvb1TD7AHtqSKF2J3qlpj/OZneruxs
 XiBuH3iKwdm3V6j9QB28aRyqpjzGv/kNR1LaaPlh9/8EBvh3MMagev9rPWXCv/GELbpU
 i2xBEbo53A6TsyEHCy461riKjSLo57GhWz2fub3LqIKVF74Ya8yZcpp+WpwmUBHDJLBo
 zxaBWQa8HxrD5F5DNAIMFFuKDgFmcdQuP9eCkWsgoGvocnpxLAPLPXdjID3pmRVrfw1x
 zv5iXCUcRltlnTN/ikdz9WZ1Ir/2BcZQH7wzyYf4m/t9MwY6Y/QGd+Soe7haM26dPy1g jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34hhb29vqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 05 Nov 2020 03:41:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A53Otni010640;
        Thu, 5 Nov 2020 03:41:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34jf4bdgh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Nov 2020 03:41:36 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A53fZrt000495;
        Thu, 5 Nov 2020 03:41:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 19:41:34 -0800
To:     Mike Christie <michael.christie@oracle.com>
Cc:     himanshu.madhani@oracle.com, njavali@marvell.com,
        james.bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH 0/8 v3] target: fix up locking/refcounting in IO paths
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tuu4scev.fsf@ca-mkp.ca.oracle.com>
References: <1604257174-4524-1-git-send-email-michael.christie@oracle.com>
Date:   Wed, 04 Nov 2020 22:41:32 -0500
In-Reply-To: <1604257174-4524-1-git-send-email-michael.christie@oracle.com>
        (Mike Christie's message of "Sun, 1 Nov 2020 12:59:26 -0600")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=1
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050025
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Mike,

> The following patches made over Martin's staging branch fix some
> ref counting issues I hit while testing and improves the locking
> in the IO paths. To do the latter, the patches:

Applied to 5.11/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
