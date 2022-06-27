Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE80655C206
	for <lists+target-devel@lfdr.de>; Tue, 28 Jun 2022 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiF0JYX (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 27 Jun 2022 05:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiF0JYV (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:24:21 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D35590
        for <target-devel@vger.kernel.org>; Mon, 27 Jun 2022 02:24:20 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-101ec2d6087so12207127fac.3
        for <target-devel@vger.kernel.org>; Mon, 27 Jun 2022 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ph19z67WWj8MKbdbfJ/X9NXE3OtaIRjlRTh0jWTZhVY=;
        b=Scq3EBgefJyL0K/eTJ01ilErBBHheYEntZWDM/k5KdrWO7TSTbzXYj27eukkh22f72
         3KPkb6vW9bBigvRxyy29YqvlG2fROvh0ckxJN2+BzeWc1W4ei3hDgPedZgGc7LAOaOdp
         b56jFFdr+qzqHTTvlfSGqVzZ/9C8uXqWbTpGebhQ3bdVSegV6AORnJVZVj6wJK2M2FTx
         cq5mTmDV2fJvYe+e4mJSIGnvG+bxyt3dictUkTNtWlR5/3mp+j2S91DbnNvDom2DpFXO
         p+IwElYGmnl3/PJlRwMp8+gxWdAEg/ngS6TGudUWJSTdBrb497HQgufHrybVqzfEk3aQ
         NmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ph19z67WWj8MKbdbfJ/X9NXE3OtaIRjlRTh0jWTZhVY=;
        b=No4MZgyqvcOK9WuaQ23kWKR8uwzKka9DaKMXfdcnoKNQyBsAW/Xf8K/ve28Yhg270M
         vk+5c+Uy2ulP1b3aiAiOG89+SnwDiMhQRyaOpYsQHzWKbp6kF+q+LpYF9eUTLeTWPnYm
         I5CeD5Vc6JWS5KEf+C9Lvu0nCMxCbX8nGwOESG9cE0ocklgoTrvl1wyERwv3pEYucRTD
         kgu5VLkgH7+LDQ7YzfmejMckdJ2IXKkCH2py+wHT6vAGHGncyffL753QYPx53maP0s2X
         Ef3NA5SbmpexSz8h+sXFEF/ph+gknpJXORk9S/rzmUPzQI+7qR52whE+Y1kMKJhfpvy4
         GRPQ==
X-Gm-Message-State: AJIora+/NSwf++bB6bze8jMa+joogNQhumbqw0wteDfz9LM2n+1PA12l
        p3DHcI+rs1bwLmzjTGUF6sHf76iLb/cX5nsdjWU=
X-Google-Smtp-Source: AGRyM1sEuiODhGqFsOqtHvkigmy5Lv2Tb7b+Ge2f6p5VSuC1PzCB0IC2pp1vNBP1dgzB3c/1b2me9jhlLv2BQ1vDRtI=
X-Received: by 2002:a05:6870:8323:b0:101:b25c:819f with SMTP id
 p35-20020a056870832300b00101b25c819fmr6983892oae.4.1656321860132; Mon, 27 Jun
 2022 02:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:af05:0:0:0:0:0 with HTTP; Mon, 27 Jun 2022 02:24:19
 -0700 (PDT)
Reply-To: josephkavin0111@gmail.com
From:   Joseph Kavin <danikadidja95@gmail.com>
Date:   Mon, 27 Jun 2022 03:24:19 -0600
Message-ID: <CAHTijp98-n0aWZAhzDTArgJTbER0JB6Pw2aiX-kawTJS33TNtg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi   are you available to  speak now

Thanks
