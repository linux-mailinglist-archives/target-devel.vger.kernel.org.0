Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5627B13BC69
	for <lists+target-devel@lfdr.de>; Wed, 15 Jan 2020 10:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgAOJ0k (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 15 Jan 2020 04:26:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:30261 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgAOJ0k (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:26:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 01:26:40 -0800
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="218064917"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.238.129.48]) ([10.238.129.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Jan 2020 01:26:39 -0800
Subject: Re: Cannot log in from BIOS to linux target
To:     Hannes Reinecke <hare@suse.de>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        target-devel@vger.kernel.org
References: <20200113165128.GC4113@kitsune.suse.cz>
 <b8c09533-3d1e-bebf-6bb3-74f3a1aa6a75@linux.intel.com>
 <9c1d4e16-4cb6-5c78-46b1-f3f88158037d@suse.de>
From:   Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <bc2b330a-9624-9e21-6a41-7ad7675b1f63@linux.intel.com>
Date:   Wed, 15 Jan 2020 17:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <9c1d4e16-4cb6-5c78-46b1-f3f88158037d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Michal,

Why not give a try on Yast2 iscsi target module? It would be easy to 
config your target with it.

Thanks,
BR
Zhu Lingshan

On 1/15/2020 3:07 PM, Hannes Reinecke wrote:
> On 1/15/20 6:15 AM, Zhu Lingshan wrote:
>> Hi Michal,
>>
>> try demo mode for a experiment? Here is a guide
>> http://www.linux-iscsi.org/wiki/ISCSI#Demo_mode
>> you can also find how to config username /password there.
>>
>> Thanks,
>> Zhu Lingshan
>> On 1/14/2020 12:51 AM, Michal Suchánek wrote:
>>> Hello,
>>>
>>> my system BIOS support booting from iSCSI.
>>>
>>> I set up readonly target with no authentication:
>>>
>>> targetcli shell version 2.1.fb49
>>>
>>> grub
>>> ..................................................................
>>> [/scratch/ISO/GRUB (1.8MiB) write-back activated]
>>>     | |   o- alua
>>> .................................................................................................
>>> [ALUA Groups: 1]
>>>     | |     o- default_tg_pt_gp
>>> .....................................................................
>>> [ALUA state: Active/optimized]
>>>
>>>    | | o- tpg1
>>> ................................................................................................
>>> [gen-acls, no-auth]
>>>     | |   |   o- mapped_lun0
>>> ...............................................................................
>>> [lun0 fileio/grub (rw)]
>>> The readonly flag does not seem to be
>>> honored
>>> ^^^
>>>
>>> Anyway, the initiator cannot log in:
>>>
>>> 3,1360,2329588663878,-;Initiator sent zero length security payload,
>>> login failed
>>> 3,1361,2329588663897,-;iSCSI Login negotiation failed.
>>>
>>> How can I export a LUN without a password?
>>>
>>> Thanks
>>>
>>> Michal
> It's actually not the password that's missing, it's the ACL.
> You have registered your iSCSI initiatorname with the target, right?
>
> Cheers,
>
> Hannes
