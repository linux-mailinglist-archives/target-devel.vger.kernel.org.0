Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4CA6349AC
	for <lists+target-devel@lfdr.de>; Tue, 22 Nov 2022 22:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiKVV4D (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Nov 2022 16:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiKVV4C (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:56:02 -0500
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 13:56:00 PST
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A36E541
        for <target-devel@vger.kernel.org>; Tue, 22 Nov 2022 13:55:59 -0800 (PST)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 152831054B2
        for <target-devel@vger.kernel.org>; Tue, 22 Nov 2022 21:50:38 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.48.61])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8A43FA0083
        for <target-devel@vger.kernel.org>; Tue, 22 Nov 2022 21:50:36 +0000 (UTC)
Received: from mail.lunahosting.net (tomservo.lunahosting.net [67.20.55.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6C8C6C006B
        for <target-devel@vger.kernel.org>; Tue, 22 Nov 2022 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lunadesign.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=REFH20XCpaR/hRuCLW2bU03WCPq0xrek2RX3qlucCKo=; b=IMoWx4EXNP6UcFKGSgFy/Ankg0
        DyREnJ0zbsWUQmLGM6+KYezyOrkBr81qI362YSTU0ZssF2bNaUe+uxFnNIPeh281speLvyBMX3MOI
        is6pN44rKUyaFUqB+RG6LmwQxhCgA6GMd11cF6px5/QY8xrv8QzpoU4GYTyj7xHPZFDl/c9vinFp/
        lY7XU1IWDLwueAnjYJJCR44p0NajSwXOUhwsabHxGA5ZsrcAZfIDVYI+/9XpHVDpcHvibBFydDZCb
        IuIXobBM7CIOhTo9kIiPPf+5zuKieXUs0k+7hCSgdmcQkPAP0y1L7O5xvvihGfLubZNbxWN0dOUtr
        BlN3JUXw==;
Received: from [50.126.108.206] (port=27642 helo=europa)
        by tomservo.lunahosting.net with esmtpsa  (TLS1.2) tls TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <ln@lunadesign.net>)
        id 1oxbA4-0002zi-OO
        for target-devel@vger.kernel.org;
        Tue, 22 Nov 2022 21:50:35 +0000
From:   "Luis Navarro" <ln@lunadesign.net>
To:     <target-devel@vger.kernel.org>
Subject: targetcli fabric modules
Date:   Tue, 22 Nov 2022 13:50:37 -0800
Organization: Luna Design Syndicate
Message-ID: <08aa01d8febc$74f61260$5ee23720$@lunadesign.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: Adj+vGs1xeBN365ASXqb/AmHhbJdLQ==
Content-Language: en-us
X-MDID: 1669153837-ZFSlKRSa6l2u
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi all,

I hope this is the right place to ask a general (possibly dumb) question
about targetcli and fabric modules.

My target is Ubuntu 22.04.1 LTS and my initiator is ESXi 6.7.  Both are
using Mellanox MCX515A-CCAT connected via a single 100G QSFP28 DAC cable.

On the server, I've used "apt" to install the "targetcli-fb" package and
have successfully configured it as an iSCSI target for my ESXi server.

However, I'm now trying to get ISER working and I'm noticing that when I
start a "targetcli" session, I'm not seeing "Using iser fabric module" (or
any "Using" messages for that matter) that I see in the snippet on
linux-iscsi dot org/wiki/ISER (excellent site, BTW!).

My question:  Do the fabric modules get loaded/enabled automatically
(perhaps when it detects a ROCEv2 enabled NIC)?  Or do I have to do
explicitly do something to make this happen?

Thanks in advance!
Luis

