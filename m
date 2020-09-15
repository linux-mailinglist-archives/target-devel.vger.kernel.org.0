Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD74626A497
	for <lists+target-devel@lfdr.de>; Tue, 15 Sep 2020 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgIOMCH (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 15 Sep 2020 08:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbgIOMBm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600171261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRKZxnfmXT6xHa0W2Qaoc/OtvN5Snga93SmINoltYeM=;
        b=Hq3VryK5+vKOmtXxhLfkYV+t54OBg7nmsdsdT9/eLhJAno5DdrR16S9gJ9RncBKJr2wV2D
        EfOk4xGF4STB0diVQZf0sJgNAUPZR7GrjCkKp9bSYyVQQ8pzvBKvXQWEznwjJsnwBBQnxw
        CuksPvySA96djK/v0xv74bK8o8DA1hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-MTpbt8lGPiuhSS14uL2xMA-1; Tue, 15 Sep 2020 07:58:06 -0400
X-MC-Unique: MTpbt8lGPiuhSS14uL2xMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DB4F801ADF;
        Tue, 15 Sep 2020 11:58:04 +0000 (UTC)
Received: from [10.40.193.20] (unknown [10.40.193.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D2977B7B2;
        Tue, 15 Sep 2020 11:58:01 +0000 (UTC)
Subject: Re: [PATCH] scsi: target: remove redundant assignment to variable
 'ret'
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        martin.petersen@oracle.com, bvanassche@acm.org,
        michael.christie@oracle.com, sudhakar.panneerselvam@oracle.com,
        ddiss@suse.de, gustavoars@kernel.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200914023207.113792-1-jingxiangfeng@huawei.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <2410adca-9e8c-d16e-8097-9c6eb8103362@redhat.com>
Date:   Tue, 15 Sep 2020 13:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914023207.113792-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



Dne 14. 09. 20 v 4:32 Jing Xiangfeng napsal(a):
> The variable ret has been initialized with a value '0'. The assignment
> in switch-case is redundant. So remove it.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/target/iscsi/iscsi_target.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index cd045dc75a58..f5272ac18b16 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -4516,7 +4516,6 @@ int iscsit_logout_post_handler(
>  			iscsit_logout_post_handler_closesession(conn);
>  			break;
>  		}
> -		ret = 0;
>  		break;
>  	case ISCSI_LOGOUT_REASON_CLOSE_CONNECTION:
>  		if (conn->cid == cmd->logout_cid) {
> @@ -4527,7 +4526,6 @@ int iscsit_logout_post_handler(
>  				iscsit_logout_post_handler_samecid(conn);
>  				break;
>  			}
> -			ret = 0;
>  		} else {
>  			switch (cmd->logout_response) {
>  			case ISCSI_LOGOUT_SUCCESS:
> 

Looks ok to me.

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>

