Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF15719CAB6
	for <lists+target-devel@lfdr.de>; Thu,  2 Apr 2020 22:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgDBUCK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 2 Apr 2020 16:02:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41772 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbgDBUCK (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:02:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id f52so4813152otf.8
        for <target-devel@vger.kernel.org>; Thu, 02 Apr 2020 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIcTkXTYRJR7AtlYCnt8yyQTGfCnZqsJuGJxqpgkmWk=;
        b=dh7k8KqrHO8RsZZcBBC7/e9Aj7AN0uIqboJx7ddXMEhaGUzLcJp0up3Yujz3ByXiAS
         deMiC0OJWIR1Cw/zf7wd09TNfCrcgH6X4Uhl6CTjViDBxH3t34s4RZGJpY6I67HHRiBk
         4L0xZeX2kaoWUwpkBIXAxNPyN3+ccoBteoccQeaXPwvzx2aOO832sLcQk1zQCOamB+vi
         P7oqqRydM5H3jtolnEq06SEYxejeh46f342EhKZ7Unqo3NUG4pzYOZQYsumeW6R3mmyW
         TCNG68rXkGdvXNCyMdIF2QqCVO60fuf4n4QjE5heTPnAirkyySG+/DC+E/DFjN0iFbm2
         Dt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIcTkXTYRJR7AtlYCnt8yyQTGfCnZqsJuGJxqpgkmWk=;
        b=MN4wX7ld1tOYet9cIDEBpaJoiHHR/DczGeMibbmEk0TysVXJRtG8JGX3qX9VL4OPPa
         WWhm+LZX43lXkm4R6MVrIsBOVqLwI0aRENHymfgsamYTETiyGmPsTbuKj8KRaR0DmkbF
         XXHhl8iTf1OU7rmZpVkUOsx8GhpuVM5db6bpS/V+HUWQ3JTg0luF9l9EuLPlnHsJrKFP
         jxuW4ybswko8QfPV3lE3tVVQlvMEN7sw/O5LLu3RI7UrssPkef0X4hjValln/MuGb86w
         pvsVvbn0i2hK12s/Xn5YtiPXqCxKGLibz5geMN/9h/Kq2XUaBvyR9o2vCKfz5z7+GgnE
         V3Zg==
X-Gm-Message-State: AGi0PuaHWvHNNs7T6bRJoofw7Hgt5AaGfcDsF9UUHVwXY8QJwjacdhib
        oPM1eh00GV90UdRWA73ZpI7p1WYBw86+OqdX3cjpsg==
X-Google-Smtp-Source: APiQypJFrqNt8RtRbjyzYOGmuL7Yn51xEcFdM0RPgRLwDEEb4JyqAU3ggvGCnBaYzGaKql2zs9wMkwPpg1qBjuUq4tM=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr3947879oto.266.1585857728074;
 Thu, 02 Apr 2020 13:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p> <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p> <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p> <d9d39d10-d3f3-f2d8-b32e-96896ba0cdb2@grimberg.me>
 <CAAFE1beqFBQS_zVYEXFTD2qu8PAF9hBSW4j1k9ZD6MhU_gWg5Q@mail.gmail.com>
 <d2f633f1-57ef-4618-c3a6-c5ff0afead5b@grimberg.me> <CAAFE1bdAbKfqbf05pKBcMUj+58fijDMT-8WBSuwiKk2Bmm4v2w@mail.gmail.com>
 <95750c05-eb49-d1db-311f-4edf9b4fd6ec@grimberg.me>
In-Reply-To: <95750c05-eb49-d1db-311f-4edf9b4fd6ec@grimberg.me>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Thu, 2 Apr 2020 16:03:15 -0400
Message-ID: <CAAFE1bcmFxb6MYbicUVdVsK6QNjweaow3v+vHe6szwfFN6K-=A@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Sagi,

> Does the attached patch work for you?

This patch _does_ work for our tests. I see all the writes aligned to
512 bytes as, I think, would be expected. Thanks!


Just for your information, using the bpftrace script earlier in this
thread, the output is as follows. The lines with 2 values shows the
first two arguments to 'bio_add_page()', the lines with 4 values shows
the first 4 arguments to `brd_do_bvec()`.

For the successful case on the new patch:

# bpftrace isert.bt
Attaching 4 probes...
512 3072
512 3072 1 131071
4096 0
4096 0 0 0
4096 0
4096 0 0 8
4096 0
4096 0 0 131064
4096 512
3584 512 1 131064
512 0 1 131071
512 0
512 0 0 131071


And for the failed case on the older unpatched code:

# bpftrace ./isert.bt
Attaching 4 probes...
512 76
512 76 1 131071
4096 0
4096 0 0 0
4096 0
4096 0 0 8
4096 0
4096 0 0 131064
4096 76
4020 76 1 131064
76 0 1 131071
512 0
512 0 0 131071


Thanks again!
Steve
