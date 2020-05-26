Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647D31CCE4D
	for <lists+target-devel@lfdr.de>; Sun, 10 May 2020 23:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgEJV5w (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 10 May 2020 17:57:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42442 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727771AbgEJV5w (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 10 May 2020 17:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589147870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d9rX/zfDWHGn5HkavCodZaas52U6Kq+3RTu4U00tsvw=;
        b=OQCRWUeQmqu+Tl20i0rb4b9IEljPKf6wiBzZ2F6D4dcytBj+5ufAiCd+n6S4OLgMZZawMW
        g9XH2CNIMED4y64K68XY7YgmmybxrtEoNz22eq8kjGB24hUEvrzM7d10HyLEygkmODKGRq
        3xQXrk6Q990+KJrizA17s2wg/7/CJvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-CZ7KVWy9OZ6FQIRhuR6tfQ-1; Sun, 10 May 2020 17:57:48 -0400
X-MC-Unique: CZ7KVWy9OZ6FQIRhuR6tfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 764731899520;
        Sun, 10 May 2020 21:57:47 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-113-0.rdu2.redhat.com [10.10.113.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81F761002382;
        Sun, 10 May 2020 21:57:46 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH v5 00/15] target: add sysfs support
Date:   Sun, 10 May 2020 16:57:29 -0500
Message-Id: <20200510215744.21999-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The following patches made over Linus's current tree allow lio to export
info about structs like the se_session that the kernel initiates creation
of via events like initiator login where there is no local user interaction
like a mkdir.

Why sysfs when we have configfs?

I started with configfs and hit bugs like:

commit cc57c07343bd071cdf1915a91a24ab7d40c9b590
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Jul 15 18:16:17 2018 -0500

    configfs: fix registered group removal

and it turns out that bug was not really a bug and was just how configfs
was meant to work. It seems it was not meant to be used where the kernel
initiates creation of dirs/files as a result of some internal action. It's
more geared to the user initiating the creation, and my patch just lead
to other bugs and was reverted:

commit f19e4ed1e1edbfa3c9ccb9fed17759b7d6db24c6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Aug 29 23:13:30 2019 -0400

    configfs_register_group() shouldn't be (and isn't) called in
rmdirable parts

So to export the session info we have debugfs, sysfs, ioctl, netlink, etc.
sysfs just seemed like a decent fit since one of the primary users is
rtslib and it already has lots of file/dir handling code.


V4:
- Don't drop const char use in fabric drivers.
- add Documentation/ABI
- use initaitor port prefix instead of generic "session"
- only make session_id file if iSCSI format=1 is being used.

V3:
- drop format field
- delay tpg deletion to allow fabric modules time to remove their
  sessions.
- Added root sessions dir for easier lookup if userspace has the
  session id.
- add session symlink
- use simple ida.
- Fix goto use. Actually moved sysfs addition call to after nego
  to avoid sysfs additions when login ends up failing.
- Dropped target_setup_session callback fixups and dropped the
  init/free session callback for now. It's not immediately needed
  for this base session sysfs info support.

V2:
- rename top level dir to scsi_target
- Fix extra newline
- Copy data that's exported to sysfs so we do not have to worry about
configfs and sysfs refcounts.
- Export session info needed for tracking sessions in userspace and
handling commands like PGRs there (still needs a way to notify userspace
when sessions are added/deleted, but that will be a different set since
the focus is different).


