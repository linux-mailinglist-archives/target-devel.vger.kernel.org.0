Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFA6CB90C
	for <lists+target-devel@lfdr.de>; Tue, 28 Mar 2023 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjC1IHV (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 28 Mar 2023 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjC1IHU (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:07:20 -0400
Received: from mail.penmade.pl (mail.penmade.pl [94.177.230.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A110D8
        for <target-devel@vger.kernel.org>; Tue, 28 Mar 2023 01:07:16 -0700 (PDT)
Received: by mail.penmade.pl (Postfix, from userid 1001)
        id 6B0A984888; Tue, 28 Mar 2023 09:06:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=penmade.pl; s=mail;
        t=1679990835; bh=CSKXLMgcdpWkXuTgJn5+jsCVobtU9JEF4vCnS5z6McM=;
        h=Date:From:To:Subject:From;
        b=G2xhzLrro08nMfnW43aJPxkvptxgghHGYyitn8OAXZgIO9NfJnl+L/7gad4oxNz5N
         ze7S28mFArMiQ3BUvqfwNuTa7dzHv/DDwn6gmnDIdKXPv8IBTQacJgMxxXTeMXHQLo
         e670ZAgfD6AJnFHoy3bXQR/kcjIg+m7/yuohiNf6o87i+IL+4Ev7NnEzpFig1xrGxX
         KP7D7JJXv8rCh4jBzCQ2igWul50z2u/uxuooXAhQHUn9wBF3OIZCKgcBggoZ0fVx95
         EWbYyCkx/WFJAHeqIw/Ibg2uOWaJNcGHsifnqRivQMEs7xi2sUv3ZmTHaqQ2Ks7e+3
         QV9M/oJgeOa7A==
Received: by mail.penmade.pl for <target-devel@vger.kernel.org>; Tue, 28 Mar 2023 08:05:52 GMT
Message-ID: <20230328074501-0.1.39.eoxn.0.rjpjgwpp4r@penmade.pl>
Date:   Tue, 28 Mar 2023 08:05:52 GMT
From:   "Wiktor Nurek" <wiktor.nurek@penmade.pl>
To:     <target-devel@vger.kernel.org>
Subject: =?UTF-8?Q?Nap=C5=82yw_Klient=C3=B3w_ze_strony?=
X-Mailer: mail.penmade.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: penmade.pl]
        *  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.177.230.163 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: penmade.pl]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [94.177.230.163 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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
