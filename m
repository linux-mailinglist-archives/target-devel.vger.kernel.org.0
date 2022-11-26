Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB15A6393AA
	for <lists+target-devel@lfdr.de>; Sat, 26 Nov 2022 04:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKZD1s (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 25 Nov 2022 22:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZD1r (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:27:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FFEE21;
        Fri, 25 Nov 2022 19:27:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ32DZE017128;
        Sat, 26 Nov 2022 03:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=OwHfbKx8JIUAzRYKv+2vCWRAulaYhFXjKmyTfyml7Fc=;
 b=zvdRssLlrcQKyCZx7zIavVYT4bQmaTEtehwM9xBfzD8vlHhYZdlujBVXqATFFZxRRzWz
 XklPbzem6vLFXe/GjnwZbZR1UOBi3KGx/OQh75KSE3oYWKeyAehFtkz46/mGqKRNzI1P
 0eXSSaABDkoJ0bUoifLYm1wM96b/BdvCBP8mrjGCeVy/3a1Os66PXzFJffi3A3e+ko4o
 DJYs7VZqbAKwFPdcJkoHxh1EESbis0rqwzfU2LtAgjkfW6gFpA2Q3POW7pfn/RCvhBt+
 6QUdxmczhh/Gmv3vf9B73p9o/8ncIgyNunixpfLP1VBeCfUY62VjN7iQVDRM7WK4Q0Cj Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m397f824y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:27:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1XSGW007284;
        Sat, 26 Nov 2022 03:27:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3988b7yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:27:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AQ3RhsN028327;
        Sat, 26 Nov 2022 03:27:43 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3m3988b7y9-1;
        Sat, 26 Nov 2022 03:27:43 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     target-devel@vger.kernel.org,
        Anastasia Kovaleva <a.kovaleva@yadro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux@yadro.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Make target send correct io limits
Date:   Sat, 26 Nov 2022 03:27:32 +0000
Message-Id: <166943312557.1684293.4086003000772327937.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114102500.88892-1-a.kovaleva@yadro.com>
References: <20221114102500.88892-1-a.kovaleva@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=715 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260024
X-Proofpoint-ORIG-GUID: HYdlNmFgKUlA1yM306F6zqMkdeiwr7cG
X-Proofpoint-GUID: HYdlNmFgKUlA1yM306F6zqMkdeiwr7cG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, 14 Nov 2022 13:24:57 +0300, Anastasia Kovaleva wrote:

> Currently iblock always reports MAXIMUM TRANSFER LENGTH in 512b units
> regardless of the LU block size.
> 
> Target block size:
>   target:~ # fdisk -l /dev/nullb0
>   Disk /dev/nullb0: 250 GiB, 268435456000 bytes, 65536000 sectors
>   Units: sectors of 1 * 4096 = 4096 bytes
>   Sector size (logical/physical): 4096 bytes / 4096 bytes
>   I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/3] target: core: Send mtl in blocks
      https://git.kernel.org/mkp/scsi/c/7870d2481789
[2/3] target: core: make hw_max_sectors store the sectors amount in blocks
      https://git.kernel.org/mkp/scsi/c/9375031ee40b
[3/3] target: core: Change the way target_xcopy_do_work sets restiction on max io
      https://git.kernel.org/mkp/scsi/c/689d94ec208c

-- 
Martin K. Petersen	Oracle Linux Engineering
