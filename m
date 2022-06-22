Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246C1554EA6
	for <lists+target-devel@lfdr.de>; Wed, 22 Jun 2022 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359038AbiFVPGl (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 22 Jun 2022 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359068AbiFVPGj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:06:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780CF3EBA3
        for <target-devel@vger.kernel.org>; Wed, 22 Jun 2022 08:06:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c205so9643499pfc.7
        for <target-devel@vger.kernel.org>; Wed, 22 Jun 2022 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=UdjSwRw+6oQ6qiUR+rRkUhjWOua8+J1yFZkG0uO49bJMwCFfyLLueiiFV2vREFvYD3
         QtS2Mf0rebC9FzTRPmreZMcP+LPiYCVXfn0eFFw6XFuKg0kRkGh+vWEx2v/l7D1oKJi9
         hGKEHoX3k08NLkUOnVvzYSZrQfOVoplrWXJZwl842JSBwC1OqwAZ4pzDGSUyMDeJ82oM
         ZkOJTKXBg+R/uW2vJUQ4lrGK0ukdXBHefoDrwFfs2t1CwgmBt9mgd2vmbpntmjRAq8Sv
         1FynTzIPvLnHdJnwSBERrCZIGHp62lUfkUT0AaQOfp2k1f6J2WeAAzrI5UDlUpblHuF0
         +8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=bmLc6LS6IWS36IIaIKZDTw53R/PFb+5YO4dBtXTzYlli/RM3a+AgjeWJTP95C1WU7w
         yBbuoSw9CZpJogPcHJRS0aubqvN4ARLQcudwUZn75B8S1KSHfCbljCN3n5sEBurvA/i5
         oB87RIUEvR7R4A2YSW1K/56ctA7aEAUhP307wQ/ETY+5AsZ33gvSlZhu8BwjxsSSI13d
         3END5tICHxqjfFOP4lpy9qRE8SmiWhCuNNvFYXD2PSGL+ol4/BdRWbrdGjrqnCM38TY9
         /E4pKM0hju5OvB9NGGSAXWybh/lfLDdO3Idswb1xu6PwJPbNNPWZCOAdLKNS2xoWEZ60
         485w==
X-Gm-Message-State: AJIora+za759jnZkCI+uZQxmP/78uPZOiAHPLYawretpm0syYnPZhGeA
        27jcNkiNBbllQ76h2GiF9ZGA5IkbG7/f7eiRuZM=
X-Google-Smtp-Source: AGRyM1vf/g0ul1trLFEAu7oYWn9j7QPhrxQj2kFug+Wf51rlwJHcE5bY2L1/LDYmR9NhUHUSJA/sC5iD4j6lOoGUUZ4=
X-Received: by 2002:a63:8c50:0:b0:40c:fa26:9738 with SMTP id
 q16-20020a638c50000000b0040cfa269738mr3295495pgn.541.1655910397895; Wed, 22
 Jun 2022 08:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:2308:b0:16a:1b3f:f74b with HTTP; Wed, 22 Jun 2022
 08:06:37 -0700 (PDT)
Reply-To: sales0212@asonmedsystemsinc.com
From:   Prasad Ronni <lerwickfinance7@gmail.com>
Date:   Wed, 22 Jun 2022 16:06:37 +0100
Message-ID: <CAFkto5thhNhkkGjQ3S6MhMGPs7Qzv1MpCVsUz+gkgdDGLSPYXA@mail.gmail.com>
Subject: Service Needed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

-- 
Hi,

Are you currently open to work as our executive company representative
on contractual basis working remotely? If yes, we will be happy to
share more details. Looking forward to your response.

Regards,
