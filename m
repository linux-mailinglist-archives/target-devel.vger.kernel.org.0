Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161D69F0B7
	for <lists+target-devel@lfdr.de>; Wed, 22 Feb 2023 09:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBVIxO (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 22 Feb 2023 03:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBVIxN (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:53:13 -0500
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 00:53:11 PST
Received: from mail.eskinair.pl (mail.eskinair.pl [185.80.53.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56EECDE6
        for <target-devel@vger.kernel.org>; Wed, 22 Feb 2023 00:53:11 -0800 (PST)
Received: by mail.eskinair.pl (Postfix, from userid 1001)
        id F036063E3A; Wed, 22 Feb 2023 08:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eskinair.pl; s=mail;
        t=1677055516; bh=iaAtwo6t3DtnWBK4iJ54LRCoPp+YkQJ25zUIE9wiSKU=;
        h=Date:From:To:Subject:From;
        b=p52QCzv/aQ7qUjdAaeBAlqFBDdkZzlKEfZS6FO9H3nb+jTnqTR1s65t6Wm1m1Qxsj
         wNOsLvmb70/SJzMFBTqwrE5/thiZnPt2qOmfc660KwfJDd4B+tg997XCFhxBGLIZDR
         P192O3shB1ehq6+KW17OFkP21o4+aFbowBGa/xadkSF/M1qOIp2/NEsK0udkkmMwhW
         p/Flm44+v1cRuCqvIsGejJkV7ueHWJUNkY2XEuHU+R2JCr5OyEa3etJt+jqFi0XNag
         xSDiEbptarMdY/4Jzm+dSb+ONX/UJ7d7vuh3bvQcgj0Od/uMUar8CLGzUaugcFa7/d
         gIH4nJxyWYl2Q==
Received: by mail.eskinair.pl for <target-devel@vger.kernel.org>; Wed, 22 Feb 2023 08:45:15 GMT
Message-ID: <20230222074500-0.1.2l.628m.0.2lonntsl5c@eskinair.pl>
Date:   Wed, 22 Feb 2023 08:45:15 GMT
From:   "Dominik Chrostek" <dominik.chrostek@eskinair.pl>
To:     <target-devel@vger.kernel.org>
Subject: =?UTF-8?Q?Nale=C5=BCno=C5=9B=C4=87_za_faktur=C4=99?=
X-Mailer: mail.eskinair.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: eskinair.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [185.80.53.209 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: eskinair.pl]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4984]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Dzie=C5=84 dobry,

chcia=C5=82bym poinformowa=C4=87 o mo=C5=BCliwo=C5=9Bci wyd=C5=82u=C5=BCe=
nia Pa=C5=84stwa sp=C5=82aty za towar.

Mog=C4=85 Pa=C5=84stwo z=C5=82o=C5=BCy=C4=87 zam=C3=B3wienie u swojego do=
stawcy za kt=C3=B3re my zap=C5=82acimy we wskazanym przez niego terminie.=
 Po wp=C5=82acie wystawiamy Pa=C5=84stwu fv sprzeda=C5=BCy z odroczonym t=
erminem p=C5=82atno=C5=9Bci (30-90 dni).

Je=C5=9Bli takie rozwi=C4=85zanie jest dla Pa=C5=84stwa interesuj=C4=85ce=
 b=C4=99d=C4=99 wdzi=C4=99czny za odpowied=C5=BA czy mog=C4=99 przedstawi=
=C4=87 szczeg=C3=B3=C5=82y.


Pozdrawiam
Dominik Chrostek
