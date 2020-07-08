Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08C219086
	for <lists+target-devel@lfdr.de>; Wed,  8 Jul 2020 21:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgGHTbP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 8 Jul 2020 15:31:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37006 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgGHTbP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:31:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068JQo9V182597;
        Wed, 8 Jul 2020 19:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DQrcplx/9V1Ua2JrjpdMLDcP0ngs5lhG3osR+6mYLbU=;
 b=L7FKTk1LK++TEyShqm9JZMOaWLYbxrRvQs84u6G7H7VWWILhUL5zl7uMFdEcgLx/StoC
 fOeqEVrsL/fsRZEvWfYxL30U29s/20kPwYA3ly/6GYXJJR1Rqw14j4VyR8D4oI/GGfHO
 7AE3JSCl2fIZvxojunRKIMaD4dnnazKXyIDhMQ1dy2pVcJMssAKC30K1zffofsTi/RUC
 wDBBPyQ3bPQnHuA9EME0RlQjUxWJetqePHbkKbGNc38KyMiLuEuPLhab1I7+oqq4w0DE
 LngAqPvvsHvCOSSOQJbrqSdBlvUC7jWdEU4I3G8TT/ykgi1c/ORYQRW4a7Ph6wqf04hH Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 325k368en4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 19:31:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068JTTCq174527;
        Wed, 8 Jul 2020 19:31:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 325k3fug4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 19:31:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 068JVBPl031322;
        Wed, 8 Jul 2020 19:31:11 GMT
Received: from [20.15.0.6] (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 12:31:11 -0700
Subject: Re: [PATCH] scsi: target: cxgbit: remove tx flow control code
To:     Varun Prakash <varun@chelsio.com>, martin.petersen@oracle.com
Cc:     target-devel@vger.kernel.org, dt@chelsio.com,
        ganji.aravind@chelsio.com
References: <1593622032-3082-1-git-send-email-varun@chelsio.com>
From:   Mike Christie <michael.christie@oracle.com>
Message-ID: <1775515a-45cd-8372-77e0-ac898a453ad2@oracle.com>
Date:   Wed, 8 Jul 2020 14:31:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1593622032-3082-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007080116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007080116
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 7/1/20 11:47 AM, Varun Prakash wrote:
> Firmware does tx flow control so remove tx flow
> control code from the driver.
> 
> Signed-off-by: Varun Prakash <varun@chelsio.com>

Reviewed-by: Mike Christie <michael.christie@oracle.com>
