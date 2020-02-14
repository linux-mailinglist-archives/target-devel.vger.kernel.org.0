Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1219915F94E
	for <lists+target-devel@lfdr.de>; Fri, 14 Feb 2020 23:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBNWRB (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 14 Feb 2020 17:17:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgBNWRB (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:17:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01EMDPJH051092;
        Fri, 14 Feb 2020 22:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=TFlkDP5oIxuuUdNfCdcFq1gpRkt26v7pnuWtc2xFhmY=;
 b=hsenqk02iTHA47bm2LIaF30qDGwnEcwEsc9Dvgj5g6jX8tSdVvWcqnSQMI198HKDPa/Q
 W8XREJKNco8gPWyamapBhJvhKFdy4ysHi+lo7QqhVpw2jgS2sVVfVjeuuPNQYwZN093Y
 r8RK0+2A2TY1nDOuryEp5kAWIMiiuxd9XTmtf5BHOHglY06N36rO+dNQYgHOI+gCeA7c
 F9sUBNsCQhD8520KQbrq6VqlhCUN7mDcY2rDLqbXdypXgtAfxfjy63z0gxx7HsD9HLXh
 MTd/O1pnXjApRU7lep2bHMJZtQVpgpu2NcF+fKfRICH0tTTxkyV/PJB6maQIVC3WjpCs Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y2p3t3vqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 22:16:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01EMCHBN166202;
        Fri, 14 Feb 2020 22:14:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y4k82wyw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 22:14:47 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01EMEk9q017938;
        Fri, 14 Feb 2020 22:14:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Feb 2020 14:14:46 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org,
        Dakshaja Uppalapati <dakshaja@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Rahul Kundu <rahul.kundu@chelsio.com>
Subject: Re: [PATCH 1/2] Revert "RDMA/isert: Fix a recently introduced regression related to logout"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200213050900.19094-1-bvanassche@acm.org>
Date:   Fri, 14 Feb 2020 17:14:44 -0500
In-Reply-To: <20200213050900.19094-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Wed, 12 Feb 2020 21:08:59 -0800")
Message-ID: <yq1y2t4olyj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=635 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=707 priorityscore=1501 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002140163
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bart,

> Since commit 04060db41178 introduces soft lockups when toggling
> network interfaces, revert it.

Applied 1+2 to 5.6/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
