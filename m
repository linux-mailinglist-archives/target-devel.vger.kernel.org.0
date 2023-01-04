Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0326065D3FA
	for <lists+target-devel@lfdr.de>; Wed,  4 Jan 2023 14:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjADNSe (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 4 Jan 2023 08:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbjADNSY (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:18:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16BDBF59
        for <target-devel@vger.kernel.org>; Wed,  4 Jan 2023 05:18:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so75568041ejc.2
        for <target-devel@vger.kernel.org>; Wed, 04 Jan 2023 05:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=bHjcrR7AvquGhVFfsIPd56FlsjuwDaBiXC3HYfHp5EzASd7vgcsdoCeeHo9hL9XA9W
         TYXvnnDtix81j/U+vP9Y3hroMghS5UiOtTmwxkkykK+nsoBKSmekO0/8PwH1nRAXJ3Ei
         Ch8Coc7+7KIzrUtGHEM2oBZV2WkyG/WaK+xPbygBRMH6yga6gkdRoHKckmApiXIc39Nk
         tKjs4KhHNJd2vUDCuhtLVHidMRI78YzMJoZB/qJqpW3gLOlS5AfXY3GMSmtNoZWglFfg
         2H3nNami1rhbrFTY9RU2JIuP6yyskw4ADxMjj8Ip5XFwa5BLOD6BAfVjprRfsw+ojnia
         6uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=rursXQLCn1oI2GdyFw7bHxk0hcNqqt/fvsvldtxMz/HA9PSqxbREfMYki4X6kLtejP
         swoGaqVF3lpCgsUWLOLMJQ7nAhrCGJR1bRtKD2k+0E0iJtdONWuu7lvJi10iKkyAXuE7
         8K2tm4HUtrA/sPPB1U8AistyOe7FJtwJvpI5mYWMj5jwOG70cMc45OyZ/gRxsMABs+uF
         jcZ4kt2B9XllNGZ4f/KQwnV1q1GOzSGlMS7efphIVR5t4zxBHul238HnvZqkGHhVvY0R
         NVll5hCVGS0slgle6q3X1J0TqP3NL0Fy4l6Lex7WiMtwZx/Km5gfLbvMD3uZAHXEskS9
         RMcQ==
X-Gm-Message-State: AFqh2kqaZ1UdciX2hmA6Qy/I/nOmZZZyv8nl3sarqVfrtlepOhuHdv8T
        0tKeMOUDNZVN0gknDqZh8uD49qxYNRVMm8XF1YE=
X-Google-Smtp-Source: AMrXdXvjisQMzGFdb+pqRz/u8RLz5xlwos7XNFOWglTrcNGmY3AD/MP/OQuaW2Sg/3Nyq7Yd10RIUJa0xfbbUA/jqx8=
X-Received: by 2002:a17:906:e24d:b0:7aa:ffd0:b738 with SMTP id
 gq13-20020a170906e24d00b007aaffd0b738mr6123383ejb.122.1672838301001; Wed, 04
 Jan 2023 05:18:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a98:b346:0:b0:19f:7dd9:3bc1 with HTTP; Wed, 4 Jan 2023
 05:18:18 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <thorstenhaastg@gmail.com>
Date:   Wed, 4 Jan 2023 13:18:18 +0000
Message-ID: <CAKOwuGmsxXBM2RBc0TEC8Ba321zo1xxiOeMtcmVDZ0XOe8YbAA@mail.gmail.com>
Subject: Seasons Greetings! This will remind you again that I have not yet
 received your reply to my last message to you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [gregdenzell9[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [thorstenhaastg[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


