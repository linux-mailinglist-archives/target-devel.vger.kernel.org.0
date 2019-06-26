Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B856F93
	for <lists+target-devel@lfdr.de>; Wed, 26 Jun 2019 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFZRd4 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 26 Jun 2019 13:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZRd4 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13F76C0495A6;
        Wed, 26 Jun 2019 17:28:03 +0000 (UTC)
Received: from [10.40.204.40] (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0B485D717;
        Wed, 26 Jun 2019 17:27:58 +0000 (UTC)
Subject: Re: [PATCH] target/iscsi: set auth_protocol back to NULL if CHAP_A
 value is not supported.
To:     target-devel@vger.kernel.org
References: <20190626154836.11542-1-mlombard@redhat.com>
Cc:     martin.petersen@oracle.com, cleech@redhat.com, ddiss@suse.de
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <b328f881-758e-c2ab-65b0-6840dfd0ec69@redhat.com>
Date:   Wed, 26 Jun 2019 19:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20190626154836.11542-1-mlombard@redhat.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 26 Jun 2019 17:28:08 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

I found another dangling pointer, see V2

Dne 26.6.2019 v 17:48 Maurizio Lombardi napsal(a):
> If the CHAP_A value is not supported, the chap_server_open() function
> should free the auth_protocol pointer and set it to NULL, or
> we will leave a dangling pointer around.
> 
> [   66.010905] Unsupported CHAP_A value
> [   66.011660] Security negotiation failed.
> [   66.012443] iSCSI Login negotiation failed.
> [   68.413924] general protection fault: 0000 [#1] SMP PTI
> [   68.414962] CPU: 0 PID: 1562 Comm: targetcli Kdump: loaded Not tainted 4.18.0-80.el8.x86_64 #1
> [   68.416589] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [   68.417677] RIP: 0010:__kmalloc_track_caller+0xc2/0x210
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/target/iscsi/iscsi_target_auth.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
> index b6e4862cc242..139abb19da43 100644
> --- a/drivers/target/iscsi/iscsi_target_auth.c
> +++ b/drivers/target/iscsi/iscsi_target_auth.c
> @@ -119,6 +119,7 @@ static struct iscsi_chap *chap_server_open(
>  	default:
>  		pr_err("Unsupported CHAP_A value\n");
>  		kfree(conn->auth_protocol);
> +		conn->auth_protocol = NULL;
>  		return NULL;
>  	}
>  
> 
