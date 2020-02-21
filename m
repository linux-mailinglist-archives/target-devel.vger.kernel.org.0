Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AD168A0D
	for <lists+target-devel@lfdr.de>; Fri, 21 Feb 2020 23:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgBUWmm (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 21 Feb 2020 17:42:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54258 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUWmm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:42:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LMd954177799;
        Fri, 21 Feb 2020 22:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=TOgfaO0dCRx40EwCp72PGO8fdYj9CFtoBSrlEsS0f/w=;
 b=farPHNCP7qwvcD0d6rl/Kgek3enOoh7G56EJsZULXyiOJ3HJxmpby2qzXntuCWUZJovr
 NwY6jiB41fVSAw7azdv0SfTw1rKPOJfKmQwCGm7lFOqW0AdQ96tTLogL3WMyPn+wx0aJ
 D04ohtc10ZZW1RB/ARn+DRQImFYrdeKBNjU7Zw+haIaOhfYZ2R4wzrWdVps206JU066Y
 IKeQjdXtXXQIG1cs0jUqBtxKSoQ0yoVrHFtHvhy/VuQvlpiSZbUbslo5r0DlWULg08Fs
 hHRb08UXNFBalx63SiNAw6zSY+j4ZTjn1/KmURE0Ypg5NWbBxCeTlKfpAPDpHtRi18tf xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8uddk9st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 22:42:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LMc20A164935;
        Fri, 21 Feb 2020 22:40:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y8udqvdgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 22:40:32 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01LMeVKd004282;
        Fri, 21 Feb 2020 22:40:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 14:40:31 -0800
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org, martin.petersen@oracle.com,
        mchristi@redhat.com, bvanassche@acm.org
Subject: Re: [PATCH] scsi: target: use an enum to track emulate_ua_intlck_ctrl
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200221094401.32021-1-ddiss@suse.de>
Date:   Fri, 21 Feb 2020 17:40:28 -0500
In-Reply-To: <20200221094401.32021-1-ddiss@suse.de> (David Disseldorp's
        message of "Fri, 21 Feb 2020 10:44:01 +0100")
Message-ID: <yq136b3tvhf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=783
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=857 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210169
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


David,

> The emulate_ua_intlck_ctrl device attribute accepts values of 0, 1 or 2
> via ConfigFS, which map to unit attention interlocks control codes in
> the MODE SENSE control Mode Page.
> Use an enum to track these values so that it's clear that, unlike the
> remaining emulate_X attributes, emulate_ua_intlck_ctrl isn't boolean.

Applied to 5.7/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
