Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1E63960C
	for <lists+target-devel@lfdr.de>; Sat, 26 Nov 2022 14:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKZNJP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 26 Nov 2022 08:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiKZNJN (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:09:13 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9900F1D643
        for <target-devel@vger.kernel.org>; Sat, 26 Nov 2022 05:09:12 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id k67so6513737vsk.2
        for <target-devel@vger.kernel.org>; Sat, 26 Nov 2022 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjTBep/hEuzuOvIlSBGXr083GbVo/g9gCrt75fjqWp4=;
        b=b7mzVjnbYm4yzLhJvPU3xmMBiSf9iXorA2EJ4v8zgQEOiPaH+zb1+w7kIIEPUps6om
         Pb6R7N43NPT/8/GgGENH7pU8rV2KMJO4E5euXFjDGe9BOYvqG7iRlLFc1kgZN60x0drA
         bu9mCmKfu9k9GQUJcfKoRKPzIkYW+Uxac4ZRxTv2yCh0n/1J5GCQWpHrdcTlX+EoUnnn
         19RbNjtMPz67U5IN3Fxo/kN/Cs8hLfj5xfLVwOz5GIkwD8oUx/Zm2JCcWbmHiaWBltFM
         jbBoGW/UiYLaHd7sMwxHtbSWv10vzGfnhoiU3Cr4EgregZSk/NBCZBu1NruXXi51YC9Y
         h6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjTBep/hEuzuOvIlSBGXr083GbVo/g9gCrt75fjqWp4=;
        b=JMHctM93bwovcXYnijOx84H8WnjyWbZs81cfGswS2BajAPOOb6SeB9M6hOHOxy5a5g
         O/BoS/7mUJTdjWwNzbJNUN72nMmxEPYGr++p6g6EUSlx+PPluN43cseLlET9xheJOmMQ
         iamNIyuD0kOE/0fjyUItyqX9L9xkHjljRnGp0NXoQBqTJsaChGnq5dE8PBQK/DF5Y2FF
         UFp6ImIz6sBVfay09oYgLUbQ30BZ2Dsiz/h1iKBuwqKAlmTsaIZit53eOEMvB66RgbDX
         /iX0amiz55TyBg9SdcJ7mOfVo6a9QrTp9ZaX9++O6Ld4kHRGY31V8vQ6E73P57JloyZh
         zIkA==
X-Gm-Message-State: ANoB5pkP6dMlZ3AmsCBEOPr3UxxPmKhoVCMQFmzPQFRy2ygtKKLz7wTu
        vfCIV0DRZvo2ghtlv5ZJzKTTaNQxCnhdvJiItLA=
X-Google-Smtp-Source: AA0mqf7S6X2KOm0KD965BGAGKTcp+soP20Idd57MLQYDAJss+QBqxjwHUDoKg+/ajK03kOLBYXMhhwmrpG6CZ1trelQ=
X-Received: by 2002:a67:d789:0:b0:3b0:6e7c:94b8 with SMTP id
 q9-20020a67d789000000b003b06e7c94b8mr9891887vsj.74.1669468151576; Sat, 26 Nov
 2022 05:09:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:c208:0:b0:32a:66df:3ea6 with HTTP; Sat, 26 Nov 2022
 05:09:11 -0800 (PST)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly49@gmail.com>
Date:   Sat, 26 Nov 2022 13:09:11 +0000
Message-ID: <CAPhHPC3ncOaJCOzNXC=4pM4M-mZBn10n3MHEy8mdi1oAVKYFYw@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

-- 
Dear,
I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs. Nina Coulibaly
