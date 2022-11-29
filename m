Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEAD63C932
	for <lists+target-devel@lfdr.de>; Tue, 29 Nov 2022 21:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiK2UVa (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 29 Nov 2022 15:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiK2UV3 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:21:29 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD20BF45
        for <target-devel@vger.kernel.org>; Tue, 29 Nov 2022 12:21:29 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id fy37so36501915ejc.11
        for <target-devel@vger.kernel.org>; Tue, 29 Nov 2022 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=NCdvtJveHDYFqzUSKnhMRlpxiMaloDGt/VpZEwPBQhjQMXUBWdnaYDjqlXrbg+Bikl
         FKSgttC7iaOmfhSEF008UFCXLlQxo2EwPt/Fad2W2xWj6oKPBSnTPaxqLrPTiomtnKtO
         ur0+U8h7iHUwHaycqReg0t0CMc1Dszu/SLG/8eCgpoN0USvRyjwqzLuOEKoI8t0f9mlg
         g3elQGqk8d8B1w5+Y32fux/b7kFF0/QD3IBevKg59D9gi88gbe5N8cT3zu85UD9r7W0V
         tJEyBOSuRU7DlkfVm7ySxjJTo33yivwbsJhjNcGj2jUbOR5AB2zC5zYVa95MlVRrZbr3
         DwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=jjHLdO3YLHEL2YYuR8FPNaKui488Y/FtxsWsEMNZmCssQSf2/yLGbJMKjyHBjs6Klt
         ZtesYAva9yu8xHWmDossFN5kaqJDEEgJlkaAd+Nnao8Xf7aWZes5e8TQ3gnWi4jSHF8r
         mwX0R2OPR3Hyv+WS3L3r8cl330CZHYzC17GxC7vM7MvCmtYSCxkfodBzRbU/3D3WOab6
         2cGSju+kHusJMZd/BfV7jIjjTPhcz+Zzorz6kOKrd7FpoMCwj2oISzUUDcPUW/j3ggiL
         KCP2CUVlOm6qARj2JD9DfCurD7NSDye3AbZZPCP9891aPfqvHM48RGAoW/FLi/aGUmrS
         VhAQ==
X-Gm-Message-State: ANoB5pkzD3W4qYg2vo6Y1llNCBp8ojuvWrCuqxRu0baTXrGhiK7DICzf
        dpO3YZ2MnmPUvXvUBOi3BylqNp4k3BE7jFhhcLU=
X-Google-Smtp-Source: AA0mqf5+auc+byiHC0rSIpN0xdxvm0HS8q7hFcXAT+IBk2Hh61ZU8jPNCbiXQ9nYEoYcn4h0bcsglNpWmAPyV5wo+0E=
X-Received: by 2002:a17:906:1d59:b0:7c0:5496:4f1b with SMTP id
 o25-20020a1709061d5900b007c054964f1bmr8915717ejh.715.1669753287568; Tue, 29
 Nov 2022 12:21:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:bfe7:b0:78c:cad3:6a2f with HTTP; Tue, 29 Nov 2022
 12:21:26 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <chiogb003@gmail.com>
Date:   Tue, 29 Nov 2022 20:21:26 +0000
Message-ID: <CABa6Gn=-hQGaeUozi=1PmGLoywO6sMGqRWVc8NVxm7AkJKYXBg@mail.gmail.com>
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
