Return-Path: <target-devel+bounces-461-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0809EAD9611
	for <lists+target-devel@lfdr.de>; Fri, 13 Jun 2025 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B54189010B
	for <lists+target-devel@lfdr.de>; Fri, 13 Jun 2025 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414BD246774;
	Fri, 13 Jun 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBQRStY8"
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8823D28A
	for <target-devel@vger.kernel.org>; Fri, 13 Jun 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845640; cv=none; b=bQQrmVDGjyoqE3Ylyk98lB7z9XBeUAo3Fnx1G1AOZpO/vw8Du6HObvsj4uW0CIdnRujP3XaZHnZIgg0UmDrYwAWKKHBtM4xRDGg+fTm9eM1Eg/t8K/ybwo0wz4cTXd8Wy1SckFs+SwjmldH3ICbqtJ+GkGmELTI1JwSWCRmPTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845640; c=relaxed/simple;
	bh=toP1pCbGPHy+KlGOWsDSQWXRDcmgf83SDs3ti1+mSoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGLmodxhCOLLYdTYupuB6AZyzbEoabFfsJSXvojqhSzDO4jzRchXSM+nCQf0iRbntRXkekqDLadhvWJkR0k+x4Do7l1sYdcE2Cmoehcyl8DvP/xqituc72s6TU01V+ig0JH9PI9GrlsVCUrBRt2DbG1kpJ5kfDxPKclIZ/2qDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBQRStY8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749845634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VQ125eVNHzqygsEflrNOBTU5yDpovgR7135B10yVWE=;
	b=SBQRStY8zz9gwh9C1wo2ubp/D6TevRW0zwa0JSDldsGlHuHuHCyJIlQI7jcPgo6FLjvKpk
	3pdnIWKn3Pewv7VZ6FWGzxnp9LzgvJhlhy5QMLy1hNYXn88Ivc+B+l1C4EDuYsqiUR3066
	Cg9/NXIL52knRLBVsN0HpZV5d9PXxUk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-3D0p6xCBMe-ahmP_FVLykQ-1; Fri,
 13 Jun 2025 16:13:50 -0400
X-MC-Unique: 3D0p6xCBMe-ahmP_FVLykQ-1
X-Mimecast-MFC-AGG-ID: 3D0p6xCBMe-ahmP_FVLykQ_1749845628
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26DC11808985;
	Fri, 13 Jun 2025 20:13:48 +0000 (UTC)
Received: from [10.22.89.154] (unknown [10.22.89.154])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8B10180045C;
	Fri, 13 Jun 2025 20:13:45 +0000 (UTC)
Message-ID: <911f27e1-34cf-4b84-a5c1-e763220b0080@redhat.com>
Date: Fri, 13 Jun 2025 16:13:44 -0400
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: target: Fix NULL pointer dereference in
 core_scsi3_decode_spec_i_port
To: Maurizio Lombardi <mlombard@redhat.com>, martin.petersen@oracle.com
Cc: mlombard@bsdbackstore.eu, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, michael.christie@oracle.com
References: <20250612101556.24829-1-mlombard@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250612101556.24829-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This bug reported by one of our customers just the other day.

Maurizio turned around the fix in less than a day.

Great job Maurizio!

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 6/12/25 6:15 AM, Maurizio Lombardi wrote:
> The function core_scsi3_decode_spec_i_port(), in its error code path,
> unconditionally calls core_scsi3_lunacl_undepend_item()
> passing the dest_se_deve pointer, which may be NULL.
> 
> This can lead to a NULL pointer dereference if
> dest_se_deve remains unset.
> 
> SPC-3 PR SPEC_I_PT: Unable to locate dest_tpg
> Unable to handle kernel paging request at virtual address dfff800000000012
> Call trace:
>    core_scsi3_lunacl_undepend_item+0x2c/0xf0 [target_core_mod] (P)
>    core_scsi3_decode_spec_i_port+0x120c/0x1c30 [target_core_mod]
>    core_scsi3_emulate_pro_register+0x6b8/0xcd8 [target_core_mod]
>    target_scsi3_emulate_pr_out+0x56c/0x840 [target_core_mod]
> 
> Fix this by adding a NULL check before calling
> core_scsi3_lunacl_undepend_item()
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/target/target_core_pr.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
> index 34cf2c399b39..70905805cb17 100644
> --- a/drivers/target/target_core_pr.c
> +++ b/drivers/target/target_core_pr.c
> @@ -1842,7 +1842,9 @@ core_scsi3_decode_spec_i_port(
>   		}
>   
>   		kmem_cache_free(t10_pr_reg_cache, dest_pr_reg);
> -		core_scsi3_lunacl_undepend_item(dest_se_deve);
> +
> +		if (dest_se_deve)
> +			core_scsi3_lunacl_undepend_item(dest_se_deve);
>   
>   		if (is_local)
>   			continue;


