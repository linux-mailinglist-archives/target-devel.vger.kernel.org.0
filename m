Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9967AA59
	for <lists+target-devel@lfdr.de>; Wed, 25 Jan 2023 07:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjAYGbh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+target-devel@lfdr.de>); Wed, 25 Jan 2023 01:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYGbh (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:31:37 -0500
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40BD37F20
        for <target-devel@vger.kernel.org>; Tue, 24 Jan 2023 22:31:34 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D72B93FEC4;
        Wed, 25 Jan 2023 07:31:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JNjGPvr-9v88; Wed, 25 Jan 2023 07:31:31 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id BBA9A3FB38;
        Wed, 25 Jan 2023 07:31:31 +0100 (CET)
Received: from [104.28.225.223] (port=50971 helo=[192.168.1.6])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pKZJN-00060a-Rl; Wed, 25 Jan 2023 07:31:30 +0100
Date:   Wed, 25 Jan 2023 07:31:09 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Mike Christie <michael.christie@oracle.com>,
        target-devel@vger.kernel.org
Message-ID: <b5033c6.ace55084.185e79f846e@tnonline.net>
In-Reply-To: <0d52151e-f3cc-f1a3-0e6f-2144ab588189@oracle.com>
References: <cd1ab2c.ace55083.185e577f69d@tnonline.net> <0d52151e-f3cc-f1a3-0e6f-2144ab588189@oracle.com>
Subject: Re: iSCSI target: kernel: NULL pointer dereference
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



---- From: Mike Christie <michael.christie@oracle.com> -- Sent: 2023-01-25 - 00:58 ----

> On 1/24/23 14:28, Forza wrote:
>> For the past year I have been experiencing spontaneous reboots with days or weeks between each time. So eventually I got a tip to enable pstore and was able to capture several traces, and all are the same. See below. 
>> 
>> I am using Alpine Linux with kernels 5.15.x all the way up to 6.1.6, but the issue is the same. The issue seems to be mostly triggered when Windows 2016 servers that have some attached storage are rebooting during maintenance. They do not boot over iscsi, it's just extra storage for some apps on those servers.
>> 
>> The target backingstore is using FILEIO ontop of a Btrfs filesystem (i.e. no pass-through to sas controller, etc). There is write caching enabled, but it happens even without it. I opened a report on bugzilla, earlier. There is a saveconfig.json from targetcli attached there: 
>> https://bugzilla.kernel.org/show_bug.cgi?id=216959
>> 
>> The issue seems pretty reproducible, but I am not sure how to debug further. Please advice. 
>> 
> 
> Are you using iscsi's multiple connections per session (MC/s) feature?

No, just single sessions.

> 
> If you just use a single connection session or multiple sessions with each
> session having one connection with MPIO does it work ok?

There is only one IP on clients, so I am not sure how I can configure MPIO. At least Windows does seem to allow this. 

https://paste.tnonline.net/files/GXulIOnf6kQV_iscsi-initiator.png

I guess I have to enable more than one connection to the targets, but this seems dangerous?

Thanks 

