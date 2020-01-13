Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9141396C9
	for <lists+target-devel@lfdr.de>; Mon, 13 Jan 2020 17:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgAMQva (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 13 Jan 2020 11:51:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:48622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgAMQva (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:51:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3DB6AAF63
        for <target-devel@vger.kernel.org>; Mon, 13 Jan 2020 16:51:29 +0000 (UTC)
Date:   Mon, 13 Jan 2020 17:51:28 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     target-devel@vger.kernel.org
Subject: Cannot log in from BIOS to linux target
Message-ID: <20200113165128.GC4113@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hello,

my system BIOS support booting from iSCSI.

I set up readonly target with no authentication:

targetcli shell version 2.1.fb49

grub .................................................................. [/scratch/ISO/GRUB (1.8MiB) write-back activated]
  | |   o- alua ................................................................................................. [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ..................................................................... [ALUA state: Active/optimized]

 | | o- tpg1 ................................................................................................ [gen-acls, no-auth]
  | |   |   o- mapped_lun0 ............................................................................... [lun0 fileio/grub (rw)]
The readonly flag does not seem to be honored                                                                                 ^^^

Anyway, the initiator cannot log in:

3,1360,2329588663878,-;Initiator sent zero length security payload, login failed
3,1361,2329588663897,-;iSCSI Login negotiation failed.

How can I export a LUN without a password?

Thanks

Michal
