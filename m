Return-Path: <target-devel+bounces-62-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47895841944
	for <lists+target-devel@lfdr.de>; Tue, 30 Jan 2024 03:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9726CB2545B
	for <lists+target-devel@lfdr.de>; Tue, 30 Jan 2024 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF338DE0;
	Tue, 30 Jan 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jlGDAfbK"
X-Original-To: target-devel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5B36AF3;
	Tue, 30 Jan 2024 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581664; cv=none; b=n9AmRS1C4jMuX9mniCL7tNOjOdyjWk6+UkfEPtLXRIcIjzd/Ka6d/xOKFkpbgbFPn/FPKKrGEgMK5LO+1KSQKQBIqnXRcragCITcgJ66eAmJWXWwbtRD61N5vndeSOSe65TyqJVbmqMeMV5Y874jlOIN0TJ+pyEbA6cVWXG4FDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581664; c=relaxed/simple;
	bh=DcZbNDcRyfD1PFFqJcfdzNCC3Rd7V20GbucIcdpbFAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szOaXJo8597BD1mIDhpRzRZxF3+2CtphNywv29eaCC314HKG4NsU9e2UncLFlSQxCmYsk7o0XwI8+ABsTrLy8QPYHi7wRFBt3WQPiDOQHpAMvdlAdat/5XHJSQ9J3JXJx0PDtQkkOKpRnrYV/MJ63i2X/PaWi88+rCX1A2NuPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jlGDAfbK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJiTHe004454;
	Tue, 30 Jan 2024 02:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=DFvxi9sXd7yUeQQ7cAsAMh+nLiPjL4kr+2ahLfMyB7k=;
 b=jlGDAfbKXSlAGhHjBrdCil7uTWTCjDoF9GB4UHigRZWtJFSjpgFtzqrfRWbRnSi1VxGA
 r5POhDKY4MTKKN6KR49z78CDcQdXPPu9qaZsWHWqzZ5+BmsQkrMse8aNGGFQt/DMd4jV
 U+QwZA9dIv3z/wzs6XeJWkjvAGbAABgoSNkKnPy0Vp5+XcrleuGwj9U5PJ8EITc6bZLq
 ajJUuVSKiF5eGI8Xo0qB152UpwHdPov21NpNl5VzWy+/AUKrHkwpR4zPiw1O2tRDQmYV
 6Bawov2D1AJWeAnBy6+lbNpbloCy6AQKvDXt+tj338TfuaLtMCo1iWEHJG/lwAYu/r5n ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqawf7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U00ORM014480;
	Tue, 30 Jan 2024 02:27:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g521-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RPxs040916;
	Tue, 30 Jan 2024 02:27:35 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-8;
	Tue, 30 Jan 2024 02:27:35 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Michael Cyr <mikecyr@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ibmvscsi_tgt: replace deprecated strncpy with strscpy
Date: Mon, 29 Jan 2024 21:27:04 -0500
Message-ID: <170657812678.784857.8463618815406692584.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com>
References: <20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=938 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-GUID: OEDyQH4gE1XU6RBa9JOzZMPSOIgpiK0M
X-Proofpoint-ORIG-GUID: OEDyQH4gE1XU6RBa9JOzZMPSOIgpiK0M

On Tue, 12 Dec 2023 01:20:20 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We don't need the NUL-padding behavior that strncpy() provides as vscsi
> is NUL-allocated in ibmvscsis_probe() which proceeds to call
> ibmvscsis_adapter_info():
> |       vscsi = kzalloc(sizeof(*vscsi), GFP_KERNEL);
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: ibmvscsi_tgt: replace deprecated strncpy with strscpy
      https://git.kernel.org/mkp/scsi/c/165470fb2600

-- 
Martin K. Petersen	Oracle Linux Engineering

