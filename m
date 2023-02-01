Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF456861E9
	for <lists+target-devel@lfdr.de>; Wed,  1 Feb 2023 09:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBAIqp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 1 Feb 2023 03:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBAIqn (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:46:43 -0500
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 00:46:41 PST
Received: from mail.penmade.pl (mail.penmade.pl [94.177.230.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D31B4FCE5
        for <target-devel@vger.kernel.org>; Wed,  1 Feb 2023 00:46:40 -0800 (PST)
Received: by mail.penmade.pl (Postfix, from userid 1001)
        id 7654C842CD; Wed,  1 Feb 2023 08:36:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=penmade.pl; s=mail;
        t=1675240624; bh=CSKXLMgcdpWkXuTgJn5+jsCVobtU9JEF4vCnS5z6McM=;
        h=Date:From:To:Subject:From;
        b=DlB2ETeZDkzRXCTWa0HQA8p2faDQlCo0ZKEP4+D9pvprEnw4fGjNfuyhDGY4iCSmK
         7yBiSMJBajufnGFrUA2RyJXm3VMpj8ybuK7MT/cpLYcw6EAvtMf4vQ0lGNkbqubTBX
         g173LUTVCWn++hCWX5uFKj2WNSGYKu/g+NFjsXiUNi+3y2Dw5a+TE9dFMAOzfAjgcz
         zlJueErH3KuiSi2vNR575GaCASmjRlsDer8JLDTsttyu1mfh926sFBQ4sRD3C/6BX6
         PxRSJM1pmDQ5XkOIf4+7zig5JHdSgVNpgwjhEtZIMzdMAEzH7JQKGUcy4e5M0SdUQT
         AzWDUmw0QIw7Q==
Received: by mail.penmade.pl for <target-devel@vger.kernel.org>; Wed,  1 Feb 2023 08:35:42 GMT
Message-ID: <20230201074500-0.1.25.7mqp.0.9r5cvkbjy9@penmade.pl>
Date:   Wed,  1 Feb 2023 08:35:42 GMT
From:   "Wiktor Nurek" <wiktor.nurek@penmade.pl>
To:     <target-devel@vger.kernel.org>
Subject: =?UTF-8?Q?Nap=C5=82yw_Klient=C3=B3w_ze_strony?=
X-Mailer: mail.penmade.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_CSS_A,
        URIBL_DBL_SPAM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: penmade.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.177.230.163 listed in zen.spamhaus.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3039]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [94.177.230.163 listed in bl.score.senderscore.com]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: penmade.pl]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Dzie=C5=84 dobry,

chcia=C5=82bym poinformowa=C4=87 Pa=C5=84stwa o mo=C5=BCliwo=C5=9Bci pozy=
skania nowych zlece=C5=84 ze strony www.

Widzimy zainteresowanie potencjalnych Klient=C3=B3w Pa=C5=84stwa firm=C4=85=
, dlatego ch=C4=99tnie pomo=C5=BCemy Pa=C5=84stwu dotrze=C4=87 z ofert=C4=
=85 do wi=C4=99kszego grona odbiorc=C3=B3w poprzez efektywne metody pozyc=
jonowania strony w Google.

Czy m=C3=B3g=C5=82bym liczy=C4=87 na kontakt zwrotny?


Pozdrawiam serdecznie,
Wiktor Nurek
