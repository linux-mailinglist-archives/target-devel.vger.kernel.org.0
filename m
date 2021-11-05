Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0552D446098
	for <lists+target-devel@lfdr.de>; Fri,  5 Nov 2021 09:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhKEI1p (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 5 Nov 2021 04:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhKEI1o (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:27:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D0C061203
        for <target-devel@vger.kernel.org>; Fri,  5 Nov 2021 01:25:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso8993259wmc.1
        for <target-devel@vger.kernel.org>; Fri, 05 Nov 2021 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EFUXh461CIiXVx1x45I6hR/O2ueRgYCwIDIidW8J+Tw=;
        b=lMD/pi28y/Uv87QFeGqi0ofGemcaTx7QwUjSrauWalLa469Orq1Qism8wG/Zujo4DV
         XEqrKE0BTjAS5ohOcQPDQpCzeHVg6xpGVaa6dMCJN7psjsa3R0ZylPVI8xKmBsw2HcdF
         fT4JBNVt+B+3Y4qpWJQ0DkUerPO6Nn213HCtaKFKnOx5YpRZMykH6ocakGNFpu7aisod
         XUBewMdfBmEudQkXh5zAxOmiNk18R4APKkSq+aIWB2ARaGpnG0Ng8YAyR2fGaAtCLH/M
         NOI8a+Uu6gwDVNLWesNr2iVNbTRMPPSvUzA6rKSJP6tS1RZVpLM9qt8P6TFo+eL13yc+
         u2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EFUXh461CIiXVx1x45I6hR/O2ueRgYCwIDIidW8J+Tw=;
        b=58hn9gisqH/O0DZkjsI7kH/EDU0UhjwofTM8LCEY4nLHugE/ofJuGJBfhtajk8QOT8
         8Yp1DIiTnafjViR7/8JZ12Od+2T+MgPKsUKavSmCawuxXwYJkxGtJxwGG4jMovGbAYkI
         0rk+4Fl+aaatXDIhG9BUItRyMQAVxzPiRXNnWEsv1+A6UvUS6YokejqncPeBL841ARfl
         LGfR1D1/JMqOCHCe9ADpPNQZ6IiucNmPLoIDBKymliG3US1Z0Ef00OOo6eqjV/DEHdIl
         VePH8PdRdktf3PkvV/NVObaWbkzjhd+kLjOjBiB3nWALyWKZ2LyIKf8oXLuzRvbTbiZv
         OGSg==
X-Gm-Message-State: AOAM532yk/d0ZcyYRrbmz1rnrb7e1gy7bpXoKdVTAj/sDdMN5Jn7XJIa
        s/ZED0AHANc+BqySVu6cm+8PTw==
X-Google-Smtp-Source: ABdhPJx8UdeUgoUtHGGn9mgxXZu5qrGkFYtzQTF9umijJZfwGuuTFS/MsOT6GwSa2FPyLrvx70gJsw==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr27658572wmb.28.1636100703566;
        Fri, 05 Nov 2021 01:25:03 -0700 (PDT)
Received: from localhost (5.186.126.13.cgn.fibianet.dk. [5.186.126.13])
        by smtp.gmail.com with ESMTPSA id r17sm3448703wmq.5.2021.11.05.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 01:25:02 -0700 (PDT)
Date:   Fri, 5 Nov 2021 09:25:01 +0100
From:   "javier@javigon.com" <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Message-ID: <20211105082501.ltdfepz6inrffiux@mpHalley-2>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104071439.GA21927@lst.de>
 <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
 <20211104173235.GI2237511@magnolia>
 <20211104173431.GA31740@lst.de>
 <20211104223736.GA2655721@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211104223736.GA2655721@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04.11.2021 15:37, Keith Busch wrote:
>On Thu, Nov 04, 2021 at 06:34:31PM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 04, 2021 at 10:32:35AM -0700, Darrick J. Wong wrote:
>> > I also wonder if it would be useful (since we're already having a
>> > discussion elsewhere about data integrity syscalls for pmem) to be able
>> > to call this sort of thing against files?  In which case we'd want
>> > another preadv2 flag or something, and then plumb all that through the
>> > vfs/iomap as needed?
>>
>> IFF we do this (can't answer if there is a need) we should not
>> overload read with it.  It is an operation that does not return
>> data but just a status, so let's not get into that mess.
>
>If there is a need for this, a new io_uring opcode seems like the
>appropirate user facing interface for it.

+1 to this. I was looking at the patchset yesterday and this was one of
the questions I had. Any reasons to not do it this way Chaitanya?

