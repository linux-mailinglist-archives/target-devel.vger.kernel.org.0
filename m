Return-Path: <target-devel+bounces-563-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA5B87486
	for <lists+target-devel@lfdr.de>; Fri, 19 Sep 2025 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F32A7E9D
	for <lists+target-devel@lfdr.de>; Thu, 18 Sep 2025 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C02857F6;
	Thu, 18 Sep 2025 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QyyrU9Ry"
X-Original-To: target-devel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32241FBEB9
	for <target-devel@vger.kernel.org>; Thu, 18 Sep 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758235622; cv=none; b=Vw2JX02BQWqKCo/vonT6XNTHL23VCTmuTgvll2aTc5BVi+PuunYI0hSXFs4MMMxI24j1Su9PxLXy1lKRHj2bRlfNTYi3TueyADtDWyhKfp1YmC08ABiGSVgrboOJjdsV5e503BaejxmEPIPcMr8rp+/QmESp797H0b6k6/tlt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758235622; c=relaxed/simple;
	bh=Fb3xaBIT6ER+rev9TSsFyrE2EiE7WWvwisRDYYmGTTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9ebSQ24s9gwJjTyqvwyiLW4QKz0VsKFqwjrDFzg0Ev38M/lWL07UcPRxiJsOMuY9iCMYfur868PpjRiHO3s3d8afW3nYPdWkfjWV79WvgqvG0eVK1fNGyWCcVGiY8s8kdgliJsJ9932a7oaiwbwIrptLSzg8qj34LqUkwdc3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QyyrU9Ry; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <457e98bf-0fa7-4ff1-affe-400ac2e0ae72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758235617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FzhZHxrkOAC+RPVVxC0EvN2oYPvyy96quTvFqvW0LtM=;
	b=QyyrU9RyxYyFbM+NmOkJQV1EVyLRTdZh8CuWtb9IstiHTPg8DWaCTLLakqiXEvFnHiQaQw
	T6rw8hHIeAGxrp2Ir3YOrS90UbMALUUmWpNRAFEE1sBKCSgceTZrxKct71jzfMz6bwg71R
	UKVl5M+t2NOFBRaqxIV8i1/zdLIpC7k=
Date: Thu, 18 Sep 2025 15:46:50 -0700
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next] RDMA: Use %pe format specifier for error
 pointers
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Allen Hubbe <allen.hubbe@amd.com>, Bart Van Assche <bvanassche@acm.org>,
 Chengchang Tang <tangchengchang@huawei.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org,
 Long Li <longli@microsoft.com>, Michael Margolin <mrgolin@amazon.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>, target-devel@vger.kernel.org,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <e81ec02df1e474be20417fb62e779776e3f47a50.1758217936.git.leon@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <e81ec02df1e474be20417fb62e779776e3f47a50.1758217936.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/18/25 10:53 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Convert error logging throughout the RDMA subsystem to use
> the %pe format specifier instead of PTR_ERR() with integer
> format specifiers.

We have already used this skill, and it has proven to be very useful. 
With it, developers no longer need to look up error codes in err.h

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/core/agent.c           |  3 +--
>   drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++--
>   drivers/infiniband/hw/bnxt_re/main.c      |  3 +--
>   drivers/infiniband/hw/cxgb4/device.c      |  5 ++---
>   drivers/infiniband/hw/efa/efa_com.c       |  4 ++--
>   drivers/infiniband/hw/efa/efa_verbs.c     |  6 ++++--
>   drivers/infiniband/hw/hfi1/device.c       |  4 ++--
>   drivers/infiniband/hw/hfi1/user_sdma.c    |  4 ++--
>   drivers/infiniband/hw/hns/hns_roce_mr.c   |  8 ++++----
>   drivers/infiniband/hw/ionic/ionic_admin.c | 18 +++++++++---------
>   drivers/infiniband/hw/irdma/verbs.c       |  6 +++---
>   drivers/infiniband/hw/mana/main.c         |  5 ++---
>   drivers/infiniband/hw/mana/mr.c           |  6 ++++--
>   drivers/infiniband/hw/mlx4/mad.c          |  8 ++++----
>   drivers/infiniband/hw/mlx4/qp.c           |  3 ++-
>   drivers/infiniband/hw/mlx5/data_direct.c  |  2 +-
>   drivers/infiniband/hw/mlx5/gsi.c          | 15 +++++++++------
>   drivers/infiniband/hw/mlx5/main.c         | 14 ++++++++++----
>   drivers/infiniband/hw/mlx5/mr.c           |  3 +--
>   drivers/infiniband/ulp/srpt/ib_srpt.c     | 16 +++++++---------
>   20 files changed, 72 insertions(+), 65 deletions(-)
> 

