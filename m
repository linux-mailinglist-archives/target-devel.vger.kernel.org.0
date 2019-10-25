Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98EE466E
	for <lists+target-devel@lfdr.de>; Fri, 25 Oct 2019 10:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406288AbfJYI6J (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 25 Oct 2019 04:58:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404657AbfJYI6J (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571993888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsZVO3+pX6zr/sTcOfDNHnaIUrnWuSFIvYurbXLUiJA=;
        b=Hpigz4X9pYm09rBli7eZWn0kFX6AutWzEiJgf57lxmRPIb4sEJxqyVlScjqBpDnZndNdhr
        NFK1WZidEBL7+DWathYxfV+Kin+37V4yJU3lTHhC4au5uY0UiJrX1pSqlwFIqTVeZjJ7lh
        S22D2ED4/Eb5O0pGpx62cqObsHfvXpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Ql0bmPTnN2erxjlC_W3NyQ-1; Fri, 25 Oct 2019 04:58:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30703800D41;
        Fri, 25 Oct 2019 08:58:04 +0000 (UTC)
Received: from [10.40.204.165] (ovpn-204-165.brq.redhat.com [10.40.204.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 537DD1F3;
        Fri, 25 Oct 2019 08:58:02 +0000 (UTC)
Subject: Re: [PATCH V2 0/3] iscsi: chap: introduce support for SHA1, SHA256
 and SHA3-256
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20191017131037.9903-1-mlombard@redhat.com>
 <yq1k18td6aq.fsf@oracle.com>
Cc:     cleech@redhat.com, mchristi@redhat.com,
        target-devel@vger.kernel.org, hch@infradead.org
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <4a399a7c-e776-7844-1c30-ca41f61ddc3f@redhat.com>
Date:   Fri, 25 Oct 2019 10:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <yq1k18td6aq.fsf@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Ql0bmPTnN2erxjlC_W3NyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hello,

Dne 25.10.2019 v 02:20 Martin K. Petersen napsal(a):
>=20
> Hi Maurizio,
>=20
>> iSCSI with the Challenge-Handshake Authentication Protocol is not FIPS
>> compliant.  This is due to the fact that CHAP currently uses MD5 as
>> the only supported digest algorithm and MD5 is not allowed by FIPS.
>>
>> When FIPS mode is enabled on the target server, the CHAP
>> authentication won't work because the target driver will be prevented
>> from using the MD5 module.
>>
>> Given that CHAP is agnostic regarding the algorithm it uses, this
>> patchset introduce support for three new alternatives: SHA1, SHA256
>> and SHA3-256.
>=20
> Can you please submit these on top of 5.5/scsi-queue which has your
> string parsing fixes in place?
>=20

I will rebase on top of 5.5/scsi-queue and send a V3.

Thanks,
Maurizio

