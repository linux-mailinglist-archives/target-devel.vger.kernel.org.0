Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8123B847B
	for <lists+target-devel@lfdr.de>; Wed, 30 Jun 2021 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhF3N5V (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 30 Jun 2021 09:57:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51976 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbhF3Nz0 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:55:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8FA1422585;
        Wed, 30 Jun 2021 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625061176;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=D8DzDR+/4iPOyGTqIBWCz19n/ccYlb+CMZuJ0YDDHgg=;
        b=lWx4RK/9hO6MtFTceMIfzNi9eLujKCcppTLFwDf6nJqm4H2WUt4aB3mxreVKhpSl4zaNbO
        gPMwWUG/o6KmFnkYfTAY/Ya6Rn5rzvOWsGgKFw8zvDMXkZKsDNkSe5lgBK5BebbKWBLcWh
        d03r2HCM2AG/0pEKdxGMhnQ0P0nj0vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625061176;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=D8DzDR+/4iPOyGTqIBWCz19n/ccYlb+CMZuJ0YDDHgg=;
        b=zcgsLgPivGhKIwKO1WbnzSYJCWUsEsPg9qIH893AD5vWQ7OhsDsdQLiZaUnwB6Cf1/aJBy
        JSK89TrFQtWxUvAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 86A12A3BB4;
        Wed, 30 Jun 2021 13:52:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80E29DA7A2; Wed, 30 Jun 2021 15:50:26 +0200 (CEST)
Date:   Wed, 30 Jun 2021 15:50:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com
Subject: Missing message prefix in target_core_device.c
Message-ID: <20210630135026.GP2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,

I've noticed that after loading the target core there's a message in
syslog

  "Rounding down aligned max_sectors from 4294967295 to 4294967288"

but without a prefix, printed from drivers/target/target_core_device.c.
It's pr_info so the prefix should be defined at the top of the file as
pr_fmt and it'll be picked by the pr_* macros automatically.

I'm not sending a patch as I don't know what would be the preferred
prefix, eg. drivers/target/target_core_user.c prints "tcmu daemon" but
does not use pr_*, and there are several bare printk calls in the same
file.  This should be unified in some way but I'm not familiar with the
target code.

d.
