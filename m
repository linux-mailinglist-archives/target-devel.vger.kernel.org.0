Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8692EF0E2B
	for <lists+target-devel@lfdr.de>; Wed,  6 Nov 2019 06:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfKFFSX (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 6 Nov 2019 00:18:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56110 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKFFSX (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:18:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA65EExh100558;
        Wed, 6 Nov 2019 05:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=Ls2X0LDd+M4ReIrHAOjUW+QNTDnwXCXnjByQNcNDP1w=;
 b=QbXsRUwuua4kxFpbMrAukxoqi4r/MwZSXCZDB/UX3nAySLHMDSmSnM12HwiRqnPfYH29
 iEFPTUXmAeeu8Ou/ZJEvKVPugHSvb50aUnpB5/y9MyZl0QCuijA9UPGIwebURvqn9cwd
 qftm6FldJIFnItilruzxRQjvarZ2gYqqZGIpnq/t3QS5qbCJQJ6E/0f7JjvYrJG1pYIU
 k82FmlbZZBCoa/E9eHM2uSUuDTCAei7ESMMUqtWKgR44V3FFi04YSMWATpqcbgYSsu6z
 A2/GFqIky58YkgrAWEtzl/WFHC69G0/1LHkshvq4HSYJzBkDwZYIThqIArqtPQxpJ2R9 PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w12erb2mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 05:18:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA65DXVV078836;
        Wed, 6 Nov 2019 05:16:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w2wcnrq5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 05:16:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA65G2S6026718;
        Wed, 6 Nov 2019 05:16:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 21:16:01 -0800
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     cleech@redhat.com, mchristi@redhat.com,
        target-devel@vger.kernel.org, hch@infradead.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH V3 0/3] iscsi: chap: introduce support for SHA1, SHA256 and SHA3-256
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191028123822.5864-1-mlombard@redhat.com>
Date:   Wed, 06 Nov 2019 00:15:59 -0500
In-Reply-To: <20191028123822.5864-1-mlombard@redhat.com> (Maurizio Lombardi's
        message of "Mon, 28 Oct 2019 13:38:19 +0100")
Message-ID: <yq1pni51t68.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=686
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=785 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060054
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Maurizio,

> Given that CHAP is agnostic regarding the algorithm it uses, this
> patchset introduce support for three new alternatives: SHA1, SHA256
> and SHA3-256.

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
