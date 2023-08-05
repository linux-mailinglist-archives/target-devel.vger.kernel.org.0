Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2D770DED
	for <lists+target-devel@lfdr.de>; Sat,  5 Aug 2023 07:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHEF2n (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 5 Aug 2023 01:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEF2m (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 5 Aug 2023 01:28:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53264C2D
        for <target-devel@vger.kernel.org>; Fri,  4 Aug 2023 22:28:41 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-586a684e85aso14531707b3.2
        for <target-devel@vger.kernel.org>; Fri, 04 Aug 2023 22:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691213321; x=1691818121;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=NgyOgqJBr0ZdWm02y+4p1Wg22aez6l4MibE5tBg/6yw+Fxy86CwwMh9tAK6w/wF849
         HJw9K3BrIuhWIpGsAOBg1zKmz9QlJthLbwj8HNb4DNN8D+ZFOD8DArmlaV+1bj2cUveT
         7j4PmZpvkmE3o/r7f9gW9hu8faa2xvdPF783mUydCNKOWhe115CER6vakXaYA4AJlfvy
         rS/5+pciOGr5nuV0NkNCz6hMnKccYcl5UqBpueUn5hXrJJokh9gIDl6FZ5zUOpTcDU6x
         IbcSPQ6fW35iYp0ap+82cSMeFvvnrRblE2mwsriXZcECHU5yyywdWE8ygQHRmQapl3HK
         2puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691213321; x=1691818121;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=gWPQgqiGYdll59rQX/teiGSpeDYi0b9pGp9I/cF9ENNnHTfSPsif/claHGPZJsMCy7
         QJHvWv32RQvWOuCBE7IZtkJRZgBsjsSqCw8utolsMgSh7q28Ozyya3o2YYlzglrValCI
         ZKa3vP2oPiYQmCi7FY7xHcktWyySHS6pYPXcV1bPFqNtmh9Pd13JQpyja4xpJs8xke4a
         VSxOs8wRujjB1lWv/YOl203wTgFQzkjOVZztm/vwUvZBNwtxVRK+9qziFiI0d52SnFMr
         /IKlXGh0NG5uE3bW8aMJskWKQ4FTpE/bteL92+wFglt/ahr1m8ceQC/HMnp1nMEtgVFT
         h+kw==
X-Gm-Message-State: AOJu0YzLa0jUhxaaFgYjr+boyYzDqHPTI0kv+9ATmU3r11cjqBKY31Kt
        uSgkocTKs2y/PeMzF5a8H5MeycbGB21pPxVBXptMWxFAIcs=
X-Google-Smtp-Source: AGHT+IF9OIMc+WdgLi3BvHBoJhdUyxR83jLlQ8PhrJCnrxI3o69vLRgqUo2Q/Q5Ul4VLGlIfIGKc6uYiRo/+2JJaYPw=
X-Received: by 2002:a0d:d582:0:b0:583:d720:db2a with SMTP id
 x124-20020a0dd582000000b00583d720db2amr4048816ywd.49.1691213320938; Fri, 04
 Aug 2023 22:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:3a94:b0:194:f3d9:1521 with HTTP; Fri, 4 Aug 2023
 22:28:40 -0700 (PDT)
Reply-To: bintu37999@gmail.com
From:   Bintu Felicia <comingsoon978@gmail.com>
Date:   Sat, 5 Aug 2023 06:28:40 +0100
Message-ID: <CA+3qwhHYo4dy-AOhLMYKRU_ZMKRpJ9BcDqzTu1X999-Ehe1Fww@mail.gmail.com>
Subject: HELLO...,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

How are you today? I hope you are fine. My name is Miss
Bintu Felicia . l am single looking for honest and nice
person whom i can partner with . I don't care about
your color, ethnicity, Status or Sex. Upon your reply to
this mail I will tell you more about myself and send you
more of my picture .I am sending you this beautiful mail
with a wish for much happiness
