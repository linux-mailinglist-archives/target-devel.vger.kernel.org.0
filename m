Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1420ADBB5C
	for <lists+target-devel@lfdr.de>; Fri, 18 Oct 2019 03:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409460AbfJRBmW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 17 Oct 2019 21:42:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41634 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfJRBmW (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:42:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I1dKQI090383;
        Fri, 18 Oct 2019 01:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=wEun/DCoVTOWFkkGv9K5YI5H50zUlibyXN+NlQIRTP8=;
 b=O5JwhHiuIGQxpaCqPVigH94/RpFrCtnjw8ZgP64cyw4m45+ssfyf7S8EqLqdqu7geXiE
 AaAnIfKLUNzocoXx6WY1cJWVKi3M3GRhbplgVDXO4ZYlqUSFE9GO3mYM2gl6zYoj9ff4
 +1OySCsPKMA8AXBp3X/CQivmDwDBQhhKgKCyxTEuW+cNPeztHay9dcfrr6GlG+TdDwMV
 XDK70oTq6LaRMz7DdiHatLfDV29off3LXj0jrufpNiPSI28maGKqkYGSDNrVB4JxInID
 1uFfL/Absn2W8N0AyQma7aVttAZKOyC5TJ5TanFqOTQvcUxkbQNNKk2SB1kVy+ZeBbTM +g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vq0q40nut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 01:42:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I1cArH136888;
        Fri, 18 Oct 2019 01:42:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vq0ed21kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 01:42:02 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9I1fxdJ032013;
        Fri, 18 Oct 2019 01:41:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 01:41:59 +0000
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>
Cc:     "target-devel\@vger.kernel.org" <target-devel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] target: do not overwrite CDB byte 1
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <12498eab-76fd-eaad-1316-c2827badb76a@ts.fujitsu.com>
Date:   Thu, 17 Oct 2019 21:41:57 -0400
In-Reply-To: <12498eab-76fd-eaad-1316-c2827badb76a@ts.fujitsu.com> (Bodo
        Stroesser's message of "Mon, 14 Oct 2019 20:29:04 +0200")
Message-ID: <yq1r23akexm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180014
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bodo,

> passthrough_parse_cdb() - used by TCMU and PSCSI - attepts to reset
> the LUN field of SCSI-2 CDBs (bits 5,6,7 of byte 1).  The current code
> is wrong, as for newer commands not having the LUN field it overwrites
> relevant command bits (e.g. for SECURITY PROTOCOL IN / OUT) We think
> this code was unnecessary from the beginning or at least it is no
> longer useful. So we remove it entirely.

Applied to 5.4/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
