Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38577A2665
	for <lists+target-devel@lfdr.de>; Thu, 29 Aug 2019 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfH2Ssj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Aug 2019 14:48:39 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44507 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfH2Ssj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:48:39 -0400
Received: by mail-lj1-f182.google.com with SMTP id e24so4026255ljg.11
        for <target-devel@vger.kernel.org>; Thu, 29 Aug 2019 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S21SwnbnpmLxuJCG4QnXTZUivK/9Tf1xBxvyErmvyg0=;
        b=XGaCB7iw6sz8FnQPCGZOaWP+piCBWJBQdzmvdwlV+J6lcF3+ko/EKZRWxnoAxXXLTQ
         2F38bi0VzfhD5Sfrgo8jr6fZD6V9JewHfXRlW/dbkjJuWO2PPYWn3/BV9rgySfmbW9wl
         +jVzXeYD3lBq4/rsb1lMgWJYDg0Ang7n5WIic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S21SwnbnpmLxuJCG4QnXTZUivK/9Tf1xBxvyErmvyg0=;
        b=HmXI+9tWnitUJdNqp+zF3Usd9O8lPzfqoeVnBHHMDupSKCYTGOxjMhNcOTzwW14DK2
         bLojEBlqPJ6uZ+Ubfze3vy9BCySmV/cIEUgLIqNB2AJLZDcCSliStA2Vyu8BJQemR7mL
         A0UBjaHjCNbNAclLu1ha1JVV4hcz7w7ATyJdGbP9NzxapAe8o6Xegru7Kto8aqw196zH
         8o8dEZNP29fFrwvZMW+nDyjUZtMoCHFRD5Mb085BDfc+9oH3gwuEyJQjepBCn2UVm+FG
         EfrQ/NlGQyquqtYGdCrriHKxIKrD/6SQf44MWAvUZsMxnfMXAzMkQ0QhQxR7LGrP/Kj6
         RzMg==
X-Gm-Message-State: APjAAAXVRtcyy3Ud5ufjjD8+UzUKWryndmPi7oSWQG/EDf2R7HCOOG8q
        /E371JqMTvR8A/5un5NdZMkUUeIUfR4=
X-Google-Smtp-Source: APXvYqyk1Ad2q+KJn6gDcYSPo9m5xoYJzaYfQGHOVJppGTntmnwoO315aVdECtoT3vFUo97qw4BVyA==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr6398244lji.174.1567104517027;
        Thu, 29 Aug 2019 11:48:37 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id o26sm518488lfi.51.2019.08.29.11.48.35
        for <target-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 11:48:36 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e27so4037985ljb.7
        for <target-devel@vger.kernel.org>; Thu, 29 Aug 2019 11:48:35 -0700 (PDT)
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr6344315lja.180.1567104515623;
 Thu, 29 Aug 2019 11:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
 <20190722114700.GE3089@kadam> <20190722115010.GF3089@kadam>
 <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
 <20190802073057.GD26174@kroah.com> <5d49567f.1c69fb81.97950.e58aSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5d49567f.1c69fb81.97950.e58aSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Aug 2019 11:48:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQeKWHW0bQ1aV5=2ivbD-WWDHcBBJ_cX5R75iiNNq2uA@mail.gmail.com>
Message-ID: <CAHk-=wgQeKWHW0bQ1aV5=2ivbD-WWDHcBBJ_cX5R75iiNNq2uA@mail.gmail.com>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
To:     laokz <laokz@foxmail.com>
Cc:     Greg KH <greg@kroah.com>, Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        stefani <stefani@seibold.net>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, Aug 6, 2019 at 3:29 AM laokz <laokz@foxmail.com> wrote:
>
> Sorry for the late reply. I didn't submit any patch, for as newbie I wasn't
> quite sure about the severity of this issue. The developers may do their
> choice.

It does seem pretty bad.

Also, INIT_KFIFO() and DECLARE_KFIFO() should probably have a

     BUILD_BUG_ON(!__is_kfifo_ptr && !is_power_of_2(ARRAY_SIZE(__tmp->buf)));

or something. Probably worth indirection through a helper macro to set
the ".mask" field.

And yes, commit dfe2a77fd243 ("kfifo: fix kfifo_alloc() and
kfifo_init()") seems wrong, It's fine for the __kfifo_alloc() case
where we actually allocate the rounded-up size, but it's completely
wrong for the __kfifo_init() case where somebody _else_ allocated the
size.

So the kfifo_init() case needs to just use a round_down, and possibly
add a WARN_ON_ONCE() too.

Anybody?

             Linus
