Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224725A47AA
	for <lists+target-devel@lfdr.de>; Mon, 29 Aug 2022 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiH2K5P (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 29 Aug 2022 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiH2K5M (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:57:12 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BEB5C9F0
        for <target-devel@vger.kernel.org>; Mon, 29 Aug 2022 03:57:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c59so3387337edf.10
        for <target-devel@vger.kernel.org>; Mon, 29 Aug 2022 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=PBKNlaHVb9v8l3/VfM/NVn1dCjKjtvtmr1zihjwmCNGsyJMpq4CMgYjXGzkGJyUan8
         2EGb2dZ+CPRIBwUcAOn638fTLYTs4RyaJGML41EzR/EVnZUblcdczV/OgmNWIadkRzDz
         ID6VjE2UzRvgTyiOCmFsi5kC0KiFHbBZbhdqDOdADt9KRrbv6sGPZP7mMZ/fRNWL9yfV
         KRsGuJKZSdY1gJgmuhfN+pTZTCjKqrFyIfd9RZaft5BkNqb3q6+1E7dZXZhxyOEfT9MV
         qVTlfNLW1KA045EYYZQXy8k7y873g0+3pIS3YlmOgu2/ojk/4V6d381hBtYU+nApSaLY
         x/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=RJpLDlxtiDnTAk0zevK4UvNExDnrz2KDdPPnrlqXSeX/Y8Rc9V6K0YHvv24m6um+kO
         o3IPCxwO26KTOSKGyJ/EXxTL8OegzG6r6MQq6Na4sii5oFJQXblfIcLb2nwePcYS1FuN
         nb72Lgasj051pqGzxwPkTyjNGB9MsM58UkeabinjZkhH7GX7drV/bUulrrKfoVoV8fmz
         NPHs7IGCcChKt3ojZ5QPdOvra0iE2ZHqYTUbWCCR8UTeXLqZwpUzsYKtW5efp+OtHJJW
         lczouDaqaMFEnODOykJ7PHoJxvGF7XBffny+nc7UkdiMnCBnpO26Ns4+YjzzhBuuTArN
         cvUQ==
X-Gm-Message-State: ACgBeo2A05gkBkkCAfNV34NBXojdNz6eAeom+W9fB7pL8bLsBpwI19eM
        oIqittMF3Nx2TOwgvgWl1+feNIj4+mDiRUYNct0=
X-Google-Smtp-Source: AA6agR5ey/22gjm2+PByqfpSa/bsp1h54/MDmHVJdveY1Cw0h93gfIfZJnwwmkVtcdB3+cckoGjx/Vl4uAHJse5dCfY=
X-Received: by 2002:a05:6402:5207:b0:448:73ba:e5e5 with SMTP id
 s7-20020a056402520700b0044873bae5e5mr3454026edd.321.1661770629090; Mon, 29
 Aug 2022 03:57:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:a90:b0:22:8059:1af9 with HTTP; Mon, 29 Aug 2022
 03:57:08 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   david <nenkan1975@gmail.com>
Date:   Mon, 29 Aug 2022 11:57:08 +0100
Message-ID: <CAFO9AXiRB0ZZ_dxzfw461YcFxNxuim5_=eDZ2+eRU_04uL7HSA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nenkan1975[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nenkan1975[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
