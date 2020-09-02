Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F025A453
	for <lists+target-devel@lfdr.de>; Wed,  2 Sep 2020 06:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIBEQK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 2 Sep 2020 00:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIBEQJ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:16:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC53C061244
        for <target-devel@vger.kernel.org>; Tue,  1 Sep 2020 21:16:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so2108731pfw.9
        for <target-devel@vger.kernel.org>; Tue, 01 Sep 2020 21:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YjuQEk1m++l8+VgRagE9HCI6EDDx7NljlOmBUw7K6jE=;
        b=rw759oD7fSY02fi35ImzrcQcE892StuRZ7BzmV2Nyic6E859zO2UlxVlj5GwrsqRCe
         /Np64c4+tiehj4WkuyJodDepUwpoHkJi28vWgoGhhEZ7AmOnJFPtBcC2Cq1zXoPwzC2T
         Jo8SCS2jwGDkI5lyiEx0ltSoWJiiDfPF09VmCCGhM+y15oj5qu6Gl/jYz4vCYL5QXQuX
         PlN+wpxjx1qr5UI56qJP6kIQ5PuDm6NmTFiQKhPQyuhKqN0PyGgYUzJviKxdyDibdKWt
         09jZhB9fp/ct4XzZWfT5MzPXmVRmRWxvNAs/PQKXa9ty7CZFQRCToA8Qx5RIFY6dQDjh
         syjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YjuQEk1m++l8+VgRagE9HCI6EDDx7NljlOmBUw7K6jE=;
        b=qrCBWpV0FBT8aoanRDxxw6fq94pEtGnWjO3ek+TGtsRhEMeROdzKUotqclmfZqrAdm
         aFDAZDLGLXy/hh/vSeDqMAlTAxhFbV33jC68aqMKC14C4QlfQxw4ZXKdddcruAdlesfC
         lcRJLasgz6OxQGoAxfM2waNAzC3zLHs+Tht8cjeEovKrEk/9dSv9EGJq+nI92Kwj2hR9
         8xzKEo2art6f88pYt0zyG1LK6e1YdoCKeIT6T6NAbsiEYQTMpF9CDPZv8iEIobaqp58I
         81pmRTNf8lEt2ZOllbqKtmoa1eLS777ZNmlGq7haRGNz2r1gp3tNmEXOVa4fR++GqMRI
         rNbg==
X-Gm-Message-State: AOAM532bQYaoVuVo8fG4AfdczeaAWkdQD5ePo36kITqmV3EoBVJqyBOn
        3puBsGAyXS2VlhJz4LEHv2j17vLkDO2CWw==
X-Google-Smtp-Source: ABdhPJxkYNhpuDRKo12BK397uJNblMB8taTb9JDBABcjU97i4j3G3oM8HvwGtq2T7nsipNYvm06yVQ==
X-Received: by 2002:a62:6847:: with SMTP id d68mr1490556pfc.110.1599020167776;
        Tue, 01 Sep 2020 21:16:07 -0700 (PDT)
Received: from [10.2.202.243] ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id a5sm3711965pfb.26.2020.09.01.21.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 21:16:07 -0700 (PDT)
Subject: Re: [PATCH] iscsi-target: fix hang in iscsit_access_np() when getting
 tpg->np_login_sem
To:     Michael Christie <michael.christie@oracle.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        stable@vger.kernel.org
References: <20200729130343.24976-1-houpu@bytedance.com>
 <24875CC6-70FA-477D-BB74-51FBFDD96732@oracle.com>
From:   Hou Pu <houpu@bytedance.com>
Message-ID: <e655c868-966d-1846-6bd8-19671cf966d4@bytedance.com>
Date:   Wed, 2 Sep 2020 12:16:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <24875CC6-70FA-477D-BB74-51FBFDD96732@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



On 2020/9/2 10:57 AM, Michael Christie wrote:
> 
> 
>> On Jul 29, 2020, at 8:03 AM, Hou Pu <houpu@bytedance.com> wrote:
>>
>> The iscsi target login thread might stuck in following stack:
>>
>> cat /proc/`pidof iscsi_np`/stack
>> [<0>] down_interruptible+0x42/0x50
>> [<0>] iscsit_access_np+0xe3/0x167
>> [<0>] iscsi_target_locate_portal+0x695/0x8ac
>> [<0>] __iscsi_target_login_thread+0x855/0xb82
>> [<0>] iscsi_target_login_thread+0x2f/0x5a
>> [<0>] kthread+0xfa/0x130
>> [<0>] ret_from_fork+0x1f/0x30
>>
>> This could be reproduced by following steps:
>> 1. Initiator A try to login iqn1-tpg1 on port 3260. After finishing
>>    PDU exchange in the login thread and before the negotiation is
>>    finished, at this time the network link is down. In a production
>>    environment, this could happen. I could emulated it by bring
>>    the network card down in the initiator node by ifconfig eth0 down.
>>    (Now A could never finish this login. And tpg->np_login_sem is
>>    hold by it).
>> 2. Initiator B try to login iqn2-tpg1 on port 3260. After finishing
>>    PDU exchange in the login thread. The target expect to process
>>    remaining login PDUs in workqueue context.
>> 3. Initiator A' try to re-login to iqn1-tpg1 on port 3260 from
>>    a new socket. It will wait for tpg->np_login_sem with
>>    np->np_login_timer loaded to wait for at most 15 second.
>>    (Because the lock is held by A. A never gets a change to
>>    release tpg->np_login_sem. so A' should finally get timeout).
>> 4. Before A' got timeout. Initiator B gets negotiation failed and
>>    calls iscsi_target_login_drop()->iscsi_target_login_sess_out().
>>    The np->np_login_timer is canceled. And initiator A' will hang
>>    there forever. Because A' is now in the login thread. All other
>>    login requests could not be serviced.
> 
> iqn1 and iqn1 are different targets right? It’s not clear to me how when initiator B fails negotiation that it cancels the timer for the portal under a different iqn/target.

iqn1-tpg1 in step1 and step3 are same one. (same target volume)
iqn2-tpg1 in step2 is a different volume on the same host.
The configuration likes below:

iqn1-tpg1:
root@storageXXX:/sys/kernel/config/target/iscsi# ls 
iqn.2010-10.org.openstack\:volume-00e50deb-5296-4f18-xxxx-106f96a880c8/tpgt_1/np/
10.129.77.16:3260

iqn2-tpg1:
root@storageXXX:/sys/kernel/config/target/iscsi# ls 
iqn.2010-10.org.openstack\:volume-86af15c6-c529-4715-xxxx-3c9ca068635d/tpgt_1/np/
10.129.77.16:3260

(I could provide more is needed)

> 
> Is iqn2-tpg1->np1 a different struct than iqn1-tpg1-np1? I mean iscsit_get_tpg_from_np would return a different np struct for initiator B and for A?
> 

iscsit_get_tpg_from_np() returned different struct iscsi_portal_group
for initiator A and B. But struct iscsi_np is shared by them.
Because they have the same portal(ip address and port).


Thanks,
Hou










