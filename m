Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED89374FFEE
	for <lists+target-devel@lfdr.de>; Wed, 12 Jul 2023 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGLHOb (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 12 Jul 2023 03:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGLHOa (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:14:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BF5BE
        for <target-devel@vger.kernel.org>; Wed, 12 Jul 2023 00:14:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b895a06484so34167735ad.1
        for <target-devel@vger.kernel.org>; Wed, 12 Jul 2023 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689146070; x=1691738070;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=cPLr3xWDc+yGZDTyRj3uTBRgJtBCQQfgWs86GO7YPyaneAOjhChSGiA42nrwyjreye
         G4U+dLU+D58YeSUMr1pOglis0vZxZvrwBftlmjhUPQgwpJB+PeGKxYXnQyWUsolVCtnh
         g3S02A0ITLU/3qO9BTWg9U8al2q5WKFi8bfBKqwT7juXg2y92fd3cUpwvk3pcins600P
         4rVBcorMRJzv9fGmPPISgVSVJW5CFxXAn/kqX1hfcjusU3aY5CF016moRY/22Vuubg5b
         CiUzwK09SdS1QmvhaudVZsPmUwB3x9DrG2eJmvCAXCDKSHKvUHNC/gmT1wwZkNdgzFTN
         Qq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689146070; x=1691738070;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=FQ95tjzZ5EBMFpvPt7bdpC6fdDj5h8NxFbL4RarOnSqFJQq8hUY3zZYazBd0yjpSla
         jRWyXN16AVYhckiXN+F66A1unjboUHcJVmTIwdRyC4vsjcoR9jNw0J0QU7xxEo17fDZJ
         l2hGj3/ZD+4bJprjiWKTbl7bZ3GQNkyvBoz7yLCoSh42qLLDFEmsTus5m997jeseBAYn
         4uxsOMrMB4YlzcxqFwEwBuh7M4SRdEJxne/R8BO4F90AQ55DqKRnN2DyZnkPaAGzqdKN
         O6McjE6dLiisvdpXP8YMmVG/hIyHPjAQhuk8+ojl4JmKDWoMzRHWVfpOKwb3Qke0wrmQ
         +nHg==
X-Gm-Message-State: ABy/qLZZZQgJAXN0mNSFMw1LvqXR4RopHA6tVav3/pHb/LWML1QWqAo/
        XyjwMMjaOLtjoa/RJCbzWONpVhvXyw5k3MYg858=
X-Google-Smtp-Source: APBJJlEFQoQ93WocLH30mC28XFv4a0CnM5Ke58aYkvk1myJI8x1R1o8ezeaoahE8Ov4umY5XnfTEdlOUnL8mYojx1S8=
X-Received: by 2002:a17:902:b494:b0:1b6:771a:3516 with SMTP id
 y20-20020a170902b49400b001b6771a3516mr13728614plr.22.1689146069713; Wed, 12
 Jul 2023 00:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:63a0:b0:65:7e5c:b4ae with HTTP; Wed, 12 Jul 2023
 00:14:29 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly211@gmail.com>
Date:   Wed, 12 Jul 2023 07:14:29 +0000
Message-ID: <CACmoC-38CEXmj2SWrpimE6d7vJNi7qRH+fKxeu43PZ1-wDBOzQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
