Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA25507D7
	for <lists+target-devel@lfdr.de>; Sun, 19 Jun 2022 03:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiFSBKn (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 18 Jun 2022 21:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSBKm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 18 Jun 2022 21:10:42 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C65E096
        for <target-devel@vger.kernel.org>; Sat, 18 Jun 2022 18:10:42 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j16so7441189vso.3
        for <target-devel@vger.kernel.org>; Sat, 18 Jun 2022 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=r9s45iLFR7996ZhX6f5bROMLZTrx/NqqeK2ijAW5crg=;
        b=lKUyqE2a158jiS6hRDYXn+1cF+rxyRfDrusMZ4bstWJGUu1DI81BhNaiPjHOpXQ9g1
         M04mvpVxGQwAGw/oAhOclSf7ddo+zGBv5rFu6xv0YYaasupTRvsoI5M3smp6r9QA3viG
         c++R7fJbEXDW/m1H5d54foNp8doZFO6p1l93LnfYZHdprVOS5qqowvTo3QSOd164uT6g
         84UNfCf1DoYYMPnjQ6CFmh/nAzz+Lmf95XzMaCFkuCFWCIKSnKUXb+gt2v+YoxjVmUpB
         XxahynbtOSEYaYWq3rm2RRH8PdWGe2xnh4k3mIsUcCha+pBZz7Wv3By5WCgiYMmyoMbR
         pF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=r9s45iLFR7996ZhX6f5bROMLZTrx/NqqeK2ijAW5crg=;
        b=VEwYXUTS/BxOZG42rp8Ha0Xm0T/zaqNXhBsQwbH2fD6MuuQWskuXs4Ppm4WjDORLzl
         AqaMaFBlmpKjs+gFBJfh8OllCowS11NCkWkZCI1ftYubyVU0VNHXgoEdrcp9s8yE2ZFJ
         N0u6K6L5D+X8E/k7jOwc4/6i08C/YtwfczYLEGRhLv453cW1J9zSGaWW75/GIjagSHEd
         bUHfgCDTlMaWo6iJBnrbh+9pg/FlGOf2PyIAucX4KOkrw0yZhF8Pk4SdEL801bJh093t
         SmJ26XhrIoixhjeerg4XXv7EgYdewkT4deVyeE+7XCEkpNimm490ZSqYVE0EegN1ejaR
         F86A==
X-Gm-Message-State: AJIora8MwUQCCQpz1bMeMnwSzPuhqGqE52QsGW/Fnx9a0z1NNfVTZgtC
        qI8eF57QQfZqgluxnk8YN6zc8OOeL4tI7dQTQ3A=
X-Google-Smtp-Source: AGRyM1ukct/kINq3vlmkecLzwIbl0yLUGLk+Ee3YtfKjZMAtqCJIEKAcU2Dc7FyfED5eTqsiWCVWHDlknVf1mEhs4cc=
X-Received: by 2002:a05:6102:38ca:b0:34c:2402:1a20 with SMTP id
 k10-20020a05610238ca00b0034c24021a20mr7461643vst.83.1655601041161; Sat, 18
 Jun 2022 18:10:41 -0700 (PDT)
MIME-Version: 1.0
Sender: hamzaafarizaa@gmail.com
Received: by 2002:a05:612c:2220:b0:2cd:51e8:669d with HTTP; Sat, 18 Jun 2022
 18:10:40 -0700 (PDT)
From:   "Mrs. Hamza Farizaa" <hamzmrsfari@gmail.com>
Date:   Sat, 18 Jun 2022 18:10:40 -0700
X-Google-Sender-Auth: iH4daZ3LTWIbXjmCtykLSEJOGps
Message-ID: <CAHw4SCXRTt9P9-N2+B1HuiwZZAnohUYrJYOkkpa4VxCsZ0vB4A@mail.gmail.com>
Subject: I think you can
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLY,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e44 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8796]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hamzmrsfari[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 HK_SCAM No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

May peace be with you,

My Greetings in the name of our family, This is the second time i am
contacting you with regards to the charity work. I am Mrs. Fariza
Hamza, an aging widow suffering from longtime illness. I am currently
admitted in a private hospital here in the capital city of
Coted=E2=80=99Ivoire.

I have sum amounts of US$17.500 Million dollars i inherited from my
late husband Late Mr. Mohamed Hamza, the sum will be disclosed to you
for security purpose which he deposited in one of a Bank here and I
need a very honest and God fearing person that can use this funds for
God's work and purpose, 15% out of the total funds will be for your
compensation for doing this work of God. I found your email address
and i decided to contact you.

Please if you would be able to use these funds for the purpose and
God's work kindly reply me back. on ( hamzamrs027@gmail.com )

Yours Sister.

Mrs. Fariza Hamza.
