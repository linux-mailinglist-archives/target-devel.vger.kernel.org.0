Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919FC10296A
	for <lists+target-devel@lfdr.de>; Tue, 19 Nov 2019 17:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfKSQaw (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 19 Nov 2019 11:30:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40111 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfKSQaw (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:30:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so4235014pgd.7
        for <target-devel@vger.kernel.org>; Tue, 19 Nov 2019 08:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lnBw6Cbp58s4PLLLqyjTpsX+/Fn9qiGFhYCCeTcSFf0=;
        b=lGTllIabkPWdHR9p10mLRPXK2BR/ICsu5EbqSMi0wMiwqe7rHq9AvubbmDLE5pd47d
         Jj4N16gDY/G9eEmmgv1hzDggs3qEvZFmPvx1X9bn3cVBCE42ns3QFJLU694GzKlidvg+
         AtmG1UV2symE8VwIKuYT4uexrcvPdg01P0+8EaZNeVD+1HvweOGAvvSfh6cGIA+Z1T8y
         7VUF/8ZMvNU2DA7zrCw+Q/OBMSuZj/Zuro9jxALgswEwRZVbOs6n9cd0LlVGFD3v6FSt
         KBubBlSdNKV0TVUDl1SktCrri4nV23Wmpy1/xs+GF9/M4PWcBiOyWBih6utlhb/+3NYu
         XRig==
X-Gm-Message-State: APjAAAUy7eLuCS4AiCWTfENtqJXNihrb5UaJxS6wyK8V33mgzm+AcrYw
        SRXecwKYFIXRHDz9ZrUnbC8o7bqh
X-Google-Smtp-Source: APXvYqziNXfG8NyrATC3ynSRMUPhxnIBmaXggvPCakY4O4LQiXrJW0VG5lBzPV7vVKMgmoWk/gdIzw==
X-Received: by 2002:a63:5205:: with SMTP id g5mr6575918pgb.267.1574181049733;
        Tue, 19 Nov 2019 08:30:49 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b5sm3956764pjp.13.2019.11.19.08.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:30:48 -0800 (PST)
Subject: Re: [PATCH] target: Fix a pr_debug() argument
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
References: <20191107215525.64415-1-bvanassche@acm.org>
 <yq1blt8ig6u.fsf@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <adc67030-d7fd-ba31-3f7a-063650b43f10@acm.org>
Date:   Tue, 19 Nov 2019 08:30:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <yq1blt8ig6u.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/18/19 9:32 PM, Martin K. Petersen wrote:
> 
> Hi Bart!
> 
>> Print the string for which conversion failed instead of printing the
>> function name twice.
> 
> What do you mean wrt. printing the function name twice?
> 
>> Cc: Christoph Hellwig <hch@lst.de>
>> Fixes: 2650d71e244f ("target: move transport ID handling to the core")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/target/target_core_fabric_lib.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
>> index 3c79411c4cd0..6b4b354c88aa 100644
>> --- a/drivers/target/target_core_fabric_lib.c
>> +++ b/drivers/target/target_core_fabric_lib.c
>> @@ -118,7 +118,7 @@ static int srp_get_pr_transport_id(
>>   	memset(buf + 8, 0, leading_zero_bytes);
>>   	rc = hex2bin(buf + 8 + leading_zero_bytes, p, count);
>>   	if (rc < 0) {
>> -		pr_debug("hex2bin failed for %s: %d\n", __func__, rc);
>> +		pr_debug("hex2bin failed for %s: %d\n", p, rc);
>>   		return rc;
>>   	}

Hi Martin,

With CONFIG_DYNAMIC_DEBUG=y, the output of pr_debug() statements is 
controlled by the settings in /sys/kernel/debug/dynamic_debug/control. 
 From Documentation/admin-guide/dynamic-debug-howto.rst:

  p    enables the pr_debug() callsite.
  f    Include the function name in the printed message
  l    Include line number in the printed message
  m    Include module name in the printed message
  t    Include thread ID in messages not generated from interrupt context
  _    No flags are set. (Or'd with others on input)

In other words, the dynamic debug infrastructure already supports 
printing the function name. I use the pmf flags when enabling pr_debug() 
statements. This is why I wrote that explicitly printing the function 
name causes the function name to be printed twice.

Please let me know if you need more information.

Bart.

