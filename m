Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1904F7F85
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 20:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfKKTM6 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 14:12:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44670 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKKTM6 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:12:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so11279607pfn.11
        for <target-devel@vger.kernel.org>; Mon, 11 Nov 2019 11:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GokarfKp4jvz3ND8O1HbjQ0I5VHatotOFh2cU1veQZA=;
        b=HAejU4r8z/dhzJczVhp2pf4GKXt9Qx8WlOWmlxXK+OGQZym81uRLuy8PJPa+p9WZn7
         56YqNaDs3N8OYobfWtgSI6BbUAPtiZSZIw7+kGr0smFciLK9Baz8Hw0xKQIG2nx/hP9S
         AATBJa8jPVnRCvkTAkMQRbUTQ3xVr4yirqFBX1p26wVQPwf0geXN9ao8MiZTvxhwwLKm
         xjkgTq7EWkhLSYIiAqpGp99e7obqAAbublXLNh8nuM02evOBEteKqBPYjpdc5ki1/P/k
         XCL1c28Rbs1sCsKmn1+9w362YIwc1ZQ5NZWHt2GS3WaM7fawR7bMTEMCsOA/QVUTMN2u
         e16w==
X-Gm-Message-State: APjAAAXWjdmoNda+7zlbz0cR3S6NUu8ILoxATLS23+WWX0rtAVQmPaXp
        eXqeS+yr2gbahbhalA3cWPBeBT4f
X-Google-Smtp-Source: APXvYqxcduKPs4YByAmeZKUp/NEphj8yFh+q4h8pm5K/G9/sxfFpu9fylbFtHhCjpOoMK6p8wjx9UA==
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr697622pjb.117.1573499576957;
        Mon, 11 Nov 2019 11:12:56 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p7sm197969pjp.4.2019.11.11.11.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 11:12:56 -0800 (PST)
Subject: Re: [PATCH 0/2] Improve SPC-2 reservation support
To:     Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
References: <20191111182944.191123-1-bvanassche@acm.org>
 <20191111185802.fedzop3t6po4mpgp@SPB-NB-133.local>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <13791d8a-6600-a388-2330-9fb2e6689104@acm.org>
Date:   Mon, 11 Nov 2019 11:12:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111185802.fedzop3t6po4mpgp@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/11/19 10:58 AM, Roman Bolshakov wrote:
> On Mon, Nov 11, 2019 at 10:29:42AM -0800, Bart Van Assche wrote:
>> Hi Martin,
>>
>> This patch series improves support for SPC-2 reservations in the SCSI target
>> code. Please consider these patches for inclusion in the v5.5 kernel.
>>
>> Thanks,
>>
>> Bart.
>>
>> Bart Van Assche (2):
>>    target/core: Declare target_release_reservation() 'static'
>>    target/iscsi: Fix a use-after-free while closing a session
>>
>>   drivers/target/target_core_pr.c        |  2 +-
>>   drivers/target/target_core_pr.h        |  1 -
>>   drivers/target/target_core_transport.c | 11 +++++++++++
>>   3 files changed, 12 insertions(+), 2 deletions(-)
> 
> I have missed the second patch, who was it send to?

Hi Roman,

That second patch has also been sent to the target-devel mailing list. 
On the following web page I can see that it has not yet been sent out by 
the mailing list server: https://www.spinics.net/lists/target-devel/. If 
that second patch does not appear on the target-devel mailing list by 
tomorrow I will resend it.

Bart.
