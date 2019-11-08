Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB2F5136
	for <lists+target-devel@lfdr.de>; Fri,  8 Nov 2019 17:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfKHQe1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 8 Nov 2019 11:34:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60852 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726039AbfKHQe1 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573230866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MswkzqSTgztzY8rIctB3nvZ7tTFuK81EkDbQodyjE2k=;
        b=Ko4sxevxyTE7S+92fwXG3SJluFXb2QYZicUXZ7eEL0NV/bsT9Vulxlf72cnqfpi9ScVSB+
        PsBwl+H9Z3go+VrAc3ERnKTSfizZgRsLfWQ78GmpOwrPbKU40Cs4sAOiBN0iw+JL3R6eqx
        VQ7cPmR4ik3NtaXWRgIioRGvKobVVPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-hWr799ELOo2eZxLUvrdC3g-1; Fri, 08 Nov 2019 11:34:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D6B107ACC4;
        Fri,  8 Nov 2019 16:34:23 +0000 (UTC)
Received: from [10.10.125.42] (ovpn-125-42.rdu2.redhat.com [10.10.125.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F18260BE1;
        Fri,  8 Nov 2019 16:34:22 +0000 (UTC)
Subject: Re: [PATCH v2] target: core: Prevent memory reclaim recursion
To:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org
References: <20191108082901.417950-1-damien.lemoal@wdc.com>
 <cefdcca4-e839-829e-54aa-b95e77825d1d@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DC59908.5010600@redhat.com>
Date:   Fri, 8 Nov 2019 10:34:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <cefdcca4-e839-829e-54aa-b95e77825d1d@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hWr799ELOo2eZxLUvrdC3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/08/2019 10:22 AM, Bart Van Assche wrote:
> On 11/8/19 12:29 AM, Damien Le Moal wrote:
>> Prevent recursion into the IO path under low memory conditions by using
>> GFP_NOIO in place of GFP_KERNEL when allocating a new command with
>> tcmu_alloc_cmd() and user ring space with tcmu_get_empty_block().
>>
>> Reported-by: Masato Suzuki <masato.suzuki@wdc.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>
>> Changes from v1:
>> * Added reported-by tag
>>
>>   drivers/target/target_core_user.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> The patch subject is weird. Shouldn't the patch subject start with
> "tcmu" instead of "target: core"?
>=20
> Has the recursion mentioned in the patch description been observed or is
> this a theoretical issue? I'm asking this because GFP_NOIO only prevents

Observed.

> recursion if it is used inside a block driver or filesystem. The tcmu
> driver is neither - it submits block I/O or filesystem I/O instead of
> implementing a block driver or filesystem. Should we really disallow
> tcmu to use the swap subsystem?

A common use is tcm loop on the frontend and tcmu on the backend. You
see this with virt and containers, where some app is used to interacting
SCSI devices, but then the storage is backed by something that people
didn't want to put in the kernel. It's similar to nbd when you use
AF_UNIX sockets with a local running daemon.

