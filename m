Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD370977E
	for <lists+target-devel@lfdr.de>; Fri, 19 May 2023 14:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjESMsI (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 19 May 2023 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjESMsH (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 19 May 2023 08:48:07 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E59410F4
        for <target-devel@vger.kernel.org>; Fri, 19 May 2023 05:47:42 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-561bb2be5f8so40874947b3.0
        for <target-devel@vger.kernel.org>; Fri, 19 May 2023 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684500461; x=1687092461;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=BiTQo6np5k3OHql+6+yDqGLqBnU8Qn8mSw3BYI1geRkDGy/NvpBbjuOdREa7J9vMtF
         tXO3Mkk/YwiIGK2ftaOCSJ8Mys8sNx9WrL+5Gda5as7jAguQW/QrVQn8Sz1xdzBD4log
         EEwRP58DY9ULmFhz70Hb8rfxgfqjmAn8SWF4dVYb0jQXUuiv83gfP3ewslqwLH7z1I08
         uwNXO8SqFA7RtQXCRlWGzFXR16pNse7LW9hmZjmUNB9qSMNRMLv6NfyH7PL1UC61i2R3
         slWHwPtdXoXFKgirMU7+zPsPtKHc2T0R2xAL5kls5lKqkGdI71odyycxASEyc0FGFJxQ
         nyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500461; x=1687092461;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=L6SiB0siw8Vm/gLpfloXFteCe29g3X2wlWalMhQ5TuKhnF4vZbrPjRlEJy7ZzVlkyc
         OEJOccOW72ZSZh7dQrUsPquWlAgbwNQULQOUig588rPv8+HyyEh2cKWjq9rrCNWem5ZW
         AecRJTM0kqUQzSlmgelPBAZgNcC7jq7edZdQs13rcdf1tSGGPZKvg5wbRHsUKSKOX+20
         m9o0cfRXeGvFRHgcGjk1oT/8lbKOY1VktEGzS17NfvmN76B0buZWHgD6LJrJ6l2MAAEs
         FPqTjN5nsH2AhKf2R90rz2PIFlNUhcopq1ZIIiYINLJ1tozAatIQeu+4RkIjbLEW/BPA
         Loqg==
X-Gm-Message-State: AC+VfDzHXRMcuLljK0PBnJkBGo+0nGtBaQXX9EHsvKWoHj/q3ao+g/50
        hOIHVcqxEAMu4uGgcb2xhX1X8EJSjwiSYIkPInU=
X-Google-Smtp-Source: ACHHUZ5kXYUxrrf5cUhd9P7rRPQSMDiceKEZnF2ai7zgqZPN+H8aOz4dgKTVwisSEPR1vUEZn/VGt+Q5kGPBokmL4nY=
X-Received: by 2002:a0d:d80a:0:b0:54f:adeb:9898 with SMTP id
 a10-20020a0dd80a000000b0054fadeb9898mr1829679ywe.10.1684500461218; Fri, 19
 May 2023 05:47:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:4587:b0:349:f63e:5b3b with HTTP; Fri, 19 May 2023
 05:47:40 -0700 (PDT)
Reply-To: ninacoulibaly04@hotmail.com
From:   nina coulibaly <coulibalynina15@gmail.com>
Date:   Fri, 19 May 2023 05:47:40 -0700
Message-ID: <CA+8Vp3UCM0+QOHHc0FvR3ysi-RJHioPiAQZVFexN_TnbQxniGQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Dear,

Please grant me the permission to share important discussion with you.
I am looking forward to hearing from you at your earliest convenience.

Best Regards.

Mrs. Nina Coulibaly
