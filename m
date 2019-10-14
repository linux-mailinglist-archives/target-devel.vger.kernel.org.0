Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D40D61BF
	for <lists+target-devel@lfdr.de>; Mon, 14 Oct 2019 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfJNLwi (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 14 Oct 2019 07:52:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34476 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfJNLwi (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:52:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EBhwif102349;
        Mon, 14 Oct 2019 11:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=zsYsXunFX6AC+v6xIwMm/N1OVyi/Xm2B9Mkcrcwg0KU=;
 b=OJXb6pfPtwV2MPRTvfNnlUwbg7qcBblLPIYdXSSJylja03UafmKOuwdYfr7SHLIMNneQ
 fxMV09ryqCC6Mnbsuulgzs87fzfYOQAyDlnMhTcIfcaHoNoERIztpzK4prq/4IRUi5Hn
 VQZyjA95XTQoHXJras4H1ScEs+FXM99/vhTZEgScdi//m0rkXlrpROY1XVC4fmxpu49f
 kwa71jGuV3yWiXUOumjxpjMPmk2l4bHkXlwKW3OZAGgnp92PrGw4N/KqBEq62qP0GqqD
 MUFgkvgWiJFgOzGqu7Yji5gcDIti9/Rti6NowuFnHJemOJqCpv3p9vx7aoZ1slrzXfb4 wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vk68u8c4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 11:52:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EBmNeH117613;
        Mon, 14 Oct 2019 11:50:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vks06mgpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 11:50:32 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9EBoUm3028753;
        Mon, 14 Oct 2019 11:50:30 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 11:50:30 +0000
Date:   Mon, 14 Oct 2019 14:50:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bvanassche@acm.org
Cc:     target-devel@vger.kernel.org
Subject: [bug report] target/cxgbit: Fix endianness annotations
Message-ID: <20191014115025.GA9350@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=777
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=879 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140116
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hello Bart Van Assche,

This is a semi-automatic email about new static checker warnings.

The patch 5cadafb236df: "target/cxgbit: Fix endianness annotations"
from Jan 13, 2017, leads to the following Smatch complaint:

    drivers/target/iscsi/cxgbit/cxgbit_cm.c:1836 cxgbit_fw4_ack()
    warn: variable dereferenced before check 'p' (see line 1834)

drivers/target/iscsi/cxgbit/cxgbit_cm.c
  1833			struct sk_buff *p = cxgbit_sock_peek_wr(csk);
  1834			const u32 csum = (__force u32)p->csum;
                                                      ^^^^^^^
We moved this dereference earlier

  1835	
  1836			if (unlikely(!p)) {
                                      ^
so now it's before the NULL check

  1837				pr_err("csk 0x%p,%u, cr %u,%u+%u, empty.\n",
  1838				       csk, csk->tid, credits,

regards,
dan carpenter
