Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DBBE408D
	for <lists+target-devel@lfdr.de>; Fri, 25 Oct 2019 02:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfJYAXN (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Oct 2019 20:23:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59318 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJYAXM (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:23:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P0IxjU075133;
        Fri, 25 Oct 2019 00:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=TmmwXKZiWLG3Jqky0MXvHbWRbIcQQUUUBN6d+o8CXJU=;
 b=C+Un7BucW2YNKbczY28BABo+zUY7gZIRzgqhHGHGpZ62gZEVJVWDLcEp8hlvXnjm9OlG
 cVe69/AKaUeRWerY4kBZFP8ELksUYlPD9z1SJWnzzcRlh41yXHL3X8nP+hxnRY1B+NVj
 7lvUZH85ph18u402VESV44k5mTg58Zs5WvXGasJO9fHT7S/tYU5BCf4x2TN6WlJFfaH9
 ZvW3MLW0BquPJvEta7OmBE0bbj1bof28ibsNo6qjMWHw7L1lm3/R9R0JCQtBdclWhBLd
 qzVBQXzRXRd06vhqEALMmkQrF5nUAMNyemp7h/qt2YWhKyXbZaQcFkqK5zoZ102+hXJp 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4r6swj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 00:22:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P0J1Ga094117;
        Fri, 25 Oct 2019 00:20:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vug0cnayc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 00:20:48 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9P0Klnj024679;
        Fri, 25 Oct 2019 00:20:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 17:20:47 -0700
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     cleech@redhat.com, mchristi@redhat.com,
        target-devel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH V2 0/3] iscsi: chap: introduce support for SHA1, SHA256 and SHA3-256
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191017131037.9903-1-mlombard@redhat.com>
Date:   Thu, 24 Oct 2019 20:20:45 -0400
In-Reply-To: <20191017131037.9903-1-mlombard@redhat.com> (Maurizio Lombardi's
        message of "Thu, 17 Oct 2019 15:10:34 +0200")
Message-ID: <yq1k18td6aq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=683
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=770 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250002
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Hi Maurizio,

> iSCSI with the Challenge-Handshake Authentication Protocol is not FIPS
> compliant.  This is due to the fact that CHAP currently uses MD5 as
> the only supported digest algorithm and MD5 is not allowed by FIPS.
>
> When FIPS mode is enabled on the target server, the CHAP
> authentication won't work because the target driver will be prevented
> from using the MD5 module.
>
> Given that CHAP is agnostic regarding the algorithm it uses, this
> patchset introduce support for three new alternatives: SHA1, SHA256
> and SHA3-256.

Can you please submit these on top of 5.5/scsi-queue which has your
string parsing fixes in place?

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
