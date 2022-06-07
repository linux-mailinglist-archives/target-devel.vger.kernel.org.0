Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C882653FA9E
	for <lists+target-devel@lfdr.de>; Tue,  7 Jun 2022 11:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbiFGJ6g (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Jun 2022 05:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbiFGJ6P (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:58:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F191737B0
        for <target-devel@vger.kernel.org>; Tue,  7 Jun 2022 02:58:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y29so18587342ljd.7
        for <target-devel@vger.kernel.org>; Tue, 07 Jun 2022 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=p7cyveT4bvEtCVZfKnt9HMSBuDucwLXScRMPEQg6smQ=;
        b=hA42f0R3UFlIosoF812whJnDZUnxM+49dZ5Q+X33MKGZoJ+9gvWjqYPq5ash8VTPtY
         JtWt4SKN7tv/xjvITTe6KGt90nySLv82wtCG+V1vcBg4vFj9ebUC1AopLgNjG0Ufw+wO
         YvWVDLc7y9VeIh5Hf3hc19qFJVtykqzJH85LgqwPs7EsLiU8Uz8treN8CAjCEnvUSsvN
         AYY+Gu+wZrj/eXCK4VBLvr91s1Oatmjr8e0nJ/baA06JTTJ34K14WYLqQk+3xCW1lDvL
         6V4MmJ/pUFS8zolrDPOXyp/ZMiTM5B9RbFEG5M+E9DbApojoIzT60WWE5MU7lA/YNZ5p
         QyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=p7cyveT4bvEtCVZfKnt9HMSBuDucwLXScRMPEQg6smQ=;
        b=JE07+tKk5MjAzih0PdW4fMrB5v70BrsFJtNnLkHMTy2WHyitm1IelQQFC2l5LuPeP7
         4H3SP8qtAClm/YkfD+KYzSqs6ORn5dQOjsB4ymj8fAV5uTnSalh4/Qp04NKWyjMz/amR
         jq8hMF78lfIcUCsBFrv68k02ot52SpoeLvSzlohJC2MIi+rVWd5bLconavdsMaYvG7vl
         gFonlLnVLF6+AT8QQJKl60RkioUsYcue9zTo+DW8cAi5m7E962f5SizjkxhnZMMqVzKK
         oDA7OzNMYBujV8qn5KbkjYTeveuoL7T5JJkXHx7CX9beajVqeSseq/pXX2qlk95wUUtZ
         yBgg==
X-Gm-Message-State: AOAM531bYExe0A7Q9Y4SXNfxLBmcRhzxqGzGsLduoo7jce5e7SxVFfmB
        nrnCI+4lMZd6cVX/TEvZ3JN/jjwAgV3Flz0oanY=
X-Google-Smtp-Source: ABdhPJwvvRMDa83+fo2an3LR8XeqKIqzRH3LspCT7h7NjUorhskvm4sGzhOsGLUm9r6noCtgmf6/HABAf5L+sT60n9s=
X-Received: by 2002:a2e:702:0:b0:253:bc1a:8a8c with SMTP id
 2-20020a2e0702000000b00253bc1a8a8cmr52185543ljh.128.1654595890606; Tue, 07
 Jun 2022 02:58:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:51d0:b0:1cf:9a7b:1066 with HTTP; Tue, 7 Jun 2022
 02:58:09 -0700 (PDT)
Reply-To: robertbaileys_spende@aol.com
From:   Robert Baileys <mrnazy58@gmail.com>
Date:   Tue, 7 Jun 2022 11:58:09 +0200
Message-ID: <CAKTXsVnEBuj_MgLhZtH2y81QwZQTxUoMzWeSiJStnNABKqxp0w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrnazy58[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrnazy58[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--=20
Sehr geehrter Beg=C3=BCnstigter,

Sie erhalten diese E-Mail von der Robert Baileys Foundation. Ich bin
ein pensionierter Regierungsangestellter aus Harlem und ein Powerball
Lotterie-Jackpot-Gewinner von 343,8 Millionen US-Dollar. Ich bin der
gr=C3=B6=C3=9Fte Jackpot-Gewinner in der Geschichte der New York Lottery in
Amerika. Ich habe diese Lotterie am 27. Oktober 2018 gewonnen und
m=C3=B6chte Ihnen mitteilen, dass Google in Zusammenarbeit mit Microsoft
f=C3=BCr eine zuf=C3=A4llige ''E-Mail-Adresse'' 3 Millionen Pfund ausgibt. =
Ich
glaube fest an "Geben w=C3=A4hrend des Lebens".
Ich spende diese 3 Millionen Pfund an Sie, um auch
Wohlt=C3=A4tigkeitsorganisationen und armen Menschen in Ihrer Gemeinde zu
helfen, damit wir die Welt zu einem besseren Ort zum Leben machen
k=C3=B6nnen. Um mehr Informationen in meinem Gewinn zu erhalten, k=C3=B6nne=
n Sie
die Website besuchen, also k=C3=B6nnen Sie skeptisch sein es .
https://nypost.com/2018/11/14/meet-the-winner-of-the-biggest-lottery-jackpo=
t-in-new-york-history/Sie
Sie k=C3=B6nnen auch auf meinem YouTube nach weiteren Best=C3=A4tigungen su=
chen:
https://www.youtube.com/watch?v=3DH5vT18Ysavc
 Ich hatte eine Idee, die sich nie ge=C3=A4ndert hat: dass Sie Ihr Verm=C3=
=B6gen
verwenden sollten, um Menschen zu helfen, und ich habe beschlossen,
heimlich { 3000.000 =C2=A3} an ausgew=C3=A4hlte Menschen auf der ganzen Wel=
t zu
spenden, Menschen, die einen gro=C3=9Fen Einfluss auf die Gesellschaft
hatten durch Verhalten. Nach Erhalt dieser E-Mail sollten Sie sich als
gl=C3=BCckliche Person betrachten und daher berechtigt sein, ein
Beg=C3=BCnstigter zu sein.
Bitte beachten Sie, dass alle Antworten an
(robertbaileys_spende@aol.com) gesendet werden sollten, und erhalten
Sie weitere Informationen dar=C3=BCber, wie Sie diese Spende auf Ihr
Bankkonto erhalten.

KONTAKT-E-MAIL: robertbaileys_spende@aol.com

Gr=C3=BC=C3=9Fe,
Robert Bailey
* * * * * * * * * * * * * * * * * * * *
Powerball-Jackpot-Gewinner
E-Mail: robertbaileys_spende@aol.com
