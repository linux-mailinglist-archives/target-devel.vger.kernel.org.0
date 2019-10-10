Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACEED30FE
	for <lists+target-devel@lfdr.de>; Thu, 10 Oct 2019 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfJJS6B (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 10 Oct 2019 14:58:01 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:50842 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfJJS6A (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1570733877; i=@ts.fujitsu.com;
        bh=VdL6wOykh1hv3jIWrhswyWfeoeMrdkPlTpUMJSF/KUc=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=sMjCql1g6BBliZ2MBXOo4jUNq2Ac0l3ZX55VauU+iTU5ucnrQWiWHIiM1KljyO/07
         2bXoFmTlxD8kd29siNYKLIljNBsyF60m/4GzbMoBTHPu/ppRB09XyjvIp1fMviJGHO
         C6E/QO5Sn+g0rsDLKa4ky4T7HnPflNG/4nt+hsynx0R/HDBXncGw8YwyJ1eJ/sCcDp
         Dsg9FOCt+X2jE0g5vaKDtRIt+SbwITGUogkBF/zUjFPkHtqQoS/TxvPnGNw7CNZnAS
         zZL0hcwCa91cMoCXMvor2MZ2zA4l4t534b5UURmClYBaZBK5ptiG9HGueHHgPrD7qH
         XdTx0Ujd4J7XQ==
Received: from [85.158.142.193] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 77/D9-25862-53F7F9D5; Thu, 10 Oct 2019 18:57:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRWlGSWpSXmKPExsViZ8MxRde0fn6
  swYsTHBbTPvxktlh/ZAOjRevSt0wOzB6Xr3h7vN93lc3j8ya5AOYo1sy8pPyKBNaMA31rWQqu
  KFa8/9zK3MD4XrKLkZNDSGAWo8TNmaogtrCAg8S9lyeZuxi5OEQEpjJKzNm7nQ3EERK4yijR/
  PE7C0gVm4CBxIpJ98FsXgFHiaPzV4HZLAKqEo/e/2QGsUUFwiVebPnDClEjKHFy5hOwGk4Ba4
  k1T04ygdjMArYSd+buZoawxSVuPZkPFZeX2P52DvMERt5ZSNpnIWmZhaRlFpKWBYwsqxgtkoo
  y0zNKchMzc3QNDQx0DQ2Ndc11jcz0Eqt0k/RSS3WTU/NKihKBknqJ5cV6xZW5yTkpenmpJZsY
  gUGbUsgutYOxZ9YbvUOMkhxMSqK8gbXzY4X4kvJTKjMSizPii0pzUosPMcpwcChJ8OaB5ASLU
  tNTK9Iyc4ARBJOW4OBREuHlrgNK8xYXJOYWZ6ZDpE4x6nLsPDpvEbMQS15+XqqUOG8TyAwBkK
  KM0jy4EbBovsQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHcmyBSezLwSuE2vgI5gAjpijSX
  YESWJCCmpBqY5Rm8KuTri198tmyHVdz/7nt7mxQUK0o/bVuTN23bpu/LVvvzlrAf/XF+j8bzA
  IU/6F6eL+upb7/K8mVyrmUJrdNbUBffemOjuW+1gNM3rEKNX5qk0bnbbwoJT892f94tlVvhKd
  FvsYvtq8OTXmTN7WgKXi2nftP50obV1Vd8EmZYfK5qaqlSDp23vtds1KXxVfl5eeuS7/DjJK+
  dEuviPF/opS+10MbHMTNvCbLuu5P4pm4VO7jbr8n0DYicrSlqkbHvzfNvcqOdz9RqqdsS6TJw
  mzzChpJDbppNv0c+VHMX3Hrm+rxOyyX0eYSUVd36az6l+eZZtvDUp6QFXH89K61wl3r9XIe/c
  1i3JSizFGYmGWsxFxYkAj/PVgmEDAAA=
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-39.tower-238.messagelabs.com!1570733876!891810!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3182 invoked from network); 10 Oct 2019 18:57:57 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-39.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Oct 2019 18:57:57 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id x9AIvk9B031769;
        Thu, 10 Oct 2019 19:57:55 +0100
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
 <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
 <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <c87f1206-4abd-d7d3-bc68-369abf80950f@ts.fujitsu.com>
Date:   Thu, 10 Oct 2019 20:57:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/10/19 17:41, Bart Van Assche wrote:
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
Hmm. You are right. Ideally only SCSI-2 compliant initiators should
use the LUN field and they should run parallel SCSI only.

OTOH, like Mike already said, we can't know whether there is any SW, FW,
BIOS, ... out there, that still sends such old style CDBs.

For example: probably SW could send such CDBs by simply using SCSI
generic device on top of a modern initiator. (I hope that's true, I
didn't test ...)
That means, old code can produce old SCSI CDBs even when running
on top of modern HW.

Do we want to take the risk of breaking such "old stuff"?

Thank you,
Bodo

> 
> Thanks,
> 
> Bart.
