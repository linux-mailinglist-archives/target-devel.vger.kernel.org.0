Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559B319D92A
	for <lists+target-devel@lfdr.de>; Fri,  3 Apr 2020 16:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDCOcd (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 3 Apr 2020 10:32:33 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:35571 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728224AbgDCOcd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1585924348; i=@ts.fujitsu.com;
        bh=gkUoq9qEc52Ya/44oopFoxwEPEm0/lDBsCPfddoakkg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=tyvKyUhMpwDVFpzlFmrndY6kxWmorq8Gxz34AcdGNyq8sehsKGP1F4/tWJy5ikbVX
         JfkIwvTG3djFwX3gUxP/mLUfGO1szYZnRnb90PF9aENgqGFfV9KPCaIPJikPFEgxM3
         nwNIsheFRX6ayXKsAip2JVCb6om3LJWFFMYYfppScpiC/jDP+oHcbqYTad63raY5hM
         jyt5CPMwFAS8q1z7WX7Y6GnYD5Uz+XXXHvIdew58RfOLL7PQV0fWeIH1MCvismPLgu
         YLFx8yJ9PTLUXtszThZzcr2zh+U/SadagGDvSNkimB+opclOJJlgN4HxM8ea86df6S
         oiELq0x6f7ASg==
Received: from [100.112.192.149] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id A9/36-46627-CF8478E5; Fri, 03 Apr 2020 14:32:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeJIrShJLcpLzFFi42Kxs+GYovvHoz3
  O4N88aYuv/6ezWKxcfZTJYvnxf0wW649sYLRoXfqWyYHVY/fNBjaPj09vsXi833eVzWPz6WqP
  z5vkAlijWDPzkvIrElgzFl97xVwwWa9i68al7A2M99S7GLk4hAQmMUqc39POCuFMZ5R4tPYSc
  xcjJwebgIHEikn3WUBsEQEFia2fz7GAFDELNDFK3Hq1ng0kISwQJPH+9xmwIhYBVYlbbw6A2b
  wCdhJ/Xq4HsyUE5CU6DkwGszkF7CU+futgBbGFgGomzT7LMoGRewEjwypGi6SizPSMktzEzBx
  dQwMDXUNDI11DSxNdIyMLvcQq3US91FLd8tTiEl1DvcTyYr3iytzknBS9vNSSTYzAcEopOPRk
  B+Pyte/1DjFKcjApifL+tWiPE+JLyk+pzEgszogvKs1JLT7EKMPBoSTBu9AdKCdYlJqeWpGWm
  QMMbZi0BAePkgjvYTegNG9xQWJucWY6ROoUo6KUOO8rkIQASCKjNA+uDRZPlxhlpYR5GRkYGI
  R4ClKLcjNLUOVfMYpzMCoJ8woCo1OIJzOvBG76K6DFTECLr1Y0gywuSURISTUwzbskUjblg9z
  Vrm0zVVnu8v6I3/rzgzd78Kp7wSmWkz/EC0a131g628Ld+h5vvs3qSxyz5ErjNZ9wL3Vj+lzQ
  f9RA9UupVmmok/a5aIVTcrFBflbKItUzXVRb9ticimZ7m5L0u7R7v1rBsVuFRfmKNfP81Pq4r
  624Fzztjtx3fiGGhV8n7JPOV0hJv2nY7MEQNW9O1gWnI1wLvtauF3p78+frewH+ezOn9++Z1/
  Gw8McaHeZU7pzfz3Ouex5POrZq78pZJqLXpvQIdrP7FTXJy9dlv9kpuJUr+PSEfoG4s+ZmLd+
  XaGxrTztwnt/Xzt6xb2GH9rk/8sv/HTDLWvB7Su2XT3satk3+s/nflo9mSizFGYmGWsxFxYkA
  XUX4PyIDAAA=
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-3.tower-265.messagelabs.com!1585924348!110486!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17805 invoked from network); 3 Apr 2020 14:32:28 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-3.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Apr 2020 14:32:28 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 033EWJiE018521;
        Fri, 3 Apr 2020 15:32:19 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id 4A25220708;
        Fri,  3 Apr 2020 16:32:19 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, ddiss@suse.de, hch@lst.de,
        martin.petersen@oracle.com,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [PATCH 2/2] target: make pgr_support and alua_support attributes writable
Date:   Fri,  3 Apr 2020 16:32:14 +0200
Message-Id: <20200403143214.18303-3-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20200403143214.18303-1-bstroesser@ts.fujitsu.com>
References: <20200403143214.18303-1-bstroesser@ts.fujitsu.com>
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Currently in tcmu reservation commands are handled by core's
pr implementation (default) or completely rejected (emulate_pr
set to 0). We additionally want to be able to do full
reservation handling in userspace. Therefore we need a way to
set the TRANSPORT_FLAG_PASSTHROUGH_PGR.
The inverted flag is displayed by attribute pgr_support.
Since we moved the flag from transport/backend to se_device in
the previous patch, we now can make it changeable per device by
allowing to write the attribute.
The new field transport_flags_changeable in transport/backend
is used to reject writing if not allowed for a backend.

I think, that it also makes sense to allow to reset
TRANSPORT_FLAG_PASSTHROUGH_PGR in pscsi, which is set by default,
because this enables usage of core's pr implementation in pscsi.

Regarding ALUA we also want to be able to passthrough commands
to userspace in tcmu. Therefore we want
TRANSPORT_FLAG_PASSTHROUGH_ALUA to be changeable, because
by setting it we can switch off all ALUA checks in core. So we
also need to set TRANSPORT_FLAG_PASSTHROUGH_ALUA in tcmu's
transport_flags_changeable.

For pscsi, we do not allow to change / reset
TRANSPORT_FLAG_PASSTHROUGH_ALUA, because ALUA is not implemented
in passthrough_parse_cdb() yet.

Of course, ALUA and reservation handling in userspace will work
only, if session/nexus information is sent to userspace along with
every command. This will be object of a following patch or patch
series.

Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
---
 drivers/target/target_core_configfs.c | 56 +++++++++++++++++++++++++++++++++--
 drivers/target/target_core_pscsi.c    |  1 +
 drivers/target/target_core_user.c     |  2 ++
 include/target/target_core_backend.h  |  1 +
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 074614e19f9e..337bc12c890b 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1105,6 +1105,32 @@ static ssize_t alua_support_show(struct config_item *item, char *page)
 			flags & TRANSPORT_FLAG_PASSTHROUGH_ALUA ? 0 : 1);
 }
 
+static ssize_t alua_support_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct se_dev_attrib *da = to_attrib(item);
+	struct se_device *dev = da->da_dev;
+	bool flag;
+	int ret;
+
+	if (!(dev->transport->transport_flags_changeable &
+	      TRANSPORT_FLAG_PASSTHROUGH_ALUA)) {
+		pr_err("dev[%p]: Unable to change SE Device alua_support:"
+			" alua_support has fixed value\n", dev);
+		return -EINVAL;
+	}
+
+	ret = strtobool(page, &flag);
+	if (ret < 0)
+		return ret;
+
+	if (flag)
+		dev->transport_flags &= ~TRANSPORT_FLAG_PASSTHROUGH_ALUA;
+	else
+		dev->transport_flags |= TRANSPORT_FLAG_PASSTHROUGH_ALUA;
+	return count;
+}
+
 static ssize_t pgr_support_show(struct config_item *item, char *page)
 {
 	struct se_dev_attrib *da = to_attrib(item);
@@ -1114,6 +1140,32 @@ static ssize_t pgr_support_show(struct config_item *item, char *page)
 			flags & TRANSPORT_FLAG_PASSTHROUGH_PGR ? 0 : 1);
 }
 
+static ssize_t pgr_support_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct se_dev_attrib *da = to_attrib(item);
+	struct se_device *dev = da->da_dev;
+	bool flag;
+	int ret;
+
+	if (!(dev->transport->transport_flags_changeable &
+	      TRANSPORT_FLAG_PASSTHROUGH_PGR)) {
+		pr_err("dev[%p]: Unable to change SE Device pgr_support:"
+			" pgr_support has fixed value\n", dev);
+		return -EINVAL;
+	}
+
+	ret = strtobool(page, &flag);
+	if (ret < 0)
+		return ret;
+
+	if (flag)
+		dev->transport_flags &= ~TRANSPORT_FLAG_PASSTHROUGH_PGR;
+	else
+		dev->transport_flags |= TRANSPORT_FLAG_PASSTHROUGH_PGR;
+	return count;
+}
+
 CONFIGFS_ATTR(, emulate_model_alias);
 CONFIGFS_ATTR(, emulate_dpo);
 CONFIGFS_ATTR(, emulate_fua_write);
@@ -1146,8 +1198,8 @@ CONFIGFS_ATTR(, unmap_granularity);
 CONFIGFS_ATTR(, unmap_granularity_alignment);
 CONFIGFS_ATTR(, unmap_zeroes_data);
 CONFIGFS_ATTR(, max_write_same_len);
-CONFIGFS_ATTR_RO(, alua_support);
-CONFIGFS_ATTR_RO(, pgr_support);
+CONFIGFS_ATTR(, alua_support);
+CONFIGFS_ATTR(, pgr_support);
 
 /*
  * dev_attrib attributes for devices using the target core SBC/SPC
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 4e37fa9b409d..e7d92ef43ca4 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1073,6 +1073,7 @@ static const struct target_backend_ops pscsi_ops = {
 	.transport_flags_default = TRANSPORT_FLAG_PASSTHROUGH |
 				   TRANSPORT_FLAG_PASSTHROUGH_ALUA |
 				   TRANSPORT_FLAG_PASSTHROUGH_PGR,
+	.transport_flags_changeable = TRANSPORT_FLAG_PASSTHROUGH_PGR,
 	.attach_hba		= pscsi_attach_hba,
 	.detach_hba		= pscsi_detach_hba,
 	.pmode_enable_hba	= pscsi_pmode_enable_hba,
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 8251f0c734cc..d6ddc95a6331 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -2617,6 +2617,8 @@ static struct target_backend_ops tcmu_ops = {
 	.name			= "user",
 	.owner			= THIS_MODULE,
 	.transport_flags_default = TRANSPORT_FLAG_PASSTHROUGH,
+	.transport_flags_changeable = TRANSPORT_FLAG_PASSTHROUGH_PGR |
+	                              TRANSPORT_FLAG_PASSTHROUGH_ALUA,
 	.attach_hba		= tcmu_attach_hba,
 	.detach_hba		= tcmu_detach_hba,
 	.alloc_device		= tcmu_alloc_device,
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index 9d1c16d24edf..6468c5a7c9d1 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -24,6 +24,7 @@ struct target_backend_ops {
 	struct module *owner;
 
 	u8 transport_flags_default;
+	u8 transport_flags_changeable;
 
 	int (*attach_hba)(struct se_hba *, u32);
 	void (*detach_hba)(struct se_hba *);
-- 
2.12.3

