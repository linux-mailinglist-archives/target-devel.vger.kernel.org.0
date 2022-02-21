Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3050A4BEB0B
	for <lists+target-devel@lfdr.de>; Mon, 21 Feb 2022 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiBUTSk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 21 Feb 2022 14:18:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiBUTSh (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:18:37 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A295F88
        for <target-devel@vger.kernel.org>; Mon, 21 Feb 2022 11:18:10 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o24so28793429wro.3
        for <target-devel@vger.kernel.org>; Mon, 21 Feb 2022 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kvhZrpHBK0kPy/iKTd/Hcailtj+KjaeLTS+rPhszZPs=;
        b=DvKvy4anWNpS713ruDITpK8IGz6yYCH8AwvjaRhPgx6UqY+1yApgXuN95QoKzY16ua
         k8wEmqqtfp0LsSRz5qv7qAdcrGFLtH8Jhl1vWJsdKQI5Mbr807uOtNQnOZIcl06XzO2b
         MRfvfZIeL3t7wU5jWhrOFiYQPP/BNjrHD7IBtcJwnjFcJrREUCIoEXxD8bBZclpU2/XN
         Fq+HeKsz3vgygYaV5QSQmALtlGKTRag0ufJ8et7dPY8OJAybSsat2lqpbPCg0nAYAmw2
         CqLM77XHNpfLctk3RgyQC89rik+NvSz2wXYZlrq4inP/++nXWbkeI2NOqvfQtb1pHhKM
         m7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kvhZrpHBK0kPy/iKTd/Hcailtj+KjaeLTS+rPhszZPs=;
        b=5xC4UNgQ5KZJ2RrNGeQCcX5FwmuwXJNcf8HRdK3eYDoIP6Q7Ef7mLTlBBbR8n+59Hl
         j9+sx9pDkqAvdfXFkohQciUyAVAdxFUrQBkZGLrnWVcQkQ/1PRrhuWugzkAkd5bvxfzK
         oPoDpHo/pYIKPeDSq9QjQ3GubJJxpxTEaW2F9a5xMlhnXPm8259RvvQIMqBvubR3zXk3
         cDd1ckCmlaeXNRNZrpvIDj05FTVQncm227p/9VVe/p5dkbshZBFTB9Ozvs60EJi64y+J
         ypTK7iPJ+AS+f4nO8Qf6WrC/067Z7mBXZ/Croy0FxZeNdqu8r6PHDjXtoRj95jlq2r1x
         EV+A==
X-Gm-Message-State: AOAM532kIuxeQYZDztuBzTqeavEBWcVnqsuqvNZwp8YnhiJ0KwavAJdy
        +GKcl6liD9fX5R7CV+NJnLukEZSKxLhpk0tBiss=
X-Google-Smtp-Source: ABdhPJwkrndb61WcPmfegEqKY5hx76jmw0qG8ijOi3O3cg1b0D1psyG+s2c3jkhnn+1kA6n2bhxblvT85Gi0WkY0vCc=
X-Received: by 2002:adf:df0b:0:b0:1e4:979f:a56f with SMTP id
 y11-20020adfdf0b000000b001e4979fa56fmr16438990wrl.686.1645471089071; Mon, 21
 Feb 2022 11:18:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:e488:0:0:0:0:0 with HTTP; Mon, 21 Feb 2022 11:18:07
 -0800 (PST)
Reply-To: jgrollande@gmail.com
From:   "Mrs.Noah Emily Sara" <nichsteve1@gmail.com>
Date:   Mon, 21 Feb 2022 11:18:07 -0800
Message-ID: <CAOgf51Bi06jf84Zqs4AY-ikdw+UV-gc-f8mRv9jqWh_4_8dGsg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nichsteve1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nichsteve1[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

My names are Mrs.Noah Emily Sara I'm from Alberta Canada but stay here
in the Bradford United Kingdom. There is something

very important I want to discuss with you.

I'm a very influential and wealthy woman but I'm sick and dying. I'm
suffering from severe oesophageal cancer and have a few months to
live. I send you this message because I want to make a donation to you
for charity purposes. I would like to donate funds for charity and
investment purposes to you.

Get back to me so I can send you more details about my donation.

Warm Regards,
Mrs.Noah Emily Sara
