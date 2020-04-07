Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6029B1A0FC9
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgDGPAY (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Apr 2020 11:00:24 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:48182 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729064AbgDGPAX (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1586271619; i=@ts.fujitsu.com;
        bh=mvqJi3itV+hJynjEGnR9zRpRDMsHPfOtIKa1eNogAGE=;
        h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=F4uMcxV26luDys0npcFqA4rKlo72iHOmxknzpprCOtyMh8H3Gj0FK0XHYVMXA02HE
         YB6jJqjYOryZ6CTsfBbDkPgnfciV7aUzTCNqZIIoTmliRrf/+VMaXf2Y2oNRD1diU3
         +11hHZQh75Dedsy/IXqwLzADrjVXFs8h40H+MRF5Oj61eP4Ob1awhGXfA/csRLf+dC
         VIUnHzcqKwIunAE7C98deKBJxfPbyJPq7cWPY0xZh8V4m3fNRP4a3rqVS1qPk7rCIY
         C+t76ueYhu09fkFEyGA6/BIf/osfqOQCv5COUUzaMy+1uwOQ2/DgeWG2pG52XlqIiS
         wH5dvZ0h/+F0Q==
Received: from [100.112.195.73] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 5F/81-10835-3859C8E5; Tue, 07 Apr 2020 15:00:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRWlGSWpSXmKPExsViZ8MxVbd5ak+
  cwfNbUhbLj/9jslh/ZAOjRevSt0wOzB4fn95i8Xi/7yqbx+dNcgHMUayZeUn5FQmsGfN3z2Av
  eGZe8brnH2MD4y/tLkYuDiGBmYwSh+f8Ze5i5ORgEzCQWDHpPguILSxgI/H6/iR2EFtEwFXiy
  MVzrCA2s4CcxO7lr8BsIYFYiedPpzKC2LwCjhJdnxeygdgsAioS777sBJspKhAu8WLLH1aIGk
  GJkzOfgM3nFNCSeHJ9GRvETFuJO3N3M0PY4hK3nsxngrDlJba/ncM8gZFvFpL2WUhaZiFpmYW
  kZQEjyypGi6SizPSMktzEzBxdQwMDXUNDI11DSyNdI1NTvcQq3US91FLd8tTiEl1DvcTyYr3i
  ytzknBS9vNSSTYzAYE4pOPB/B+OJte/1DjFKcjApifIeru6JE+JLyk+pzEgszogvKs1JLT7EK
  MPBoSTBO3MKUE6wKDU9tSItMwcYWTBpCQ4eJRFelW6gNG9xQWJucWY6ROoUo6KUOK8YSJ8ASC
  KjNA+uDRbNlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ8y6ZDDSFJzOvBG76K6DFTECLryV
  1gywuSURISTUwOWxZzs64I1EpSGzKadUXk15cuNLhW6t/OMntwkG2Q53vZKUis1qvhre+sv+5
  vHVPRbVHToya3/Ufth732q74zj1xS4Rb6rfH/xs5U9senZ/wTX9NWn2kVnfjhdoJncpulZp2l
  SVK7c3SGmteyPKvkrpb+eHvHZ0/Dzf7tBu8t6uuS03yqtkeFuHoWFn69ExdL5/KHo/D6z2MJ8
  qU5usmXLw6x8ZtbYpJvSd3ivvHpTPdlxS6fPXcYWInp3d75t5FMz4eT7JMlPKXn8muPG19gXq
  QRWBhMVvv3vvsS+xX8zM2L7IROK8aKDTPwMBuy9vv/q+E5PvOPHr+5wXPH6nSX/YPl35/cGGd
  cNjmjLlKLMUZiYZazEXFiQDerEVKYQMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-22.tower-265.messagelabs.com!1586271618!628512!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31513 invoked from network); 7 Apr 2020 15:00:19 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-22.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2020 15:00:19 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 037F03Rc006733;
        Tue, 7 Apr 2020 16:00:09 +0100
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: Re: [PATCH] target: pr: fix PR IN, READ FULL STATUS
To:     Mike Christie <mchristi@redhat.com>, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com
References: <20200406182951.17446-1-bstroesser@ts.fujitsu.com>
 <5E8B99AC.2010303@redhat.com>
Message-ID: <99574976-b040-11a1-c1f1-3a7958adb51a@ts.fujitsu.com>
Date:   Tue, 7 Apr 2020 16:59:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <5E8B99AC.2010303@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Mike,

On 04/06/20 23:05, Mike Christie wrote:
> On 04/06/2020 01:29 PM, Bodo Stroesser wrote:
>> AFAICS there are some problems in target_core_fabric_lib.c
>> that afflict PERSISTENT RESERVE IN / READ FULL STATUS command.
>>
>> 1) Creation of the response to READ FULL STATUS fails for FC
>>     based reservations. Reason is the too high loop limit (< 24)
>>     in fc_get_pr_transport_id(). The string representation of FC
>>     WWPN is 23 chars long only ("11:22:33:44:55:66:77:88"). So
>>     when i is 23, the loop body is executed a last time for the
>>     ending '\0' of the string and thus hex2bin() reports an error.
>>
>> 2) For iSCSI based reservations that include an ISID, the
>>     reported TRANSPORT ID is wrong. This has two reasons:
>>     a) The code inserts an NULL byte between the ISCSI Name and
>>        the SEPARATOR
>>     b) Only the first 6 chars of the ISID are appended. AFAIK,
>>        binary ISID is 48 bits, so 12 chars might be necessary.
>>
>> The last hunk in this patch fixes a minor flaw that could be
>> triggered by a PR OUT RESERVE on iSCSI, if TRANSPORT IDs with
>> and without ISID are used in the same command. I don't know, if
>> that ever could happen, but with the change the code is cleaner,
>> I think.
>>
>> This patch is based on code review only. It compiles fine, but
>> unfortunately I wasn't able to test.
> 
> Your patch for #2 is still not going to work for iscsi, because there's
> lots of issue in that code. Offlist I sent you my patch for #2 and a
> hand full of other fixes in that code path.

Thank you.

> 
> Let's sync them up, so we can test it all together.

Ok.

> 
> - We should break out the first chunk for your issue #1, and the last
> chunk that sets port_nexus_ptr to NULL into separate patches.

I did, will be sent soon. Meanwhile I was able to test chunk 1, works fine.

> 
> I tested the NULL ptr chunk with my patches and it works fine.

Thank you.

> 
> - If you are ok with my patch for #2, I will post my patch for that and
> the other ones to the list. As you saw I have other fixes in the same
> lines of code and I fixed up the comments, so it would just be easier
> code conflict wise.

One question:
why did you remove writing of the format code in byte 0 of buf?
Isn't that necessary?

Regarding the separator: instead of writing 5 single ASCII bytes as hex
values, wouldn't it be better to do:
	memcpy(&buf[off], ",i,0x", 5);
In the beginning I thought, that using the hex values makes the code
independent from the host code. But there are many other places in the 
code, where silently is assumed, that host code is ASCII.

I'm not sure, whether it is a good idea to assume a fixed size of 12 hex
digits for the ISID string. I know, ISID is 48 bits, but if there are
leading 0s, is there anything in the spec, that disallows to shorten the
string?
Therefore in my patch I used snprintf() to get the right length of the
saved string.

> 
> There is actually another isid fix needed for the core pr code:
> 
> https://patchwork.kernel.org/patch/10525287/
> 
> Handling Bart's review comment for that patch ended up being crazy
> because of other issues in the PR code so I have not completed that fix.

I'm not very familiar with iSCSI, so I don't know where the code should
be, but I think we should not remove the ISID binary value (u64).
In case of shortened ISID strings or in case of lower and upper case a-f
usage, string compare might fail for basically the same ISID values.

Therefore in your patch I don't like the hex2bin usage.
Would it be better to use sscanf() with a check for trailing chars, e.g:
	ret = sscanf(isid, "%llx%c", &pr_reg->pr_reg_bin_isid,
                      &dummychar);
and then check for ret == 1 and
  pr_reg->pr_reg_bin_isid <= 0xffffffffffffllu ?

> 
> 
>>
>> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
>> ---
>>   drivers/target/target_core_fabric_lib.c | 33 ++++++++++++++-------------------
>>   1 file changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
>> index 6b4b354c88aa..8a726076ae56 100644
>> --- a/drivers/target/target_core_fabric_lib.c
>> +++ b/drivers/target/target_core_fabric_lib.c
>> @@ -63,7 +63,7 @@ static int fc_get_pr_transport_id(
>>   	 * encoded TransportID.
>>   	 */
>>   	ptr = &se_nacl->initiatorname[0];
>> -	for (i = 0; i < 24; ) {
>> +	for (i = 0; i < 23; ) {
>>   		if (!strncmp(&ptr[i], ":", 1)) {
>>   			i++;
>>   			continue;
>> @@ -148,10 +148,6 @@ static int iscsi_get_pr_transport_id(
>>   	 */
>>   	len = sprintf(&buf[off], "%s", se_nacl->initiatorname);
>>   	/*
>> -	 * Add Extra byte for NULL terminator
>> -	 */
>> -	len++;
>> -	/*
>>   	 * If there is ISID present with the registration and *format code == 1
>>   	 * 1, use iSCSI Initiator port TransportID format.
>>   	 *
>> @@ -185,17 +181,15 @@ static int iscsi_get_pr_transport_id(
>>   		buf[off+len] = 0x30; off++; /* ASCII Character: "0" */
>>   		buf[off+len] = 0x78; off++; /* ASCII Character: "x" */
>>   		len += 5;
>> -		buf[off+len] = pr_reg->pr_reg_isid[0]; off++;
>> -		buf[off+len] = pr_reg->pr_reg_isid[1]; off++;
>> -		buf[off+len] = pr_reg->pr_reg_isid[2]; off++;
>> -		buf[off+len] = pr_reg->pr_reg_isid[3]; off++;
>> -		buf[off+len] = pr_reg->pr_reg_isid[4]; off++;
>> -		buf[off+len] = pr_reg->pr_reg_isid[5]; off++;
>> -		buf[off+len] = '\0'; off++;
>> -		len += 7;
>> +		len += snprintf(&buf[off+len], PR_REG_ISID_LEN, "%s",
>> +		                pr_reg->pr_reg_isid);
>>   	}
>>   	spin_unlock_irq(&se_nacl->nacl_sess_lock);
>>   	/*
>> +	 * Add Extra byte for NULL terminator
>> +	 */
>> +	len++;
>> +	/*
>>   	 * The ADDITIONAL LENGTH field specifies the number of bytes that follow
>>   	 * in the TransportID. The additional length shall be at least 20 and
>>   	 * shall be a multiple of four.
>> @@ -224,10 +218,6 @@ static int iscsi_get_pr_transport_id_len(
>>   	spin_lock_irq(&se_nacl->nacl_sess_lock);
>>   	len = strlen(se_nacl->initiatorname);
>>   	/*
>> -	 * Add extra byte for NULL terminator
>> -	 */
>> -	len++;
>> -	/*
>>   	 * If there is ISID present with the registration, use format code:
>>   	 * 01b: iSCSI Initiator port TransportID format
>>   	 *
>> @@ -236,12 +226,16 @@ static int iscsi_get_pr_transport_id_len(
>>   	 */
>>   	if (pr_reg->isid_present_at_reg) {
>>   		len += 5; /* For ",i,0x" ASCII separator */
>> -		len += 7; /* For iSCSI Initiator Session ID + Null terminator */
>> +		len += strlen(pr_reg->pr_reg_isid); /* Initiator Session ID */
>>   		*format_code = 1;
>>   	} else
>>   		*format_code = 0;
>>   	spin_unlock_irq(&se_nacl->nacl_sess_lock);
>>   	/*
>> +	 * Add extra byte for NULL terminator
>> +	 */
>> +	len++;
>> +	/*
>>   	 * The ADDITIONAL LENGTH field specifies the number of bytes that follow
>>   	 * in the TransportID. The additional length shall be at least 20 and
>>   	 * shall be a multiple of four.
>> @@ -341,7 +335,8 @@ static char *iscsi_parse_pr_out_transport_id(
>>   			*p = tolower(*p);
>>   			p++;
>>   		}
>> -	}
>> +	} else
>> +		*port_nexus_ptr = NULL;
>>   
>>   	return &buf[4];
>>   }
>>
> 
