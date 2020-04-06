Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14B1A008D
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 00:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDFWBy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 6 Apr 2020 18:01:54 -0400
Received: from mout02.posteo.de ([185.67.36.66]:40201 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgDFWBy (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:01:54 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 60F0A2400FE
        for <target-devel@vger.kernel.org>; Tue,  7 Apr 2020 00:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1586210512; bh=dRDQZV0sY4oTvURafp17rP/Rdahy0x5E7zk5sOviauo=;
        h=Subject:To:Cc:From:Date:From;
        b=SgHB9S5IUWou9qplQ7petaAs0q2AIy3SDfivru/iUuR8WoEGMnf3jL75H4TMUJffq
         upwX2ciuIW2vRIkx//Lj49Y6wvKPcBD3ibVjCyLk91twLTg35A6gB5eQApd6kuatdi
         1UQJ5o/V8vZDY3UavsN369j/jWDiqpKRCySgT3mBvQ/tujhRDsjsdoZFCZcsuvhiLA
         YrFjSzl4QR9r04ARpzaf+/DHkWoPvBrdIhb4mKOp+DThbbMyCeAIroZzMXSvWFQDWU
         Dhjsvo6Qc4RJcm7X3O5CCEU8yxMbVd9oaM7xWGCVYy8MZoaOJGIYu5QCIb1PTPAf8F
         b0Yc9jT5ovYxQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48x4JH53kDz9rxM;
        Tue,  7 Apr 2020 00:01:51 +0200 (CEST)
Subject: Re: strange dm-crypt problem with qemu / LIO / vhost
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org
References: <5e29cc94-a21d-2506-9bac-48d8d29ab85b@posteo.de>
 <20200406233347.5c764427@suse.de>
From:   Andreas Kinzler <hfp@posteo.de>
Message-ID: <b05a9703-673b-8a14-c274-69258f28879b@posteo.de>
Date:   Tue, 7 Apr 2020 00:01:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406233347.5c764427@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hello David,

> It's normally a good idea to provide your kernel version with any
> bug reports...

Sorry. Kernel is 5.3.18 vanilla from kernel.org

>> [ 3683.414936] bio error: 0000000024d02dea,  err: 10
>> This is from target_core_iblock.c function "iblock_bio_done".
>> Any ideas? Hints?
> This looks like an I/O error from the block layer / underlying dm-crypt
> block device. It's not much to go on, but I'd suggest tracing the I/O
> further down the stack.

In the meantime, I was able to debug further. Actually in Windows only 
the "format disk" operation fails. If you do that otherwise and later 
use the formatted disk, it seems to work. So I assume it is a special 
SCSI opcode that is only used during "format disk" that fails.

What would be a simple debug statement in iblock_bio_done to print the 
SCSI opcode to find out which operation failed?

> Cheers, David

Regards Andreas
