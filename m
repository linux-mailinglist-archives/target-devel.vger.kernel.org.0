Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6431D6C27
	for <lists+target-devel@lfdr.de>; Sun, 17 May 2020 21:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEQTQG (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 17 May 2020 15:16:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbgEQTQG (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 17 May 2020 15:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589742964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+w/3zmaHjfLCAsHS652uDQzylLJ6xD4X3mXeELm+dc=;
        b=ZCkP13A71+DPx6MTb9jLOT4UlzFLHaOoXi67wcfvVtkZ1BvLWEp1fF+sSkQjVYZWkQKlR6
        O8s7iGQdSxuAVRl4e59djgh0Gut1I41dmCmo3/wbRu+MLw+OFymW2tp1jSm7jUB4qDZ4oc
        rx+TFZaPGQvpz/NCJWzTzXGAku6Q7+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-N0Pb0_uqMOax4Nb0ao2KYw-1; Sun, 17 May 2020 15:16:02 -0400
X-MC-Unique: N0Pb0_uqMOax4Nb0ao2KYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3013E1005512;
        Sun, 17 May 2020 19:16:01 +0000 (UTC)
Received: from [10.10.112.55] (ovpn-112-55.rdu2.redhat.com [10.10.112.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 803735D9D7;
        Sun, 17 May 2020 19:16:00 +0000 (UTC)
Subject: Re: [PATCH target] target: Add initiatorname to NON_EXISTENT_LUN
 error
To:     Lance Digby <lance.digby@gmail.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cd119ce943d9ec62ef1bff237ebb49e35a337c3b.1589407872.git.lance.digby@gmail.com>
 <93c437ce-f881-9f54-5e39-afa8afd96141@redhat.com>
 <CAHh6B+poeCFeZjCt04QT2c12bgvCf9UN+5vdx5EeK6PcgD2y3g@mail.gmail.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <fb2b881c-fe23-4a80-53c3-189d744f2fe3@redhat.com>
Date:   Sun, 17 May 2020 14:16:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHh6B+poeCFeZjCt04QT2c12bgvCf9UN+5vdx5EeK6PcgD2y3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/16/20 6:29 PM, Lance Digby wrote:
> Mike,  Thanks for the review!
>   The pr_err  Detected NON_EXISTENT_LUN is the error messages issued
> for the TCM_NON_EXISTENT_LUN retcode so I believe they are the same.
>   Simply scanning for the wrong lun on an initiator will generate this
> error on the target but not generate an error on the initiator. And I
> have seen installs, with a lot of initiators, automate the scanning of
> such luns incorrectly deemed missing.
>   While this looks like a simple problem it can take days to get
> access or the tcp traces to sort it out.
> 
>    Within the same routine there is another pr_err for
> TCM_WRITE_PROTECTED that I did not add the initiatorname to as I
> thought this would leave a heavy footprint on the initiator. If you

I'm not sure what you mean by heavy footprint on the initiator part means.

I would say do whatever is helpful to you to debug the problem. For
TCM_WRITE_PROTECTED I'm not sure the initiatorname is helpful. I think
the target name and tpg would be useful, because I think you sometimes
set it at the tpg level then it gets inherited by the LU. But I think
it's a pain to get to the target name from this code path, so I wouldn't
worry about adding it now.

> believe this should be changed for consistency please let me know and
> I will add this and change to nacl->initiatorname.

Just to make sure we are on the same page. I was just commenting about
the other NON_EXISTENT_LUN instace in transport_lookup_tmr_lun. I just
thought we would want/need the same info there.


> 
> 
> 
> 
> 
> 
> 
> 
> 
> On Sat, May 16, 2020 at 9:50 AM Mike Christie <mchristi@redhat.com> wrote:
>>
>> On 5/13/20 11:01 PM, Lance Digby wrote:
>>> The NON_EXISTENT_LUN error can be written without an error condition
>>>  on the initiator responsible. Adding the initiatorname to this message
>>>  will reduce the effort required to fix this when many initiators are
>>> supported by a target.
>>>
>>> Signed-off-by: Lance Digby <lance.digby@gmail.com>
>>> ---
>>>  drivers/target/target_core_device.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
>>> index 4cee113..604dea0 100644
>>> --- a/drivers/target/target_core_device.c
>>> +++ b/drivers/target/target_core_device.c
>>> @@ -100,9 +100,10 @@
>>>                */
>>>               if (unpacked_lun != 0) {
>>>                       pr_err("TARGET_CORE[%s]: Detected NON_EXISTENT_LUN"
>>> -                             " Access for 0x%08llx\n",
>>> +                             " Access for 0x%08llx from %s\n",
>>>                               se_cmd->se_tfo->fabric_name,
>>> -                             unpacked_lun);
>>> +                             unpacked_lun,
>>> +                             se_sess->se_node_acl->initiatorname);
>>
>> You can do nacl->initiatorname.
>>
>> Do you also want add the name to the tmr case? It's probably not common,
>> but the error message would be consistent.
>>
>>>                       return TCM_NON_EXISTENT_LUN;
>>>               }
>>>
>>
> 

