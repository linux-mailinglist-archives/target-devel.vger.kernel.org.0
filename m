Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F210A1C02C2
	for <lists+target-devel@lfdr.de>; Thu, 30 Apr 2020 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3QlJ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 30 Apr 2020 12:41:09 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:37376 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgD3QlJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1588264864; i=@ts.fujitsu.com;
        bh=NgRRjbx6uEaXKlWUG7hcsfPGkpMg0jyX1pjdLJiAiiQ=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=T0vBy3PwJnNf9zkLI5GWYbwzc7aVZ8qQNFxZX9udj308f+RSiKKNlyd9PZFOZyBEt
         aVJ+14JiRWGsIPUVlyOOcLy3GX5bCruYgxKVk8W6/ZxzXtsvxQYmLHuMxBKdU8RgAb
         oko+uP+qxFiHmTNDFJ7iBUOri4ZpGP10D7+bd8vpb9Ui1Ek44O/4eQuT2pAaTdyLFf
         wP3LNpHoQf5TaGVy6yceWb+mBUuT+oox9RHpkzCTnhmYsf51yFW59sl7DwJh0debmx
         2wB9L4f6I763iXre+hZe0oCJfAZXmP5qhJLM41QZsilej4oZd6Zb97XeU2bS63my7h
         hvcAo3Hoi4rHg==
Received: from [100.113.4.52] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 88/8F-39489-0AFFAAE5; Thu, 30 Apr 2020 16:41:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRWlGSWpSXmKPExsViZ8MxRXfB/1V
  xBrvuClosP/6PyWL9kQ2MFq1L3zI5MHt8fHqLxeP9vqtsHp83yQUwR7Fm5iXlVySwZpy9tpap
  YIVkxdVlG9gaGC+JdDFycQgJzGKUaF9+g7mLkZNDWMBF4t6Cq6wgtohApkRv11cmEFtIoFBi6
  rYjLCA2m4CBxIpJ98FsXgFHid/LprCB2CwCqhLP5rxnB7FFBcIlXmz5wwpRIyhxcuYTsHpOAT
  uJOa+ugc1kFrCVuDN3NzOELS5x68l8qLi8xPa3c5gnMPLOQtI+C0nLLCQts5C0LGBkWcVokVS
  UmZ5RkpuYmaNraGCga2horGuia2Gul1ilm6SXWqqbnJpXUpQIlNRLLC/WK67MTc5J0ctLLdnE
  CAzalEKW8B2MO5e/1zvEKMnBpCTKa3BhVZwQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd5j/4Byg
  kWp6akVaZk5wAiCSUtw8CiJ8LKApHmLCxJzizPTIVKnGHU5Tq5asohZiCUvPy9VSpzXEqRIAK
  QoozQPbgQsmi8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuZ9+BdoCk9mXgncpldARzABHZE
  tvBzkiJJEhJRUA5NJJ/8Tg57HMRE7pWxVJWVsjy2zn3I5UNFfwaNz0p1Li18vTeCtZDOIYfza
  wRF6c8XPdgvXzIevl1068u7E9rhAxp92kRe6tj3kF/27rv1rX2rY3Cu8Fa99zQ1WN2yTlLr8f
  /WsTYJvA8sS1nEEcW4qnlrIWn7y3aFpdd7lM6cz3dIUD56ec071mOzr9+rPhdnYVW3eVj+4tu
  vZF7ZJ2n7T1vw305n++uISoVDJmlp1Rwn2cydPVEWHfvlc2XhgxjyX2S7n+b7elNY1N0wuCv4
  v8XbRQ++iPwo9UteW9aUJL/8VYf3VUEN7Pt9l0W1x+8pPXUwVXqT9qPkFn/DJ6cz7/JYkKJ46
  HLVBbP8ysVVKLMUZiYZazEXFiQBTJqLsYQMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-10.tower-245.messagelabs.com!1588264863!347959!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5296 invoked from network); 30 Apr 2020 16:41:04 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-10.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Apr 2020 16:41:04 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 03UGeZ3J018078;
        Thu, 30 Apr 2020 17:40:51 +0100
Subject: Re: [RFC] tcmu: wrong input from userspace can confuse tcmu
To:     Mike Christie <mchristi@redhat.com>, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
References: <20200430151041.31053-1-bstroesser@ts.fujitsu.com>
 <90283f89-c4e7-19c0-2fdf-64c791f33221@redhat.com>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <230e914f-f28c-56e4-853c-09de658cd7a2@ts.fujitsu.com>
Date:   Thu, 30 Apr 2020 18:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <90283f89-c4e7-19c0-2fdf-64c791f33221@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



On 04/30/20 17:59, Mike Christie wrote:
> On 4/30/20 10:10 AM, Bodo Stroesser wrote:
>> Hi,
>>
>> When tcmu queues a new command - no matter whether in command
>> ring or in qfull_queue - a cmd_id from IDR udev->commands is
>> assigned to the command.
>>
>> If userspaces sends a wrong command completion containing the
>> cmd_id of a command on the qfull_queue, tcmu_handle_completions()
>> finds the command in the IDR and calls tcmu_handle_completion()
>> for it. This might do some nasty things, because commands in
>> qfull_queue do not have a valid dbi list.
>>
>> Of course this is easy to fix. E.g.:
>>
>>
>> --- a/drivers/target/target_core_user.c	2020-04-30 14:15:36.177184668 +0200
>> +++ b/drivers/target/target_core_user.c	2020-04-30 14:29:43.331882066 +0200
>> @@ -1242,13 +1242,14 @@ static unsigned int tcmu_handle_completi
>>   		}
>>   		WARN_ON(tcmu_hdr_get_op(entry->hdr.len_op) != TCMU_OP_CMD);
>>   
>> -		cmd = idr_remove(&udev->commands, entry->hdr.cmd_id);
>> -		if (!cmd) {
>> +		cmd = idr_find(&udev->commands, entry->hdr.cmd_id);
>> +		if (!cmd || !test_bit(TCMU_CMD_BIT_INFLIGHT, &cmd->flags)) {
>>   			pr_err("cmd_id %u not found, ring is broken\n",
>>   			       entry->hdr.cmd_id);
>>   			set_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
>>   			break;
>>   		}
>> +		idr_remove(&udev->commands, entry->hdr.cmd_id);
>>   
>>   		tcmu_handle_completion(cmd, entry);
>>   
>>
>> To avoid the second idr_*() call in main data path, it would also
>> be possible to not replace the idr_remove() by idr_find(), but
>> in case cmd was found without TCMU_CMD_BIT_INFLIGHT being set,
>> during error handling re-add the cmd to the idr with the same id
>> as before by calling idr_alloc(...,cmd_id, crmdd_id+1, ...).
>>
>>
>> OTOH, I'm wondering whether the better solution would be to
>> remove idr_alloc() from tcmu_setup_cmd_timer() and add it
>> to queue_cmd_ring() immediately before or after it calls
>> tcmu_setup_cmd_timer().
>> Doing so would mean that commands in qfull_queue no longer have
>> a cmd_id (which is not necessary AFAICS) and therefore the problem
> 
> It's done for logging, but its only debug logging so we could just print
> the pointer value.
> 

Yes, and then add the pointer value to the pr_debug that prints the
assigned cmd_id after idr_alloc()

>> cannot happen, because tcmu_handle_completions() cannot find them
>> in the IDR.
>>
> 
> This is probably best if it's not a lot of trouble.

I already spent some time to check the necessary changes. I think
there is no trouble, just some small changes.
So, yes, the bigger fix is probably better.

I'll wait till next week for further comments and then send a patch.

> 
> If you go this route then in tcmu_reset_ring I think I made a mistake

I'm not sure, but I don't think there is a mistake. If you cleanup
the ring, you don't need to cancel the commands in qfull_queue.

> and we just continue the loop if TCMU_CMD_BIT_INFLIGHT is not set. I
> think we want to do:
> 
> for cmd in qfull_list
>      target_complete_cmd()
So I think, this is not really necessary, but after
     clear_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);

we could do
     run_qfull_queue(udev, false);

right?

> 
> for cmd in idr
>       target_complete_cmd()
> 
