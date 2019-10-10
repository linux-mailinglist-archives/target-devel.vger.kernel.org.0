Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB80D3347
	for <lists+target-devel@lfdr.de>; Thu, 10 Oct 2019 23:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfJJVSk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 10 Oct 2019 17:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVSk (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:18:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9B2210CC1ED;
        Thu, 10 Oct 2019 21:18:39 +0000 (UTC)
Received: from [10.10.122.48] (ovpn-122-48.rdu2.redhat.com [10.10.122.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4AD5D6A5;
        Thu, 10 Oct 2019 21:18:39 +0000 (UTC)
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Bart Van Assche <bvanassche@acm.org>,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
 <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
 <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
 <c87f1206-4abd-d7d3-bc68-369abf80950f@ts.fujitsu.com>
 <c5c1b35f-6dcf-dedc-b380-f28b1684c69e@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D9FA02E.3050909@redhat.com>
Date:   Thu, 10 Oct 2019 16:18:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <c5c1b35f-6dcf-dedc-b380-f28b1684c69e@acm.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Thu, 10 Oct 2019 21:18:39 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/10/2019 03:14 PM, Bart Van Assche wrote:
> On 10/10/19 11:57 AM, Bodo Stroesser wrote:
>> Hmm. You are right. Ideally only SCSI-2 compliant initiators should
>> use the LUN field and they should run parallel SCSI only.
>>
>> OTOH, like Mike already said, we can't know whether there is any SW, FW,
>> BIOS, ... out there, that still sends such old style CDBs.
>>
>> For example: probably SW could send such CDBs by simply using SCSI
>> generic device on top of a modern initiator. (I hope that's true, I
>> didn't test ...)
>> That means, old code can produce old SCSI CDBs even when running
>> on top of modern HW.
>>
>> Do we want to take the risk of breaking such "old stuff"?
> 
> Is blindly filtering out the LUN number correct? All initiator code that

I have no idea about other details other than the code comments. I think
in general that code is wrong:

1. The original comment mentions iscsi and SAM2 but I think the SBC,
SPC, etc versions iscsi supported no longer supported commands that had
the LUN in those bits.

2. If we got one of these old commands and we clear the LUN, then we
have LUN=0 in that field, but the physical (not the lio level hba struct
but the drivers/scsi one) HBA/driver for the physical device might have
the physical device at LUN != 0, so I would think firmware might have
had issues with that.

3. It does not make sense to me why that list is so incomplete. I do not
understand why only those commands are in that list and not others.


> I found and that touches the highest three bits of that byte sets the
> LUN number in that byte. From the SCSI error handler:
> 
> if (sdev->scsi_level <= SCSI_2 && sdev->scsi_level != SCSI_UNKNOWN)
>     scmd->cmnd[1] = (scmd->cmnd[1] & 0x1f)|(sdev->lun << 5 & 0xe0);
> 
> Bart.

