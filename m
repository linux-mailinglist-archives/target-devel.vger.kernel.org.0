Return-Path: <target-devel+bounces-100-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78496856056
	for <lists+target-devel@lfdr.de>; Thu, 15 Feb 2024 11:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B4AB34B43
	for <lists+target-devel@lfdr.de>; Thu, 15 Feb 2024 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4612C7FE;
	Thu, 15 Feb 2024 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWeoVFXX"
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF612C54B
	for <target-devel@vger.kernel.org>; Thu, 15 Feb 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993321; cv=none; b=dgqW3yD5D737whmebBT2Z/bITEa32aqD5zVWB2i3m3LybDpPlDR7j5LzQ+sjAadkjehXBFBysmcByESliouphQ7GnUXSJ6J49QkIju0Nfuqx2w2vnEXIHW54nrHMosI+zy3uV7zCseryglWrUD04axyKRNenIDtNKrAloRa14jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993321; c=relaxed/simple;
	bh=HM9RkysB1yR6odbWU0DwqwCAtghl6ebXS98K5wHGsFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYet7pEIYvLs4ZWAc3C86jZvl/ad6O5jDztIRaNppQeD9dHu5RvcdnAeYPbKcQ88Rf5LmuE08C784TTU338vVjSE3A+mQjk3GC9n8G29VLvRZmJvvPYUID0Y6vM2oboGgnMua9/Rd0R5mmriC04+gHNvS3wAWkNNPLWQotRQodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWeoVFXX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707993318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2BsHwX3WvR0SnwEuMUPj0hNm2XQw4iJRc+VVZruDptY=;
	b=dWeoVFXXfiuAwgp1C2t2h11U9PHI1uw1vLDQ/SEKTTluapoePX1M6b+Y0M/Ck60YEB+da1
	60MQc02DYpWscJt5Llz7h6Dga1HL9LlQmJVHkFGM4SmRWR/9rCgJIvvrCjS6+C7r65QaYU
	dCYSp7q0bma2nbcjoR8k6gfKU0j9aNQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-oegHcztmMD6aN-AIcdC2og-1; Thu,
 15 Feb 2024 05:35:12 -0500
X-MC-Unique: oegHcztmMD6aN-AIcdC2og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 330D71C0BA47;
	Thu, 15 Feb 2024 10:35:12 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14DF728D;
	Thu, 15 Feb 2024 10:35:09 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: michael.christie@oracle.com
Cc: d.bogdanov@yadro.com,
	target-devel@vger.kernel.org,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com
Subject: [PATCH 0/1] Fix SELinux denials against target driver
Date: Thu, 15 Feb 2024 11:35:07 +0100
Message-Id: <20240215103508.839426-1-mlombard@redhat.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


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

Maurizio Lombardi (1):
  target: fix selinux error when systemd-modules loads the target module

 drivers/target/target_core_configfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.39.3


