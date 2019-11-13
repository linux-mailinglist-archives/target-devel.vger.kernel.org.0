Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA381F9FEA
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 02:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKMBLe (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 12 Nov 2019 20:11:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKMBLd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:11:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD19E1R000812;
        Wed, 13 Nov 2019 01:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=MC14PbJ+D1LquRdR0QTz4OdYe+W79cmn0VRMDYw0two=;
 b=XF7Y3OG7txEQoZ9H/+jNECilUaV/xlLPOD3PhGgDZHuUtFa7/g1ns1dtvjfAkJfLT72g
 /bzSjEx3BKJkibjaOwFrremV9zAwwUaOoJqpqUjtQh9Z5Pgftepi2UAWWsxqiBSxth+t
 iQRj+0nLhtBAOjgYhR4QXI3KdpZJhGc/KsFaLsrHmRsK1mhrsSIfc/uD/8Ab5LZHswBF
 Lqfwg42bxmyDCMdgSDVI/sl4pa97Ts05klXqhpCRG09f4USLgRJJGQRA2FT7Zb2r+XjV
 Ea0+iBRxmiHwzGpxd4/cMaKHG4Za263NmW5vTgsXpdrsBbKZAZ13tUUo6AsuVuPX7Kwf PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w5ndq8nm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 01:11:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD19Avx003392;
        Wed, 13 Nov 2019 01:11:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2w7j041qgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 01:11:25 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAD1BNO4031799;
        Wed, 13 Nov 2019 01:11:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 17:11:23 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] target/core: Declare target_release_reservation() 'static'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191111182944.191123-1-bvanassche@acm.org>
        <20191111182944.191123-2-bvanassche@acm.org>
Date:   Tue, 12 Nov 2019 20:11:16 -0500
In-Reply-To: <20191111182944.191123-2-bvanassche@acm.org> (Bart Van Assche's
        message of "Mon, 11 Nov 2019 10:29:43 -0800")
Message-ID: <yq1woc4shqj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130003
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bart,

> Since this function is only used inside the source file in which it has
> been defined, declare it 'static'. See also commit fae43461f8f2 ("scsi:
> target/core: Rework the SPC-2 reservation handling code").

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
