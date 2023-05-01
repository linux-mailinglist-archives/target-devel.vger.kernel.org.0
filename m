Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E96F313B
	for <lists+target-devel@lfdr.de>; Mon,  1 May 2023 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjEAMxf (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 1 May 2023 08:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjEAMxe (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 1 May 2023 08:53:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165310D1
        for <target-devel@vger.kernel.org>; Mon,  1 May 2023 05:53:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so2130154a12.3
        for <target-devel@vger.kernel.org>; Mon, 01 May 2023 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682945612; x=1685537612;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W+Xyl8GFZnjIscOSe4qlAq6PZj3KVD/uO8v6sui6RQ8=;
        b=NZzMzBTFyGxSSsB6Ygc9igIimVu4WZbedZD6BXQiMgFJq0RBmzIeNwGEgQrMBLeBW/
         3YPCm4jmvL8iTCxCytv/iH4MrQTnX9FiZMeUIG1NciaCfRnl7pmMizisLlB4ZGTnwEx7
         t6GZnmoVQ4g542jQgEDEue21VOW36msRTxAw2undt6NUh7lXSysNQbnFUoSfU4IPcLlk
         OrGxeQmEBJY26vQlb7cwEXQythK5aHexxBfqoOyWMTyDFuIfA1dbLHgEAuqVXHW4WfWB
         OC3IV/nS62ven3QGGI4Ca70GG+WV/2UjORXUNyNYgt0s8tYUbZS+xEdqvmXUJbYUadCl
         HLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945612; x=1685537612;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+Xyl8GFZnjIscOSe4qlAq6PZj3KVD/uO8v6sui6RQ8=;
        b=NDf7Y0PpPTLgBrICUnpxkwvyiw5tJN2BmLJts872e6ZK/yqiRZJRLqLBckNbeyYwJE
         loN+rvvoBHH7a3gpPKJ8oBuQiG6Ru78Y/0XYtutgCU8Mc4vvCwDV/P2/crE0cFwiUgFW
         QGbKDGHYWJLXK/OcS0W7C5c9BuPCTwwbEZrAzP+b+0EtJWbYVTZYblGal/qYU833M6kZ
         ksxqOoXeaDxshG0NS6xmi3bQc97FmPudidxxZIy0lOdGeT/z2vG/wF0Oco2EspYhC3Yp
         QikoWysxOYho+/ge7BSNbxO7vWs8SkWBSxgXiQj+OYEkRjS483EauYUJ5zNbNWsrxtfI
         9CJw==
X-Gm-Message-State: AC+VfDxD+KFBiMGRDz+HzdZBTXUhlJ5QsP2lo3qqnYLaizdG7SYmoWJF
        XDHknp2ZH52j8iLbemJcUQ+h310wL7Sj6Y1Ewv8=
X-Google-Smtp-Source: ACHHUZ7EfILVh2dPA/Zwkw36z7LsSzoLv9YYccCcrG5FgngoCWtG+6QBcqjTsv+PLEMEb5eXDjnTnLuxmVBZiPxrWL8=
X-Received: by 2002:aa7:cac3:0:b0:506:a561:b0a9 with SMTP id
 l3-20020aa7cac3000000b00506a561b0a9mr6404903edt.14.1682945612108; Mon, 01 May
 2023 05:53:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:aaab:0:b0:209:e1ae:81f1 with HTTP; Mon, 1 May 2023
 05:53:31 -0700 (PDT)
Reply-To: lschantal86@gmail.com
From:   "L.S Chantal" <etp838558@gmail.com>
Date:   Mon, 1 May 2023 12:53:31 +0000
Message-ID: <CAHJkhGUuz6uxv=8SfOprUVg5XGsCAqJ8N14qqq6zBv6S03-gZg@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HK_SCAM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [etp838558[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lschantal86[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [etp838558[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.4 HK_SCAM No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED

NATION.
Your compensation fund of =E2=82=AC5.1 million is ready for payment
contact me for more details.

Thanks
