Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EBF1A65E0
	for <lists+target-devel@lfdr.de>; Mon, 13 Apr 2020 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgDMLuL (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 13 Apr 2020 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgDMLuC (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:50:02 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 07:50:02 EDT
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132CC03BC8F
        for <target-devel@vger.kernel.org>; Mon, 13 Apr 2020 04:43:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b12so8992744ion.8
        for <target-devel@vger.kernel.org>; Mon, 13 Apr 2020 04:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1ds36DMGg+XEGIlwBFe9RgCHJxWIGiKsCVNzaGEJ22Y=;
        b=gWoRs6amKNiq0mXbGR1d2sWmvYjrawWeRDe8T9ymjgaI6vhetQPFd7m91cXsc2IInt
         DD25yEbvMpblZGmTyG6RhLmb83psqCu5ICqONsbQIPXQbReUU6jihHUtl5QiNpYzxQzX
         q/4tSZT3qtGtMkiTsEXEOcEjXU1KK1GB+uZl76jHImPAF4jBwDWa4/7rTLNNRtXkDjwb
         JFtXw5whxx2dRh/Dv1KpWbO41XTsWgZnF1mib6UyT132PRa7eq/LeNNFVpyP3XDnt4BG
         3zgbE+3I9vZTjpa5LWbXozLM7JpQu2xoxzf6l6ykFCLliSrqCqIKsYkVb+5EFo/O5Zud
         TPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=1ds36DMGg+XEGIlwBFe9RgCHJxWIGiKsCVNzaGEJ22Y=;
        b=Kf4NYzo4rAANLxK3LgtDp4qB4Jx+WvkPdhY9XmLV/1/rX2ZI+21pyJVoq62/RLx5Oz
         R4NXaBadYcG1UJ7lLYLEB7EpPBwI1iPX3eXlL1diSFW3Vb8P3cOj5mH9XyKg0T2/l3ns
         F6Ii2nM6mdrkn2IEkgj5S7T8o86DFkGRDOlASOYC3u1phr1YGxlqpyS2Pi7Kr88z1s7I
         xpmzJkLNjSU21y7nMiBAA9XV5QadMB7vuKJQjztVQS+pNCkw5h2OsJt10gZq121bBmCL
         0yco2jeMhaEsNf0671t/wdReelVLR93Rc8O3fP73LULybiB5jCqOquACV65XWIxtGMMx
         8S2A==
X-Gm-Message-State: AGi0PuZfaZJvr0F8kfhOZPc7Ox9EMyr7UjcQoDepgtmoEhtchJ+PGZY1
        VSohFOAxK4mBZK61kO8DNRJEJDC1iID47GuC6Q==
X-Google-Smtp-Source: APiQypKSQeTPj3lgenseMd+aSYS71+dJhCNyLOTa+zWUA7lJqrflnhIRpnmUjps3M8M0mPmhWbaz8RtDO1I6zVEsEkM=
X-Received: by 2002:a02:6c4a:: with SMTP id w71mr8110288jab.2.1586778209258;
 Mon, 13 Apr 2020 04:43:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5e49:0:0:0:0:0 with HTTP; Mon, 13 Apr 2020 04:43:28
 -0700 (PDT)
Reply-To: mgbenin903@gmail.com
From:   Barrister Robert Richter UN-Attorney at Law Court-Benin 
        <info.zennitbankplcnigerian@gmail.com>
Date:   Mon, 13 Apr 2020 13:43:28 +0200
Message-ID: <CABHzvrkwD2fUnnJ0oQrWEyM9uH6JjG-H4j2cY7u_pKX6haqt-g@mail.gmail.com>
Subject: I have already sent you first payment US$5000.00 this morning through
 MONEY Gram service.it is available to pick up in address now.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

ATTN DEAR BENEFICIARY.

GOOD NEWS.

I have already sent you first payment US$5000.00 this morning through
MONEY Gram service.

So we advise you to Contact This Money Gram office to pick up your
transfer $US5000.00 today.
it is available to pick up in address now.

Note that your compensation payment funds is total amount $US2.800,000
Million Dollars.We have instructed the Money Gram Agent,Mr. James
Gadner to keep sending the transfer to you daily, but the maximum
amount you will be receiving everyday is US$5000.00. Contact Agent now
to pick up your first payment $US5000.00 immediately.

Contact Person, Mr. James Gadner, Dir. Money Gram Benin.
Email: mgbenin903@gmail.com
Telephone Numbers: +229 62819378/ +229 98477762

HERE IS YOUR PAYMENT DETAILS FOR THE FIRST =C2=A3US5000.00 SENT TODAY.

Track View Website link:
https://secure.moneygram.com/track
Sender=E2=80=99s First name: David
Sender=E2=80=99s Last Name: Joiner
Money Transfer Control Number (MTCN) (REFERENCE)# 26046856

Contact the Mmoney Gram Urgent and reconfirm your address to the
office before, they will allow you to pick up the transfer today.

HERE IS WHAT REQUIRED OF YOU.

YOUR FULL NAME---------
ADDRESS--------------
COUNTRY-----------------------------
TELEPHONE NUMBERS-----------------

Note, I paid the transfer fee for you, but only you are required to
send to the office is $75.00 only,Been Your Payment File activation
fee, Send once you contact the office,before you can able to pick up
your transfer today.

Let me know once you pick up first payment today.

Barrister Robert Richter UN-Attorney at Law Court-Benin
