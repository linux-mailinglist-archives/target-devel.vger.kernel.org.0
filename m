Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA5A13B8E2
	for <lists+target-devel@lfdr.de>; Wed, 15 Jan 2020 06:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgAOFPy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 15 Jan 2020 00:15:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:40657 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgAOFPy (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:15:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 21:15:53 -0800
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; 
   d="scan'208";a="217998027"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.238.129.48]) ([10.238.129.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jan 2020 21:15:52 -0800
Subject: Re: Cannot log in from BIOS to linux target
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        target-devel@vger.kernel.org
References: <20200113165128.GC4113@kitsune.suse.cz>
From:   Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <b8c09533-3d1e-bebf-6bb3-74f3a1aa6a75@linux.intel.com>
Date:   Wed, 15 Jan 2020 13:15:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200113165128.GC4113@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Michal,

try demo mode for a experiment? Here is a guide 
http://www.linux-iscsi.org/wiki/ISCSI#Demo_mode
you can also find how to config username /password there.

Thanks,
Zhu Lingshan
On 1/14/2020 12:51 AM, Michal Suchánek wrote:
> Hello,
>
> my system BIOS support booting from iSCSI.
>
> I set up readonly target with no authentication:
>
> targetcli shell version 2.1.fb49
>
> grub .................................................................. [/scratch/ISO/GRUB (1.8MiB) write-back activated]
>    | |   o- alua ................................................................................................. [ALUA Groups: 1]
>    | |     o- default_tg_pt_gp ..................................................................... [ALUA state: Active/optimized]
>
>   | | o- tpg1 ................................................................................................ [gen-acls, no-auth]
>    | |   |   o- mapped_lun0 ............................................................................... [lun0 fileio/grub (rw)]
> The readonly flag does not seem to be honored                                                                                 ^^^
>
> Anyway, the initiator cannot log in:
>
> 3,1360,2329588663878,-;Initiator sent zero length security payload, login failed
> 3,1361,2329588663897,-;iSCSI Login negotiation failed.
>
> How can I export a LUN without a password?
>
> Thanks
>
> Michal
