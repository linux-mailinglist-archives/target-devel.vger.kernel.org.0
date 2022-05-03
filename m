Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733FC517BB9
	for <lists+target-devel@lfdr.de>; Tue,  3 May 2022 03:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiECBmc (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 2 May 2022 21:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiECBmc (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 2 May 2022 21:42:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458F3701A;
        Mon,  2 May 2022 18:39:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2430TJqi004092;
        Tue, 3 May 2022 00:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=IU9i46VqixkkZm2G74FBQyDQfbnpVNr6yXH6mgFOou8=;
 b=UKiV5IK+ohjILELJymG9CoQwLKxedln5k/l5qObIp36hkaar2r1fMRepbzw85wZl/CPR
 k9Owckc6M6vPJuGisyMKuspR4dK2xqH+0GR2n0hOAx2cLTCoplKF+YDuBhwLIx381P/3
 RdaDrfZD1ZM0CuKVAzmqA73gnxegVl/d3PSw4LpcsY6fLTftwUGkqWh5f64nCbYw7qOH
 lH8sLe4PotG0SJ3q31mTTh4ASdVv7QMdjFY5TxqGQ9IXUIt1JIgTxgMlev/DYuivAakP
 I87EswUpx3U96Whj0zGsdkNlROWyDN0ZoClr+qK4daVsYk+iPf/AgGYHayWXCq+im3Pu 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amhjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430opUT008924;
        Tue, 3 May 2022 00:52:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83xav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljq010389;
        Tue, 3 May 2022 00:52:02 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-28;
        Tue, 03 May 2022 00:52:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     target-devel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux@yadro.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: target: core: Silence the message about unknown VPD pages
Date:   Mon,  2 May 2022 20:51:38 -0400
Message-Id: <165153836358.24053.13078455847265502912.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220418212622.275516-1-k.shelekhin@yadro.com>
References: <20220418212622.275516-1-k.shelekhin@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DAZjRw91PhnqVd_jwCZG4riNHTFApH4L
X-Proofpoint-ORIG-GUID: DAZjRw91PhnqVd_jwCZG4riNHTFApH4L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, 19 Apr 2022 00:26:22 +0300, Konstantin Shelekhin wrote:

> Target does not support some VPD pages and is very verbose about it.
> Sometimes initiators don't bother and just keep sending the same request
> from time to time, filling up the logs.
> 
> This patch lowers the message priority to debug.
> 
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: target: core: Silence the message about unknown VPD pages
      https://git.kernel.org/mkp/scsi/c/95af09fabf37

-- 
Martin K. Petersen	Oracle Linux Engineering
