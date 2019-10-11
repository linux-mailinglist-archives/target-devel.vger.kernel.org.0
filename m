Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4FCD4650
	for <lists+target-devel@lfdr.de>; Fri, 11 Oct 2019 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfJKRNG (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 11 Oct 2019 13:13:06 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34823 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfJKRNG (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:13:06 -0400
Received: by mail-pf1-f172.google.com with SMTP id 205so6472706pfw.2
        for <target-devel@vger.kernel.org>; Fri, 11 Oct 2019 10:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Rw8a/JeQuwpD8nSKFieiu0BHAKeIux6gnjOHIeJl2Y=;
        b=H+nmo/aiujonH80MG2P33GOokkE+oCqc0KttEBUjZQZs1o5wJf+zSXG8WEfRJ4fCHv
         f7oHVfnzCLcpbPM5LSCwlBWDcJmdV6Utrleu3zjk6LHS0b82CM4cBkKvo9jLduTc9q4V
         qhhN9GpacYWxtODhxBl5k9HWZF9/0RNQxF+nE8x/FTzxKhdQORjM1yh14SGuZUUClOsR
         s+q0zGK+aR4Ckaro1iG3XGbsd/Rv5pkCjjILTjajInS+MSMzwKdhyqf5UhpZmr64WTqp
         34t03qL0klM8rAQ8zK58t+DA1DarZwLfxc4rL6xdXbgShYh0CAYHKtrM3iOEU0vSAlg0
         caBw==
X-Gm-Message-State: APjAAAWJurvTA3oMr27ToHfMba1jfpWX09H0/uRnnUWlrxZcHi9NAVWU
        i6pz3SOEYPmMZQxbyKEvgWJfeLVM
X-Google-Smtp-Source: APXvYqyyg4gAtz9tamPfzWmjOHzkm9V7wLmjfnkdryMgUmi1QjRrLBwxIOGkEtvvOvSIIVkvBvMI7g==
X-Received: by 2002:aa7:8583:: with SMTP id w3mr18299473pfn.182.1570813984644;
        Fri, 11 Oct 2019 10:13:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y144sm10544599pfb.188.2019.10.11.10.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:13:03 -0700 (PDT)
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
 <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
 <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
 <c87f1206-4abd-d7d3-bc68-369abf80950f@ts.fujitsu.com>
 <c5c1b35f-6dcf-dedc-b380-f28b1684c69e@acm.org> <5D9FA02E.3050909@redhat.com>
 <b5c4de4c-b93d-8579-e427-79cb565e3d08@suse.de>
 <38ec5155-9dd1-480a-a542-141f652bc2eb@ts.fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1ab6c1c0-1928-f8c7-ab8d-d655725d32aa@acm.org>
Date:   Fri, 11 Oct 2019 10:13:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <38ec5155-9dd1-480a-a542-141f652bc2eb@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/11/19 3:12 AM, Bodo Stroesser wrote:
> If I understood correctly, we all would prefer to make TCMU completely
> transparent regarding the CDB.
> 
> For pscsi I think we all agree, that the code is wrong or incomplete.
> But for pscsi up to now no one complained. So I'm wondering whether we
> should spend much effort for pscsi to discuss / find out the right
> solution? Especially as the original comment in the code, as posted by
> Mike, as well as the current comment are not very clear. Thus 'fixing'
> pscsi would mean to change or remove something we don't understand
> completely.
> 
> So I agree to Hannes: we should simply move that code from
> passthrough_parse_cdb() to pscsi_parse_cdb(), at least as a first step.

Hannes wrote "[ ... ] delegate it to pscsi if there is a need." Is there 
really a need for such code in the SCSI passthrough driver? The upstream 
SCSI target code is one of the four Linux SCSI target stacks that I know 
of. I haven't found any SCSI-2 LUN number filtering code in the tgt 
project (http://stgt.sourceforge.net/). I'm not sure about IET. SCST is 
around since 2006 and has SCSI-2 LUN number filtering code in its CDROM 
and MODISK passthrough drivers. That LUN number filtering code is there 
since the initial commit so it is not the result of a recent request of 
a user. SCST does not have LUN filtering code in its disk passthrough 
driver nor in its tape passthrough driver. In other words, I do not 
expect that anyone's setup will be broken by removing 
passthrough_parse_cdb() entirely.

Bart.
