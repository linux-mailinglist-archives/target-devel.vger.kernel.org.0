Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83951E5E24
	for <lists+target-devel@lfdr.de>; Sat, 26 Oct 2019 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfJZRJW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 26 Oct 2019 13:09:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33647 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfJZRJW (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 26 Oct 2019 13:09:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so3124739plk.0
        for <target-devel@vger.kernel.org>; Sat, 26 Oct 2019 10:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+RyuBefV4irzGY/nbkvYZTOHym7/+tRuE943yMc4rsU=;
        b=t0mKqComqoCvg6jSG0/WUN6Q2aXVLwo7LeJ/U29CXuZ0a/CI86tXEeKVzojHgYL4Rc
         turyDLyh8e8DxEifu5jNxbk7gVDtg/PrCRnnOuRI+b3sdsI/Ey62uRqu1iuKgJS2PE0W
         S87pbgNo763fc/Yci45c/sAzvV6BJGHBRme7i3jPvbxvpQUfuPY5m2N5z2NC2sL9aU2r
         gaUddU33njUyH49L8IjpD4kH+629uDTyXH89TL3zVTQSzOEEivsOmPgAW+ME4qxt6hAZ
         TaAfMlYZPCM1KYfTr0SyHgZ7ZS95ZFj2pR3NW1NMLf/b2XVS9T/52bRQYltA9PWJjYax
         sd+g==
X-Gm-Message-State: APjAAAV5qliSQleNkf/eMEKzCtRg+InmqqrPWvLL9vpaXLY11rQ8mreZ
        raEtSfmVg3MhRpGUAKrO9hT97RnT
X-Google-Smtp-Source: APXvYqxOMXgtEyf34p+AjGN1FdydXCgvEgtIXIks7xM1YfZTK94GgGpont15pGbhfmn33j28LgaUDA==
X-Received: by 2002:a17:902:56e:: with SMTP id 101mr10384472plf.90.1572109760932;
        Sat, 26 Oct 2019 10:09:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:bd:487f:db2a:aa6e:f823])
        by smtp.gmail.com with ESMTPSA id b17sm7203740pfr.17.2019.10.26.10.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2019 10:09:19 -0700 (PDT)
Subject: Re: Possible LIO crash under heavy ESXi 6.7U3 load with iSCSI
To:     Thomas <wolverine6218@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     target-devel@vger.kernel.org
References: <CAHTmSeTfOjVDMMtG6mVPKJyRWeMgvnCowq5Uyze=vMzPiQ4S5Q@mail.gmail.com>
 <20191026070305.GA20220@infradead.org>
 <CAHTmSeRHRW6jaArFMd-DBgYV7b6ebYH2=uPd1y024-++sebjYw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <c4d3c949-4d19-5867-f3dc-7b6d2abeabbc@acm.org>
Date:   Sat, 26 Oct 2019 10:09:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAHTmSeRHRW6jaArFMd-DBgYV7b6ebYH2=uPd1y024-++sebjYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2019-10-26 08:32, Thomas wrote:
> Hi Christoph, are you referring to the fact that I am using ZoL as the
> backend? To confirm, are you saying that the LIO community has no
> interest in supporting ZoL as a backend device, despite it being in
> major distros like Ubuntu? Just want to make sure I understand your
> reply fully.

Hi Thomas,

I think Christoph's reply means that you will have some more work to do
before anyone will have a closer look at your report. Bugs encountered
with the Ubuntu kernel should be reported to Canonical. If you
cherry-pick patches on top of that kernel then you are on your own. When
posting a report on a kernel mailing list like target-devel it helps to
grab attention if a bug report is about an unmodified recent upstream
kernel and without having loaded any out-of-tree kernel modules. Because
ZoL is an out-of-tree kernel module it is always behind the latest
kernel API changes. As you probably know API mismatches can be a source
of misbehavior by itself.

Bart.
