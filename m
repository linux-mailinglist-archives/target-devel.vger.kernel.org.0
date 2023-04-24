Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2030F6EC338
	for <lists+target-devel@lfdr.de>; Mon, 24 Apr 2023 02:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDXABW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 23 Apr 2023 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDXABV (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 23 Apr 2023 20:01:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8D10E7
        for <target-devel@vger.kernel.org>; Sun, 23 Apr 2023 17:01:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so24781055e9.3
        for <target-devel@vger.kernel.org>; Sun, 23 Apr 2023 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682294479; x=1684886479;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOTCnOQQwCWpkIcM1uCTBChxdASEHhizVtk2S1sGxDA=;
        b=fySL9W+vFzthWuCsBe1118rSYzsFqiJZXTMP9EYPXXWistkMhe8XfA3iOT/187Ft7a
         LiVJS8NG7ihWlXuellB0BgVbRYiqZLh3Y6g7K7q+Jd4YAhl5S2wkQvF/RiC2PyIzPeNL
         blJ6Eq7hW75XX9nazFxjezehWMGhEHB/flLpJar4Mu/mCp/dWHwxPsSjs7RBx1ujZIt/
         KdNcEbMgsZWpmhQnendI4cJV65Dpy8GX6rwfZCc6QGVhSmZMs00+BsWMY4Vy+ItNWtnc
         SNaAwIESUtBEXGWw48ziNJGyUbhUtW6XAxJlglJ3GVqT3lajM2l6KDQ//8JH/lqKRmNs
         C6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682294479; x=1684886479;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOTCnOQQwCWpkIcM1uCTBChxdASEHhizVtk2S1sGxDA=;
        b=l1drndFtIE529Ouw4PlosIknk+/loiU8gmgGQYV4r3phRpOO+HKXFduF5wKMuU2nGH
         andLnqAnPsbNU9u2C6BD7GQBxgV7h0On9VIQSjEIYG1wSGa4x/CnvWcJGrgzK97yijrr
         8B2ZtWd0YnfAitu7sifn6OZovit+9QAe+k3Q8srMYBb2IQj505DyH7+9cW+p7WuYFYlh
         O7iDD/oEc8iQr5S21xtG+srr3ISokyYw4rD92EwDos2ZZcXfKqDrdP087gEN3cq9fgV1
         8PF8KVbi9h1LaGvz6rtyhGH6O0UePFJ9uuqQAHjhyu8hDidGXEij+x8EUH68OcTPQD6n
         ilOw==
X-Gm-Message-State: AAQBX9dE0pbMj/GVMZMeIX/m/ZtwfKfgaRCGjxD2PeVy/Hm2WEKCmmgX
        TEKpg19kbSls62CaZcRlqWWoTA9Rn12GHoH43oE=
X-Google-Smtp-Source: AKy350bNXCpuMwYyyLD66+x4Fqcuf/10oGkDzjTckRbsdp25HQYJM8f0xY4a9ms56S1AyNB1PJfmtn1H/6KHvIH22AI=
X-Received: by 2002:a05:600c:24cd:b0:3f1:73ce:e1dd with SMTP id
 13-20020a05600c24cd00b003f173cee1ddmr6132767wmu.10.1682294478790; Sun, 23 Apr
 2023 17:01:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e352:0:b0:304:6d18:e431 with HTTP; Sun, 23 Apr 2023
 17:01:18 -0700 (PDT)
Reply-To: dinana1212lawfirm@gmail.com
From:   "Mrs. Diana Hamade" <lamido.sanusi800@gmail.com>
Date:   Sun, 23 Apr 2023 17:01:18 -0700
Message-ID: <CANLeZGBHft8q6V7n+jryA1CHNCUOJHyLn1GR6OrP2Y6kbG59XA@mail.gmail.com>
Subject: Second Notice
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Greetings
I have a business proposal that will benefit both of us. Please get
back to me with your name and phone number so i can give you more
details
Regards
Mrs. Diana Hamade
Tel:+971528946412
