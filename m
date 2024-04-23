Return-Path: <target-devel+bounces-133-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7098ADA1F
	for <lists+target-devel@lfdr.de>; Tue, 23 Apr 2024 02:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69FA287512
	for <lists+target-devel@lfdr.de>; Tue, 23 Apr 2024 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2C616ABC6;
	Mon, 22 Apr 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC2SVpG0"
X-Original-To: target-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC416ABC1;
	Mon, 22 Apr 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830190; cv=none; b=hQwko+bE7VLizKeJGQ592d9TwQik8VrXzlTnzeYOG7eUgE87VGDrCOdph8BwOD9Xjb9201lHtNR4zyQshmDr+dq2xDGiezkdOQwDzWn/MycVFPwIDebmRKMmTnMBePok0vSHGm1XKfr0yHLrF5sqLnn+L4Kz4QtvNVLeT5n3V10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830190; c=relaxed/simple;
	bh=ORskC7QabFrXJTepVrSUHDaq0bxupimv57Ilt7IRBYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baZfFBr4HkmnoNbrHuqfwc2KvpxUUea6mzfm+YiU6b9qb2Rab0auJ9yqS6ixS/AdMcEy0+OKAneMFyOzHPIR+kDSImiDEwY/2/RvBoDAkiii/qHxuPY0hgNZS96ZCukAf/dHcskXL1h/5KKmYgNem68GoJD+hCYDkX69KNZn+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC2SVpG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA3CC113CC;
	Mon, 22 Apr 2024 23:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830190;
	bh=ORskC7QabFrXJTepVrSUHDaq0bxupimv57Ilt7IRBYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NC2SVpG0HACxoKLptMS6fxBJHb1NUyTbho1aY7FMYyME4TEeYeVVrbbfDrEheO2Sc
	 NMqtkED8bbv2+Irye+nVisE/WVngqhe4HmxUBZCg2UGwKUj+Jv/ntcteFxRgoHctX0
	 xDsTm8aT5vQzWRvgkLk5bzh1qf9jTEdX3EgxoQfEnRs0CsQ0KHE6nPxhqAEWAxfCRA
	 2VOpY8tbrdatbZTdWtwk8yhxvAm2+iyWz1Qe3EoXykhNCBs5nFmBaJneCb9s0BmKvl
	 Gb7xzR80WLfzFXP1NVOGbQWo6hyeh7IChB1G0lUsv8h8ZvV8YkJfFON2LcImDokVff
	 We2Saa3DX6OkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/29] scsi: target: Fix SELinux error when systemd-modules loads the target module
Date: Mon, 22 Apr 2024 19:16:52 -0400
Message-ID: <20240422231730.1601976-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 97a54ef596c3fd24ec2b227ba8aaf2cf5415e779 ]

If the systemd-modules service loads the target module, the credentials of
that userspace process will be used to validate the access to the target db
directory.  SELinux will prevent it, reporting an error like the following:

kernel: audit: type=1400 audit(1676301082.205:4): avc: denied  { read }
for  pid=1020 comm="systemd-modules" name="target" dev="dm-3"
ino=4657583 scontext=system_u:system_r:systemd_modules_load_t:s0
tcontext=system_u:object_r:targetd_etc_rw_t:s0 tclass=dir permissive=0

Fix the error by using the kernel credentials to access the db directory

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Link: https://lore.kernel.org/r/20240215143944.847184-2-mlombard@redhat.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_configfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index d5860c1c1f469..9a88774836c9d 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3634,6 +3634,8 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
+	struct cred *kern_cred;
+	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3710,11 +3712,21 @@ static int __init target_core_init_configfs(void)
 	if (ret < 0)
 		goto out;
 
+	/* We use the kernel credentials to access the target directory */
+	kern_cred = prepare_kernel_cred(&init_task);
+	if (!kern_cred) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	old_cred = override_creds(kern_cred);
 	target_init_dbroot();
+	revert_creds(old_cred);
+	put_cred(kern_cred);
 
 	return 0;
 
 out:
+	target_xcopy_release_pt();
 	configfs_unregister_subsystem(subsys);
 	core_dev_release_virtual_lun0();
 	rd_module_exit();
-- 
2.43.0


