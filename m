Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F55C8F70
	for <lists+target-devel@lfdr.de>; Wed,  2 Oct 2019 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfJBRJj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 2 Oct 2019 13:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfJBRJj (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8AFB18CB8E0;
        Wed,  2 Oct 2019 17:09:39 +0000 (UTC)
Received: from [10.10.122.215] (ovpn-122-215.rdu2.redhat.com [10.10.122.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE7260605;
        Wed,  2 Oct 2019 17:09:39 +0000 (UTC)
Subject: Re: [PATCH 2/3] target: fix SendTargets=All string compares
To:     David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org
References: <20190912095547.22427-1-ddiss@suse.de>
 <20190912095547.22427-3-ddiss@suse.de>
Cc:     martin.petersen@oracle.com, bvanassche@acm.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D94D9D2.7030709@redhat.com>
Date:   Wed, 2 Oct 2019 12:09:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190912095547.22427-3-ddiss@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Wed, 02 Oct 2019 17:09:39 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 09/12/2019 04:55 AM, David Disseldorp wrote:
> strncmp is currently used for "SendTargets" key and "All" value matching
> without checking for trailing garbage. This means that Text request PDUs
> with garbage such as "SendTargetsPlease=All" and "SendTargets=Alle" are
> processed successfully as if they were "SendTargets=All" requests.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  drivers/target/iscsi/iscsi_target.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index d19e051f2bc2..09e55ea0bf5d 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -2189,24 +2189,22 @@ iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
>  		}
>  		goto empty_sendtargets;
>  	}
> -	if (strncmp("SendTargets", text_in, 11) != 0) {
> +	if (strncmp("SendTargets=", text_in, 12) != 0) {
>  		pr_err("Received Text Data that is not"
>  			" SendTargets, cannot continue.\n");
>  		goto reject;
>  	}
> +	/* '=' confirmed in strncmp */
>  	text_ptr = strchr(text_in, '=');
> -	if (!text_ptr) {
> -		pr_err("No \"=\" separator found in Text Data,"
> -			"  cannot continue.\n");
> -		goto reject;
> -	}
> -	if (!strncmp("=All", text_ptr, 4)) {
> +	BUG_ON(!text_ptr);
> +	if (!strncmp("=All", text_ptr, 5)) {

Why is the count 5 now?

Did the ones below need to be increased too then?

>  		cmd->cmd_flags |= ICF_SENDTARGETS_ALL;
>  	} else if (!strncmp("=iqn.", text_ptr, 5) ||
>  		   !strncmp("=eui.", text_ptr, 5)) {
>  		cmd->cmd_flags |= ICF_SENDTARGETS_SINGLE;
>  	} else {
> -		pr_err("Unable to locate valid SendTargets=%s value\n", text_ptr);
> +		pr_err("Unable to locate valid SendTargets%s value\n",
> +		       text_ptr);
>  		goto reject;
>  	}
>  
> 

