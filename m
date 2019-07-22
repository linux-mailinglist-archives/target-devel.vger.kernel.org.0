Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5150D6FEEF
	for <lists+target-devel@lfdr.de>; Mon, 22 Jul 2019 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfGVLri (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 22 Jul 2019 07:47:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60212 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbfGVLri (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:47:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MBhcwF090119;
        Mon, 22 Jul 2019 11:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8mgKycLiDFKZ57eCzuXtmf070k3n5xT2IW9GzC9I8Yg=;
 b=0xs7hjf8/en+ut+z86GnhaH9QuKJjVRlNV047mTbUDTUHrFC8CnQYFoQs87Pkot8/rNr
 IZY90YWS59t3EJKxz1AraLtIwqBxbJLiVDEM5S8J1nvDZmZ3/4Wj5yPa8ix2VNfCEqaG
 buV7XScb/K0jrMYSRyanh4Z59ghGf50HheEtiMmi1DXzNyC7SzNo8KO2yka7sCL+PYSF
 5y0GhqBEI9vKZJWvI631+VpuFA8D4zQELX0rwv8AWHK4WtEcFWCqRafhUhbDNouEGQdo
 MPbw3hAEfJ8RRPGRYfrA9Ma2Jum723PplrhX918s+K/4fds8Pj7WzDCPVuBEia0Jmcwz mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tutct64qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 11:47:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MBgx5n173524;
        Mon, 22 Jul 2019 11:47:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tuts2tsh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 11:47:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6MBl7Ff006267;
        Mon, 22 Jul 2019 11:47:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 04:47:07 -0700
Date:   Mon, 22 Jul 2019 14:47:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     laokz <laokz@foxmail.com>
Cc:     security@kernel.org, stefani <stefani@seibold.net>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
Message-ID: <20190722114700.GE3089@kadam>
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9325 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9325 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220141
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:23:56PM +0800, laokz wrote:
> Hello,
> 
> A couple of weeks ago, I reported the respect author/maintainers. Haven't
> got reply yet, so I come here. 
> 
> The following is based on kernel 5.2-rc6.
> 
> include/linux/kfifo.h::kfifo_init() initialize a fifo using a preallocated
> buffer. It requests the buffer size should be power_of_two, if not so, the
> actual worker __kfifo_init() will round UP it to the next power of two. For
> it just records the new size in fifo's internal parameters, does not touch
> the real buffer, obviously this may introduce buffer overflow. 
> 
> In the source tree, I found an instance.
> 
> In drivers/scsi/ibmvscsi_tgt/libsrp.c::srp_iu_pool_alloc(), it calls
> kcalloc() and kfifo_init() with buffer size=max*sizeof(void
> *)=INITIAL_SRP_LIMIT*sizeof(void *), most likely be
> 800*8=6400. That is NOT power of 2, KFIFO will treat it as 8192 big! Bad.
> 
> Here is its only call-chain:
>   #define INITIAL_SRP_LIMIT 800                       /* ibmvscsi_tgt.c */
>   ibmvscsis_probe()::vscsi->request_limit=INITIAL_SRP_LIMIT
>     -> srp_target_alloc(,vscsi->request_limit,)       /* libsrp.c */
>       ->srp_iu_pool_alloc(,nr,)                /* nr=vscsi->request_limit */
>         ->kfifo_init(,max*sizeof(void *),)     /* max=nr */
> 
> I know before kernel 3.9 __kfifo_init() algorithm was rounddown. I don't
> know why changed to roundup, but it is safe and more robust to rounddown
> instead of roundup.
> 
> If i'm wrong, please let me know also. Thanks.

It looks like you're right.  Probably the fix is to:
1) Change INITIAL_SRP_LIMIT to 8192
2) Change kfifo_init() to round down like you say
3) Add a WARN_ONCE() in kfifo_alloc and kfifo_init() if the size isn't
   a power of two.

regards,
dan carpenter

