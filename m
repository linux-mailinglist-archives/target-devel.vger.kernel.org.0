Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F631A0BDF
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgDGK3m (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Apr 2020 06:29:42 -0400
Received: from mout02.posteo.de ([185.67.36.66]:44861 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgDGK3l (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:29:41 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 785F12400FD
        for <target-devel@vger.kernel.org>; Tue,  7 Apr 2020 12:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1586255379; bh=ZA0/1A/mItsSVAVQa6vOfxiHl95oxvcT2ndCS8YTPtg=;
        h=Subject:To:Cc:From:Date:From;
        b=Fc2uwlzZsssitzB+C607k6/nNntRCm9tqlPjEBBvJLjrp1eZqI7Ocz2wDC5M0mGpz
         oPatblrW3lBW23vKoDImqreMncPxR1B7+S9zkh/UPfacHvDK53xOfPOHNWblmLL9Jn
         Lw5Nr4cRj7kR7AUprEmMh6pp1bRZ0K7QuWEvbSRH1Tkd5I47XntONdlNi8rAnK+8dM
         0wQ4H6xrk9i64KbquYlU+Om6bxQk1ufQRsbz2Vu5RX25rreKzDd+2c7oS/LQ64ZjYf
         4xHpX0ZzFEK/YaHrUq7j+YYA5d4Tffj6p0+1uzdOzqWGHwlQYEOpLVTWckdfqcYZ8M
         SP/6/H5mk4FeA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48xNv66mXYz9rxG;
        Tue,  7 Apr 2020 12:29:38 +0200 (CEST)
Subject: Re: strange dm-crypt problem with qemu / LIO / vhost
To:     David Disseldorp <ddiss@suse.de>
Cc:     target-devel@vger.kernel.org
References: <5e29cc94-a21d-2506-9bac-48d8d29ab85b@posteo.de>
 <20200406233347.5c764427@suse.de>
 <b05a9703-673b-8a14-c274-69258f28879b@posteo.de>
 <20200407010508.70bd36c6@suse.de>
From:   Andreas Kinzler <hfp@posteo.de>
Message-ID: <3660ac9e-92d4-3752-2c7d-d984f3e681a8@posteo.de>
Date:   Tue, 7 Apr 2020 12:29:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407010508.70bd36c6@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hello David,

>> In the meantime, I was able to debug further. Actually in Windows only
>> the "format disk" operation fails. If you do that otherwise and later
>> use the formatted disk, it seems to work. So I assume it is a special
>> SCSI opcode that is only used during "format disk" that fails.
> You could print the SCSI opcode value with something like:

Thanks for the help. I was able to find the root cause. To avoid 
duplication with the issue tracker of the kvm-guest drivers, here is the 
link to my findings:

https://github.com/virtio-win/kvm-guest-drivers-windows/issues/446

Please feel free to add more comments to remaining open questions there.
Especially about the question of alignment in BIOs.

Regards Andreas
