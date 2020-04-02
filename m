Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030C919C3A8
	for <lists+target-devel@lfdr.de>; Thu,  2 Apr 2020 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgDBOMV (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 2 Apr 2020 10:12:21 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:37718 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728225AbgDBOMU (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1585836738; i=@ts.fujitsu.com;
        bh=LeqclMGBiLXrmxMS8BeqqVCx8LF0NgkH9Big8voXnBY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=CzrUc4FuvjevAqHj8cy57bdZQuFOkoXq2MV/tU9BAOu8oG1zLvzWNAFZ668NP8aZJ
         qFKI7DjgKWgxIrIj8YvXFzfe1/6L9Y+i7vH/c1TxwYAR6YD7QoFd9tSbeXQioXfgbO
         L/UsLsUMqgyVlV09ONL7GLmdQZxMMIPdS0HwgGhMrvWEhpu1m1TRHIhVjcOKpyzwRR
         69EEqPSdGvivn+cQs26YrOpjoB7Qg8Mot67BgYfcpQa/lpWRkAE3KrxCiwkDceBC9m
         954VsalV8Ys+hVLQV0BeTbsSt1zBKxxB19pH7gvxuCGmAm1y/kh5xMnZEkBMuuh2B+
         +9ako5IDGN6Yg==
Received: from [100.112.199.204] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id BA/25-36769-2C2F58E5; Thu, 02 Apr 2020 14:12:18 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRWlGSWpSXmKPExsViZ8MxVffQp9Y
  4g1U75Cy+/p/OYrFy9VEmi+XH/zFZrD+ygdGidelbJgdWj903G9g8Pj69xeLxft9VNo/Np6s9
  Pm+SC2CNYs3MS8qvSGDNuHyumalgs2jFpkcPmBoYvwh2MXJxCAnMZJRYduQVSxcjJ4ewQKjE/
  RfvWEFsEQFTic0nT7GB2MwClhI7u7YxgdhCAoUSi+dsAbPZBAwkVky6D9bLK+Ao8WdXMzOIzS
  KgItHVehxsjqhAuMSLLX9YIWoEJU7OfAJWzylgJ9G18QQLxHxbiTtzdzND2OISt57MZ4Kw5SW
  2v53DPIGRbxaS9llIWmYhaZmFpGUBI8sqRvOkosz0jJLcxMwcXUMDA11DQyNdQ0tLXVNzvcQq
  3SS91FLd8tTiEl1DvcTyYr3iytzknBS9vNSSTYzAgE8pOG65g/Hp2vd6hxglOZiURHkzH7bGC
  fEl5adUZiQWZ8QXleakFh9ilOHgUJLg3fAeKCdYlJqeWpGWmQOMPpi0BAePkgjv/o9Aad7igs
  Tc4sx0iNQpRkuOnUfnLWLmeLN2CZBsu3d3EbMQS15+XqqUOG8wSIMASENGaR7cOFiCuMQoKyX
  My8jAwCDEU5BalJtZgir/ilGcg1FJmNcBZApPZl4J3NZXQAcxAR10taIZ5KCSRISUVAOTk7ZL
  pLicQPcR17bU66cPXVrv4rzq+2+3R7e7575l7DJ9fiBT1+6g10yXqepaRSnNidvvXwnyb13fe
  eVJ87kKv71t5fGtD3k9Uk4Y/AsIOaQzb06GIe9Hg3e/l0+Pm5OhlpMq1LtUcspWQQaly9/Y+z
  YW3znn0HDNYsWj/WIZmRLh6k9SYv5lLFl8zsv18vIJ5xSMkupYoqc95AporV1/580Bluc5V9+
  cseM0OVP9z/zBnsaJV5+uObPoxaLlU+RtbgYv/Z7wwk/1/1GOzj8x01w/r+ZrW2IhXTBr5T1n
  0yMrqhIyCmW9HFU/vN+14GRXYcN/71Y7n8ZzRwV/alomr9qz41NIRHXz2cO/o7cFKLEUZyQaa
  jEXFScCAO8f6dOLAwAA
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-23.tower-287.messagelabs.com!1585836738!311075!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31546 invoked from network); 2 Apr 2020 14:12:18 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-23.tower-287.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Apr 2020 14:12:18 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 032EBsZr008771;
        Thu, 2 Apr 2020 15:12:00 +0100
Subject: Re: [PATCH] target: tcmu: add missing pr attributes to passthrough
 backends
To:     mchristi@redhat.com, target-devel@vger.kernel.org
Cc:     ddiss@suse.de, hch@lst.de, martin.petersen@oracle.com
References: <20200401132153.23501-1-bstroesser@ts.fujitsu.com>
 <76689136-62a7-65d7-7eb8-44c459f95aa7@redhat.com>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <e4d201a5-28d1-0ace-c3c8-46f17321de3e@ts.fujitsu.com>
Date:   Thu, 2 Apr 2020 16:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <76689136-62a7-65d7-7eb8-44c459f95aa7@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


On 04/01/20 22:05, Michael Christie wrote:
> On 04/01/2020 08:21 AM, Bodo Stroesser wrote:
>> In commit b49d6f7885306ee636d5c1af52170f3069ccf5f7 the new attribute> emulate_pr was added.
>> passthrough_parse_cdb() uses the attribute's value to distinguish,
>> whether reservation commands should be rejected or not.
>> But the new attribute was not added to passthrough_attrib_attrs, so in
>> pscsi and tcmu - the users of passthrough_parse_cdb() - the attribute
>> is not available to change parser's behavior.
>> This patch adds the new attribute as well as the "pr control" attributes
>> enforce_pr_isids and force_pr_aptpl to passthrough_attrib_attrs.
>>
>> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
>> ---
>>   drivers/target/target_core_configfs.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
>> index ff82b21fdcce..c5a974c5b31d 100644
>> --- a/drivers/target/target_core_configfs.c
>> +++ b/drivers/target/target_core_configfs.c
>> @@ -1203,6 +1203,9 @@ struct configfs_attribute *passthrough_attrib_attrs[] = {
>>   	&attr_hw_block_size,
>>   	&attr_hw_max_sectors,
>>   	&attr_hw_queue_depth,
>> +	&attr_emulate_pr,
> 
> This one seems ok here, because it works for both pscsi and tcmu.
> 
>> +	&attr_enforce_pr_isids,
>> +	&attr_force_pr_aptpl,
> 
> These only work for tcmu. pscsi will do whatever the physical device
> does, and we can't control it. I guess the options would be:

Sorry, I forgot to add a note, that I'm preparing a further patch, that
allows to write pgr_support attribute (TRANSPORT_FLAG_PASSTHROUGH_PGR),
if the backend allows it.

We need this to be able to set TRANSPORT_FLAG_PASSTHROUGH_PGR for tcmu.

But of course it also would be an option for pscsi to allow resetting of
TRANSPORT_FLAG_PASSTHROUGH_PGR. Then the pr emulation in target core can 
be used by pscsi. (And then the two other attributes become useful.)

I'm wondering anyway, whether reservation passthrough makes sense for 
pscsi? For tcmu we will also send a patch allowing to pass nexus info up 
to userland.

> 
> 1. Just add them above.

According to what I wrote above, I'd still prefer option 1. :)

Thank you,
Bodo

> 
> 2. Add them above and add some TRANSPORT_FLAG_PASSTHROUGH_PGR checks in
> functions like force_pr_aptpl_store like we did for the pr functions, so
> the user gets some feedback if they try to use them for pscsi. We would
> have to add a isid function too.
> 
> 3. Export the attrs or some common lib/helper functions to get/set the
> values then target_core_user.c can setup the attrs and add it to
> tcmu_attrib_attrs.
> 
> 
>>   	&attr_alua_support,
>>   	&attr_pgr_support,
>>   	NULL,
> 
> 
> 
