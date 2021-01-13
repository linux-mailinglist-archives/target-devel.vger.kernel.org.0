Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1142F50AC
	for <lists+target-devel@lfdr.de>; Wed, 13 Jan 2021 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbhAMRLI (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Jan 2021 12:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbhAMRLH (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:11:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166D5C061575;
        Wed, 13 Jan 2021 09:10:27 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id 6so4144786ejz.5;
        Wed, 13 Jan 2021 09:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rFBmtH1TI8zpSCup/4jrWzYhxSsaVXPS2ThkcS6xCJ0=;
        b=aIMagPTPW5supDBmENlZq7xdFrzi1OXEo7ZF+Q483gf21qhw4fDc2TqDjy6ROodjhY
         HMPFMQNT4RJubJpa9mEYiTRexS6oolOfsrfr5p1WE8NpkcMqvGntrhpjV0K9tt6YbNp9
         HdPTXwAuiHtcxGtwVLUqOwi5tWQIWdud/69FA7w3fDMTsKcBvik43ek+OuZZ6nSUTKPi
         RWJHE6EiQUGbb48k2DFWLTz14nOOfkDi/xdXwPuL4/dUnJzknwqybUts4UiPctJF0bLk
         4r+2vMKSOn7GUwRJHbeTGkGJIm59kFryO+N6guxLLXYGjqkSk1EHbuMODOfbEUW7xnWg
         tPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFBmtH1TI8zpSCup/4jrWzYhxSsaVXPS2ThkcS6xCJ0=;
        b=RKEw44ITEMH7t+2dtlgaBmIU7fE1zKquf9IYxQjrmE6ilqC1nD3GbP2SprJNiVzb1X
         Xjgc+okYMY/1qLtaXuhXHCHs2QQdmKwyAdo/pVGg14E5sHi3cSvNO4TVPIjCBXhcil7q
         LDLpWxiPGu/O8ifibrdZclbNJtUT5Y3EYhCCKpUcO3BdhEW04JafgrrXwlA2jpBVUmUC
         3LXHLlH1yMPd67Y+88IylD5DN+EBZXUEzsVehJklNOF1EPjSXv6Wqt0ySH/q9mBnDQS/
         v/F8DBjGzSuPT7idAhRWPyk4ezvc7ZSuwn0IJLBzsgGUtn2nY4zCGNCK403Z28c3H4K9
         yLRg==
X-Gm-Message-State: AOAM532Jp3TsMxQoVm4FGpYyCu6QaE33+5od+4hiIWDkATQNCLJnvoG1
        rG4A0ikvboFbrjGt1cG6knw=
X-Google-Smtp-Source: ABdhPJzGYWrWx1+YdVnW0dg98O3rMutlkpoXJNZ/Ah+UuIVDnTp2g6rawPy5mtCs/vv1YtqPangINQ==
X-Received: by 2002:a17:906:1f8e:: with SMTP id t14mr2312243ejr.350.1610557825759;
        Wed, 13 Jan 2021 09:10:25 -0800 (PST)
Received: from [192.168.178.40] (ipbcc05d1b.dynamic.kabel-deutschland.de. [188.192.93.27])
        by smtp.gmail.com with ESMTPSA id d14sm1148101edn.31.2021.01.13.09.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 09:10:25 -0800 (PST)
Subject: Re: [PATCH] scsi: target: tcmu: Fix use-after-free of se_cmd->priv
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20210113024508.1264992-1-shinichiro.kawasaki@wdc.com>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <53431c50-e13c-27cf-572f-51b5d0ef6f0c@gmail.com>
Date:   Wed, 13 Jan 2021 18:10:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113024508.1264992-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 13.01.21 03:45, Shin'ichiro Kawasaki wrote:
> Commit a35129024e88 ("scsi: target: tcmu: Use priv pointer in se_cmd")
> modified tcmu_free_cmd() to set NULL to priv pointer in se_cmd. However,
> se_cmd can be already freed by work queue triggered in
> target_complete_cmd(). This caused BUG KASAN use-after-free [1].
> 
> To fix the bug, do not touch priv pointer in tcmu_free_cmd(). Instead,
> set NULL to priv pointer before target_complete_cmd() calls. Also, to
> avoid unnecessary priv pointer change in tcmu_queue_cmd(), modify priv
> pointer in the function only when tcmu_free_cmd() is not called.
> 
> [1]
> BUG: KASAN: use-after-free in tcmu_handle_completions+0x1172/0x1770 [target_core_user]
> Write of size 8 at addr ffff88814cf79a40 by task cmdproc-uio0/14842
> 
> CPU: 2 PID: 14842 Comm: cmdproc-uio0 Not tainted 5.11.0-rc2 #1
> Hardware name: Supermicro Super Server/X10SRL-F, BIOS 3.2 11/22/2019
> Call Trace:
>   dump_stack+0x9a/0xcc
>   ? tcmu_handle_completions+0x1172/0x1770 [target_core_user]
>   print_address_description.constprop.0+0x18/0x130
>   ? tcmu_handle_completions+0x1172/0x1770 [target_core_user]
>   ? tcmu_handle_completions+0x1172/0x1770 [target_core_user]
>   kasan_report.cold+0x7f/0x10e
>   ? tcmu_handle_completions+0x1172/0x1770 [target_core_user]
>   tcmu_handle_completions+0x1172/0x1770 [target_core_user]
>   ? queue_tmr_ring+0x5d0/0x5d0 [target_core_user]
>   tcmu_irqcontrol+0x28/0x60 [target_core_user]
>   uio_write+0x155/0x230
>   ? uio_vma_fault+0x460/0x460
>   ? security_file_permission+0x4f/0x440
>   vfs_write+0x1ce/0x860
>   ksys_write+0xe9/0x1b0
>   ? __ia32_sys_read+0xb0/0xb0
>   ? syscall_enter_from_user_mode+0x27/0x70
>   ? trace_hardirqs_on+0x1c/0x110
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fcf8b61905f
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 b9 fc ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 0c fd ff ff 48
> RSP: 002b:00007fcf7b3e6c30 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcf8b61905f
> RDX: 0000000000000004 RSI: 00007fcf7b3e6c78 RDI: 000000000000000c
> RBP: 00007fcf7b3e6c80 R08: 0000000000000000 R09: 00007fcf7b3e6aa8
> R10: 000000000b01c000 R11: 0000000000000293 R12: 00007ffe0c32a52e
> R13: 00007ffe0c32a52f R14: 0000000000000000 R15: 00007fcf7b3e7640
> 
> Allocated by task 383:
>   kasan_save_stack+0x1b/0x40
>   ____kasan_kmalloc.constprop.0+0x84/0xa0
>   kmem_cache_alloc+0x142/0x330
>   tcm_loop_queuecommand+0x2a/0x4e0 [tcm_loop]
>   scsi_queue_rq+0x12ec/0x2d20
>   blk_mq_dispatch_rq_list+0x30a/0x1db0
>   __blk_mq_do_dispatch_sched+0x326/0x830
>   __blk_mq_sched_dispatch_requests+0x2c8/0x3f0
>   blk_mq_sched_dispatch_requests+0xca/0x120
>   __blk_mq_run_hw_queue+0x93/0xe0
>   process_one_work+0x7b6/0x1290
>   worker_thread+0x590/0xf80
>   kthread+0x362/0x430
>   ret_from_fork+0x22/0x30
> 
> Freed by task 11655:
>   kasan_save_stack+0x1b/0x40
>   kasan_set_track+0x1c/0x30
>   kasan_set_free_info+0x20/0x30
>   ____kasan_slab_free+0xec/0x120
>   slab_free_freelist_hook+0x53/0x160
>   kmem_cache_free+0xf4/0x5c0
>   target_release_cmd_kref+0x3ea/0x9e0 [target_core_mod]
>   transport_generic_free_cmd+0x28b/0x2f0 [target_core_mod]
>   target_complete_ok_work+0x250/0xac0 [target_core_mod]
>   process_one_work+0x7b6/0x1290
>   worker_thread+0x590/0xf80
>   kthread+0x362/0x430
>   ret_from_fork+0x22/0x30
> 
> Last potentially related work creation:
>   kasan_save_stack+0x1b/0x40
>   kasan_record_aux_stack+0xa3/0xb0
>   insert_work+0x48/0x2e0
>   __queue_work+0x4e8/0xdf0
>   queue_work_on+0x78/0x80
>   tcmu_handle_completions+0xad0/0x1770 [target_core_user]
>   tcmu_irqcontrol+0x28/0x60 [target_core_user]
>   uio_write+0x155/0x230
>   vfs_write+0x1ce/0x860
>   ksys_write+0xe9/0x1b0
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Second to last potentially related work creation:
>   kasan_save_stack+0x1b/0x40
>   kasan_record_aux_stack+0xa3/0xb0
>   insert_work+0x48/0x2e0
>   __queue_work+0x4e8/0xdf0
>   queue_work_on+0x78/0x80
>   tcm_loop_queuecommand+0x1c3/0x4e0 [tcm_loop]
>   scsi_queue_rq+0x12ec/0x2d20
>   blk_mq_dispatch_rq_list+0x30a/0x1db0
>   __blk_mq_do_dispatch_sched+0x326/0x830
>   __blk_mq_sched_dispatch_requests+0x2c8/0x3f0
>   blk_mq_sched_dispatch_requests+0xca/0x120
>   __blk_mq_run_hw_queue+0x93/0xe0
>   process_one_work+0x7b6/0x1290
>   worker_thread+0x590/0xf80
>   kthread+0x362/0x430
>   ret_from_fork+0x22/0x30
> 
> The buggy address belongs to the object at ffff88814cf79800
>   which belongs to the cache tcm_loop_cmd_cache of size 896
> 
> Fixes: a35129024e88 ("scsi: target: tcmu: Use priv pointer in se_cmd")
> Cc: stable@vger.kernel.org # v5.9+
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thank you for the fix.

Acked-by: Bodo Stroesser <bostroesser@gmail.com>
