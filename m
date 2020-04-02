Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57C19C947
	for <lists+target-devel@lfdr.de>; Thu,  2 Apr 2020 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbgDBS7B (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 2 Apr 2020 14:59:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46134 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388658AbgDBS7B (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585853939;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gT+QktImGPwKida314PKntP8yTyT1+z6WH8pumQ2Q2k=;
        b=W5W1Hu+FbDuGQaejKqZg7LF4x0divNRyOnoEI10lRlkajneSGZ775E6pp5wCB95GWsZiET
        wT7Y8WhXRTwN2HcLstxVvYkdpBIklT5O4Agyyp9MR0w7G6polfsb4uqSdXIo00+Ec9+ysa
        jXCOw2+zBV+TQylBLEBDhvV8QfDeh0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-bwEIeJoeMeKcm_SjbWSYTQ-1; Thu, 02 Apr 2020 14:58:57 -0400
X-MC-Unique: bwEIeJoeMeKcm_SjbWSYTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6623D107B272;
        Thu,  2 Apr 2020 18:58:56 +0000 (UTC)
Received: from mchristi.msp.csb (ovpn-119-64.rdu2.redhat.com [10.10.119.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A1191001B28;
        Thu,  2 Apr 2020 18:58:55 +0000 (UTC)
Reply-To: mchristi@redhat.com
Subject: Re: [PATCH] target: tcmu: add missing pr attributes to passthrough
 backends
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        target-devel@vger.kernel.org
Cc:     ddiss@suse.de, hch@lst.de, martin.petersen@oracle.com
References: <20200401132153.23501-1-bstroesser@ts.fujitsu.com>
 <76689136-62a7-65d7-7eb8-44c459f95aa7@redhat.com>
 <e4d201a5-28d1-0ace-c3c8-46f17321de3e@ts.fujitsu.com>
From:   Michael Christie <mchristi@redhat.com>
Organization: Red Hat
Message-ID: <68272880-55c1-f56b-13fe-ef58a284aa3d@redhat.com>
Date:   Thu, 2 Apr 2020 13:58:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <e4d201a5-28d1-0ace-c3c8-46f17321de3e@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04/02/2020 09:11 AM, Bodo Stroesser wrote:
>=20
> On 04/01/20 22:05, Michael Christie wrote:
>> On 04/01/2020 08:21 AM, Bodo Stroesser wrote:
>>> In commit b49d6f7885306ee636d5c1af52170f3069ccf5f7 the new attribute>
>>> emulate_pr was added.
>>> passthrough_parse_cdb() uses the attribute's value to distinguish,
>>> whether reservation commands should be rejected or not.
>>> But the new attribute was not added to passthrough_attrib_attrs, so i=
n
>>> pscsi and tcmu - the users of passthrough_parse_cdb() - the attribute
>>> is not available to change parser's behavior.
>>> This patch adds the new attribute as well as the "pr control" attribu=
tes
>>> enforce_pr_isids and force_pr_aptpl to passthrough_attrib_attrs.
>>>
>>> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
>>> ---
>>>   drivers/target/target_core_configfs.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/target/target_core_configfs.c
>>> b/drivers/target/target_core_configfs.c
>>> index ff82b21fdcce..c5a974c5b31d 100644
>>> --- a/drivers/target/target_core_configfs.c
>>> +++ b/drivers/target/target_core_configfs.c
>>> @@ -1203,6 +1203,9 @@ struct configfs_attribute
>>> *passthrough_attrib_attrs[] =3D {
>>>       &attr_hw_block_size,
>>>       &attr_hw_max_sectors,
>>>       &attr_hw_queue_depth,
>>> +    &attr_emulate_pr,
>>
>> This one seems ok here, because it works for both pscsi and tcmu.
>>
>>> +    &attr_enforce_pr_isids,
>>> +    &attr_force_pr_aptpl,
>>
>> These only work for tcmu. pscsi will do whatever the physical device
>> does, and we can't control it. I guess the options would be:
>=20
> Sorry, I forgot to add a note, that I'm preparing a further patch, that
> allows to write pgr_support attribute (TRANSPORT_FLAG_PASSTHROUGH_PGR),
> if the backend allows it.
>=20
> We need this to be able to set TRANSPORT_FLAG_PASSTHROUGH_PGR for tcmu.
>=20
> But of course it also would be an option for pscsi to allow resetting o=
f
> TRANSPORT_FLAG_PASSTHROUGH_PGR. Then the pr emulation in target core ca=
n
> be used by pscsi. (And then the two other attributes become useful.)
>=20
> I'm wondering anyway, whether reservation passthrough makes sense for

Yeah, I wondered the same thing. Some commands that use transport info
might not work correctly right now or apps could get confused when the
transport it sees is FC because the qla2xxx fabric driver is used to
export a pscsi LU, but the pscsi scsi_device struct is for a iSCSI
device so inquiry name and port info will look mismatched. But then for
really specific SCSI 2 reservation cases it might be working.

When I added the extra passthrough flags, I did not know how users were
using it, and I didn't want to break existing setups. I just kept the
same behavior/support incase someone had a specific setup that was workin=
g.

> pscsi? For tcmu we will also send a patch allowing to pass nexus info u=
p
> to userland.
>=20
>>
>> 1. Just add them above.
>=20
> According to what I wrote above, I'd still prefer option 1. :)

I think it might be best to get them in at the same time then. If not,
we might end up where in some kernels those files do nothing and report
success, then in other kernels they actually work.


>=20
> Thank you,
> Bodo
>=20
>>
>> 2. Add them above and add some TRANSPORT_FLAG_PASSTHROUGH_PGR checks i=
n
>> functions like force_pr_aptpl_store like we did for the pr functions, =
so
>> the user gets some feedback if they try to use them for pscsi. We woul=
d
>> have to add a isid function too.
>>
>> 3. Export the attrs or some common lib/helper functions to get/set the
>> values then target_core_user.c can setup the attrs and add it to
>> tcmu_attrib_attrs.
>>
>>
>>>       &attr_alua_support,
>>>       &attr_pgr_support,
>>>       NULL,
>>
>>
>>
>=20

