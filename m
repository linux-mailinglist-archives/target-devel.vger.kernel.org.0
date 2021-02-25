Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D0E324279
	for <lists+target-devel@lfdr.de>; Wed, 24 Feb 2021 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhBXQtM (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 24 Feb 2021 11:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhBXQtF (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:49:05 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A85C061786
        for <target-devel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:23 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 74so2705931iob.0
        for <target-devel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1+mpX7zx0n4pKPlEw3hBAnsSTnEgaecbMXBQXh8Z37U=;
        b=bJRnx9a0JrFxWlYgyk2jyiRpJPQJNXNMPWbL5EnUxyVSch3NY812m+zPkaOOeQG9gE
         rs0rCo0fJuj/glleu3wdzyZ1sbMyHYwsV5BHTbcMpvcNSEN1VzYR9JpF1EJFbPokIpRP
         pQFA9x0cFcUm+wj/d9C7MittCB6Pzu9NBrIWj0+f0KwN2z25gJ9NY8wag2SjQO0ua0ev
         ZVb26i7aH9IF/twGU677bbnoqNxjoX/YznSaZOR126/+xhxo8OHS4QMUdKCTDjp0BRQo
         RNRen7wNfFOzqDylSea/+a0RlJ08r6OWvecZNFxJhZUCe5oZYOK06fy2FnZ88SyWM37D
         dX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+mpX7zx0n4pKPlEw3hBAnsSTnEgaecbMXBQXh8Z37U=;
        b=O2GgoIy7dxa65HeL/MPgBoAiQFD3nQXBXbois+cy3EpkCZnNH2qfeY9hbOddh7d/TK
         wYrYwUTjDWKa/cGQoyFrACbTiGtU4fd4NUT4ZxSBIO3GqOiEVQ7FtqF9W0I4h1HC0dz/
         aaIwJ/ghq88lf1Sj0BHMOie3N8cHdTv/tW4Sj+F8FjrKZ94p43qNQ4egItW/yMTX29I2
         3cunHt/HnwO0W568zDzJoC3n7ADwRz3Y9XtK3PjYhujK8xzDc5ASp2cAdz2TFHG6GNVa
         MCIihSxgVEoVZxx+0DxxnJz0LztOf3t/h1/axVpcNzxD/qRtr7Aite4FBCWIHsCmR6oG
         vcPw==
X-Gm-Message-State: AOAM533p4vWmMBpZTFm5HFvYVU6QFgzIpOX/mXasYD2Y1cGyB9EtQI5d
        qKXZimdNTZO8lM8x2rHVnCZYxA==
X-Google-Smtp-Source: ABdhPJwss97019ILy/7qQcv1GNjekopW38KQaiSTkiRj6pTu3XozM6UbMn7yxILO9vbNkFv7yo9ZjA==
X-Received: by 2002:a02:1c49:: with SMTP id c70mr34122809jac.136.1614185303233;
        Wed, 24 Feb 2021 08:48:23 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m15sm1760501ilh.6.2021.02.24.08.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 08:48:22 -0800 (PST)
Subject: Re: [RFC PATCH] blk-core: remove blk_put_request()
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        fujita.tomonori@lab.ntt.co.jp, tim@cyberelk.net, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, davem@davemloft.net,
        bp@alien8.de, agk@redhat.com, snitzer@redhat.com,
        ulf.hansson@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dgilbert@interlog.com,
        Kai.Makisara@kolumbus.fi, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bfields@fieldses.org, chuck.lever@oracle.com,
        baolin.wang@linaro.org, vbadigan@codeaurora.org, zliua@micron.com,
        richard.peng@oppo.com, guoqing.jiang@cloud.ionos.com,
        stanley.chu@mediatek.com, cang@codeaurora.org,
        asutoshd@codeaurora.org, beanhuo@micron.com, jaegeuk@kernel.org
References: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
 <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3141eb3-9938-a216-a9f8-cb193589a657@kernel.dk>
Date:   Wed, 24 Feb 2021 09:48:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2/24/21 4:53 AM, Stefan Hajnoczi wrote:
> On Mon, Feb 22, 2021 at 01:11:15PM -0800, Chaitanya Kulkarni wrote:
>> The function blk_put_request() is just a wrapper to
>> blk_mq_free_request(), remove the unnecessary wrapper.
>>
>> Any feedback is welcome on this RFC.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>  block/blk-core.c                   |  6 ------
>>  block/blk-merge.c                  |  2 +-
>>  block/bsg-lib.c                    |  4 ++--
>>  block/bsg.c                        |  4 ++--
>>  block/scsi_ioctl.c                 |  6 +++---
>>  drivers/block/paride/pd.c          |  2 +-
>>  drivers/block/pktcdvd.c            |  2 +-
>>  drivers/block/virtio_blk.c         |  2 +-
>>  drivers/cdrom/cdrom.c              |  4 ++--
>>  drivers/ide/ide-atapi.c            |  2 +-
>>  drivers/ide/ide-cd.c               |  4 ++--
>>  drivers/ide/ide-cd_ioctl.c         |  2 +-
>>  drivers/ide/ide-devsets.c          |  2 +-
>>  drivers/ide/ide-disk.c             |  2 +-
>>  drivers/ide/ide-ioctls.c           |  4 ++--
>>  drivers/ide/ide-park.c             |  2 +-
>>  drivers/ide/ide-pm.c               |  4 ++--
>>  drivers/ide/ide-tape.c             |  2 +-
>>  drivers/ide/ide-taskfile.c         |  2 +-
>>  drivers/md/dm-mpath.c              |  2 +-
>>  drivers/mmc/core/block.c           | 10 +++++-----
>>  drivers/scsi/scsi_error.c          |  2 +-
>>  drivers/scsi/scsi_lib.c            |  2 +-
>>  drivers/scsi/sg.c                  |  6 +++---
>>  drivers/scsi/st.c                  |  4 ++--
>>  drivers/scsi/ufs/ufshcd.c          |  6 +++---
>>  drivers/target/target_core_pscsi.c |  4 ++--
>>  fs/nfsd/blocklayout.c              |  4 ++--
>>  include/linux/blkdev.h             |  1 -
>>  29 files changed, 46 insertions(+), 53 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index fc60ff208497..1754f5e7cc80 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -642,12 +642,6 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
>>  }
>>  EXPORT_SYMBOL(blk_get_request);
>>  
>> -void blk_put_request(struct request *req)
>> -{
>> -	blk_mq_free_request(req);
>> -}
>> -EXPORT_SYMBOL(blk_put_request);
> 
> blk_get_request() still exists after this patch. A "get" API usually has
> a corresponding "put" API. I'm not sure this patch helps the consistency
> and clarity of the code.
> 
> If you do go ahead, please update the blk_get_request() doc comment
> explicitly mentioning that blk_mq_free_request() needs to be called.

Would make sense to rename blk_get_request() to blk_mq_alloc_request()
and then we have API symmetry. The get/put don't make sense when there
are no references involved.

But it's a lot of churn for very little reward, which is always kind
of annoying. Especially for the person that has to carry the patches.

-- 
Jens Axboe

