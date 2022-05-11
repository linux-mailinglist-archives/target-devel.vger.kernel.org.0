Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625D7522B64
	for <lists+target-devel@lfdr.de>; Wed, 11 May 2022 06:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiEKEnf (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 11 May 2022 00:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiEKEnd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 11 May 2022 00:43:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001AFA0D10
        for <target-devel@vger.kernel.org>; Tue, 10 May 2022 21:43:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e24so1138511pjt.2
        for <target-devel@vger.kernel.org>; Tue, 10 May 2022 21:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=s3Cdswvtyrq8qHVwuRB9YRoTAIoD9G/2//h6WeFZHzo=;
        b=cATSTZkJ3ihDr7kmGJT5peIk4WzATgziNlLDQUaQF0UjlDqgoEEuGaUrbUqldJ31oR
         vabmbeFahRwl3lPbxxDBTmLTUVgtoY1muM2STFJtAzdS2/uSXQL/RgxLgwTMgi6wZC5y
         9jgvSsXhPDebEC+KeA4Yp5ZuYqS0IZCNAwEYvRF90XYQCKM/5RYtpKtYGDwmBfroTwaV
         1kjYRadfleXzzdkACPIOP5V24SpiU9H+uY4/l89+6jdTamZt/dBupBOYqgZ1ZOGcp0Kc
         rHgsvHxiWrGCkefizlgJ1/E5wTpZjYmPWzkULzoPVy/TUF5Wl3VJLwp8t2mpFTdixXxi
         RXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s3Cdswvtyrq8qHVwuRB9YRoTAIoD9G/2//h6WeFZHzo=;
        b=TPEE0L879QWFxIA7X0jYG7mkcY4vG9JDkDc+IuiyRYkAtzYdE1Ru18SqhAFCTbFvkc
         jgQoTutKcWXxL1yUfEW3plaHrTu/i4sEQQn8RBmbjTgF72zOt7DUk2bam6u4khPw8Mxn
         hBgsV884M6RFPRbKAfc3gYwVuZVZOtzW2RZ4IyziThmYV2x7PaDQhCc8gv7V750WQBZp
         MTFmvVNNNbqecxiZO2Ad0raX8dy7Cmw+pHQmqk4F7rD1IvbYVwcOmZ5g8Hm+YD+qUIVh
         6hG7CL/V2d3WDH3Q8g+UnAMYiqqQTSrq6CM0hOssxrp6QtA59eiPLiPtqRFc/r3n6rHN
         oUYA==
X-Gm-Message-State: AOAM531acPFNaNWwAumjvP1WF+2mQX67UzsLduB66lbF9lG0TIJvDUn6
        CQ/azX0vk+gEIBHcQO1v7BS2SXYK+qwEXmdrKt8=
X-Google-Smtp-Source: ABdhPJxm5feB8ZFgWHkCEpggtBzqg6dLDwsr8iBU2Yy9cypEMDQj02HE7vMvH1ARhebCA2i8QIBvAnFPu1l+uxcE0Lc=
X-Received: by 2002:a17:903:2287:b0:15e:99b4:9b0a with SMTP id
 b7-20020a170903228700b0015e99b49b0amr23702716plh.43.1652244211258; Tue, 10
 May 2022 21:43:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:319:0:0:0:0 with HTTP; Tue, 10 May 2022 21:43:30
 -0700 (PDT)
From:   Private Mail <privatemail1961@gmail.com>
Date:   Tue, 10 May 2022 21:43:30 -0700
Message-ID: <CANjAOAjhJ4ieJMmzRZUBxfOb_bWq+QvWGKAj5_rzjwB5+n510w@mail.gmail.com>
Subject: Have you had this? It is for your Benefit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DEAR_BENEFICIARY,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Our Ref: BG/WA0151/2022

Dear Beneficiary

Subject: An Estate of US$15.8 Million

Blount and Griffin Genealogical Investigators specializes in probate
research to locate missing heirs and beneficiaries to estates in the
United Kingdom and Europe.

We can also help you find wills, obtain copies of certificates, help
you to administer an estate, as well as calculating how an estate,
intestacy or trust should be distributed.

You may be entitled to a large pay out for an inheritance in Europe
worth US$15.8 million. We have discovered an estate belonging to the
late Depositor has remained unclaimed since he died in 2011 and we
have strong reasons to believe you are the closest living relative to
the deceased we can find.

You may unknowingly be the heir of this person who died without
leaving a will (intestate). We will conduct a probate research to
prove your entitlement, and can submit a claim on your behalf all at
no risk to yourselves.

Our service fee of 10% will be paid to us after you have received the estate.

The estate transfer process should take just a matter of days as we
have the mechanism and expertise to get this done very quickly. This
message may come to you as a shock, however we hope to work with you
to transfer the estate to you as quickly as possible.

Feel free to email our senior case worker Mr. Malcolm Casey on email:
malcolmcasey68@yahoo.com for further discussions.

With warm regards,

Mr. Blount W. Gort, CEO.
Blount and Griffin Associates Inc
