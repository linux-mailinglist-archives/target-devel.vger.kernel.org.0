Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE963C930
	for <lists+target-devel@lfdr.de>; Tue, 29 Nov 2022 21:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiK2UU2 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 29 Nov 2022 15:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiK2UU0 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:20:26 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49C167E9
        for <target-devel@vger.kernel.org>; Tue, 29 Nov 2022 12:20:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bp15so23732567lfb.13
        for <target-devel@vger.kernel.org>; Tue, 29 Nov 2022 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=khQUKJy5QTqMS02ZgUug6ZvJpGPRzKhqnVKP/ihMew714Twm4Vt0bJ1RDH7JkJx1vK
         QPIr+wY5mJdKsp4MTVnvr62BKuSqhUlw9YzOiwc6aSZn3RyMpwZRV8rPzsz02lndF6l8
         Z44IieKGZ9+wKPcb6Y9KU+TVD9LogV6bWt7ooUjlujuOtVx1m6gZG7ojogSZH0uNQ+Cj
         MpXwGwdcJbOjIH8AbYeYeHV03C2zw0NJI4DmUKbpFT+ixW0z/Kh2VFy58SxfviLi0BUQ
         KgVTqGuPZkNigtujnhrgPLmx9tpZAbOM+IF0FKtRRWJNP1sqB0c1+eg9FFvpZwFir8AW
         D7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=zlFe64affpO9DFo4TBKXEPG0KdlZVXA06I/8aWvj/j3K82XdWCa4ZyPmF0SVimM6JM
         5thqNtnZsHH6+LS7nYvd4pZV5QTib0rXrAafGFEPG4TEjdQ5B6zadSa0Td/5TyWhZvl6
         us7ZIx8oiXTxJC8SLBwVslhRhCgfL93oKHGMpw5EsT7B7ht8nXy/WQx7Vgnl2ZZbHC12
         g2uzGx1Olh274bDSk2gf8rP0MEhoQXr1q0LG3mlFoJjd7Ak6rPkEWB6WMGGDP1tekvSi
         APWvSJgOJJFbWWBWI2RaYyHeDwvJ5l5mytG2u0QCYEeAscjt7z6MjvlsKFyxMHLZCF1P
         hRVw==
X-Gm-Message-State: ANoB5pk3PgxJreleHo7aOUM1P+qEjvYJ8PpXgEHEFbEjXHBXiJ3YYCAB
        wza2Z1noLQvOnj2oJ1rdm5Qb9Ps8NAcP7kmGaw4=
X-Google-Smtp-Source: AA0mqf5lvI1ZDLITXh5wnUbdaaVhInlvl0S8nDoSQ5168883B7Eghk1zoYL79Emt0arAXgVojWBZdZToEFXHFH434hQ=
X-Received: by 2002:ac2:4e0a:0:b0:4a2:2aab:5460 with SMTP id
 e10-20020ac24e0a000000b004a22aab5460mr13813732lfr.62.1669753224182; Tue, 29
 Nov 2022 12:20:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:1d6:b0:22e:e610:6979 with HTTP; Tue, 29 Nov 2022
 12:20:23 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <chiogb002@gmail.com>
Date:   Tue, 29 Nov 2022 20:20:23 +0000
Message-ID: <CAHoLJnkGu+S8DpzcYVkTJt-WQCbZ2RHr9n1SS2ht3g44tusinQ@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
