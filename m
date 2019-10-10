Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839E0D31D7
	for <lists+target-devel@lfdr.de>; Thu, 10 Oct 2019 22:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfJJUOt (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 10 Oct 2019 16:14:49 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:42821 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUOt (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:14:49 -0400
Received: by mail-pf1-f177.google.com with SMTP id q12so4594130pff.9
        for <target-devel@vger.kernel.org>; Thu, 10 Oct 2019 13:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lz+PwD7Y9jpUghzrFfnAlFyOPgeowoA5Fno+le1bEjs=;
        b=dntV9v1A9EdyA4HCnrtMqhlHFe4yrhd/4PfwZd4evyVvuBtok8HNCaFlPfCS32zEFL
         FfvH95/ZRkpGRuOTdV5p+B0cPH5szbLS6GWailrp3XaVZPe5JjUJj1edfYagsBxlWg8a
         4cgj4RbEmipSfNh9PVfeRlptDhBD87udB1GoGLy3IRVu4nrLwMogpM3kyfcjpRkBIa3x
         /WRvEY6Oh+E8IVl24UD5cW1MqkvFGDoIk/DjY90Sfy+Iq7l0mxiTApwjMpdyHx7bMnkU
         ABDKq39SuhsRwRrAceo3ZfpnKxsYrVHgAJkdyYfOTSfXSk9kr+8ANVxsbKtHkh1lg58t
         8yvg==
X-Gm-Message-State: APjAAAVnf+D/4lzUV8lWnXSjaqYwMEyjqYaNcjXMSwdJ0xTNQBWJY8ES
        oE1eDkAmF3xzJbbK3v/Pe9GJ9/Kn
X-Google-Smtp-Source: APXvYqyyyqZrOw4nGGNJetIp4kyoQXtykpmmXk5UlQAQrOlplPSFJmsyY+h7ZO5zyEvT2byOIVsSOQ==
X-Received: by 2002:a63:c901:: with SMTP id o1mr13016693pgg.66.1570738486523;
        Thu, 10 Oct 2019 13:14:46 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b14sm6751897pfi.95.2019.10.10.13.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 13:14:45 -0700 (PDT)
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        Mike Christie <mchristi@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
 <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
 <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
 <c87f1206-4abd-d7d3-bc68-369abf80950f@ts.fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c5c1b35f-6dcf-dedc-b380-f28b1684c69e@acm.org>
Date:   Thu, 10 Oct 2019 13:14:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c87f1206-4abd-d7d3-bc68-369abf80950f@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/10/19 11:57 AM, Bodo Stroesser wrote:
> Hmm. You are right. Ideally only SCSI-2 compliant initiators should
> use the LUN field and they should run parallel SCSI only.
> 
> OTOH, like Mike already said, we can't know whether there is any SW, FW,
> BIOS, ... out there, that still sends such old style CDBs.
> 
> For example: probably SW could send such CDBs by simply using SCSI
> generic device on top of a modern initiator. (I hope that's true, I
> didn't test ...)
> That means, old code can produce old SCSI CDBs even when running
> on top of modern HW.
> 
> Do we want to take the risk of breaking such "old stuff"?

Is blindly filtering out the LUN number correct? All initiator code that 
I found and that touches the highest three bits of that byte sets the 
LUN number in that byte. From the SCSI error handler:

if (sdev->scsi_level <= SCSI_2 && sdev->scsi_level != SCSI_UNKNOWN)
	scmd->cmnd[1] = (scmd->cmnd[1] & 0x1f)|(sdev->lun << 5 & 0xe0);

Bart.
