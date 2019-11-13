Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFCF9FF9
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 02:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKMBPv (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 12 Nov 2019 20:15:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39314 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfKMBPu (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:15:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD1ERJC181856;
        Wed, 13 Nov 2019 01:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=PoylKNmm63Pe1/6rKO7pTPs4cPxc6gCeml2hxUBP9Rc=;
 b=IXMwe9agCEiUHem9phAI2rvuOxYVT27vuI58c+UMJcizZnkL1Ta5akCi/GuQxRqe5wDV
 spufRB1RnRxdnUB9urUm42wZAyJ/Tq5NJXGGZMWRIBzKiVhN6u03d+K7TacES407/NJo
 VyoDYGvgpKh3LgnXnVXxEXRGEOQhWU18Nlv4MjmVsDT2vFl+QMPQVcAUP3BQCR4s80tD
 LA6IcXyROqJyJp5XYT+TcrUhKuZfESLb3LiueXNZYTXOdV7pSXM0t04ODRQXts9z3i0z
 ePYHERQwCBruyNuCl2usgGTRvk0Y221PMPlyB/PKkCAB/SNyADuhdZINZRjrFPoWu3I0 XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w5p3qrk9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 01:15:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD1E8td047671;
        Wed, 13 Nov 2019 01:15:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w7khmcrwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 01:15:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAD1Fgbv001878;
        Wed, 13 Nov 2019 01:15:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 17:15:41 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] Three reliability improvements
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191112035752.8338-1-bvanassche@acm.org>
        <fd927f32-2150-9c34-22f7-dc3e31db6bca@acm.org>
Date:   Tue, 12 Nov 2019 20:15:39 -0500
In-Reply-To: <fd927f32-2150-9c34-22f7-dc3e31db6bca@acm.org> (Bart Van Assche's
        message of "Tue, 12 Nov 2019 09:05:35 -0800")
Message-ID: <yq1sgmsshj8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=755
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=843 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130004
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bart,

> - The patch that declares target_release_reservation() static has been
> left out because a patch in this series introduces a call to that
> function outside the file in which that function has been defined.

OK, I'll drop it again. Thought this series replaced patch two of the
first.

-- 
Martin K. Petersen	Oracle Linux Engineering
