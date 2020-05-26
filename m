Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6A1A72DA
	for <lists+target-devel@lfdr.de>; Tue, 14 Apr 2020 07:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405424AbgDNFPW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 14 Apr 2020 01:15:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54903 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729007AbgDNFPW (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586841320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EkNLNHwZfOUTusQOw40Jzr/je7WbnUGoqzc8vWN5NV8=;
        b=Sz1sWYPtr61jChyRWPEZ8zf6s2B0XlYuXQfpH5ILpCWdrS/dXyAEIkEIgV2sHkFoRAAWJ7
        HeREpPD0uAFpX6ohQdz5g4p4KJOSPVtG1wsKRzT0cHrUs3eGLn53gNsEyuAoE8irGWlDzs
        haj8+tC1V1IEImxpZMFlvVY430gS4EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-uFra4obzMfWoRnMeCQY-SA-1; Tue, 14 Apr 2020 01:15:18 -0400
X-MC-Unique: uFra4obzMfWoRnMeCQY-SA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2ED4800D53;
        Tue, 14 Apr 2020 05:15:16 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-112-105.rdu2.redhat.com [10.10.112.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07FD41001DDE;
        Tue, 14 Apr 2020 05:15:15 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     jsmart2021@gmail.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        nab@linux-iscsi.org
Subject: [RFC PATCH 0/5] target: add sysfs support
Date:   Tue, 14 Apr 2020 00:15:09 -0500
Message-Id: <20200414051514.7296-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The following patches made over Linus's current tree allow lio to
export info about structs that the kernel initiates creation of
via events like initiator login where there is no user interaction
like a mkdir. These patches specificially focus on the
I_T_nexus/session but could be used for other objects if we want.

Why sysfs when we have configfs?

I started with configfs and hit bugs like:

commit cc57c07343bd071cdf1915a91a24ab7d40c9b590
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Jul 15 18:16:17 2018 -0500

    configfs: fix registered group removal

but it turns out that bug was not really a bug and was just how
configfs was meant to work. It seems it was not meant to be used
where the kernel initiates creation of dirs/files as a result of
some internal action. It's more geared to the user initiating
the creation, and my patch just lead to other bugs and was
reverted:

commit f19e4ed1e1edbfa3c9ccb9fed17759b7d6db24c6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Aug 29 23:13:30 2019 -0400

    configfs_register_group() shouldn't be (and isn't) called in
rmdirable parts

So to export the session info we have debugfs, sysfs, ioctl,
netlink, etc. sysfs just seemed like a decent fit since one of the
primary users is rtslib and it already has lots of file/dir
handling code.



