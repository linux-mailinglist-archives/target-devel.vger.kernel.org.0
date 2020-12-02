Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE692CC1A3
	for <lists+target-devel@lfdr.de>; Wed,  2 Dec 2020 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgLBQG1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 2 Dec 2020 11:06:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50068 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgLBQG1 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:06:27 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B2G0mJm030523;
        Wed, 2 Dec 2020 16:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=xxcjt3mtG/KHaHQo8wbjGj0uXaf0aqSvVB1wzb68+XY=;
 b=Ng6LiJvBxoTLeeEEscwn8EX4TpUHsrxSmJzWO4/rQ3wRS62vip44iU0QTVTJVqyjT8Yp
 1GIFZxWuNBNVVYZHgoli3rnLpLgUPo6ldW0PkjMhvci6CT8nDJu5AtmCdF+gFUG65qI5
 WDsbJgUcGFsw29u7JQzgRF0Syvqa1i8YOuO3hpYxeeh0DaxbUleQVKsPxkiFNYGjcjse
 qCbbc9u4WoL9rhf8Gk8QhpMYFIkaW8EnGise+pQlsnCb8YMxqFES5JmSOPJTNuwF0G0t
 Z5d+qsVOIte6zvxL+wIWdIy3rdp1DCluR/OGeNLsYIgvWE3/8n1ZOiSgF+1gUT0vQOIZ 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 353c2b18gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Dec 2020 16:05:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B2FaYLT105718;
        Wed, 2 Dec 2020 16:05:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3540aug246-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Dec 2020 16:05:04 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B2G52hx017490;
        Wed, 2 Dec 2020 16:05:02 GMT
Received: from [20.15.0.5] (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Dec 2020 08:05:01 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] qemu vhost scsi: add VHOST_SET_VRING_ENABLE support
From:   Michael Christie <michael.christie@oracle.com>
In-Reply-To: <20201202045807-mutt-send-email-mst@kernel.org>
Date:   Wed, 2 Dec 2020 10:05:00 -0600
Cc:     stefanha@redhat.com, qemu-devel@nongnu.org, fam@euphon.net,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <62EE5A4E-E817-43FC-91B7-0B1050D034C7@oracle.com>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-2-git-send-email-michael.christie@oracle.com>
 <20201202045807-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012020095
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



> On Dec 2, 2020, at 3:59 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Nov 12, 2020 at 05:19:00PM -0600, Mike Christie wrote:
>> diff --git a/linux-headers/linux/vhost.h =
b/linux-headers/linux/vhost.h
>> index 7523218..98dd919 100644
>> --- a/linux-headers/linux/vhost.h
>> +++ b/linux-headers/linux/vhost.h
>> @@ -70,6 +70,7 @@
>> #define VHOST_VRING_BIG_ENDIAN 1
>> #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct =
vhost_vring_state)
>> #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct =
vhost_vring_state)
>> +#define VHOST_SET_VRING_ENABLE _IOW(VHOST_VIRTIO, 0x15, struct =
vhost_vring_state)
>=20
> OK so first we need the kernel patches, then update the header, then
> we can apply the qemu patch.

Hey Michael,

Don=E2=80=99t waste any more of your time on this patch and the kernel =
related ones.

I=E2=80=99m working on the userspace initiated threading approach =
discussed the other week.=
