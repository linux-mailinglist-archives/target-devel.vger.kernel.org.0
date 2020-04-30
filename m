Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2621B1C03E5
	for <lists+target-devel@lfdr.de>; Thu, 30 Apr 2020 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgD3R3S (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 30 Apr 2020 13:29:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44542 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD3R3S (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588267756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3zKt2wUNCZBE+fFh9B//zp9eiW3QL9FmZIMppjsIaM=;
        b=Gl6y5qI28iGwIOI38apl/CsT3gTJ9RIZwfUQDYUnhiy9+gt9CDdeYKZ/MlIrydUBr/MgCk
        tGTMrrct1PUgwhQjyHO7XdsHTSPm1ctU3RyR6YlF7nWmd4tzTb+k5jPXMUh1GzWh4iTYxt
        OzilQYb9Ng8N1dw95S26/jB7ZMHdDg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-4IgbAX9nOo637SL6u81uvg-1; Thu, 30 Apr 2020 13:29:14 -0400
X-MC-Unique: 4IgbAX9nOo637SL6u81uvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A9ED835B43;
        Thu, 30 Apr 2020 17:29:13 +0000 (UTC)
Received: from [10.10.116.41] (ovpn-116-41.rdu2.redhat.com [10.10.116.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9A95605DE;
        Thu, 30 Apr 2020 17:29:12 +0000 (UTC)
Subject: Re: [RFC] tcmu: wrong input from userspace can confuse tcmu
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        martin.petersen@oracle.com, target-devel@vger.kernel.org
References: <20200430151041.31053-1-bstroesser@ts.fujitsu.com>
 <90283f89-c4e7-19c0-2fdf-64c791f33221@redhat.com>
 <230e914f-f28c-56e4-853c-09de658cd7a2@ts.fujitsu.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <e4b8cc9c-ab81-516f-2c79-f9c7d873e54a@redhat.com>
Date:   Thu, 30 Apr 2020 12:29:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <230e914f-f28c-56e4-853c-09de658cd7a2@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 4/30/20 11:40 AM, Bodo Stroesser wrote:
>=20
>=20
> On 04/30/20 17:59, Mike Christie wrote:
>> On 4/30/20 10:10 AM, Bodo Stroesser wrote:
>>> Hi,
>>>
>>> When tcmu queues a new command - no matter whether in command
>>> ring or in qfull_queue - a cmd_id from IDR udev->commands is
>>> assigned to the command.
>>>
>>> If userspaces sends a wrong command completion containing the
>>> cmd_id of a command on the qfull_queue, tcmu_handle_completions()
>>> finds the command in the IDR and calls tcmu_handle_completion()
>>> for it. This might do some nasty things, because commands in
>>> qfull_queue do not have a valid dbi list.
>>>
>>> Of course this is easy to fix. E.g.:
>>>
>>>
>>> --- a/drivers/target/target_core_user.c=A0=A0=A0 2020-04-30
>>> 14:15:36.177184668 +0200
>>> +++ b/drivers/target/target_core_user.c=A0=A0=A0 2020-04-30
>>> 14:29:43.331882066 +0200
>>> @@ -1242,13 +1242,14 @@ static unsigned int tcmu_handle_completi
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON(tcmu_hdr_get_op(entry->hdr.len_op=
) !=3D TCMU_OP_CMD);
>>> =A0 -=A0=A0=A0=A0=A0=A0=A0 cmd =3D idr_remove(&udev->commands, entry-=
>hdr.cmd_id);
>>> -=A0=A0=A0=A0=A0=A0=A0 if (!cmd) {
>>> +=A0=A0=A0=A0=A0=A0=A0 cmd =3D idr_find(&udev->commands, entry->hdr.c=
md_id);
>>> +=A0=A0=A0=A0=A0=A0=A0 if (!cmd || !test_bit(TCMU_CMD_BIT_INFLIGHT, &=
cmd->flags)) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("cmd_id %u not found, =
ring is broken\n",
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 entry->h=
dr.cmd_id);
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_bit(TCMU_DEV_BIT_BROKEN, =
&udev->flags);
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 idr_remove(&udev->commands, entry->hdr.cmd_id)=
;
>>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0 tcmu_handle_completion(cmd, entry);
>>> =A0
>>> To avoid the second idr_*() call in main data path, it would also
>>> be possible to not replace the idr_remove() by idr_find(), but
>>> in case cmd was found without TCMU_CMD_BIT_INFLIGHT being set,
>>> during error handling re-add the cmd to the idr with the same id
>>> as before by calling idr_alloc(...,cmd_id, crmdd_id+1, ...).
>>>
>>>
>>> OTOH, I'm wondering whether the better solution would be to
>>> remove idr_alloc() from tcmu_setup_cmd_timer() and add it
>>> to queue_cmd_ring() immediately before or after it calls
>>> tcmu_setup_cmd_timer().
>>> Doing so would mean that commands in qfull_queue no longer have
>>> a cmd_id (which is not necessary AFAICS) and therefore the problem
>>
>> It's done for logging, but its only debug logging so we could just pri=
nt
>> the pointer value.
>>
>=20
> Yes, and then add the pointer value to the pr_debug that prints the
> assigned cmd_id after idr_alloc()
>=20
>>> cannot happen, because tcmu_handle_completions() cannot find them
>>> in the IDR.
>>>
>>
>> This is probably best if it's not a lot of trouble.
>=20
> I already spent some time to check the necessary changes. I think
> there is no trouble, just some small changes.
> So, yes, the bigger fix is probably better.
>=20
> I'll wait till next week for further comments and then send a patch.
>=20
>>
>> If you go this route then in tcmu_reset_ring I think I made a mistake
>=20
> I'm not sure, but I don't think there is a mistake. If you cleanup
> the ring, you don't need to cancel the commands in qfull_queue.

I was thinking about your userspace restart PGR question in another
mail. Between the time userspace stopped and restarted the session->id
to I_T nexus mapping could have changed, so id now refers to a different
I_T nexus.

Code path wise, it would be easier if we restarted the inflight and
non-inflight commands the same way.


>=20
>> and we just continue the loop if TCMU_CMD_BIT_INFLIGHT is not set. I
>> think we want to do:
>>
>> for cmd in qfull_list
>> =A0=A0=A0=A0 target_complete_cmd()
> So I think, this is not really necessary, but after
> =A0=A0=A0 clear_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
>=20
> we could do
> =A0=A0=A0 run_qfull_queue(udev, false);
>=20
> right?
>=20
>>
>> for cmd in idr
>> =A0=A0=A0=A0=A0 target_complete_cmd()
>>
>=20

