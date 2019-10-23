Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE6E0FF4
	for <lists+target-devel@lfdr.de>; Wed, 23 Oct 2019 04:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbfJWCPK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Oct 2019 22:15:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46160 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJWCPK (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:15:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N2ErTJ022111;
        Wed, 23 Oct 2019 02:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=3a9jFkrcvxVs3fii45LjWauXKvjD0VM9U6tfo5OtgaY=;
 b=edprELAo+4xAUC/L50STj1mzOsQTnPp07+043DUcwWCG4VPsHgiI3Gc8pSMAkC4ZXLHK
 A1zNyFdXkme3lw6rkG+afJmdRKG78/zOJ34SBHagAWm7d4nxws2Mh1WGZ/pC1czOLCnZ
 iCRNPzLBlhx8crS5TjObj7kglBzuWVnPdowVcp8uoR3zh9yYNyjV6HZ4M84wtG3DPS+1
 pD+oW9ABcSZPeUBtz/N0OWuSeJ3ugLZwVwBSH84UNDw8Q8/D5TIVGIH9ndJwIXl3J7nJ
 yPTnDke2qwReoQhjIPnFRc9EmcEIkb62hh4tP0MbM9vXFWsEGa5uclQbca3Gs178Xehw dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qt4vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 02:14:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N2DZ35034192;
        Wed, 23 Oct 2019 02:14:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vsx2416kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 02:14:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9N2Eud5011493;
        Wed, 23 Oct 2019 02:14:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 19:14:55 -0700
To:     Mike Christie <mchristi@redhat.com>
Cc:     David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org
Subject: Re: [PATCH 0/3] target: minor iSCSI parameter parsing fixes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190912095547.22427-1-ddiss@suse.de>
        <5DADD77A.6010903@redhat.com>
Date:   Tue, 22 Oct 2019 22:14:53 -0400
In-Reply-To: <5DADD77A.6010903@redhat.com> (Mike Christie's message of "Mon,
        21 Oct 2019 11:06:18 -0500")
Message-ID: <yq1pniodx7m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=950
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230020
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


>> This patchset includes some minor fixes for parsing iSCSI CHAP_A and
>> SendTargets fields. Patch 1/3 was already submitted and reviewed by
>> Lee.

> Reviewed-by: Mike Christie <mchristi@redhat.com>

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
