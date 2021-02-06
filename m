Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620AF311DFB
	for <lists+target-devel@lfdr.de>; Sat,  6 Feb 2021 15:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBFOwQ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 6 Feb 2021 09:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBFOwP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:52:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357AC061756
        for <target-devel@vger.kernel.org>; Sat,  6 Feb 2021 06:51:34 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w2so17559181ejk.13
        for <target-devel@vger.kernel.org>; Sat, 06 Feb 2021 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=s8lW6YZWnvUK7Tvlt1e2xFgpS0A6CWOUAqjS+VtrtIak+UPdQ+7l+J3tP9UY5/KPS+
         KEWFn4n6pllGZyrmGfSKElYIwDAKdjc2fmkMPe3ult5JJeZRuMDXiNsKbmA9mOrO+1Ow
         V7G4xUZDBnJ1aF8lRuT9QFBbuDAyoV826qXGwnR1cPhR1hUo5PlVP7FHbHVjqnpB1GNP
         eliTpXHEcIvx4uKGmK0JVzb3zQtQqfYXrL9q0JL/YTDEwu9TpmPAzNKmjQcQLlJ35puk
         IpQ0mnN3Y5fPfNw5DevPEtHyquTKjCJI6MS758lOeTIDhLZl9lewdpZFN272Iq+rLlU2
         +Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=pMygGdGBKEjSMYN4MuBxYvmQ53bm/kztiIhnJSAihm9Ial6iLNTIFuXMjOU/w07umg
         HMKfSlKfwweJxUPEv3Uk8nbiEE0MC3MT43KIRmA63MmEVdA+1+AsJbF1rFYej+jCPUXm
         fnJw29aFbSc+X0ESyB2Ur7lb1u3Qf8NYaREGt1rJ0N/s8utudGZ+noueHNc6FeK2F8eV
         1UVk5KHmX4+/ne0ym/e8k9CXm7xfoxC9mJEX1NOchtfrHNQWd6wg3vwrCb0g3HSvvMlu
         NJHsGbZLQs2QjJ8vE1CN21/8BjCpQy0zpIySO7punhjZ9rzcGy78WycYsaGXmt8/RbN7
         vPJQ==
X-Gm-Message-State: AOAM533ub2RZAkYL3bqfD3/jWKL2lr+7DaQeJjmsEPfGz7tANvynmWz8
        pLF56eFLJSsReSZYbhRiU6/P6NoDfLIOI9wuZ+0=
X-Google-Smtp-Source: ABdhPJwKEibhtua8jTuLbkBXVOL+X0gFUYDNhWkJcrYB4bgtGKQCxUaLyaNWtnL7GvNWrjzndLfBs0zluDayTyISYGM=
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr8910361ejb.525.1612623093139;
 Sat, 06 Feb 2021 06:51:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:51:32
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:51:32 +0100
Message-ID: <CAGSHw-CwdZ7cob1JzomFz5dqEbMJRqn_+22Z35dNjvLGM3a-tg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
