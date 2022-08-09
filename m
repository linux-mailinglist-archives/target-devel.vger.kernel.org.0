Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43658E203
	for <lists+target-devel@lfdr.de>; Tue,  9 Aug 2022 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiHIVqE (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 9 Aug 2022 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiHIVqB (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:46:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEFF4C61D
        for <target-devel@vger.kernel.org>; Tue,  9 Aug 2022 14:46:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bx38so14275869ljb.10
        for <target-devel@vger.kernel.org>; Tue, 09 Aug 2022 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=hnUM0lzwulX2q1QwimZooJGSc8HzCb0oOd/8o0YSo68=;
        b=DUj3Zy73RprhLaV+pD+4FumnUuUX8kdxUWekeST2+802TRbaZ/6HBAa+Xmgq8uenLI
         eVstukLHmjRD/kfj38q881JNZGfBrYqZ0O+LO5E9vcbLkXDFRtlxHLr6kSfhOnCRMIhf
         j3OdObtM1m9/wbiZy2tHS+T8if955OxQAX10jSIFeexl8LyEC5c9W/2Z1+Clqq9BTE8D
         AvOAEuM6+1ABInsCPREnzAyJ3455YGfncRj5COjOu9zVed1nlI3TRg6v1YqxHiL0OY6p
         RnafwHYML9uw4mrL8x3GQGoPG5AX5Cz35umY7JGdReXZyQ2XyIK5DCXda+Je9J4R4I6I
         OdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=hnUM0lzwulX2q1QwimZooJGSc8HzCb0oOd/8o0YSo68=;
        b=dfUTkoczACZmW/Y7MegyiX93Jki5ZvzL/rqHkV4In2ArL5YNAGKAUQVZyzibBO3yCz
         bnKwOdK3ibadaTnorVq9+eMvT5fiwjPGh64V2wM8B5Yt5grDRDRAZdgtjCwg/bR7UfU/
         /cwCpFdyBalU5eCNUkb/55lsABRlvZZiHC1LjwCdrX5bb3xJM+6l4s6C+LUOqrddF8HV
         1fA4WN0F3CqJPgZVnUghhE29s+4hS4aVXTvknWWTn7RurvBbGhKTb95pJd4fgJLnCGay
         xmJhu4DOu2/TKIbtsFePLpSMmUbIYlqtUC0/hh99dFdLW/laOf84PCSsZ30409krulg+
         WQEQ==
X-Gm-Message-State: ACgBeo32amvYVWgIgbUOiIJMfh11R14RTU174tCTZzq/AZNjocGiV11m
        m84iAYgWF4tJYpqc0uGTpNGGoQNzzoylkEWQFbI=
X-Google-Smtp-Source: AA6agR4b5kPOv29AggQn7TIMpieI5pisLkPS7r0hAVP0Pp7IWC2XgAm2MF7dknSI++Kx07LatB7dP9RgCOivsuU+O7I=
X-Received: by 2002:a2e:5351:0:b0:25e:7aef:a1c4 with SMTP id
 t17-20020a2e5351000000b0025e7aefa1c4mr6398247ljd.465.1660081558122; Tue, 09
 Aug 2022 14:45:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:1985:b0:1d9:6119:6b37 with HTTP; Tue, 9 Aug 2022
 14:45:57 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mr. Yakubu Abubakar," <yakubuabubakar1884@gmail.com>
Date:   Tue, 9 Aug 2022 14:45:57 -0700
Message-ID: <CANt38etMxq7mqXKJ0mpr=mtXKc8Ww4bhQ557+2R+WnCFhexsEA@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5008]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yakubuabubakar1884[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yakubuabubakar1884[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

My regards,
Dr. Yakubu Abubakar..

Sincerely,
Prof. Chin Guang
