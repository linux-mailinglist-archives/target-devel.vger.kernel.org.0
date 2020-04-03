Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039D819D504
	for <lists+target-devel@lfdr.de>; Fri,  3 Apr 2020 12:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgDCK1Q (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 3 Apr 2020 06:27:16 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:44294 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbgDCK1Q (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1585909634; i=@ts.fujitsu.com;
        bh=XM3DeYegmce03s1eR2EA+NvPvHAPCJdLNp86IE2hhWQ=;
        h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=iiCnlFJ441fpBMkay1bbygxP7QIBVIfP6dQL2zueBC4keWAUbQ0YZONTGHjeXcCuz
         023i68WFsQNOGWeAM1Vmn5q728X1vkb6IIknKIoUAnZ1lXW1T9JbtcKnHSM21ED0dC
         oUu7ZQ5j0gfk9/b+bHW33yZxPWOzrTv4k3CK26eErnGjbuU/0IdsTzu4H/Z6cBc7j0
         HYTZo56xjl8/v3XUH6w8Ok7cX7YZcHWiaZr/xE/HdzTS2IV84tlJxxxn33vZ4GpTwu
         MmgVwhapFwwgdMu1iVMM4e5v3F5w6WtAugkk4Dh7CrzqJJ7NHqwtEiIZLnWRKKzvHR
         fNzAuVHkp155A==
Received: from [100.113.2.118] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id C2/F6-46407-28F078E5; Fri, 03 Apr 2020 10:27:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRWlGSWpSXmKPExsViZ8MxVbeRvz3
  OYEOPvsXX/9NZLFauPspksfz4PyaL9Uc2MFq0Ln3L5MDqsftmA5vHx6e3WDze77vK5rH5dLXH
  501yAaxRrJl5SfkVCawZC15WF+ziq9h6Ywt7A2M3TxcjF4eQwExGifZlR5i6GDk52AQMJFZMu
  s8CYgsLhErcf/GOFcQWEVCRuP50GjuIzSyQKvH49F6weiGBRImWa1uZQWxeAUeJX+e6weIsQP
  Uf12wBqxcVCJd4seUPK0SNoMTJmU/A5nMK6Ekcf/SKFWKmmcS8zQ+ZIWxxiVtP5jNB2PIS29/
  OYZ7AyDcLSfssJC2zkLTMQtKygJFlFaNlUlFmekZJbmJmjq6hgYGuoaGxLog00Eus0k3USy3V
  TU7NKylKBMrqJZYX6xVX5ibnpOjlpZZsYgSGfEohQ94Oxsb57/UOMUpyMCmJ8v7ibI8T4kvKT
  6nMSCzOiC8qzUktPsQow8GhJMEbwweUEyxKTU+tSMvMAcYfTFqCg0dJhDeXFyjNW1yQmFucmQ
  6ROsWoy7Hz6LxFzEIsefl5qVLivCdAZgiAFGWU5sGNgKWCS4yyUsK8jAwMDEI8BalFuZklqPK
  vGMU5GJWEebeBTOHJzCuB2/QK6AgmoCOuVjSDHFGSiJCSamAq9hF7+Eha78POVWw3Or8wmJ1L
  as6fuWZjHb87D+8X2TmP3k/o4eO02Dxv8u3D2lLXPobHfnlVy9hgE/vGvfwFq7Fq9qcIjTb22
  umS3H7SnXxbfitPibpW+u+Agcv8gN/WSrl6a24krdmXtdRXc81nowfrHdcELYl9FTRBY49AYL
  +pvePVvT6sJzQzm1cfNp4+42Fl1V2Vv+eO/p10jln/CNO7RUfPXrDZV7vNfxXXvbZN2yX5K1h
  PROfNWjLT94CHyZSv+p9n8Od52n3f6DmHvbrv/f2HJs9tpNlfNFzzcHU+WnDZeZZRd8s/60MH
  lbdMLd8Ua+bFvN+lhS19e2xh737OvDMxUUYRfJL69X1KLMUZiYZazEXFiQCLHHxjgAMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-11.tower-226.messagelabs.com!1585909633!221655!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5007 invoked from network); 3 Apr 2020 10:27:13 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-11.tower-226.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Apr 2020 10:27:13 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 033AQrij005710;
        Fri, 3 Apr 2020 11:26:59 +0100
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: Re: [PATCH] target: tcmu: add missing pr attributes to passthrough
 backends
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org, mchristi@redhat.com, hch@lst.de,
        martin.petersen@oracle.com
References: <20200401132153.23501-1-bstroesser@ts.fujitsu.com>
 <20200403013037.3da74123@suse.de>
Message-ID: <b5b27cb5-bf42-6b85-66d6-dff1bc87af7a@ts.fujitsu.com>
Date:   Fri, 3 Apr 2020 12:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20200403013037.3da74123@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi David,

On 04/03/20 01:30, David Disseldorp wrote:
> Hi,
> 
> On Wed,  1 Apr 2020 15:21:53 +0200, Bodo Stroesser wrote:
> 
>> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
>> index ff82b21fdcce..c5a974c5b31d 100644
>> --- a/drivers/target/target_core_configfs.c
>> +++ b/drivers/target/target_core_configfs.c
>> @@ -1203,6 +1203,9 @@ struct configfs_attribute *passthrough_attrib_attrs[] = {
>>   	&attr_hw_block_size,
>>   	&attr_hw_max_sectors,
>>   	&attr_hw_queue_depth,
>> +	&attr_emulate_pr,
>> +	&attr_enforce_pr_isids,
>> +	&attr_force_pr_aptpl,
>>   	&attr_alua_support,
>>   	&attr_pgr_support,
>>   	NULL,
> 
> The attr_emulate_pr addition here looks fine. If you and Mike agree to
> proceed with the other two attrs then it probably makes sense to add
> them via a separate patch.

Before my patch and also after it if setting of emulate_pr is not
changed tcmu uses the core's pr emulation.
So I think at least for tcmu it makes sense to add the two "pr control"
attributes here, because they are missing for the default mode of tcmu,
while the emulate_pr attribute should be added to be able to switch off
pr in total.

Of course we end up then having the "pr control" attributes for pscsi
also and they have no effect because TRANSPORT_FLAG_PASSTHROUGH_PGR
is set in pscsi. Regarding this I'll soon send a patch that converts
pgr_support and alua_support attribute from readonly to read write,
if the backend allows writing it.
I need that for full userspace emulation with tcmu, but I guess for
pscsi it would also be good to allow writing of at least pgr_support.
Writing 1 to that attribute would reset TRANSPORT_FLAG_PASSTHROUGH_PGR
and thus switch on core's pr emulation for pscsi, making
enforce_pr_isids and force_pr_aptpl useful for pscsi.

Thank you,
Bodo

> 
> Cheers, David
> 
