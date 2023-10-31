Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2713F7DC942
	for <lists+target-devel@lfdr.de>; Tue, 31 Oct 2023 10:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbjJaJR0 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 31 Oct 2023 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343740AbjJaJRZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:17:25 -0400
X-Greylist: delayed 620 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 02:17:22 PDT
Received: from mail.thrivehub.pl (mail.thrivehub.pl [164.132.48.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194DAA2
        for <target-devel@vger.kernel.org>; Tue, 31 Oct 2023 02:17:22 -0700 (PDT)
Received: by mail.thrivehub.pl (Postfix, from userid 1002)
        id 1AC63247F4; Tue, 31 Oct 2023 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thrivehub.pl; s=mail;
        t=1698743196; bh=m3ZUCTPRVLoDFM+cXi7VhHW+xNF3eUdGHrj1eDbLwQI=;
        h=Date:From:To:Subject:From;
        b=YNc7XCtJ2nDz+7Y9ZX09Zcw8B5A1nV36O/eJJbG0RXZugVrLdF/o0JlOMRXXN8EaY
         FdeRWm+J6IpJDbFa4bR7nOs5bPSgPeiIw/7VQSwWGcJDomrOTWNdIF+RCJd8km79de
         Mq1mpvPrblIM7bMUsPzDi+MYiehD0op6gAAX7BUW2bRli9Uhpg7fGG4RZMWBkbt9Nj
         PujeUSq5k32Tl9+qNY6e/HbEIO1gEdWZRjhGpXsQZw8JeKqJ2Kkr3P6O5Yk4BliaCX
         vY5hhKEex302IF+aKwoVIZJdWdqClwdGWTj4zKpS3yDRLJbBB9OFiPZyGRFmYz9Kmz
         2mIMM+XQ8ZtNA==
Received: by mail.thrivehub.pl for <target-devel@vger.kernel.org>; Tue, 31 Oct 2023 09:05:59 GMT
Message-ID: <20231031074500-0.1.2o.13x77.0.r9c51n7eep@thrivehub.pl>
Date:   Tue, 31 Oct 2023 09:05:59 GMT
From:   "Szymon Jankowski" <szymon.jankowski@thrivehub.pl>
To:     <target-devel@vger.kernel.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.thrivehub.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L3,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: thrivehub.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [164.132.48.43 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.0 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [164.132.48.43 listed in bl.mailspike.net]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: thrivehub.pl]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Dzie=C5=84 dobry,

Pozwoli=C5=82em sobie na kontakt, poniewa=C5=BC jestem zainteresowany wer=
yfikacj=C4=85 mo=C5=BCliwo=C5=9Bci nawi=C4=85zania wsp=C3=B3=C5=82pracy.

Wspieramy firmy w pozyskiwaniu nowych klient=C3=B3w biznesowych.

Czy mo=C5=BCemy porozmawia=C4=87 w celu przedstawienia szczeg=C3=B3=C5=82=
owych informacji?=20


Pozdrawiam
Szymon Jankowski
