Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE414F0DAA
	for <lists+target-devel@lfdr.de>; Mon,  4 Apr 2022 05:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351898AbiDDDSp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 3 Apr 2022 23:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346706AbiDDDSo (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:18:44 -0400
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Apr 2022 20:16:49 PDT
Received: from mta-out-06.alice.it (mta-out-06.alice.it [217.169.118.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 528C72D1FB
        for <target-devel@vger.kernel.org>; Sun,  3 Apr 2022 20:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alice.it; s=20211207; t=1649042209; 
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Date:Message-ID:MIME-Version;
        b=G/9sJ6xLoHGKZnbLPheE0y9UdN4AKF2oisLs1T9F0niA0QVZq34zR9ApUJKc8LBy+wXuSytPYcELi2M0C2VmRyrFxbPXVOePOO7ZEI/DEWVBG3qHT1FC8GLMpH4hAAYvrU3D7CT+Zr/b2rdscv6DN/wPR5lIDM7Hw/74KntamrPQ+OQvnM2iQWEzvDaOTmwfY7tE940rU5UZCDKuah6hgp6pm0ZkFxUArX7+kHxYDuWufAbIszTOdaMh3jn0iXoQLGd8pCPZAIsgIHgQXAIJuO+z9IQO2UTd66JEFepsXz5oP80ekggrI5k89tubFeckn7NaK4MbFhonYRk6LdRYHQ==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudejuddgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdengfhmphhthicusghougihucdlhedtmdenucfjughrpehrhffvfffkggestddtfedttddttdenucfhrhhomhephggvuchhrghvvgcurghnuchofhhfvghruchtohcuihhnvhgvshhtuchinhcuhihouhhrucgtohhunhhtrhihuchunhguvghrucgruchjohhinhhtuchvvghnthhurhgvuchprghrthhnvghrshhhihhpuchplhgvrghsvgcurhgvphhlhicufhhorhcumhhorhgvucguvghtrghilhhsuceofhgpphgvnhhnrgesrghlihgtvgdrihhtqeenucggtffrrghtthgvrhhnpeehjeetgefhleetiedtkeelfffgjeeugeegleekueffgfegtdekkeeifedvvdffteenucfkphepudejiedrvddvjedrvdegvddrudeltdenucevlhhushhtvghrufhiiigvpeefkedtnecurfgrrhgrmhephhgvlhhopegrlhhitggvrdhithdpihhnvghtpedujeeirddvvdejrddvgedvrdduledtpdhmrghilhhfrhhomhepfhgpphgvnhhnrgesrghlihgtvgdrihhtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepthgrrhhgvghtqdguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 60
X-RazorGate-Vade-Classification: clean
Received: from alice.it (176.227.242.190) by mta-out-06.alice.it (5.8.807.04) (authenticated as f_penna@alice.it)
        id 623C9D2101212A14 for target-devel@vger.kernel.org; Mon, 4 Apr 2022 05:11:11 +0200
Reply-To: dougfield20@inbox.lv
From:   We have an offer to invest in your country under a
         joint venture partnership please reply for more
         details <f_penna@alice.it>
To:     target-devel@vger.kernel.org
Date:   03 Apr 2022 20:11:09 -0700
Message-ID: <20220403201109.39F749BA7DE75008@alice.it>
MIME-Version: 1.0
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,BODY_EMPTY,
        DKIM_INVALID,DKIM_SIGNED,EMPTY_MESSAGE,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5147]
        *  0.9 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [217.169.118.12 listed in bl.mailspike.net]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [217.169.118.12 listed in list.dnswl.org]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dougfield20[at]inbox.lv]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [f_penna[at]alice.it]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blacklisted
        *  1.8 MISSING_SUBJECT Missing Subject: header
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts and no
        *      Subject: text
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  0.0 BODY_EMPTY No body text in message
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

