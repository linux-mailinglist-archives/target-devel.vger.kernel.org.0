Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8225046EF
	for <lists+target-devel@lfdr.de>; Sun, 17 Apr 2022 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiDQHZg (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 17 Apr 2022 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiDQHZf (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 17 Apr 2022 03:25:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132366176
        for <target-devel@vger.kernel.org>; Sun, 17 Apr 2022 00:23:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b19so15268746wrh.11
        for <target-devel@vger.kernel.org>; Sun, 17 Apr 2022 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=a76B5ZazP66F+MjjxwJeCev0sXSEVmZnHJFAl28/egLaJJoCnsnBJU1Sk8AI87Wp+X
         jFMhKzHx2qRtn0mncccF3RwL6IE4c5sR4Ks6In7Q9ZSgIeBHkXBXYJtr77kH/zpWiFE/
         qv786vNHduo18TjPblXG8cpCuRA7kaOFgc2936rzgEJo02FBYjjNKHXzIck4IICktW57
         IWLm8d5omDnTcxs1DQvP4T2iblM3fTv2hzEvIOeGORyHEo3YQafl1AJ1e2b6/KUstUNn
         b14HbssNC2Pv8Y/YsCQJPzboMQgD33zFJq61Vs2Mf/AeEwzmD+Fl5EYbZ/8D3Zbv8J0x
         2RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=zRppq+/0N1LKnoP4nJwSzD+KBBXledABX/IlAjSPdqJFwvdMKRgMmTbVvz6+FhIaI/
         GSzPWhiJT1Zi/xeKTjen48SDgFlOzrnjiHSecxhWCPYyUefFbzOGAhwef7HBi9Hsyzqu
         KUdyanTnQ4rNw3pRMmDr7f610rA7fVybj6Lsl7+ogHbWMTR23Q8c72XszW2KwppwrNh4
         POtbjahjGnPwxrWwN0ojK5ZZOUAQcBCSh17bKkoRv1QcCJ1tMwshNZBIO7nVbIaZ2Bfa
         nHB0aCfWHkMtzr+csP0pI1JXPSNI+h8gD0AN8gSm51Sg5aqIQ7gVBrgt2ySzkzlFTL9C
         NATw==
X-Gm-Message-State: AOAM532qr5ZY4KCRRZl0A6ZUXsWEIyvAERooeThp0ItFeIqRw7zJYxgG
        cCanzPnQVMfUihUZValJDKrftzpj2IZv/PME9Sw=
X-Google-Smtp-Source: ABdhPJxqX5GioPtIik7UUz8o2q2w69dICkpuCZVmbMqgQ4lXXmUcp9iJAPQCs8mRej4LAUZlbMmwIxC91Mo/62j4Y8U=
X-Received: by 2002:adf:dc90:0:b0:207:aa5c:8524 with SMTP id
 r16-20020adfdc90000000b00207aa5c8524mr4679324wrj.523.1650180178336; Sun, 17
 Apr 2022 00:22:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:e0d4:b0:1cf:83e1:2b7f with HTTP; Sun, 17 Apr 2022
 00:22:57 -0700 (PDT)
Reply-To: danielseyba@yahoo.com
From:   Seyba Daniel <joynelly70@gmail.com>
Date:   Sun, 17 Apr 2022 09:22:57 +0200
Message-ID: <CANHFsh+mem0t2UpkvLbtYMnrTrUAzK_F1KB+1+iiCbbpaLxjDw@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:441 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joynelly70[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joynelly70[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
