Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC2219085
	for <lists+target-devel@lfdr.de>; Wed,  8 Jul 2020 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgGHTa5 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 8 Jul 2020 15:30:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40328 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGHTa4 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:30:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068JQosm046357;
        Wed, 8 Jul 2020 19:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qG2tjELifZLlyV72yPLIkgXyaoKEb7Xvgz0tQEKztdY=;
 b=TS/o8ExVoDqsIlwf45V+rnGkm1QLDH3kOqQ3k0MBRBLfBauFrqLYqePW6j3I01RWPyT6
 eXVFCgrILAoFosHvpPSClwwUAwMJHJ4eXRAC+g1zXXYxBDzKUDRiDXKFhLwjJG1BCA3f
 CbnJ1MXeg8XnC8Hoablb1Dv3hxjB1kPvGgVd+M7h4gp38rvFqmdclbDhDWDXWrRuyGih
 Az6fGwCjRVr0gGkZQrNo+Ldjy2LC3v2/oqerMHexZkpN22XjAUoZDW2UbZt9hO4HnQJp
 U8KGENPAnlBwtWSiOhm9IxTLqGuL+v4Si27/5NgkXwx+aCb1+Lt59IpAXQZKZgXbOHTB 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 325k348ekt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 19:30:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068JTUq6152460;
        Wed, 8 Jul 2020 19:30:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 325k3fkatb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 19:30:50 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 068JUnhO031124;
        Wed, 8 Jul 2020 19:30:50 GMT
Received: from [20.15.0.6] (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 12:30:49 -0700
Subject: Re: [PATCH] scsi: target: cxgbit: check connection state before
 issuing hardware command
To:     Varun Prakash <varun@chelsio.com>, martin.petersen@oracle.com
Cc:     target-devel@vger.kernel.org, dt@chelsio.com,
        ganji.aravind@chelsio.com
References: <1593621970-3026-1-git-send-email-varun@chelsio.com>
From:   Mike Christie <michael.christie@oracle.com>
Message-ID: <af826cef-c6be-7e4e-1f49-cecef501d499@oracle.com>
Date:   Wed, 8 Jul 2020 14:30:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1593621970-3026-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007080116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007080116
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 7/1/20 11:46 AM, Varun Prakash wrote:
> Current code does not check connection state before issuing
> header/data digest offload and DDP page size setup hardware
> command.
> 
> Add a connection state check to issue hardware command only
> if connection is in established state.
> 
> Signed-off-by: Varun Prakash <varun@chelsio.com>

Looks ok.

Reviewed-by: Mike Christie <michael.christie@oracle.com>
