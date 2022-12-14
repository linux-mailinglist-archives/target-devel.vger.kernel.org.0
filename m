Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493E364C594
	for <lists+target-devel@lfdr.de>; Wed, 14 Dec 2022 10:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLNJKZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 14 Dec 2022 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLNJKX (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:10:23 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462A10FF5
        for <target-devel@vger.kernel.org>; Wed, 14 Dec 2022 01:10:22 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id c190-20020a4a4fc7000000b004a3addd10b5so2275788oob.1
        for <target-devel@vger.kernel.org>; Wed, 14 Dec 2022 01:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nuvBIf2lT6ew8E3Gonh9xI5Qgd+TLMqmI33+g9gdqOQ=;
        b=G0PNtRvJRXtlRPfmaVr9f1iNJSykI4rSVSTkRsj5ZTY0PGdA1LtldGr8ZS6ylSSEKK
         X5QYeUAncqVHXboWRt/3HBtj5+zPkm6tJ9dBKflkLwggeO2aNOqaC73Nv2XOWGavD71U
         rebLnU4IrlzNbE3yRfbSOIoILV1j/6wuIcWswCljfGoicK7IqKZVRL+Ou4a9ybYvdh+L
         loGGQMSBFRmPKbmchEPTFCn+1Fl+IwpJ2//7/5grV/24UZL3KlBDpIjqgvlIq2rDTrX6
         AFSHn6nm9U8jg8vFhhph2h/yPHuu2ZYwlh+84XfAi8NcRkF9K/17LxORevMXENLMwtlm
         Q8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuvBIf2lT6ew8E3Gonh9xI5Qgd+TLMqmI33+g9gdqOQ=;
        b=UxqVLAjRBgtqjwKcagq0m10K2+t54KQ1b+Xx/UW60b4nO7ygCAwZySS9U7x6ZGEGLS
         XjvqtN6CfZWNZL8CCS3pG1ZmyB3kjL1/cdI77Jgw8PT0wVaiOOSZKyxAc31yATLL/cFi
         VgbyVfLy06sdN5bVPZx3WF3RTNlfyRl5Sa9nxh/2Tcxx+aeyCm8UAaGadoEvQWH482dN
         tMWggu2wy7JnsJg3sqoSg5fqaUsxHviDoL29zzMZupd7HV6lHaANcVXroIWWnEIlGiPk
         6CilAZ+eNgsEzif+LRbK25lhplklxhp50XDtKzQG+2ZmLVM5Whr4vzWQW2mcnT/tgwMY
         92wg==
X-Gm-Message-State: ANoB5pkzHa4RIUXORg7KqnrQp3j5Ku5XKH8VhQ1PTPP0YVJE3ZvaDtxt
        kjhc5l7/MQ5700wUPyyU5IBnk+iBsSInimVYHZg=
X-Google-Smtp-Source: AA0mqf4FwgYmxLqXp5R6N11klJQuY9vmleodwghNoh0cg/IDrh8j/DF0An8RETR/DWxXy1X4gVdYEwIQxclp7QzTx/g=
X-Received: by 2002:a4a:892f:0:b0:49f:46ea:1bbc with SMTP id
 f44-20020a4a892f000000b0049f46ea1bbcmr31524489ooi.53.1671009021551; Wed, 14
 Dec 2022 01:10:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:7211:b0:dd:1fa2:ef73 with HTTP; Wed, 14 Dec 2022
 01:10:21 -0800 (PST)
Reply-To: phmaanu21@hotmail.com
From:   Philip Manul <lometogo1999@gmail.com>
Date:   Wed, 14 Dec 2022 01:10:21 -0800
Message-ID: <CAFtqZGFLnyoWNRa8xhs4Sk_1A6t7k7HSwYv7KsEW4S5gSvmSsw@mail.gmail.com>
Subject: REP:
To:     in <in@proposal.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNCLAIMED_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [phmaanu21[at]hotmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lometogo1999[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lometogo1999[at]gmail.com]
        *  2.4 UNCLAIMED_MONEY BODY: People just leave money laying around
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.0 ADVANCE_FEE_3_NEW Appears to be advance fee fraud (Nigerian
        *      419)
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--=20
Guten tag,
Mein Name ist Philip Manul. Ich bin von Beruf Rechtsanwalt. Ich habe
einen verstorbenen Kunden, der zuf=C3=A4llig denselben Namen mit Ihnen
teilt. Ich habe alle Papierdokumente in meinem Besitz. Ihr Verwandter,
mein verstorbener Kunde, hat hier in meinem Land einen nicht
beanspruchten Fonds zur=C3=BCckgelassen. Ich warte auf Ihre Antwort zum
Verfahren.
Philip Manul.

***************************************************

Good day,
My name is Philip Manul. I am a lawyer by profession. I have a
deceased client who happens to share the same surname with you. I have
all paper documents in my possession. Your relative my late client
left an unclaimed fund here in my country. I await your reply for
Procedure.
Philip Manul.
