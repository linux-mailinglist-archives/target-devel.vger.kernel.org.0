Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55165D28BC
	for <lists+target-devel@lfdr.de>; Thu, 10 Oct 2019 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfJJMHe (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 10 Oct 2019 08:07:34 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:34584 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbfJJMHe (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1570709251; i=@ts.fujitsu.com;
        bh=dnC7USoqKf6DsNQ5lofg3rN1DvocUwvqcqYPtzu7WTg=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=R06iTW1ijRW3aeNcL0XEMbgb2ywhUrGxZdUTnbrEmm7plYEWiIlOE90El09WgSIjN
         5a/VSvUVNawrhUjx6wmA10ODY8CErgzbtjDBPQuSPQMXc0bKMbrZOGB/zeygyqh0O9
         DVCY3aj6Iaeg7Hoq3dgT29R5cvYr5fEZ5dMoo/MTSLB9APP7pboJ51dkJhSn0NyVaF
         ZySGEvGVeEwbaMw54v8YckpBKwEb2nSBhnYDwTunxh5o68QHmq8D6zgnEJKmT5sRHT
         XEMk821EQHiER7a+M9d+8nqhSjqSyHib90gXnATNrGcKStOtize9XH9a+r8EoS4v+z
         NgGPWqh00D4gw==
Received: from [85.158.142.193] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 19/4D-25862-30F1F9D5; Thu, 10 Oct 2019 12:07:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8MxRZdZfn6
  sQddbQYv1RzYwWrQufcvkwOTxft9VNo/Pm+QCmKJYM/OS8isSWDOuP1nJWrBYvGLJrYOMDYxr
  BbsYuTiEBGYxSmzf/5Cli5GTQ1jAQeLey5PMILaIQJ5E8/PJrCC2EJD94MplsBo2AQOJFZPug
  9m8Ao4S/yduZwexWQRUJZZd/MgEYosKhEu82PKHFaJGUOLkzCdg9ZwCWhI7riwHs5kFbCXuzN
  3NDGGLS9x6Mp8JwpaX2P52DvMERt5ZSNpnIWmZhaRlFpKWBYwsqxgtk4oy0zNKchMzc3QNDQx
  0DQ2NdU10jQwt9RKrdJP0Ukt1k1PzSooSgbJ6ieXFesWVuck5KXp5qSWbGIEhmlLIcnsH48Ej
  r/UOMUpyMCmJ8jKwzo8V4kvKT6nMSCzOiC8qzUktPsQow8GhJMErIguUEyxKTU+tSMvMAcYLT
  FqCg0dJhHeiHFCat7ggMbc4Mx0idYpRl2Pn0XmLmIVY8vLzUqXEed1AigRAijJK8+BGwGL3Eq
  OslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVhXl6QKTyZeSVwm14BHcEEdES+y2yQI0oSEVJSDUw
  2T1/y8Rzs+llquqN5H8uDAI5p30SU3WVPSr6t1zM8bR2d9L6xyfvGOUXXb/+q3nDdyJNmev5t
  l8DRZFnrqh1nI9T01uxWe35tkrau/UeHNeuaDGc3Clu6LlnVInFX5PKPut2/vc+aB6Yt+cEdw
  MR4w7P38fp/G1izD37usN3+4+3sq+4P1Y9zTNe+s0zL+H1v0JuXsj/D4sSPubxxC8h8Uzl/3o
  KiveZK9XkX3mgKT+CyNL+r2xlqzn2q6sGUj1k+BqeYba9OPJEl2L3Qxq4l5sAmtd+Ozk9XCKi
  ovvjXv/rFC76TEsu4nhkpvGx9yvr1ruff4G0zDM72Klyv5KvsLvq74ecHww2ahy3VdQOUWIoz
  Eg21mIuKEwHEjSrWWAMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-4.tower-238.messagelabs.com!1570709250!840222!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11198 invoked from network); 10 Oct 2019 12:07:31 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-4.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Oct 2019 12:07:31 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id x9AC7MSt001892;
        Thu, 10 Oct 2019 13:07:29 +0100
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Mike Christie <mchristi@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
Date:   Thu, 10 Oct 2019 14:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <5D9EA7CA.8030306@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



On 10/10/19 05:38, Mike Christie wrote:
> On 10/08/2019 03:20 PM, bodo.stroesser@ts.fujitsu.com wrote:
>> Hi,
>>
>> We use TCMUser to run userspace tape and changer emulations.
>>
>> Current tests with a new version of backup SW failed, due to that application
>> using SECURITY PROTOCOL IN / OUT  SCSI commands.
>> The CDBs of these commands in byte 1 contain relevant information that
>> is overwritten in passthrough_parse_cdb() / target_core_device.c
>>
>> This is the related part of the code:
>>
>>          /*
>>           * Clear a lun set in the cdb if the initiator talking to use spoke
>>           * and old standards version, as we can't assume the underlying device
>>           * won't choke up on it.
>>           */
>>          switch (cdb[0]) {
>>          case READ_10: /* SBC - RDProtect */
>>          case READ_12: /* SBC - RDProtect */
>>          case READ_16: /* SBC - RDProtect */
>>          case SEND_DIAGNOSTIC: /* SPC - SELF-TEST Code */
>>          case VERIFY: /* SBC - VRProtect */
>>          case VERIFY_16: /* SBC - VRProtect */
>>          case WRITE_VERIFY: /* SBC - VRProtect */
>>          case WRITE_VERIFY_12: /* SBC - VRProtect */
>>          case MAINTENANCE_IN: /* SPC - Parameter Data Format for SA RTPG */
>>                  break;
>>          default:
>>                  cdb[1] &= 0x1f; /* clear logical unit number */
>>                  break;
>>          }
>>
>> Obviously the list of command codes for which bits 5,6,7 of byte 1 are _not_ reset
>> is not complete. Now I'm wondering what would be the right fix:
>>
>> 1) Scan the SCSI specs and add all other missing command codes to the list of
>>     Codes to skip
>>
>> 2) Create a list of commands that definitely have the LUN field in byte 1 and
>>     reset the bits only in those. (Might be better than 1), because I expect new
>>     commands to not have the LUN field.)
>>
>> 3) Remove the code entirely, because it is no longer needed / useful (?)
>>
> 
> My preference would be to remove it like Bart suggested. Maybe we should
> make it configurable via a device attribute or backend module flag.
> 
> For the 2 users:
> 
> pscsi - It seems this code was there from the beginning via
> transport_generic_prepare_cdb in the original commit. Nick must have
> found some initiator where the workaround was needed and I am not sure
> if we would break them or not now. Based on the original code's comment
> about iscsi my guess is there was some misc iscsi initiator probably in
> a boot firmware or some offload card that supported old commands.
> 
> tcmu - We want the raw cdb. I think masking out the above bits was an
> accident. It looks like when Andy converted tcmu to use common code the
> behavior got brought in for tcmu.
> 
I think, regarding TCMU you both are right, we should skip the code.
To avoid the need for an attribute, I'd prefer a new flag in the backend
ops. So pscsi can stay unchanged for the moment.

If you agree, I would prepare a patch.
