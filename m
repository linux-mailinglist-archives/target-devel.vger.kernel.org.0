Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB51B14AE51
	for <lists+target-devel@lfdr.de>; Tue, 28 Jan 2020 04:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgA1DL4 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 27 Jan 2020 22:11:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56424 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1DLz (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 27 Jan 2020 22:11:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00S33a8M146205;
        Tue, 28 Jan 2020 03:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=bO24n4La2Efk2NtJKHbFaqjslhUP7TElegEw6X1mz9g=;
 b=GpekiONr8+znG6ljeCcCV9aAfltVphTUrxB7lj4BA0UzIkNsbKEG2suqZiObI3EQs/2a
 v+YDbe4nJJGpAV6KKyhBHKAcqmjzQTT74g0SaLLPlttlpnx1WXCqfCWH2XXlvYdn5nc1
 UFY+r73/t01pe9IIlfMzPg/n/dmeYL8gGaetjqKVCirq2G4JYIJUB9pmR83veO7KXUXe
 kMaRhr7JP/+pbq1UObRvH52AM3RybCt/icPJReroYpWGInQnm0lL5VU00ohsaAnJdtFl
 HZe0he7O3ACmS5Udtn5rk1cAPAXYhl57Wtebr8DeiBz/433vfNjcDqyEhWb0PPSU1P8E IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xrdmqbbdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 03:11:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00S33Txl159805;
        Tue, 28 Jan 2020 03:09:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xry4vnyf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 03:09:47 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00S39hfF030734;
        Tue, 28 Jan 2020 03:09:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 19:09:43 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        "target-devel\@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [EXT] [PATCH] tcm_qla2xxx: Make qlt_alloc_qfull_cmd() set cmd->se_cmd.map_tag
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200103192719.205158-1-bvanassche@acm.org>
        <b21b981b-bbb3-2362-63a6-39cb0e7ddfbb@acm.org>
        <ADC40ECE-EEC9-4BFC-9866-65F51B7635CE@marvell.com>
Date:   Mon, 27 Jan 2020 22:09:41 -0500
In-Reply-To: <ADC40ECE-EEC9-4BFC-9866-65F51B7635CE@marvell.com> (Himanshu
        Madhani's message of "Mon, 27 Jan 2020 13:25:27 +0000")
Message-ID: <yq1tv4gb7ka.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=639
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=703 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280024
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


> Reduce code duplication by introducing the tcm_qla2xxx_{get,rel}_cmd()
> functions. Introduce these functions in the tcm_qla2xxx.c source files
> such that the qla_target.c source file becomes independent of the SCSI
> target core header files. This patch fixes a bug, namely by ensuring that
> qlt_alloc_qfull_cmd() sets cmd->se_cmd.map_tag.

Applied to 5.7/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
