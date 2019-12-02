Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E810EF68
	for <lists+target-devel@lfdr.de>; Mon,  2 Dec 2019 19:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLBSm1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 2 Dec 2019 13:42:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39098 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBSm1 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:42:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so636680oib.6
        for <target-devel@vger.kernel.org>; Mon, 02 Dec 2019 10:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hnWxYJS6UwvHgZfL5C7ZAjZ6VkkzMMU7kmsT3ouMqc=;
        b=sWeec0pqiWKAQx6GsxOcoExatEOX6Ri6zErHouUpuNZpUk/3VfbcqEwSFH7asbdMSf
         d4f2fjQLHSCzDMPSVv4Cn/X9DfYRH+7UAPZPnqRzxcPG46x+TDGPpFyXwer35ezQhlJC
         cnsd6L+RkdSCVCJtC7novckEhsoBhoIBfGAkkLXORzSyiK36mGhxkTIyLbbuOI6iZPNM
         g/qHMLGvVlTGuNrea+fojo24uRyvurwCb4yjtIiMp71WlWOqRbVb349azrXNKpjzRmHK
         Cs9K6yF5HNIaOX3UyeOY/WPL1fGhP+Rl8wUvORPSkfMgAMmfnOzO4ApZlbRiDzwCDf4Y
         4XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hnWxYJS6UwvHgZfL5C7ZAjZ6VkkzMMU7kmsT3ouMqc=;
        b=WNSYmzA25nFnx8o7rpgJ6YMqoCmJ/MrxwrgZmJOZSim4tlM69sK80HcMkJ7N7DRY0e
         m1+hU4RMeAmewuGnnJYPRRQMju0LtrrEWJUaiiVn8z5b1AAXUKeVoKlSIpBqmDaGr0+r
         tOrY08po3QwSfQ+F9mdyPvRQY695ntSKozB756Yyk7cj5lVsbXtJEYMAzMHOKS1sQC9M
         KMJj3fWHxdn49upLhxDb8Mcqoaow3gKOMDo9bXfMdwTPZlDGCccTTv1grMheyG+OkFFG
         Q9HSwWIhT8g1bfcQLTLCCtQ5CF2BrI0CYE9T/zhlVlqnIExl+3kv0zx8+OviX4jRTcQk
         GP2Q==
X-Gm-Message-State: APjAAAVCS+ixlUbtZhqPV+7aqN4LKVMc5UY6A2o/4jzHFcKIaUvj6qad
        s/x9971tnu3/d32ifCHkce6B9+whiYPGEOv7GEatIw==
X-Google-Smtp-Source: APXvYqxtoqDm0j7pzYiqmwJ79qHV4hqM09C5CPP7ue5y+F2n1QpcowgAf6qc+AUIL/MdTjBqctZ4jZ5qS8oYDDkHW6c=
X-Received: by 2002:aca:4e90:: with SMTP id c138mr359970oib.147.1575312146080;
 Mon, 02 Dec 2019 10:42:26 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p> <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p> <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p>
In-Reply-To: <20191128091210.GC15549@ming.t460p>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Mon, 2 Dec 2019 13:42:15 -0500
Message-ID: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
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

Hi Ming,

> I may get one machine with Mellanox NIC, is it easy to setup & reproduce
> just in the local machine(both host and target are setup on same machine)?

Yes, I have reproduced locally on one machine (using the IP address of
the Mellanox NIC as the target IP), with iser enabled on the target,
and iscsiadm connected via iser.

e.g.:
target:
/iscsi/iqn.20.../0.0.0.0:3260> enable_iser true
iSER enable now: True

  | |   o- portals
....................................................................................................
[Portals: 1]
  | |     o- 0.0.0.0:3260
...................................................................................................
[iser]

client:
# iscsiadm -m node -o update --targetname <target> -n
iface.transport_name -v iser
# iscsiadm -m node --targetname <target> --login
# iscsiadm -m session
iser: [3] 172.16.XX.XX:3260,1
iqn.2003-01.org.linux-iscsi.x8664:sn.c46c084919b0 (non-flash)

> Please try to trace bio_add_page() a bit via 'bpftrace ./ilo.bt'.

Here is the output of this trace from a failed run:

# bpftrace lio.bt
modprobe: FATAL: Module kheaders not found.
Attaching 3 probes...
512 76
4096 0
4096 0
4096 0
4096 76
512 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
4096 0
^C

@start[14475]: 0
@start[14384]: 0
@start[6764]: 0
@start[14477]: 0
@start[7771]: 0
@start[13788]: 0
@start[6879]: 0
@start[11842]: 0
@start[7765]: 0
@start[7782]: 0
@start[14476]: 0
@start[14385]: 0
@start[14474]: 0
@start[11564]: 0
@start[7753]: 0
@start[7786]: 0
@start[7791]: 0
@start[6878]: 0
@start[7411]: 0
@start[14473]: 0
@start[11563]: 0
@start[7681]: 0
@start[7756]: 0


Thanks,
Steve
