Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA6FB8C8
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 20:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKMT1e (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 14:27:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35753 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKMT1e (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:27:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id q13so2314860pff.2
        for <target-devel@vger.kernel.org>; Wed, 13 Nov 2019 11:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M/tAqd6hNkLLW7RG9JboynskSK5m+AKPauI97PQFsgs=;
        b=KG8fEXlGhUzEax2APuNN71r3DVXrcneUBmm1shi6sDrh2fUFwSH47THBMQfSdZw4vt
         Hbp6ExuHb2GlgnmiBD0DGdRg7KtXhFZ1NPhODheQ00rk3NiJKzC/JcyAWMHUCRzJoz9N
         wFjQbQEIw5oK88xg05erNCOvtThwZMaUhDFHC6tHwnQml4qbujp7FO/ur+xiz5nLaLPu
         Ox2zElvWWM62wi7zQ+CgWAZGFg4iDJ6vEeUCeSYAYYDoiq7ZMIjc5UKJX2coSK47HV0P
         BodugDSDDFlexoy29/8bU5cxp5pmSiQsnkPl1Si8XsYb0ULb7JBFXbLvW5nG6ZfYoreA
         iQlg==
X-Gm-Message-State: APjAAAWufT54zU4DpbRhcXmfuYVGbTj4wyqTF1r7tPAgNxTa2tMuVsby
        KSUBVSk9f9dUlTlOUsaUJL+Ea+xu
X-Google-Smtp-Source: APXvYqzf5GFzGNTun7H9TJU3vrcmchlJ1yIBVWSwmLx0S14qBC8I3ftW0zgUsyU7Wpzr/0WOo38NPg==
X-Received: by 2002:a63:2e01:: with SMTP id u1mr5781938pgu.25.1573673253420;
        Wed, 13 Nov 2019 11:27:33 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v15sm4420162pfc.85.2019.11.13.11.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 11:27:32 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 2/3] target/core: Fix a use-after-free in the TMF
 handling code
To:     Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
References: <20191113175239.147389-1-bvanassche@acm.org>
 <20191113175239.147389-3-bvanassche@acm.org>
 <20191113181818.7iirhzhbkdkkefnt@SPB-NB-133.local>
Message-ID: <45dd927b-9bbd-0358-7ee9-ef3e432f5503@acm.org>
Date:   Wed, 13 Nov 2019 11:27:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113181818.7iirhzhbkdkkefnt@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/13/19 10:18 AM, Roman Bolshakov wrote:
> On Wed, Nov 13, 2019 at 09:52:38AM -0800, Bart Van Assche wrote:
>> diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
>> index 09f833c1de8a..944777f4356f 100644
>> --- a/drivers/target/target_core_transport.c
>> +++ b/drivers/target/target_core_transport.c
>> @@ -3256,6 +3256,8 @@ static void target_tmr_work(struct work_struct *work)
>>   	struct se_tmr_req *tmr = cmd->se_tmr_req;
>>   	int ret;
>>   
>> +	config_item_get(&dev->dev_group.cg_item);
>> +
>>   	if (cmd->transport_state & CMD_T_ABORTED)
>>   		goto aborted;
>>   
>> @@ -3297,10 +3299,14 @@ static void target_tmr_work(struct work_struct *work)
>>   	cmd->se_tfo->queue_tm_rsp(cmd);
>>   
>>   	transport_cmd_check_stop_to_fabric(cmd);
>> +
>> +out:
>> +	config_item_put(&dev->dev_group.cg_item);
>>   	return;
>>   
>>   aborted:
>>   	target_handle_abort(cmd);
>> +	goto out;
>>   }
>>   
>>   int transport_generic_handle_tmr(
> 
> I might be well wrong but could it happen that refcount of se_device
> becomes zero before the work starts? Shouldn't we get the refcount
> increased before the work is scheduled in transport_generic_handle_tmr()?

Hi Roman,

Looking closer into this, I couldn't find an explanation why lun_ref 
does not prevent 'dev' to disappear. In the tests I ran without this 
patch the issue did not reappear. So the call trace mentioned in the 
patch description probably has the same root cause as patch 3/3. I will 
drop this patch.

Bart.
