Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE95119DC8F
	for <lists+target-devel@lfdr.de>; Fri,  3 Apr 2020 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDCRTW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 3 Apr 2020 13:19:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727998AbgDCRTW (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585934361;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMvShQKOJbjlk+Rg4s7HM+dbUOpfshX0Tx5vRiVgo8s=;
        b=dnC0+funF8dFF9fdtT3Ah7+CU04/JZeatg3XtTHWJa9cumtijZWpsL+WiSj4oD9XYVrkYc
        9pN4l3F8r8yaeZPdotyQGeSdZJmxeJokSGeWAxndohFMMpQ4albynGMFBn2HlNPeN8z2vl
        sc3v+/42VhtD45e0YvfJjxzmom9ojVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-SGcYiQOFP_a7wAGuM_D52g-1; Fri, 03 Apr 2020 13:19:19 -0400
X-MC-Unique: SGcYiQOFP_a7wAGuM_D52g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A37219057A1;
        Fri,  3 Apr 2020 17:19:17 +0000 (UTC)
Received: from mchristi.msp.csb (ovpn-113-44.rdu2.redhat.com [10.10.113.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6BA626DEA;
        Fri,  3 Apr 2020 17:19:16 +0000 (UTC)
Reply-To: mchristi@redhat.com
Subject: Re: [PATCH 2/2] target: make pgr_support and alua_support attributes
 writable
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        target-devel@vger.kernel.org
Cc:     ddiss@suse.de, hch@lst.de, martin.petersen@oracle.com
References: <20200403143214.18303-1-bstroesser@ts.fujitsu.com>
 <20200403143214.18303-3-bstroesser@ts.fujitsu.com>
From:   Michael Christie <mchristi@redhat.com>
Organization: Red Hat
Message-ID: <ca4ab505-22f7-c46c-cbdf-7e00c5f59d0c@redhat.com>
Date:   Fri, 3 Apr 2020 12:19:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20200403143214.18303-3-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04/03/2020 09:32 AM, Bodo Stroesser wrote:
>  /*
>   * dev_attrib attributes for devices using the target core SBC/SPC
> diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target=
_core_pscsi.c
> index 4e37fa9b409d..e7d92ef43ca4 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -1073,6 +1073,7 @@ static const struct target_backend_ops pscsi_ops =
=3D {
>  	.transport_flags_default =3D TRANSPORT_FLAG_PASSTHROUGH |
>  				   TRANSPORT_FLAG_PASSTHROUGH_ALUA |
>  				   TRANSPORT_FLAG_PASSTHROUGH_PGR,
> +	.transport_flags_changeable =3D TRANSPORT_FLAG_PASSTHROUGH_PGR,
>  	.attach_hba		=3D pscsi_attach_hba,
>  	.detach_hba		=3D pscsi_detach_hba,
>  	.pmode_enable_hba	=3D pscsi_pmode_enable_hba,

Do we need more code to support this?

For example, if LIO core is now handling PRs then it uses the I_T nexus
info from LIO core for registrations if its not provided in the PR
command. But port/target INQUIRY info would be from the struct
scsi_device that pscsi is using since we pass INQUIRY down to that
device. We will end up with mismatches where a PR-in READ_FULL_STATUS
would return different results than the INQUIRY.

