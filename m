Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71520170787
	for <lists+target-devel@lfdr.de>; Wed, 26 Feb 2020 19:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBZSWH (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 26 Feb 2020 13:22:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40281 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBZSWG (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:22:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so335129otr.7
        for <target-devel@vger.kernel.org>; Wed, 26 Feb 2020 10:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pjwDLlXU2xiM2aUT6ukSYLUx9sBybM2+bEK2Iocwnow=;
        b=Fn5rKlPn9goVWr2xULRdrKDePJoV2V33Wyp3EIjT04k1hAsTW62fwZgiIWjkGDEvrS
         q9RCW8y9yHFLJ6zeAkj3jCIuJBR78fKUK9XjzVpBqRPhC2OfJoax/Gnun9fNqT/QyZ1K
         ljRYtWcJIJPGaitqRwicH+nyFa9DNoGZMBHpgyQ10WWWTWLrZnURwJ/cr+Wr31PC294Z
         qCQToaRcdClg+WGCTrMUaqiruPk0yEewVHSvINiF6VGd5Ac6VAY/rpuIRhb192wDfTU3
         q5VB3mGgbYZX2IDiBpVrtzgbFe1Dnl9QiFpdUY0IynGm57kS9rqZkttnhc+zTucxV3Jh
         qviw==
X-Gm-Message-State: APjAAAVcACJ0+7Dbfe51nlZ2vAgf/4aqTrYGlG2Va6iU3+/c4PO+kj65
        O9d2VUbIO1Cekf8U7isDKjI=
X-Google-Smtp-Source: APXvYqxDjw9c6iQORlRGKW0U+VXmtCIoTFagj7cKSD2nvoHLGHXys2a/CtvZXhQS/Mx2Fdv5bMAoeA==
X-Received: by 2002:a9d:7593:: with SMTP id s19mr32133otk.219.1582741325751;
        Wed, 26 Feb 2020 10:22:05 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id w20sm1026228otj.21.2020.02.26.10.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 10:22:04 -0800 (PST)
Subject: Re: Connection errors with ISER IO
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        target-devel@vger.kernel.org
Cc:     maxg@mellanox.com, martin.petersen@oracle.com
References: <20200226155241.GA28594@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d655f85f-d910-a77b-1672-0fbb919e5d9a@grimberg.me>
Date:   Wed, 26 Feb 2020 10:22:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226155241.GA28594@chelsio.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


> Hi All,
> I observe connection errors almost immediately after I start iozone over iser
> luns. Atached are the connection error and hung task traces on initator and
> target respecively.
> Interestingly, I see connection errors only if LUN size is less than 512MB.
> In my case I could consistently reproduce the issue with 511MB LUN and 300MB
> lun size. Connections errors are not seen if I create 512MB or greated LUN.

Can you share log output on the target to before hung tasks?

> Further, after the connection errors, I noticed that the poll work queue is
> stuck and never processes drain CQE resulting in hung tasks on the target side.

Is the drain CQE actually generated?

> I tried changing the CQ poll workqueue to be UNBOUND but it did not fix the issue.
> 
> Here is what my test does:
> Create 8 targets with 511MB lun each, login and format disks to ext3, mount the
> disks and run iozone over them.
> #iozone -a -I -+d -g 256m

Does it happen specifically with iozone? or can dd/fio also reproduce 
this issue? on which I/O pattern do you see the issue?

> I am not sure how LUN size could cause the connection errors. I appreciate any
> inputs on this.

I imagine that a single LUN is enough to reproduce the issue?

btw, I tried reproducing the issue with rxe (couldn't setup an iser
listener with siw) in 2 VMs on my laptop using lio to a file backend but
I cannot reproduce the issue..
