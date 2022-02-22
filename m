Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0994BF5BC
	for <lists+target-devel@lfdr.de>; Tue, 22 Feb 2022 11:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiBVKYh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Feb 2022 05:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiBVKYa (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:24:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43F159EB8
        for <target-devel@vger.kernel.org>; Tue, 22 Feb 2022 02:24:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j17so5484474wrc.0
        for <target-devel@vger.kernel.org>; Tue, 22 Feb 2022 02:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=pXTibmYGBx12yu5rhR5//nfYznFaMD51f/24MZt2MBPHY+YblB4iWeyWquCs1oipbO
         rCObe3Sjnbr3eNV8dZoI2zMBQ20wzDFhIkGIEpHzeeflYtzVzn8kITLlxWkAzR3Pttpz
         zUHFAVgAguHyeRFjTAILhVcLr//ZUuNUBABErpnxUYCbrdm5IvHvKz+svpm8Er/p56cZ
         1Ien8Hd1yzYxf5Z2aTKTnBnPsSKijS1sISqnsLlJsic15l3YnBHj4yktVtDK5PE3DkQt
         URx2MdzPK9KJFp4h1R74DxT6MTBE/TPldYBpeAUxEiQp9+JD+Z9TAUAa00gLojT9PAAV
         ue7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=zSEkH4ZUeOGvvMv67MnnmoelhlaIWTbwj5VmVa+Y315wOiJ9aLFz17YHkT7xFN6ErV
         5/C6LFfYnCv0DdzfOSoBq5MR7AkDLN+d48so1PaJsgUHsdNI/grNVsID75bZ99YZA7kv
         Nm6uD0127YGImC2NHsO35Ra5uWjcSOq2nMZoSQ/rJFxyPnOUkhbq33+4Y8Mxws3WQl1K
         1lOBAyngUsNKhjLH+e7EaNUjl0qEaO2fwABbtOEFg0X5+2+uJPIZqlGtv/TKDybMp0tR
         MovuA/fPafYu/YXWNy/v477iBJdaxoqv+DunyMd3vKwgPBF1Xl2OaHdqFdVBMgULAb5a
         9wgg==
X-Gm-Message-State: AOAM5313IcP9qfLyqZVqgj2xatqp7ZATFb5uSVykA9TNEfdu8T/+E4S+
        ntwCDw1j3xXTzXjtkwkK8xQ=
X-Google-Smtp-Source: ABdhPJydKrIrpyS2LZzwZerVWTqHFV4/5twdIxYmHGteecd6TNj1377uGks4FRfRzan7S8rBol/Jeg==
X-Received: by 2002:a05:6000:2cb:b0:1ea:9133:43c3 with SMTP id o11-20020a05600002cb00b001ea913343c3mr1718403wry.47.1645525443995;
        Tue, 22 Feb 2022 02:24:03 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id u15sm54137760wrn.48.2022.02.22.02.24.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 22 Feb 2022 02:24:03 -0800 (PST)
Message-ID: <6214b9c3.1c69fb81.83d06.1bb3@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <garyvernon830@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Tue, 22 Feb 2022 14:23:56 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com=20
