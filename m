Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238F74E64BF
	for <lists+target-devel@lfdr.de>; Thu, 24 Mar 2022 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbiCXONC (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Mar 2022 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbiCXONB (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:13:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C33AC04F
        for <target-devel@vger.kernel.org>; Thu, 24 Mar 2022 07:11:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so7308743wms.1
        for <target-devel@vger.kernel.org>; Thu, 24 Mar 2022 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=sfxo1dqqTrr7e28OuTBjrwUEPnrevaNVUdgTMF56Ktk=;
        b=lht20495o279uTMqkk9avlB0zkO0c7mmCZIH8e0fGDtWZUw65aZMRgJ5LQ3zUzoHKP
         0lzB/nByEq5Du7n1TQsBT7fN33u6pR/WhxaXWZUj+kyczlxqKZr3TpxAjgql9uFHK+UT
         yG98eotj81A4YkCzYUk8lVpU+CFL6GPPd2yLWJ0fsjLRgjyAHP1yTjiWu6yzq1HAmdjG
         Nws7xCn90IfL0VTxdyiOL1vS4+ukfAM9vwOToGk/+goyKwjTY4+XyrLIHl3DlUphs7NI
         d6DCP3k78xvPrWLMkrTsFNWIw5su6YBE+h/XHnaphCq+KNawGdrp96YKp1KFkMWeZvL6
         h4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=sfxo1dqqTrr7e28OuTBjrwUEPnrevaNVUdgTMF56Ktk=;
        b=koKrTSt+eAAj6rzVWScyf6nPlaxzvwyEz1AtEYSKqLHgCrYWEX6sU7dHBhkeriWlbn
         WTpnkN4I/VaK5b9fqPG0BvdIjvSeU9HCTdc3XVSdkyxGkTJ5Fb6WstUmiWeVdHtpxgyr
         fJnnpoPNzF07ktqt6oD5zv1csLInL/Nbrrk/l68X1Jpa9ePfxMc+i1b9OKTu+NinFNMU
         wLFkNK6364UY8taq2QlbtWq+sNnFNXRxkGK9a5/+6ocUMPDh7d7wpG8xrWUL6AV+yOVr
         lJjJfcSx7PdgEM0A+zejMXoauWbR15djKjIiPq1ZpU2AZDhyktoKCqOh16P3OCF2rYAi
         2RLQ==
X-Gm-Message-State: AOAM531O9+vQAlk591uzgonpuhTJmeVQcsLVCh+I8u+OtBu5x5rvoy9L
        gVyJkUqkjdM50aph9HRGJ28=
X-Google-Smtp-Source: ABdhPJzND5cmCimK4m8fBwVJXSHXE4o1Sg3rCS+CpCoLBgTL3A75clV9wmG0JIkR8SWD5mVA5kp8aA==
X-Received: by 2002:a05:600c:1ca4:b0:38c:987e:5feb with SMTP id k36-20020a05600c1ca400b0038c987e5febmr14447628wms.27.1648131084949;
        Thu, 24 Mar 2022 07:11:24 -0700 (PDT)
Received: from [192.168.0.102] ([105.112.209.229])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002058631cfacsm2830384wrf.61.2022.03.24.07.11.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2022 07:11:24 -0700 (PDT)
Message-ID: <623c7c0c.1c69fb81.cf812.b780@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: meine Spende
To:     spenserw08@gmail.com
From:   spenserw08@gmail.com
Date:   Thu, 24 Mar 2022 07:11:12 -0700
Reply-To: mariaelisabethschaeffler70@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

 Hallo,

 =


Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Gesch=E4ftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, den Rest von 25% in diesem J=
ahr 2021 an Einzelpersonen zu verschenken. Ich habe beschlossen, Ihnen 1.50=
0.000,00 Euro zu spenden. Wenn Sie an meiner Spende interessiert sind, kont=
aktieren Sie mich f=FCr weitere Informationen.


Sie k=F6nnen auch mehr =FCber mich =FCber den unten stehenden Link lesen

https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe

Gesch=E4ftsf=FChrer Wipro Limited

Maria Elisabeth Schaeffler

E-Mail: mariaelisabethschaeffler70@gmail.com
