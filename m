Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1356F92
	for <lists+target-devel@lfdr.de>; Wed, 26 Jun 2019 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZRdm (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 26 Jun 2019 13:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZRdl (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D1CC30832DE
        for <target-devel@vger.kernel.org>; Wed, 26 Jun 2019 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-222.rdu2.redhat.com [10.10.121.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E5C21001B00
        for <target-devel@vger.kernel.org>; Wed, 26 Jun 2019 17:33:41 +0000 (UTC)
Date:   Wed, 26 Jun 2019 10:33:37 -0700
From:   Chris Leech <cleech@redhat.com>
To:     target-devel@vger.kernel.org
Subject: Re: [PATCH V2] iscsi: set auth_protocol back to NULL if CHAP_A value
 is not supported.
Message-ID: <20190626173337.GA14883@localhost.localdomain>
Mail-Followup-To: Chris Leech <cleech@redhat.com>,
        target-devel@vger.kernel.org
References: <20190626172734.20751-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626172734.20751-1-mlombard@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 26 Jun 2019 17:33:41 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Jun 26, 2019 at 07:27:34PM +0200, Maurizio Lombardi wrote:
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
> v2: use the chap_close() function and fix yet another dangling pointer
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Reviewed-by: Chris Leech <cleech@redhat.com>

> ---
>  drivers/target/iscsi/iscsi_target_auth.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
> index b6e4862cc242..51ddca2033e0 100644
> --- a/drivers/target/iscsi/iscsi_target_auth.c
> +++ b/drivers/target/iscsi/iscsi_target_auth.c
> @@ -81,6 +81,12 @@ static int chap_check_algorithm(const char *a_str)
>  	return CHAP_DIGEST_UNKNOWN;
>  }
>  
> +static void chap_close(struct iscsi_conn *conn)
> +{
> +	kfree(conn->auth_protocol);
> +	conn->auth_protocol = NULL;
> +}
> +
>  static struct iscsi_chap *chap_server_open(
>  	struct iscsi_conn *conn,
>  	struct iscsi_node_auth *auth,
> @@ -118,7 +124,7 @@ static struct iscsi_chap *chap_server_open(
>  	case CHAP_DIGEST_UNKNOWN:
>  	default:
>  		pr_err("Unsupported CHAP_A value\n");
> -		kfree(conn->auth_protocol);
> +		chap_close(conn);
>  		return NULL;
>  	}
>  
> @@ -133,19 +139,13 @@ static struct iscsi_chap *chap_server_open(
>  	 * Generate Challenge.
>  	 */
>  	if (chap_gen_challenge(conn, 1, aic_str, aic_len) < 0) {
> -		kfree(conn->auth_protocol);
> +		chap_close(conn);
>  		return NULL;
>  	}
>  
>  	return chap;
>  }
>  
> -static void chap_close(struct iscsi_conn *conn)
> -{
> -	kfree(conn->auth_protocol);
> -	conn->auth_protocol = NULL;
> -}
> -
>  static int chap_server_compute_md5(
>  	struct iscsi_conn *conn,
>  	struct iscsi_node_auth *auth,
> -- 
> Maurizio Lombardi
> 
