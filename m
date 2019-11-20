Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC2D1031D9
	for <lists+target-devel@lfdr.de>; Wed, 20 Nov 2019 04:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfKTDCp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 19 Nov 2019 22:02:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34550 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfKTDCp (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 19 Nov 2019 22:02:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK2xLgD009167;
        Wed, 20 Nov 2019 03:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=zXtVuaco0uWZR42rEY3RPDY+ZTdxw5TaBiW1PSHChz8=;
 b=VIi7hq55xJAxAZMdPC/SaIVvuvXcmW2JoHFY92nB0o9NcYa3RpmE2MBgfrTFHhETISAO
 cCW7umzMTGs6QIhKin9Qsj7WT4hhecqXlnzeT41kgDysSKVadpK6ygADBfbhsEi9WyBJ
 N/Bz0kqfQ23zjgGxfJZA7hTnMUaYbWT35Oxl3e5vPRwf67G3JhI78PUcDGwFznUS5CGP
 gXQC6biKD88npkCWSbhy4fyYeqbR5L+gNX/4DQNV3AkFXm5eMMP/j6ipYHO4L9j/ufXp
 9tjDZtcdWfzpT5VEm5epWtk7dDLcrn8/pe1zHRnwY/oUsHL2gH9VqrgwxysNHX6NiEDM IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92ptsg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 03:02:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK2xDPH171239;
        Wed, 20 Nov 2019 03:02:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wcemcx325-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 03:02:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAK32Nkk017013;
        Wed, 20 Nov 2019 03:02:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 19:02:23 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
Subject: Re: [PATCH] target: Fix a pr_debug() argument
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191107215525.64415-1-bvanassche@acm.org>
        <yq1blt8ig6u.fsf@oracle.com>
        <adc67030-d7fd-ba31-3f7a-063650b43f10@acm.org>
Date:   Tue, 19 Nov 2019 22:02:21 -0500
In-Reply-To: <adc67030-d7fd-ba31-3f7a-063650b43f10@acm.org> (Bart Van Assche's
        message of "Tue, 19 Nov 2019 08:30:47 -0800")
Message-ID: <yq1lfsbfdxe.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=945 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200026
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bart,

> With CONFIG_DYNAMIC_DEBUG=y, the output of pr_debug() statements is
> controlled by the settings in
> /sys/kernel/debug/dynamic_debug/control.

OK.

Applied to 5.5/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
