Return-Path: <target-devel+bounces-104-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37785661A
	for <lists+target-devel@lfdr.de>; Thu, 15 Feb 2024 15:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD951C22BCC
	for <lists+target-devel@lfdr.de>; Thu, 15 Feb 2024 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1C132490;
	Thu, 15 Feb 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlTuQdap"
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644513246B
	for <target-devel@vger.kernel.org>; Thu, 15 Feb 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007993; cv=none; b=ny62Qdn5Lqd0ieWxEjgdVmTx4ZKhhpGef9cQwkRJP2E7wY6idznpC8iAI9gCcVhsNWbrVn4s//z8dw0/gAjVyzvzQE3IjGr7yWJ0kJnLMyvr1YCa0vOGOH2Xz7ZtVuTe/F2ZJD1/nijZFe7IR5o3/WzKO4QXbMgkQAow/CTaJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007993; c=relaxed/simple;
	bh=yfirhgvzqhvvTDWuDa6qT3uSz6iDfNexNWm1sMLqB1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSX/f2bMzQQDGls4xv6VWJMwggRyncOwwMViP/4eOczvmpRCc0n2FxZfOulN7iPioKzv3WIoZaDmwnrOy6q3QS3MZWbK/vK9eTLBVadxVmoSbqP7VT8ZqEe/+uJiqge2tBdwjdV50CzuCxHhq64vdh7V1OYBnezk4vLFVMRLNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlTuQdap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708007990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Dchf+V7L9NEpP1yW2LEbdlnO7STAfvA1Xp2MckaNXU=;
	b=RlTuQdapO93AmUEV5i2lfY/o4VyI9dbVyuZoxx4Yy3BMAmjtX9ixVMmKjHBUnjY+7luBzX
	isWOpqBDDaJTqeq7AJfkB7BN53akXSKlT+Hz8X+tG4Vy7gRPlzEJM6G3Rfje38sPhfdY/8
	FiFsyi/UF32i98fq1grY6AhOQLW/Ljw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-VPEGKrV1PJygBvAtV7yfIg-1; Thu,
 15 Feb 2024 09:39:48 -0500
X-MC-Unique: VPEGKrV1PJygBvAtV7yfIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E08A3C0009D;
	Thu, 15 Feb 2024 14:39:48 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0EBF0400D5CC;
	Thu, 15 Feb 2024 14:39:45 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: michael.christie@oracle.com
Cc: d.bogdanov@yadro.com,
	target-devel@vger.kernel.org,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com
Subject: [PATCH V2 0/2] Fix SELinux denials against target driver
Date: Thu, 15 Feb 2024 15:39:42 +0100
Message-Id: <20240215143944.847184-1-mlombard@redhat.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Steps to reproduce:

1) install the ibacm, rdma-core and targetcli
2) service ibacm start   (ignore the errors)
3) Look at the dmesg, you will see an error message like
   "db_root: cannot open: /etc/target"

4) Execute $ sudo ausearch -m AVC,USER_AVC -ts recent

   type=AVC msg=audit(1707990698.893:610): avc:  denied  { read } for  pid=26447
   comm="systemd-modules" name="target" dev="dm-0" ino=973050 scontext=system_u:system_r:systemd_modules_load_t:s0
   tcontext=system_u:object_r:targetd_etc_rw_t:s0 tclass=dir permissive=0

Fix inspired by commit 581dd69830341d299b0c097fc366097ab497d679

V2: fix a memory leak in the error path, add a patch to set
    a freed pointer to NULL to avoid possible double frees

Maurizio Lombardi (2):
  target: fix selinux error when systemd-modules loads the target module
  target: set the xcopy_wq pointer to NULL after free.

 drivers/target/target_core_configfs.c | 12 ++++++++++++
 drivers/target/target_core_xcopy.c    |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.39.3


