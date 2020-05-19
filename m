Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C51DA43A
	for <lists+target-devel@lfdr.de>; Wed, 20 May 2020 00:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgESWE0 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 19 May 2020 18:04:26 -0400
Received: from sonic305-3.consmr.mail.bf2.yahoo.com ([74.6.133.42]:37584 "EHLO
        sonic305-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgESWE0 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 19 May 2020 18:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589925865; bh=6mffK3RH01pMSJbI3gzRyn/TJ4jPuu2pqeTpPbg3ras=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Aj011fP+CTREFVEj2/uKZ5XKMqjeAlLjsCKdp93UfQDkQYWT6tYcmIgysN0t78soYZSKn1jr5f/EUMGus47nJockk0RtYiOFqkiLjjviVmclWysndAn9tlMwKHQKeZ67yMi4n/qiE3XLiNSZvNBG0VRWGauzIIzDo6brfHIJryWlqKMOlpyfHMA1nX7OP6mPZjYWS6B0dHmG0qlDvKpdR/z5hkWsPjd6wwJ2a2Q3rRLFyVuLCACxxuScjWDZuox5gI/OpH1m5w4L96RsgBMPakbeVQwalxXeVRrC4oHLULkI4tlbtETUNJ3fGiVXDuuMsPqXbKQJn8V0EEgNkQWubw==
X-YMail-OSG: YUrZCUMVM1mFmSbInZk7WAR7un7wLuhARl9bl7aURuN70Dlc5N3TuQPgjj9qK_v
 voRNLFIdo8mmuW4ZY9X0dXmT.1_QxaMdVBlaCH92D22QukiRZjYD5H0RWJ0HnamQUr0SM9vJkRHV
 T.tDkLbmTx94jFUU8OkMoFcvHmO_9HUapAUdet5psbK56Q_MMaWtCKGSLApDmSUmZx9jAUaNXn7i
 8ACiu21k.ZfjOnZ10KYORlNnRCud0WV1bhw1UKQVwC47ZgTpMDX3Pcrqzufjzf7432Iqsysd6gHz
 dadmNt2IuX3NSiGc438LQqyAh4A_xuO_5MblA3JrYGGkCRWbw.INQlHrN4mkj1fAF.7H_he1qlgr
 jR2i641G8rstu68dXlaDvcIxDYkGc_iNbhzYzfuAa6Jqjb_xk1P6Q842_AQaJtads4gVn4zfnUAB
 BzyTS9UWXsKnYFFNIrXe0.Xu3UVdAD4Y75FoIPHLeNgRNVh9hSX8H2SqO3IEBPpx5u6aFxLDH8gf
 HKNBBsVUUXBqsnLZ.9.9.JmyQT7EJWcPVcwNAwY7n5eGE4MvosJWIH1AsGQXM3Az1CrTq4X5KmIR
 APQ9nShXqmryHqme88jtdGRZugEHqNAkDgJy0B4jDcekHNJJnDWFcDPzWfNKxPuTbMKaJx4rFUYq
 euX1Aad.cXlmoa6UscRnO11vCwL7b8hBINoORUmN4bt5QhBW0wUP3xq2EbS6Ge4lNvcxUAM2gm0M
 cXIFK6jYNXg9oSe74xp_ysAHpCj0KwHf6OjBN.Po_sB9aofJs4tFyVA5eh9Qz8Ku2JIVEhgvoJ9l
 3ocdtMTK5I84_ERz5dbZ7oqkVIF3_N_E6DBX9aIFB_whtqHChNARb6VCwTiBWKlZiSOdFjqMncha
 RM93cV912gHNTiuB0M74Z7mJpf9.U3E7NplaEGQ0MtWhQ2.fnr7pA38a5GaCgv6GFWXt1U7.e_u_
 qFATApGRvUrI.bggvA6pOTHpW3tJLwt6vH0_ef5Ls0h4pdzTDM5mvVnyaBmTNXv3DOcBS2bKOIU8
 PhURYIeOLSxCygYZ_rBvmWbLIyvwDznU0_hvcgV3pS8RBzN56ZVmwgtMWpWuw.rvh1cuXrSixXuQ
 E6ahDjdI9GWYszYD9HQxjLT5QpEEHWaG7xHJEw4025wwxpcA2y_lv0Th_9_t7GM3amZOnyk9FIPT
 OdVMtWnar5XYTpOl_htpEtk8WrDzC94ATpoqiSYyzCHmEUPxeFyyixVbss8AkcU75MKRnGgnunsm
 H8YmrTSzK7oAuCfuxjHLoeRZcQ_tYarH6dRDHbEoGoSFBqxNOoaALzC5lCPIEqSd3HIDgVzYMFjK
 Ddw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 19 May 2020 22:04:25 +0000
Date:   Tue, 19 May 2020 22:04:23 +0000 (UTC)
From:   Rose Gordon <rosegordonor@gmail.com>
Reply-To: rosegordonor@gmail.com
Message-ID: <833794691.564681.1589925863973@mail.yahoo.com>
Subject: Hi there
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <833794691.564681.1589925863973.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Best of the day to you I'm Rose by name 32years old single lady, Can we be friends? i was born and raised in london in United Kingdom Take care Rose.
