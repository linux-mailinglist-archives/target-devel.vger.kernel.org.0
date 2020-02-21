Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6E9168A09
	for <lists+target-devel@lfdr.de>; Fri, 21 Feb 2020 23:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBUWkX (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 21 Feb 2020 17:40:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52380 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgBUWkX (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:40:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LMbTtJ041408;
        Fri, 21 Feb 2020 22:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=eL4+rWmhM/WZ5hbspOqGuqbsPyXoLUIPqffc0CSwYhE=;
 b=UvTxQalu5g5Z2BTga+O8bBwcxwNRrYAtGCEcWvU3rVI3SFsGkbqCzdSvNEQo2yh3j3eN
 SF3J+KJRpFRntsQ0+XRCdSYw2GZrDDyZGAvvg/RjhekEG7hcnzCkQj7RGgJZ/MbzUiyC
 +ne/AUP6qGh3JrEPG3B/E4RPNk7DT/0LK/ORRsh1p3pYgiNO+InsznmsXa4qfQq4AUNJ
 bCssGrN10md4PA6DhfNZ+3R1vbF09LOvBV4JvhNV4HsPLPQh6Gu6rl59ctf+80tTmcT8
 g3GNHAaAo/6rLJDe8QWwJl2ccxRe53eCgbAcC0KcejC0hb7NS1q0w9UfJuX8Q0Kdq37Y qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y8udku92a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 22:40:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LMcx4w133509;
        Fri, 21 Feb 2020 22:40:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2y8ud9u8k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 22:40:12 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01LMeBLd005960;
        Fri, 21 Feb 2020 22:40:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 14:40:11 -0800
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org, martin.petersen@oracle.com,
        mchristi@redhat.com, bvanassche@acm.org
Subject: Re: [PATCH v2 0/2] scsi: target: modify boolean configfs attributes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200219130136.18946-1-ddiss@suse.de>
Date:   Fri, 21 Feb 2020 17:40:09 -0500
In-Reply-To: <20200219130136.18946-1-ddiss@suse.de> (David Disseldorp's
        message of "Wed, 19 Feb 2020 14:01:34 +0100")
Message-ID: <yq17e0ftvhy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=676 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=750 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210169
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


David,

> This series includes a fix for a regression in the configfs interface
> and has a subsequent type cleanup to avoid similar mistakes in future.

Applied to 5.7/scsi-queue, thanks!

Please don't forget to CC: linux-scsi. Otherwise things won't get
captured by lore.

-- 
Martin K. Petersen	Oracle Linux Engineering
