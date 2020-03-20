Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A11D018C762
	for <lists+target-devel@lfdr.de>; Fri, 20 Mar 2020 07:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCTGWN (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 20 Mar 2020 02:22:13 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:36831 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgCTGWN (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:22:13 -0400
Received: by mail-pj1-f54.google.com with SMTP id nu11so2030123pjb.1
        for <target-devel@vger.kernel.org>; Thu, 19 Mar 2020 23:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zGL0gqGDHJCU2VjK7A4tFwTq2xKNdCei3QISoUsfdJ0=;
        b=Byp3rvP/Gdy2/tM6HcMe8PKzPME+q4AXSuapiUsh4+HgtCZSANrI7vVMvGSJK9Uy0E
         CZnPtMUtxFxe3kxxdjothgOA6DyejwrBvwn7U8219QGdoGWt7DcSRXMG7eDHaIhX9l3S
         fNpGP8FPBh5rmAXGnLH8AaMqkqJLVO4Nq2bzRDet/zTmALsXKELlQWgot78tBCDlDJ6K
         IQ3pHw0IY/0ahfsTq6t8B+Zhmb5uzIUB/qpt18L3G58rqsVjMPW+t1vKcgpxPmsYhlLu
         1JnQFYo9sXbrjtzK9yjkGQ4jaweOh47XBMyUdagOIm5kmBQLJLViF8QIq3yF5KR424vP
         J35Q==
X-Gm-Message-State: ANhLgQ0MZ/UUAty+YVbvrZpm4zpXeBJxDPeaJY73DeVnxJj/7DFdQigI
        SVcHxWndxGl02WZHP9hm/RM=
X-Google-Smtp-Source: ADFU+vs0s4gvdXEf6U+lQN/OIigtR4TqKaqfMw7wxsaSQKy9sXDyDGh0qQYJkc5OKIwdgSwfw3kB3Q==
X-Received: by 2002:a17:90a:9f96:: with SMTP id o22mr7581620pjp.88.1584685332232;
        Thu, 19 Mar 2020 23:22:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f092:4ccc:3e48:6081? ([2601:647:4802:9070:f092:4ccc:3e48:6081])
        by smtp.gmail.com with ESMTPSA id t142sm4039404pgb.31.2020.03.19.23.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 23:22:11 -0700 (PDT)
Subject: Re: Connection errors with ISER IO
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20200226155241.GA28594@chelsio.com>
 <d655f85f-d910-a77b-1672-0fbb919e5d9a@grimberg.me>
 <20200227140045.GA2029@chelsio.com>
 <b021295a-cc41-d8e9-8605-cfbc77cead80@grimberg.me>
 <20200304182612.GA6665@chelsio.com> <20200310120150.GA7669@chelsio.com>
 <20200319174510.GB29063@chelsio.com>
 <1d236e48-d76e-e7be-53a5-a1e6426a26b5@grimberg.me>
 <20200320060330.GB16482@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <24e7c897-fcc1-1712-100f-9c36ba607729@grimberg.me>
Date:   Thu, 19 Mar 2020 23:22:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200320060330.GB16482@chelsio.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This seems the a possible root-cause...


> [11367.785938] kworker/5:1H    S    0   768      2 0x80004000
> [11367.786401] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [11367.786958] Call Trace:
> [11367.787446]  ? __schedule+0x31a/0x850
> [11367.787988]  schedule+0x36/0xc0
> [11367.788488]  iscsit_allocate_cmd+0x246/0x2c0 [iscsi_target_mod]
> [11367.789042]  ? finish_wait+0x80/0x80
> [11367.789564]  isert_allocate_cmd+0x1d/0x60 [ib_isert]
> [11367.790120]  isert_recv_done+0x282/0xa30 [ib_isert]
> [11367.790620]  __ib_process_cq+0x76/0xc0 [ib_core]
> [11367.791181]  ib_cq_poll_work+0x26/0x80 [ib_core]
> [11367.791697]  process_one_work+0x235/0x5d0
> [11367.792300]  worker_thread+0x3c/0x390
> [11367.792818]  ? process_one_work+0x5d0/0x5d0
> [11367.793366]  kthread+0x11f/0x140
> [11367.793850]  ? kthread_park+0x90/0x90
> [11367.794440]  ret_from_fork+0x24/0x30

The only way that the workqueue cannot process the drain completion
is if it is stuck. This appears to be the cq workqueue blocks on
a command allocation that apparently never completes.

The question is why does that happen only for 511MB luns, and
how come this allocation never completes...
