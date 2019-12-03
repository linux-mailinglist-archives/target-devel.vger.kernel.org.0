Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA010F591
	for <lists+target-devel@lfdr.de>; Tue,  3 Dec 2019 04:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfLCD0k (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 2 Dec 2019 22:26:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41627 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfLCD0k (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:26:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id e9so1939439oif.8
        for <target-devel@vger.kernel.org>; Mon, 02 Dec 2019 19:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwpIDBucvKjpCN15l8CmiENKWiJ3fV7rlV+B6EGUY/Q=;
        b=uMRhepsMu54o9CknQNkBGlVn/d9qy8xO+eU0zmh4MITzbVKaCBeSRy+aJ/PP3/JOMQ
         n5zQiSfEKe35TPViuH2uRohl67uxsx9P1Z63dXSkXzveAEGVF3xEqnFY3reQYbHZJYB+
         5aGzLn+qzcY4WFFKjE9rRNtySBtfsawB08cY/e8Ajku/lxSAcuBkTvXYl6oRD5DcsB/x
         foQMpBqwsmXvd50oD3SNv8pgWLRUHRJxkNYN8+Arr6U3m++sENJzesJ54aDM9MWMYH+5
         XOrtAKD6WJhlLK9pU5XPW0pFlsZpN5E1C8XLc6mJTd8MG47+iMbtPDYjA1EdNeyToH26
         Xk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwpIDBucvKjpCN15l8CmiENKWiJ3fV7rlV+B6EGUY/Q=;
        b=N57WAs7Yzhch+tC883cwBXs4zTyyC8fN6lqnCCJ3oiWoYIZF1kSGF6gxdomrgohWXq
         WmNTF5CEcPtdeuPKXsosJlr25PG8idTXgNoNdSfiL0IVxT9mFEok7eqrkdSekUULO4hE
         ow9ddDlDA3dGvG5Va1JlICs+nRHw/PzC9uTlXvzD5SUvv+jXW9MRmwUT0pUCaq1KK29q
         sli66LKhjSOqbev9ebJwHB1mzxwHkDwdSpuM0M3kzqN9hpYinbLE+sDf1Mp0v/626B9x
         luT7lpkNsATWMisGWZbDAVxV9n+e4/4tmkopLqTX7ProFxaCDbGxcWELhg7NB3rLFqpU
         2Mcg==
X-Gm-Message-State: APjAAAWVv537Bg1KoyI1tryVpW4QpLUBT2FWdYYUEA7AL9QwObsB99LC
        HL5xMkLrK68XbD0f1UArcMsNGSZEVEdHOi1zG4yRkQ==
X-Google-Smtp-Source: APXvYqwz4mfuLXrSsp718O29itUq1yXjgDG5hOd8dyAdMUbt6utvr7bHWcM09Cww6W0Y6cXJadQ8xNl2lKC2MLvNsE0=
X-Received: by 2002:a05:6808:b2d:: with SMTP id t13mr2009175oij.83.1575343599018;
 Mon, 02 Dec 2019 19:26:39 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p> <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p> <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p> <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
In-Reply-To: <20191203031444.GB6245@ming.t460p>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Mon, 2 Dec 2019 22:26:28 -0500
Message-ID: <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

> oops, it should have been (arg4 & 511) != 0.

Yep, there they are:

# /usr/share/bcc/tools/trace -K 'bio_add_page ((arg4 & 511) != 0) "%d
%d", arg3, arg4'
PID     TID     COMM            FUNC             -
7411    7411    kworker/31:1H   bio_add_page     512 76
        bio_add_page+0x1 [kernel]
        sbc_execute_rw+0x28 [kernel]
        __target_execute_cmd+0x2e [kernel]
        target_execute_cmd+0x1c1 [kernel]
        iscsit_execute_cmd+0x1e7 [kernel]
        iscsit_sequence_cmd+0xdc [kernel]
        isert_recv_done+0x780 [kernel]
        __ib_process_cq+0x78 [kernel]
        ib_cq_poll_work+0x29 [kernel]
        process_one_work+0x179 [kernel]
        worker_thread+0x4f [kernel]
        kthread+0x105 [kernel]
        ret_from_fork+0x1f [kernel]

7753    7753    kworker/26:1H   bio_add_page     4096 76
        bio_add_page+0x1 [kernel]
        sbc_execute_rw+0x28 [kernel]
        __target_execute_cmd+0x2e [kernel]
        target_execute_cmd+0x1c1 [kernel]
        iscsit_execute_cmd+0x1e7 [kernel]
        iscsit_sequence_cmd+0xdc [kernel]
        isert_recv_done+0x780 [kernel]
        __ib_process_cq+0x78 [kernel]
        ib_cq_poll_work+0x29 [kernel]
        process_one_work+0x179 [kernel]
        worker_thread+0x4f [kernel]
        kthread+0x105 [kernel]
        ret_from_fork+0x1f [kernel]
