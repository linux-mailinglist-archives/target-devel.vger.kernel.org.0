Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6367A5D8E3
	for <lists+target-devel@lfdr.de>; Wed,  3 Jul 2019 02:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGCAaa (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 2 Jul 2019 20:30:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43322 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfGCAaa (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:30:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x62KcwEc130757;
        Tue, 2 Jul 2019 20:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=3WE9qWavv9b6Dvpf/hgDXH6fMxiIkWI9SFCqtd9Yv04=;
 b=AhLXoVZzaHSJJhL218ZtlzQ2PnqChSBFsXLL73u+hU8yDWPt4JwVfKTUu5rDmF7eKdE3
 Fb70t8omi3EoYKiGvjcDCJ0Jdaok6a1597csX/UXOMm4VelBI0R6/RZFSMhiwD5crIGE
 d9Mf7zCzPyYxz0jnt6EA5p3g2hd+dRUVChidrrO4hktFdwBjGeBgDNy4hLplKjlZza3L
 Ch+WnUtbuomiipSCaoxsfmV/HpYZFMBzPC+rjzfkpBlZUFO4eT84iUVOg3FtFzHiXxIX
 4PWp+N56z+3YE9ijmCCaOfMZricEtT/JDT9Lcq5H37EmqhWBjCTQjlYC4XX7kBLvsRDC Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2te61pwv06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 20:41:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x62Kc7bF035906;
        Tue, 2 Jul 2019 20:41:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tebqgquj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 20:41:10 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x62Kf8HV012060;
        Tue, 2 Jul 2019 20:41:08 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 13:41:07 -0700
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     target-devel@vger.kernel.org, martin.petersen@oracle.com,
        cleech@redhat.com, ddiss@suse.de
Subject: Re: [PATCH V2] iscsi: set auth_protocol back to NULL if CHAP_A value is not supported.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190626172734.20751-1-mlombard@redhat.com>
Date:   Tue, 02 Jul 2019 16:41:05 -0400
In-Reply-To: <20190626172734.20751-1-mlombard@redhat.com> (Maurizio Lombardi's
        message of "Wed, 26 Jun 2019 19:27:34 +0200")
Message-ID: <yq1lfxgf9um.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=834
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020228
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=901 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020228
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Maurizio,

> If the CHAP_A value is not supported, the chap_server_open() function
> should free the auth_protocol pointer and set it to NULL, or we will
> leave a dangling pointer around.

Applied to 5.2/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
