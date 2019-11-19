Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2450710143E
	for <lists+target-devel@lfdr.de>; Tue, 19 Nov 2019 06:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfKSFbt (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 19 Nov 2019 00:31:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46638 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfKSFbt (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:31:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ5TFZl122524;
        Tue, 19 Nov 2019 05:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=D5fU9HkdoEcaDjDg9smBCNNL6bXBXBJHKivLNV8WmQ8=;
 b=cjuMf9mO/zUzEBEe9lMabnnPXbfSL5DrckJXiseur7r3TvFB/JoNFZkjEYcLLsE89L3Q
 pEnNSUN+DeQ6OFu/BW4/5uvt+Wn5DwE7VonsuB1Va6+nxQDizTXfJM1HGyKoASrWaejU
 HLxAdakPZagDvN62yPTCSgyX2vU0/yP2VMCq+J2DCY+ssijIY0UYfVtDpOBfMyjzLXHS
 0A7AH62mj8U0aca6kabTo1Gv/db0NL1EwJNsaf5pe4/PIT2jXHe3FwUijxkZn6YljVYK
 AhSJe4eBYq1Nyy/hvUsgEJvUVkJn87KuGtnWhaKcMARwVsKxZf2h5VIA3zcrOxoW1ZIt EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wa92pmgj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:31:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ5TMFx109476;
        Tue, 19 Nov 2019 05:29:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wc09ws3gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:29:33 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ5T4Y4010844;
        Tue, 19 Nov 2019 05:29:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 21:29:04 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Subject: Re: [PATCH] target/core: Document target_cmd_size_check()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191107215458.64242-1-bvanassche@acm.org>
Date:   Tue, 19 Nov 2019 00:29:02 -0500
In-Reply-To: <20191107215458.64242-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Thu, 7 Nov 2019 13:54:58 -0800")
Message-ID: <yq1ftikigdd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=872
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=957 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190050
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Bart,

> Since it is nontrivial to derive the meaning of the size argument from
> the code, add a documentation header above target_cmd_size_check().

Applied to 5.5/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
