Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A90770DDF
	for <lists+target-devel@lfdr.de>; Sat,  5 Aug 2023 07:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjHEFNZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 5 Aug 2023 01:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFNY (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 5 Aug 2023 01:13:24 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4D4EDA
        for <target-devel@vger.kernel.org>; Fri,  4 Aug 2023 22:13:23 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5860c7fc2fcso31433787b3.2
        for <target-devel@vger.kernel.org>; Fri, 04 Aug 2023 22:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691212402; x=1691817202;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=H3P4T8OEC3n2iegtAandu0JC4IsIFo4uVFoBH+OevwhLQu2dcQJR0jv13p/6euIT0a
         VG1EFPRhRWW4OPCYnRTFM8122OdSThZCI+uatKa3ieDJ62khA1wfp0ZL0XhY7PqPp+fM
         XaPccLKDtJKQ8CWDhnNj1qrjRdZuXV1XDavij11eBmxm9JGi3fe9gFWqXi7zpR2bGUrm
         tt8FvChZpl+1fheViaGNP4wzf4KETVf8JQhVZKB2RbMq5LrJ5k4gCgDg+UwjOHjRIoky
         9I03ZiiTYM910sXowxql9J4b0CnQeP0eUdX0m7YAgep8UCnQk33iiKSk4vOuwwhxKPtV
         aOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691212402; x=1691817202;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=jklDJsBnE3/H3uxPe7Nyi9Pcid+FweppGlqonxj3h/RSJzVQt1ut+Zj1hHDqNMUVb7
         BfW5I0GqEBbWf2WBliU/6CRTO68ueMcnZ7QbhOqZsYm5Z7mEDvmNVk6xkfyb7+k+ygas
         FebGQoAYzPZZFqsUNVvGOFhMEYSlU/hsyevCv4BHOu7/BwBvxJ+yyQBFaXh8Pw8/iosa
         prU/kow5WoHvFLhrb96397gt8TxSvhrtpPPod5f4jypzE3XRukTWKA3UtVPUGpoLAgW3
         J4dkURvbfu7zwbL99iJFzJgzi99Jwf83tyTBTJptgXxKrN1j6KR8DtSK+4MTUHYeQPc7
         KCMg==
X-Gm-Message-State: AOJu0YwxWnzUnzAT/vTNxf6VUWyUfcnoiK12mrgxHweLNh/FW/7Nm2hs
        SabR2NX6aHl8X4PldwxYmcHdREiGmvCiTmpVDlM=
X-Google-Smtp-Source: AGHT+IHxTIrH1F3KqtXuyvQZ2XGKSMOMmpH0SuBM0JbKRvyDSvKfRNRdzkyiDbCDV6cKdle+JJIgJU2iI643kxpseSk=
X-Received: by 2002:a25:2447:0:b0:d08:20f1:f7cd with SMTP id
 k68-20020a252447000000b00d0820f1f7cdmr3877449ybk.16.1691212402461; Fri, 04
 Aug 2023 22:13:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:6254:b0:377:d5d4:4eb0 with HTTP; Fri, 4 Aug 2023
 22:13:21 -0700 (PDT)
Reply-To: bintu37999@gmail.com
From:   BINTU FELICIA <gatotusb@gmail.com>
Date:   Sat, 5 Aug 2023 06:13:21 +0100
Message-ID: <CALyoYrP=mDkN0qDWa-TjXLEa-UQDLzdg-cW4pN4L51xw9W8A0Q@mail.gmail.com>
Subject: HELLO...,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
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
