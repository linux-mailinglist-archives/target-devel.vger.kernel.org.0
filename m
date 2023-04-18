Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E6B6E5D66
	for <lists+target-devel@lfdr.de>; Tue, 18 Apr 2023 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjDRJap (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 18 Apr 2023 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDRJan (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:30:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8C55AC
        for <target-devel@vger.kernel.org>; Tue, 18 Apr 2023 02:30:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j15so7446084ybl.10
        for <target-devel@vger.kernel.org>; Tue, 18 Apr 2023 02:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681810240; x=1684402240;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIDs2kxktlKTTEJ6a5vNk/gXg/KBrPoTQlY4dW6WTl0=;
        b=FeOR9NxNEW/XdzlmIDNeq+VabTW9lVmkGgnDLbG1FoX2G4I0EloY5wnCvqQYB5lyVF
         o3G5B9qu4LaaWQ2Jrks8vufvCVN7orMmCo8pjR9UKj0PbKRhSu12apJpIyvgXFzT1V9p
         co9E50uZmDfjBOXboZ1FeIz5dPSRcu1krlsjCXGJ3JE/aH+c/QXHI4EX9C299W4gEr3R
         uoO3o62cU4STXK/F7XsO0XxFIQzSN/tJI7XLMs99sq7ahDsaH/QiKDOW8ZcTs2m3pNob
         B/qiuzPzK4ZOknhnjELrKsQwegzvWe0BuSeV0y+IA+msHq5242wrn1A9abZhvhB9zDvd
         apFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681810240; x=1684402240;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIDs2kxktlKTTEJ6a5vNk/gXg/KBrPoTQlY4dW6WTl0=;
        b=VXfUtF+0Mn+q0yUWRGPctZoL1lEvVI8eeKMuUZDyrE6/jWydo8p00GafenMmHtyqAM
         3s0UofsHiJ22vqaFKSXX7plSvxg2rJM5wVQLtdndKCKSi5vMa1N/4vj06wRryuuGOzd2
         Crllo0yGoIYKXBxp4jTRmeOaG0LFsJTVJDMmVO+vc6r5Za/KlO9MySouFlO49sjB0kvT
         +JCco+oRFWfTBJTdzFv5s9QpmW6GepSZ1NnxosNehTsctSNjFg42DTk7wPa1aIpgGL4d
         YSYxf7GQNL2e+Q502IQhKEoaYbMnQfaUJ2mRbDZJN9LZzLLkwTDU1kHAISOezYHR4Kv2
         OFlg==
X-Gm-Message-State: AAQBX9fgcHehtQZJ4nj5+hRHinWdNlh0j2/+lzugnRQcurrYDh2S7gVW
        zUrkUVR7HIvq9c+GntjL00Vm4fQesOX05W5GnQ==
X-Google-Smtp-Source: AKy350b8njG0H0YrEXcpjpgjnJedDi2rx6+jfDtckJPAqPpfWxUenEd4u457j/rHv6N3EvNsx8b3ete1GCf4n5H1DHA=
X-Received: by 2002:a25:e74d:0:b0:96c:c73d:5f79 with SMTP id
 e74-20020a25e74d000000b0096cc73d5f79mr16626008ybh.5.1681810239944; Tue, 18
 Apr 2023 02:30:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:8d2a:b0:341:26a9:b2d6 with HTTP; Tue, 18 Apr 2023
 02:30:39 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly.info2020@gmail.com>
Date:   Tue, 18 Apr 2023 02:30:39 -0700
Message-ID: <CAC4KtETQpZwdu_1L8LWWxU0-SAbRo0ZRMyMppmFpCaWdtLehXA@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Dear ,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs. Nina Coulibaly
