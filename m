Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C88300A57
	for <lists+target-devel@lfdr.de>; Fri, 22 Jan 2021 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbhAVR0u (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 22 Jan 2021 12:26:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbhAVQyP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:54:15 -0500
Date:   Fri, 22 Jan 2021 17:51:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611334293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=duF826oNjVqHJH4TCpsijGzt7xMkMBsSQhoM/BiX/rk=;
        b=Bs2Vt+SwuiX5kT2alBKmXtdI9+TdBzTQld5+fMdiPh6fE5MNkd70XHTrHtSKwal/MNkZIi
        lGq7thshhf4hdaC5HKlYbIhfjtC/HSkXVvU+K+XyIrZrEkuWoq6HSVMWXOyyMx20VUiluw
        Pp+f7Z758ZUD9KEBCyrdfK7BA6uwP7023Wt4Vle1leTJSI963ke1nkKHqxDyMpcK9nOmsN
        3yp72asrF9J2NUiGquOhzIms/Ed1Mlc0QxBJBhHWvlKThDSlG8AzONbNqWyGHJYy8dVcMY
        8bKoImIg30Rx3V6FesfvshJL8p97EyADvvpYatlj3vCfntQMkQG0q000yh8+ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611334293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=duF826oNjVqHJH4TCpsijGzt7xMkMBsSQhoM/BiX/rk=;
        b=KaLTi/c9uenRo/ZUU8if2WMwfxRSb7itk3NLJdEKMCynf29TO5qwbstv4EIOy0FudLPXZ1
        h41f2ivxgPUyUNDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>
Subject: Re: [PATCH 0/6] scsi: target: Remove in_interrupt() usage.
Message-ID: <20210122165133.3ejgs4d5tewnuvps@linutronix.de>
References: <20201220203638.43615-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201220203638.43615-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2020-12-20 21:36:32 [+0100], To target-devel@vger.kernel.org wrote:
> Folks,
> 
> in the discussion about preempt count consistency across kernel
> configurations:
> 
>  https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/
> 
> it was concluded that the usage of in_interrupt() and related context
> checks should be removed from non-core code.
> 
> In the long run, usage of 'preemptible, in_*irq etc.' should be banned from
> driver code completely.
> 
> This series addresses the target subsystem.
> Most of in_interrupt() usage is debugging. There is one function which
> either invokes wait_for_completion() or schedules a timer based on
> in_interrupt().

A gentle ping case it got buried somewhere in the merge window / xmas.
My understanding is that nab is out-of-town and target gets routed via
scsi.

Sebastian
