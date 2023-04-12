Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A466DECA1
	for <lists+target-devel@lfdr.de>; Wed, 12 Apr 2023 09:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDLHgk (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 12 Apr 2023 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLHgj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:36:39 -0400
Received: from mail.penmade.pl (mail.penmade.pl [94.177.230.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D3D19AB
        for <target-devel@vger.kernel.org>; Wed, 12 Apr 2023 00:36:37 -0700 (PDT)
Received: by mail.penmade.pl (Postfix, from userid 1001)
        id 820328316C; Wed, 12 Apr 2023 08:35:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=penmade.pl; s=mail;
        t=1681284994; bh=CSKXLMgcdpWkXuTgJn5+jsCVobtU9JEF4vCnS5z6McM=;
        h=Date:From:To:Subject:From;
        b=X7qcymms0RgMwUPW4KwN83AlkEeLmv27RNqZw6sAARAB9OZ/p3Nd/l/C6qFd7B5/K
         lifZQZhzh1snGnT7rHikUxgVdieP5UwVCIDyTxMWK32GzhXJj1ISODi5TMm4NSy6tX
         gxnwO1IlM8tbFiZS/A2oWtR4j3ca2yxoVZox+HF8H5hqI8eXlSaluoRZCvl/vNXK/8
         gLMYSy1+UuCzMWDAGYfIlVrTZFxrcLdXom9F6BQXJqyl5yBtlsSdfmum4uqtkH/nGh
         Dd6bbfFwX9kdjov8MI4Gg6XlUO7G/QSBMIVQUuW7iMcyumDNHLKIqdkg2FQ+I1bbOw
         hx62r9tRz5AcA==
Received: by mail.penmade.pl for <target-devel@vger.kernel.org>; Wed, 12 Apr 2023 07:35:31 GMT
Message-ID: <20230412074501-0.1.3j.eoxn.0.5d9fayfhgm@penmade.pl>
Date:   Wed, 12 Apr 2023 07:35:31 GMT
From:   "Wiktor Nurek" <wiktor.nurek@penmade.pl>
To:     <target-devel@vger.kernel.org>
Subject: =?UTF-8?Q?Nap=C5=82yw_Klient=C3=B3w_ze_strony?=
X-Mailer: mail.penmade.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: penmade.pl]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: penmade.pl]
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0471]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.177.230.163 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: penmade.pl]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
X-Spam-Level: *****
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
