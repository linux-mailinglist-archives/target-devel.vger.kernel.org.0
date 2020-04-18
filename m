Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182331AF407
	for <lists+target-devel@lfdr.de>; Sat, 18 Apr 2020 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgDRS7u (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 18 Apr 2020 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbgDRS7u (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:59:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2384CC061A0C
        for <target-devel@vger.kernel.org>; Sat, 18 Apr 2020 11:59:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rh22so4246203ejb.12
        for <target-devel@vger.kernel.org>; Sat, 18 Apr 2020 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJRI8oZ6j+rGEg2+OCymOS7794uvyRZcSR2Htjt5TI4=;
        b=Dab8X2CtWipiSivi9nyLxp8nBHQpWedKwzW35yNj8kBU3VxCHrB+3Kn5U3rtIjeKoA
         Lw3k/ndceMaBnN8HktM5POukz2zYdQKxOk+s6N6D5bBob3ys4IoAy4L7IIPc1NiF89LI
         qpPs2HFFi+SoqSVPJ7yi1QNfgGKP7Teiklti0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJRI8oZ6j+rGEg2+OCymOS7794uvyRZcSR2Htjt5TI4=;
        b=iSKRM/IisHobyawg/7rpXl0gBnoxk0wbBf2CA/AyydFKz8azow+T2ycwxc37O1EYwe
         D/CNncQfYWLWBoivbi8J1K0wN6gTF136JfOUbw368hhy9PCvDGsPKxPzH9f3JG4Q3Rny
         Hv4yL8mRzVEufrlLArfoJixHi/TxOmWs6U701g82OatiROChPixpeakTMI33fgCOLjk9
         DkuFlx7wVzjwzwxNqAyW83nHMPNAWjHxB8p8UfP97pJvohnNQD0xhakDScJRio3GJxhY
         wqB0hO1ojhKGck2+KfJqbayc+h/E1WF9YagC4eLlKElU5cDzOFEPHQgShm5wF7IlRi5h
         m3yw==
X-Gm-Message-State: AGi0PubfkI9ikvCVwz3q6VGEL1FIqMi/vu8wPjiSvgopD/LV/B5BDzKP
        LObSn9hXhxboF0OYwqvJYNTw4rVP+MQ=
X-Google-Smtp-Source: APiQypLu4CZiSYa4mwot+78NkupdTsxNZ188STAFzvf+evdX/N0CxKEfe3pRGtSMeF/w2eLmn5ybuA==
X-Received: by 2002:a17:906:f106:: with SMTP id gv6mr9164460ejb.271.1587236388457;
        Sat, 18 Apr 2020 11:59:48 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id l2sm3514360ejz.29.2020.04.18.11.59.48
        for <target-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 11:59:48 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id gr25so4262514ejb.10
        for <target-devel@vger.kernel.org>; Sat, 18 Apr 2020 11:59:48 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr5483360lfk.192.1587235998911;
 Sat, 18 Apr 2020 11:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200418184111.13401-1-rdunlap@infradead.org> <20200418184111.13401-3-rdunlap@infradead.org>
In-Reply-To: <20200418184111.13401-3-rdunlap@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Apr 2020 11:53:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Message-ID: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Subject: Re: [PATCH 2/9] fs: fix empty-body warning in posix_acl.c
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>,
        Zzy Wysm <zzy@zzywysm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix gcc empty-body warning when -Wextra is used:

Please don't do this.

First off, "do_empty()" adds nothing but confusion. Now it
syntactically looks like it does something, and it's a new pattern to
everybody. I've never seen it before.

Secondly, even if we were to do this, then the patch would be wrong:

>         if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
> -               /* fall through */ ;
> +               do_empty(); /* fall through */

That comment made little sense before, but it makes _no_ sense now.

What fall-through? I'm guessing it meant to say "nothing", and
somebody was confused. With "do_empty()", it's even more confusing.

Thirdly, there's a *reason* why "-Wextra" isn't used.

The warnings enabled by -Wextra are usually complete garbage, and
trying to fix them often makes the code worse. Exactly like here.

             Linus
