Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532BFF8124
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 21:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKKUXj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 15:23:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44441 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUXj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:23:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so11432858pfn.11
        for <target-devel@vger.kernel.org>; Mon, 11 Nov 2019 12:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scI0/OUGaxtM8l5LM6Ik1B7hJrXCWW8pcUSJzVlvoXw=;
        b=Ef/F8domwyKPfqNiA7ArCD6aE7PpM+eO6dbInTfb2rEzYVr7cu5N3zCz9fjuLoxbOV
         40lcGHJEt5pkEelKqpUj4DxeEzSMt/uWoD059fSXWZ0dFJ0SOOBVYpDkN0RzZnCU0dzf
         nHxo8XKS9QSM7Nx8Ssy1Ns6VTKrrl/MmcqdFWu+wmd41PCXdA6ORTfhUftR8HDO9KigU
         WVvDfztJTrdX3wqMNGuGrBGkkZOcOEU+o5cewQXendr6dJhObYpynB4SJs9lXBVv2KMM
         2khpCZcUvkYAMLo2AUQY6xFiUY/TU8vXe7U8FchkM2OyV3Wlc9VNPoske2EpCjqMJKaz
         cOWg==
X-Gm-Message-State: APjAAAWlJrLQD5xpKd7CryI4wdXb/yhlNP6LySDayWorJEIx5xTyU/mR
        OYxGW53HcQn4ys0D1D50mb3b0cMM
X-Google-Smtp-Source: APXvYqxVE8tdanTqyUCFTiWDTNaxSr4inXXVsw51nEGohnDLI/dmNaJ1nQK1J2aye9pMgDLbk/RdSQ==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr19681602pgj.247.1573503818234;
        Mon, 11 Nov 2019 12:23:38 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h3sm247992pji.16.2019.11.11.12.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:23:37 -0800 (PST)
Subject: Re: [PATCH 2/2] target/iscsi: Fix a use-after-free while closing a
 session
To:     Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
References: <20191111182944.191123-1-bvanassche@acm.org>
 <20191111182944.191123-3-bvanassche@acm.org>
 <20191111194114.yckp2zkraulvl7hz@SPB-NB-133.local>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d6f56368-1b3d-f778-adf1-ac67b6dc1df0@acm.org>
Date:   Mon, 11 Nov 2019 12:23:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111194114.yckp2zkraulvl7hz@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/11/19 11:41 AM, Roman Bolshakov wrote:
> On Mon, Nov 11, 2019 at 10:29:44AM -0800, Bart Van Assche wrote:
>> +static int target_release_res(struct se_device *dev, void *data)
>> +{
>> +	struct se_session *sess = data;
>> +
>> +	if (dev->reservation_holder == sess)
>> +		dev->reservation_holder = NULL;
> 
> Does it worth to use target_release_reservation() when the session is
> reserveration holder instead of the explicit assignment? That would also
> reset reservation flags of the se_device.

That sounds like a good idea to me. I will look into this.

> IMO the code is not specific to iscsi and the tag should be changed to
> "target/core:"

Agreed. I will fix the patch subject.

Bart.
