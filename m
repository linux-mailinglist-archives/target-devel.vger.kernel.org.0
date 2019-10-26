Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754CEE5DEF
	for <lists+target-devel@lfdr.de>; Sat, 26 Oct 2019 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfJZPdF (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 26 Oct 2019 11:33:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45846 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfJZPdE (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 26 Oct 2019 11:33:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so5462968wrs.12
        for <target-devel@vger.kernel.org>; Sat, 26 Oct 2019 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGdWPWmfy5G5iGlvLqrZGfsx1lbBPO3KFEH/TcG/jVw=;
        b=Ev4Dh0S/UcWiNBPuX4DfPWofdmpwenndNC6NsXAG1RhupnJWieIgGtxeIn544cfCCE
         Rec2TTspBgQGrCDe1QOfS8ugi/S3MwVegrXD/JpZT+H6vcn/7LKC4mcGQohvMhSyrsml
         FcWHMbJv0I6GnKEttROFs+cQdqUk9ZVfElDQj9EytlioiZT126V557rEuAn748e5nhBM
         O22hYCfL951ozqCMN7/2yE5AgxqE3Dyc3UPWVAqUiMYwbaFOPvvDJneUsgit4EOWfcp7
         g+6MUnF8JkqHIN6QTqonYFkx4TNEEHs5WQiCrLDEJuL1KnscVxe5TXlAgFcKVfRT7mbS
         SyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGdWPWmfy5G5iGlvLqrZGfsx1lbBPO3KFEH/TcG/jVw=;
        b=toJEMyhPB1HQRjbxLE7wg8CqODpBUsLv5QEn3wphL9cZgU92hhL0UftjC08L3S+qfB
         9GyXuRkDYkerD/P0VPz2tyHWcxsg0kfR1802Kg5gVSQFCRfPtqZmV03NpWtkcFQA0Ws/
         tBmQQGLHvB6UakJPjCYJ02C9LgMnHiisstKS09xy8Dd355TRdaDwPwK4ZwRjSt/JqxGT
         oW3JRpZNVDAkt2wUz+kQpyFjUZpH8xtv4kkeN4XYiW+sXQaz4KoI/tcVkx83sPXLYcX5
         hNp6MdEoM4ogRftxUyyedxRG3nYxW+Zzg+9wUJhL61FawXbRKLgcKflMMPyxxuI1W964
         ilxg==
X-Gm-Message-State: APjAAAXVyIL57sF+Yng+4zQ2SBar+HwoXmsnYUZ2ja02bxmUJzOVfkLI
        RYRPIuS+/6+m8vsA1I0QiGStvmuAim4oquPwmZ0=
X-Google-Smtp-Source: APXvYqw3QS1ngiMF6bARt5pQBVW5lF/PaEzC7dhB/tHkTEkF3C6Id0tyRmOJIWor7bTlgZyTME6va4P1KGD7diSG7Ao=
X-Received: by 2002:adf:f686:: with SMTP id v6mr8286925wrp.141.1572103982625;
 Sat, 26 Oct 2019 08:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHTmSeTfOjVDMMtG6mVPKJyRWeMgvnCowq5Uyze=vMzPiQ4S5Q@mail.gmail.com>
 <20191026070305.GA20220@infradead.org>
In-Reply-To: <20191026070305.GA20220@infradead.org>
From:   Thomas <wolverine6218@gmail.com>
Date:   Sat, 26 Oct 2019 08:32:33 -0700
Message-ID: <CAHTmSeRHRW6jaArFMd-DBgYV7b6ebYH2=uPd1y024-++sebjYw@mail.gmail.com>
Subject: Re: Possible LIO crash under heavy ESXi 6.7U3 load with iSCSI
To:     Christoph Hellwig <hch@infradead.org>
Cc:     target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Christoph, are you referring to the fact that I am using ZoL as the
backend? To confirm, are you saying that the LIO community has no
interest in supporting ZoL as a backend device, despite it being in
major distros like Ubuntu? Just want to make sure I understand your
reply fully.


On Sat, Oct 26, 2019 at 12:03 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Please don't report problems using out of tree modules with incompatible
> Licenses to linux lists.  They are entirely your own problem.
