Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6829FB02
	for <lists+target-devel@lfdr.de>; Fri, 30 Oct 2020 03:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJ3CCg (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Oct 2020 22:02:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43166 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgJ3CCg (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:02:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09U1xcZJ111955;
        Fri, 30 Oct 2020 02:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Qr5Ja6ZQ1tgA8TRducZioDzgWj730iOPf7N64yZRbds=;
 b=BC+upRMRB9geCjkJXGidBo5PKrP0diWB6Ne8AX0GZw0Jc8mOSYYqPfJMIn8urMyXSUhz
 I6qDz/Y5/KbOHG9Hfhje+wYN+W+M93SJKMSAYAagiFuoQclCSOR1QFuN9Y82GAMimRNh
 O3yfoSbZmtZIQN+UZSeXZbuk+NNmtXnvHPrB2Ta3uTqJ/OsHSUbunVJneWcQU/iUa/7K
 TuaaHJMQ83JeL44noNf9oEoLwwhaGnMggRUebImKdut/p0fU0j7YIQzu/C9m9XPyxC1H
 0gX4GquXdg9AlU5TzCqcGCaRfo9J6MUPq2bM3MCbUeAzN+mxVPKF1vtPdS3dPb9YVVPF xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34c9sb7v0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 02:02:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09U1sXdp007417;
        Fri, 30 Oct 2020 02:02:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34cwuqf7aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 02:02:12 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09U22AqE002653;
        Fri, 30 Oct 2020 02:02:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 19:02:09 -0700
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 0/5] scsi: target: COMPARE AND WRITE miscompare sense
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1blgk1nfx.fsf@ca-mkp.ca.oracle.com>
References: <20201026190646.8727-1-ddiss@suse.de>
Date:   Thu, 29 Oct 2020 22:02:08 -0400
In-Reply-To: <20201026190646.8727-1-ddiss@suse.de> (David Disseldorp's message
        of "Mon, 26 Oct 2020 20:06:41 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300012
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


David,

> This patchset adds missing functionality to return the offset of
> non-matching read/compare data in the sense INFORMATION field on
> COMPARE AND WRITE miscompare.

Applied 2-5 to 5.11/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
