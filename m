Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB7D6EFBA7
	for <lists+target-devel@lfdr.de>; Wed, 26 Apr 2023 22:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjDZUcQ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 26 Apr 2023 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZUcP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:32:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776461FE1
        for <target-devel@vger.kernel.org>; Wed, 26 Apr 2023 13:32:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso5472953b3a.2
        for <target-devel@vger.kernel.org>; Wed, 26 Apr 2023 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682541133; x=1685133133;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=D131puIHV2FmcGRCdpsLDSIy2AMZAqvP6ARBUAHld0AErxG5w5exCsuTjBAeYvUxAY
         TfhOQhCLDcJBLBfAcqvRRNYDAad30e9ZjqhTrJ6x/ygU1w3eJbGW6SgTpZqqXdIGB6lT
         XZGORhMaqgGIiffHJZeY7XigGI7V4RwP72JH/EA++3O/NvUT0RnfJlSQ4y0m95ZPs1fw
         6wsP/GZPA4xPu1wW6i6cJyW+UcY8/SxokiK0vBeORiOH6bl1vOd18GQIUHqZ2wB2JiSo
         QnU+cMTeoyo2Hmfee5enKub0427CRBTJVSg7a4TCXVpm/LlTjP1wej7GqGEEYVnw7/aH
         KeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541133; x=1685133133;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=fi/+/cLotMNqoced2vTnoLCHC3f65TnDuVkzx9Ycipg50oyhB0OKU1TMDwqOw+diJM
         FpI0ixjKEZAfxYFT3KrAfeHronH5PqD2EIiH4+uudBzcu755VzqE++ciJq9fMnLaDyII
         DN2j6h248Xg5SXoOzE0xvS7J8LrGufmKsS/xe6u/SsaNHyzSGJe9+ncaSNxtoovAGPwV
         N3Wyv3AMmRYTIJz2pkh3AjinbGC91k3stCOR6wim29UTTtfZ8vuHkECVegW2apZ8N+bJ
         k6QHRhHqdk4I+GOhSg17kjSk14t7MQGRCxLTWU5qD8U21HeSNgFJxZrfoGTBxtaoiNsR
         9UpQ==
X-Gm-Message-State: AC+VfDy7g455BoDmrguNBlV4HrsMce1npn//sCeyufyd/s0g/2Sb8dOn
        QocIBWrHWIQGqA5MEJY6FT0vGd2q+JHzrLFz2Vc=
X-Google-Smtp-Source: ACHHUZ7ZTdTjgDkjjsQYklcKRnXCRcegEqThrj/rjxO0NMprF0B247gqe57BIhonGenVnea47SJ49AX5MXF2S7Ls3KI=
X-Received: by 2002:a17:902:f682:b0:1a9:85f2:5df6 with SMTP id
 l2-20020a170902f68200b001a985f25df6mr9193395plg.6.1682541132814; Wed, 26 Apr
 2023 13:32:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:6397:b0:62:6247:38e with HTTP; Wed, 26 Apr 2023
 13:32:12 -0700 (PDT)
Reply-To: klassoumark@gmail.com
From:   Mark Klassou <pastoremmanuelkonan74@gmail.com>
Date:   Wed, 26 Apr 2023 20:32:12 +0000
Message-ID: <CAAbfB5S047vuRKB=U=7JH+rW2Tsj4XjMeKicz+qPdp_xUw4qWA@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Good Morning,

I was only wondering if you got my previous email? I have been trying
to reach you by email. Kindly get back to me swiftly, it is very
important.

Yours faithfully
Mark Klassou.
