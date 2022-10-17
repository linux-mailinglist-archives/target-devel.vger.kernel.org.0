Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6E60089B
	for <lists+target-devel@lfdr.de>; Mon, 17 Oct 2022 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJQISX (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 17 Oct 2022 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJQISV (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:18:21 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 01:18:21 PDT
Received: from mail.flyingprice.pl (mail.flyingprice.pl [193.142.59.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B942101F8
        for <target-devel@vger.kernel.org>; Mon, 17 Oct 2022 01:18:20 -0700 (PDT)
Received: by mail.flyingprice.pl (Postfix, from userid 1001)
        id E037523D64; Mon, 17 Oct 2022 10:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flyingprice.pl;
        s=mail; t=1665994247;
        bh=kECt9x2dzkW1QJ5sNZ9CqfHxrNzLdZ2r55b5WGK2SS0=;
        h=Date:From:To:Subject:From;
        b=z/n5EgRzb5E9pGdVz0rYYPqcG+JroeHQQz8SVvgGJgoNBYuJqFacBlZy0CKk4BrKR
         xZ+3+2X5e99QsU0nn/CLk7RGPh9UIVEdzo0k2ruO3qvnuVNm91m5y11kxoq8LKHo0G
         9MD0gYlH0LYs3hGEkAAWx1gnvl5mgo92M4c6lDS2f11MmFt8BinxfBgbUJS8SIGM8D
         Om97/rstAgweLzlik0irBESrsocN94PYqJrVkGGohQLEz4zZfJoqtlgK6g/ZcRTq7Z
         AdiA9OQLLFn50qkdTBdmxIhAXnBNRfQ0UZjcYakdaY5ADaj4gRk5FOQNI5Ly1Mswm/
         X02fT4PC4x/bA==
Received: by mail.flyingprice.pl for <target-devel@vger.kernel.org>; Mon, 17 Oct 2022 08:10:41 GMT
Message-ID: <20221017084500-0.1.1f.2djs.0.6canm3ejsw@flyingprice.pl>
Date:   Mon, 17 Oct 2022 08:10:41 GMT
From:   "Patryk Zawada" <patryk.zawada@flyingprice.pl>
To:     <target-devel@vger.kernel.org>
Subject: =?UTF-8?Q?W_sprawie_zam=C3=B3wie=C5=84?=
X-Mailer: mail.flyingprice.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_PBL,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [193.142.59.204 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [193.142.59.204 listed in bl.score.senderscore.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Dzie=C5=84 dobry,

mo=C5=BCemy zap=C5=82aci=C4=87 u dostawcy za zakupione przez Pa=C5=84stwa=
 towary, a Pa=C5=84stwo ureguluj=C4=85 faktur=C4=99 w p=C3=B3=C5=BAniejsz=
ym terminie (30-90 dni).

Takie rozwi=C4=85zanie wielokrotnie sprawdza si=C4=99 u naszych Klient=C3=
=B3w, wi=C4=99c je=C5=9Bli chcieliby Pa=C5=84stwo zobaczy=C4=87, jak to w=
ygl=C4=85da w praktyce-prosz=C4=99 o wiadomo=C5=9B=C4=87.

Ch=C4=99tnie zadzwoni=C4=99 i przedstawi=C4=99 szczeg=C3=B3=C5=82y.=20


Pozdrawiam
Patryk Zawada
