Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21E4D3319
	for <lists+target-devel@lfdr.de>; Thu, 10 Oct 2019 23:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfJJU6O (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 10 Oct 2019 16:58:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfJJU6O (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:58:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A0D63086272;
        Thu, 10 Oct 2019 20:58:13 +0000 (UTC)
Received: from [10.10.122.48] (ovpn-122-48.rdu2.redhat.com [10.10.122.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D17C35D6A5;
        Thu, 10 Oct 2019 20:58:12 +0000 (UTC)
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Bart Van Assche <bvanassche@acm.org>,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
 <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
 <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D9F9B64.80505@redhat.com>
Date:   Thu, 10 Oct 2019 15:58:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 10 Oct 2019 20:58:13 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/10/2019 10:41 AM, Bart Van Assche wrote:
> On 10/10/19 5:07 AM, Bodo Stroesser wrote:
>> On 10/10/19 05:38, Mike Christie wrote:
>>> On 10/08/2019 03:20 PM, bodo.stroesser@ts.fujitsu.com wrote:
>>>> Hi,
>>>>
>>>> We use TCMUser to run userspace tape and changer emulations.
>>>>
>>>> Current tests with a new version of backup SW failed, due to that
>>>> application
>>>> using SECURITY PROTOCOL IN / OUT  SCSI commands.
>>>> The CDBs of these commands in byte 1 contain relevant information that
>>>> is overwritten in passthrough_parse_cdb() / target_core_device.c
>>>>
>>>> This is the related part of the code:
>>>>
>>>>          /*
>>>>           * Clear a lun set in the cdb if the initiator talking to
>>>> use spoke
>>>>           * and old standards version, as we can't assume the
>>>> underlying device
>>>>           * won't choke up on it.
>>>>           */
>>>>          switch (cdb[0]) {
>>>>          case READ_10: /* SBC - RDProtect */
>>>>          case READ_12: /* SBC - RDProtect */
>>>>          case READ_16: /* SBC - RDProtect */
>>>>          case SEND_DIAGNOSTIC: /* SPC - SELF-TEST Code */
>>>>          case VERIFY: /* SBC - VRProtect */
>>>>          case VERIFY_16: /* SBC - VRProtect */
>>>>          case WRITE_VERIFY: /* SBC - VRProtect */
>>>>          case WRITE_VERIFY_12: /* SBC - VRProtect */
>>>>          case MAINTENANCE_IN: /* SPC - Parameter Data Format for SA
>>>> RTPG */
>>>>                  break;
>>>>          default:
>>>>                  cdb[1] &= 0x1f; /* clear logical unit number */
>>>>                  break;
>>>>          }
>>>>
>>>> Obviously the list of command codes for which bits 5,6,7 of byte 1
>>>> are _not_ reset
>>>> is not complete. Now I'm wondering what would be the right fix:
>>>>
>>>> 1) Scan the SCSI specs and add all other missing command codes to
>>>> the list of
>>>>     Codes to skip
>>>>
>>>> 2) Create a list of commands that definitely have the LUN field in
>>>> byte 1 and
>>>>     reset the bits only in those. (Might be better than 1), because
>>>> I expect new
>>>>     commands to not have the LUN field.)
>>>>
>>>> 3) Remove the code entirely, because it is no longer needed / useful
>>>> (?)
>>>>
>>>
>>> My preference would be to remove it like Bart suggested. Maybe we should
>>> make it configurable via a device attribute or backend module flag.
>>>
>>> For the 2 users:
>>>
>>> pscsi - It seems this code was there from the beginning via
>>> transport_generic_prepare_cdb in the original commit. Nick must have
>>> found some initiator where the workaround was needed and I am not sure
>>> if we would break them or not now. Based on the original code's comment
>>> about iscsi my guess is there was some misc iscsi initiator probably in
>>> a boot firmware or some offload card that supported old commands.
>>>
>>> tcmu - We want the raw cdb. I think masking out the above bits was an
>>> accident. It looks like when Andy converted tcmu to use common code the
>>> behavior got brought in for tcmu.
>>>
>> I think, regarding TCMU you both are right, we should skip the code.
>> To avoid the need for an attribute, I'd prefer a new flag in the backend
>> ops. So pscsi can stay unchanged for the moment.
>>
>> If you agree, I would prepare a patch.
> 
> SCSI-2 was introduced in 1994 and SCSI-3 was introduced in 1996
> according to https://en.wikipedia.org/wiki/Parallel_SCSI. Is embedding
> the LUN in byte one of the CDB something that is only relevant for
> SCSI-2 parallel adapters? Since the SCSI target code supports receiving
> SCSI commands over iSCSI, FC and SRP but not through a parallel port,
> can the SCSI target code ever receive a CDB with a LUN number in byte
> one of the CDB?
> 

The code's original said it was for a iscsi issue:


/*      transport_generic_prepare_cdb():
 *
 *      Since the Initiator sees iSCSI devices as LUNs,  the SCSI CDB will
 *      contain the iSCSI LUN in bits 7-5 of byte 1 as per SAM-2.
 *      The point of this is since we are mapping iSCSI LUNs to
 *      SCSI Target IDs having a non-zero LUN in the CDB will throw the
 *      devices and HBAs for a loop.
 */
