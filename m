Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3400D2DF2
	for <lists+target-devel@lfdr.de>; Thu, 10 Oct 2019 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfJJPlN (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 10 Oct 2019 11:41:13 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:45710 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPlN (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:41:13 -0400
Received: by mail-pf1-f181.google.com with SMTP id y72so4135921pfb.12
        for <target-devel@vger.kernel.org>; Thu, 10 Oct 2019 08:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MVFHn6c27/n7j7ZlUUlxh/TF0t6VTIC2mkeQ+Kj2YOo=;
        b=t6pX/ndKgufvg4paI4wNlIdWndbLtmprvlClBw23VWlKIwkqNtA2zCfxynQs5Qd5hz
         OvQO7/gvmkUrakCd+rzjm2IBoe9zKYz8vxdOn86pgwLEx+y4rgUtz5FNhhSUF19V6ZTZ
         R41oPflBR3rFiMhsDtlLUQIJ0VPjPe7Jko1QjZVW85HTRTeOEjbACOtodQZXBwR5wxRU
         vu72PeYWTXmbJhwq6pJ8IF+52kJk37xFbhgkPlkdmUnIzZa5iUhD3cCi+OBtBmoYi66E
         rsxXVG5tkkY3xnwHSPKNVgTsk0YrxHyJSt9iEXyWZNIkshBB3uh5aCeO8fJh7a8P1nSo
         Y8DQ==
X-Gm-Message-State: APjAAAX9Ycjmph3miTFwdfs4PNjDWSqBWw4CJCzhaFEO84sRL+8QsXI2
        Slv68c1QOHL9+a0chU0FPwPMf6GG
X-Google-Smtp-Source: APXvYqwoMfAHubrijK+DLUp/0ORAkT3Vngndobt4+OZ/uRufnxrUmKg/pCjCVAMQXfkQohMp6G0aqw==
X-Received: by 2002:a17:90a:ae0e:: with SMTP id t14mr12486581pjq.56.1570722071449;
        Thu, 10 Oct 2019 08:41:11 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id j17sm5939877pfr.70.2019.10.10.08.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 08:41:10 -0700 (PDT)
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        Mike Christie <mchristi@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
 <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
Date:   Thu, 10 Oct 2019 08:41:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/10/19 5:07 AM, Bodo Stroesser wrote:
> On 10/10/19 05:38, Mike Christie wrote:
>> On 10/08/2019 03:20 PM, bodo.stroesser@ts.fujitsu.com wrote:
>>> Hi,
>>>
>>> We use TCMUser to run userspace tape and changer emulations.
>>>
>>> Current tests with a new version of backup SW failed, due to that 
>>> application
>>> using SECURITY PROTOCOL IN / OUT  SCSI commands.
>>> The CDBs of these commands in byte 1 contain relevant information that
>>> is overwritten in passthrough_parse_cdb() / target_core_device.c
>>>
>>> This is the related part of the code:
>>>
>>>          /*
>>>           * Clear a lun set in the cdb if the initiator talking to 
>>> use spoke
>>>           * and old standards version, as we can't assume the 
>>> underlying device
>>>           * won't choke up on it.
>>>           */
>>>          switch (cdb[0]) {
>>>          case READ_10: /* SBC - RDProtect */
>>>          case READ_12: /* SBC - RDProtect */
>>>          case READ_16: /* SBC - RDProtect */
>>>          case SEND_DIAGNOSTIC: /* SPC - SELF-TEST Code */
>>>          case VERIFY: /* SBC - VRProtect */
>>>          case VERIFY_16: /* SBC - VRProtect */
>>>          case WRITE_VERIFY: /* SBC - VRProtect */
>>>          case WRITE_VERIFY_12: /* SBC - VRProtect */
>>>          case MAINTENANCE_IN: /* SPC - Parameter Data Format for SA 
>>> RTPG */
>>>                  break;
>>>          default:
>>>                  cdb[1] &= 0x1f; /* clear logical unit number */
>>>                  break;
>>>          }
>>>
>>> Obviously the list of command codes for which bits 5,6,7 of byte 1 
>>> are _not_ reset
>>> is not complete. Now I'm wondering what would be the right fix:
>>>
>>> 1) Scan the SCSI specs and add all other missing command codes to the 
>>> list of
>>>     Codes to skip
>>>
>>> 2) Create a list of commands that definitely have the LUN field in 
>>> byte 1 and
>>>     reset the bits only in those. (Might be better than 1), because I 
>>> expect new
>>>     commands to not have the LUN field.)
>>>
>>> 3) Remove the code entirely, because it is no longer needed / useful (?)
>>>
>>
>> My preference would be to remove it like Bart suggested. Maybe we should
>> make it configurable via a device attribute or backend module flag.
>>
>> For the 2 users:
>>
>> pscsi - It seems this code was there from the beginning via
>> transport_generic_prepare_cdb in the original commit. Nick must have
>> found some initiator where the workaround was needed and I am not sure
>> if we would break them or not now. Based on the original code's comment
>> about iscsi my guess is there was some misc iscsi initiator probably in
>> a boot firmware or some offload card that supported old commands.
>>
>> tcmu - We want the raw cdb. I think masking out the above bits was an
>> accident. It looks like when Andy converted tcmu to use common code the
>> behavior got brought in for tcmu.
>>
> I think, regarding TCMU you both are right, we should skip the code.
> To avoid the need for an attribute, I'd prefer a new flag in the backend
> ops. So pscsi can stay unchanged for the moment.
> 
> If you agree, I would prepare a patch.

SCSI-2 was introduced in 1994 and SCSI-3 was introduced in 1996 
according to https://en.wikipedia.org/wiki/Parallel_SCSI. Is embedding 
the LUN in byte one of the CDB something that is only relevant for 
SCSI-2 parallel adapters? Since the SCSI target code supports receiving 
SCSI commands over iSCSI, FC and SRP but not through a parallel port, 
can the SCSI target code ever receive a CDB with a LUN number in byte 
one of the CDB?

Thanks,

Bart.
