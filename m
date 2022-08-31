Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A097B5A7EA9
	for <lists+target-devel@lfdr.de>; Wed, 31 Aug 2022 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiHaNYd (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 31 Aug 2022 09:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHaNYc (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:24:32 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31670A50E1
        for <target-devel@vger.kernel.org>; Wed, 31 Aug 2022 06:24:32 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-3321c2a8d4cso307034507b3.5
        for <target-devel@vger.kernel.org>; Wed, 31 Aug 2022 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=DnjnZSajfNgAzpK5ym8unXyyAyM+qS8cquz4gOGGtuU=;
        b=VU4FjQFFYvsFyOvNVpmEb6H4ZphLL+YwLtb3jSAzd1WTvSI/5SBJzku8mlHOkwyBRa
         DCDkIHvrg96r5vTX57PrIMSKWY9l2NxK9d1te2+pf7/b7yw/bwaWIB4HhEV5hfhNJ4Ye
         pUk7qxwlvTDAJ7Y+kRGHcPMaNPWdSOZdGw8/sQfOe7VMjMPopN30ePSVi0gVO142SiWj
         YGMVJI8JWxLPi1u09bu2A/kAtDjWuGsdzwuQr+ppcAbcjExbZ3ip97zKZ2tsL8JQFIWO
         l313PIlRGkW080Leny/l2KnD5h6fu0hMtayVNMxbQB7aGRFYhSQIVaWp//ondzFoBw2r
         AphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DnjnZSajfNgAzpK5ym8unXyyAyM+qS8cquz4gOGGtuU=;
        b=qfP8TmSUAyuI4TmxVZgaf2r1lCHFSNrPy8G15wXFT+FWy6EDMukrB9M9jM+aRqSnKo
         45rnLK2O/GIdKBosi37Lts7fPSKd5pP/p3w57oxbFqSs9U/I476CgWfegCgVdR5PUh/v
         4N/42jldNpnOqgfXjdP2aMGM3Gx6OIgxm3oYtqhLEQ3P9nrICv88dslBTji3CLUIhjI4
         H/8XqqVtAwARH8pHwtbOljC1oJtCl7/ryHecPEZc+5CLBoUvLXb+MXhBoHMOAFvUE0Xx
         ArGSLNs/SUD2cwRuCPEw3MFzeHXcg1K/k04JFbekWMgSpuDPU7Z7wErUeGfZrkc8LFmg
         qkUg==
X-Gm-Message-State: ACgBeo0idcww97JNO4eJpKVl14YnmchWS5PHgzE8juskGZxgiQRUviw5
        PcgAxV1ET5DJUntwFiIzatT/5qCTPVMkmFzVIJ4=
X-Google-Smtp-Source: AA6agR42MH7PQaoMYBofIBQk33ANX7uG4CWIW8x0dnBrhoOa8DAHiOdbnnF4460Mo54LX/rI9vqvbMJpdsWD5ghHMFU=
X-Received: by 2002:a0d:ea90:0:b0:33d:faad:db54 with SMTP id
 t138-20020a0dea90000000b0033dfaaddb54mr17858610ywe.116.1661952271372; Wed, 31
 Aug 2022 06:24:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:74d3:0:0:0:0 with HTTP; Wed, 31 Aug 2022 06:24:30
 -0700 (PDT)
Reply-To: golsonfinancial@gmail.com
From:   OLSON FINANCIAL <khadijayusuf6876@gmail.com>
Date:   Wed, 31 Aug 2022 06:24:30 -0700
Message-ID: <CAEUDHmhTihgN+eeSbh65SBf56eJYwmog0znGWP2O+OQUyF82yg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [khadijayusuf6876[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [khadijayusuf6876[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--=20
Hallo Gr=C3=BC=C3=9Fe,
Ben=C3=B6tigen Sie dringend einen Kredit, um ein Haus oder ein Auto zu
kaufen? oder ben=C3=B6tigen Sie ein Gesch=C3=A4fts- oder Privatdarlehen, um=
 zu
investieren? ein neues Gesch=C3=A4ft er=C3=B6ffnen, Rechnungen bezahlen? Un=
d
zahlen Sie uns Installationen zur=C3=BCck? Wir sind ein zertifiziertes
Finanzunternehmen. Wir bieten Privatpersonen und Unternehmen Kredite
an. Wir bieten zuverl=C3=A4ssige Kredite zu einem sehr niedrigen Zinssatz
von 2 %. F=C3=BCr weitere Informationen
mailen Sie uns an: golsonfinancial@gmail.com..
