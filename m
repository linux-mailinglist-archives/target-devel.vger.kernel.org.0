Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C416ABC2B
	for <lists+target-devel@lfdr.de>; Mon,  6 Mar 2023 11:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCFK0N (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 6 Mar 2023 05:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCFKZ4 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:25:56 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4725BB0
        for <target-devel@vger.kernel.org>; Mon,  6 Mar 2023 02:25:30 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536cb25982eso174401227b3.13
        for <target-devel@vger.kernel.org>; Mon, 06 Mar 2023 02:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678098329;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh7FN/ulAdnmY8O0LKz7bqpIFk4oOSQ9iCZ8VQ/AkNo=;
        b=XJm8B3ffNcEfjuQOOooM+qEAwt2zzUpVbSPqsQ2i4gdQc8ZCMxlUPBU21bo0A0ntgn
         Q52Q4NBJT5Q8YGhUgqyPNY10cNVg4BtFht+/CgPs3nmBCUNhfaYGI3VrJdpRsRv4P0OZ
         F+qdIeHM1abTKJLY9rF7X/6hcmwhNKamDaO2ivTk34trYaMcVTTkeHnkMVwsYKBCtNI5
         gByk2OT/xKpOoSlCpdFyrsBT36GgEw9Nx4cE8CQK3zNbFYGIl+DLAxGSafG+ACB9O6gH
         OQq3s8o44dJzOkxWMN4aLXcSgJrcJ61yq8o62oIrfZBFU+P4Tiv5aiEyvsUGp7iRekjn
         NCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098329;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh7FN/ulAdnmY8O0LKz7bqpIFk4oOSQ9iCZ8VQ/AkNo=;
        b=pKV+zpZvnC1R3y2jPNR5njNjucwN02t8acW23fnl96A/V6tFlzWArlhxkHIcXFPivC
         pkMR04Ao8QSmxkh0qpPgWnnlCPRIeU9+Zi9m1JuC+5NrjyLNFuzQDk48S9X3S/Tk1lHK
         yeUNGg/EeS32h1ywR553JutDIKr4r/WiqyKZs32OBZ5p9oAINHS/Kffmy2m+egymloTa
         6gTjW9FKUF+6E/mcGAlom1QOc4cEV1vPkn+plPcfsFsqP2a0OlBvEdZXqKYYVSjlA5eh
         zlct0du91ggIUhD7h8wVCovuAZWlimI8cJMU3/pregqGpV0ezXFjHhRjYiynQOidArVP
         L6lQ==
X-Gm-Message-State: AO0yUKVw7AO3BXXYderfGclwiFB5xlw6jR7nFfjrpsxCi1DfmP9sXXLZ
        rK0aBbA8Ek3fojcX9jJbT5pssHeos9x8OY50A6Kgfk5ugvo=
X-Google-Smtp-Source: AK7set+HbxOG8fRWYdSd2Spe8YgeAHrZJbrwpyn/MCNLktCdTFpedrqR91TU0+OXtW6ZaqP/6B7py4FyO7omWVyWxwo=
X-Received: by 2002:a1f:1752:0:b0:401:f65:99c2 with SMTP id
 79-20020a1f1752000000b004010f6599c2mr6566336vkx.3.1678098308425; Mon, 06 Mar
 2023 02:25:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:ce6f:0:b0:3ae:930b:3e70 with HTTP; Mon, 6 Mar 2023
 02:25:08 -0800 (PST)
Reply-To: madis.scarl@terlera.it
From:   "Ms Eve from U.N" <denisagotou@gmail.com>
Date:   Mon, 6 Mar 2023 11:25:08 +0100
Message-ID: <CAD6bNBj=acZn6jpkuAhuMAxbq=prud3DvWJUd6YsqM0swBt35Q@mail.gmail.com>
Subject: Re: Claim of Fund:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hello Good Morning,
This is to bring to your notice that all our efforts to contact you
through this your email ID failed Please Kindly contact Barrister.
Steven Mike { mbarrsteven@gmail.com } on his private email for the
claim of your compensation entitlement

Note: You have to pay for the delivery fee.
Yours Sincerely
Mrs EVE LEWIS
