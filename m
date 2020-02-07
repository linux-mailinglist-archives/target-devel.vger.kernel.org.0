Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4E155BC2
	for <lists+target-devel@lfdr.de>; Fri,  7 Feb 2020 17:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgBGQ3R (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 7 Feb 2020 11:29:17 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:44393 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGQ3R (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:29:17 -0500
Received: by mail-pl1-f170.google.com with SMTP id d9so1199482plo.11
        for <target-devel@vger.kernel.org>; Fri, 07 Feb 2020 08:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pkbexL+3NPnKGqI5BDhBi+11xhbPMjLKBaQg+Woxtqc=;
        b=hDtwm5ceUclEUIFSpdP1R4WncOWIlmawxo3u/wISUq/gDni9Bj71LC/Paf/dm4XkB9
         E05tsQtBPObRXmDbb9SnQebwXZUosIJHHdv5fPHiHMMicXL5mbA+VXaUYpRS3xWvscTt
         Q69Ll/zLHQymTG+zl9PapjOsosrV2DMtzttmLuq/df1tZac1EoTzWUYniAUVYDP93zEJ
         Ix4E0X6VPfgN9i0FwDVST7FdgTulK2MxDH1X29HLGUjJUR/EABh9DcOe/gJ/Hd++8SBk
         r1PeE1Jo3DoaaiDNOeefJLyEFfjryfQtN+vw0LtJvZ7VYRMEraHUUAt5o5O6aPauAwNc
         7d1Q==
X-Gm-Message-State: APjAAAXgeIw4bgq6GlC4KDHFT1D9JijocJR35xa2lqpUrEAA5PTGxl72
        BDjjY5Bk1VYDcxmN/t8HCss=
X-Google-Smtp-Source: APXvYqxPI4GFM6XPtCkeFi0NL9WoASEjso0AwvDgP3QQPrpsSZ8Gt1Alv0dFR3m6Ch8VhZkXfGkeHg==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr4773434pjn.117.1581092956227;
        Fri, 07 Feb 2020 08:29:16 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d23sm3565973pfo.176.2020.02.07.08.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:29:15 -0800 (PST)
Subject: Re: IOZONE fails intermittently while toggling the interface
To:     Dakshaja Uppalapati <dakshaja@chelsio.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Cc:     Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <CH2PR12MB4005D671F3D274C4D5FA0BAEDD1C0@CH2PR12MB4005.namprd12.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a42fd32c-ff04-6bd9-508c-25ad38212d4e@acm.org>
Date:   Fri, 7 Feb 2020 08:29:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CH2PR12MB4005D671F3D274C4D5FA0BAEDD1C0@CH2PR12MB4005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2/7/20 6:00 AM, Dakshaja Uppalapati wrote:
> While testing iser with kernel 5.5, I see attached soft lockups.
> Logged in and ran iozone on mounted disks. While the traffic is running, toggled the initiators interface down to up for 13 secs.
> I see the attached hung task warnings in the target dmesg.
> # iozone -a -I -+d -g 32m
> 
> The same test with kernel-5.4 runs fine. I have suspected the following three commits which are all correlated, so removed these commits from 5.5 kernel, rebuilt the kernel and ran the same test then no issue is seen. Iozone is running successfully.
> 
> 80647a89eaf3f2: scsi: target: core: Release SPC-2 reservations when closing a session
> e9d3009cb936b: scsi: target: iscsi: Wait for all commands to finish before freeing a session
> 04060db41178c: scsi: RDMA/isert: Fix a recently introduced regression related to logout
> 
> I am trying to root cause the issue. Please do suggest me if you want me to  check some thing specific.

Hi Dakshaja,

Thanks for having included a call trace; that's very useful. I will try 
to reproduce this issue this weekend and will keep you posted.

Bart.
