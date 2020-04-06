Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52719FFEC
	for <lists+target-devel@lfdr.de>; Mon,  6 Apr 2020 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgDFVF6 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 6 Apr 2020 17:05:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726254AbgDFVF5 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586207156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbzd6a4148j04flxX8bIeTPEXnyjK0T0AA0oI9R+C4Y=;
        b=YJ2xy2cNV3jFOwOG9IPDtQeVSgA6pSQ3ZYMLgSvOAB55mSzAAtM9+QISMUH4wzT1CS+QTy
        Sgqj8Xf86eyzkHB6WXXagZbB/HsCBYrMKwUxAH6eReu/sx83Qpnj1PT5D+VGxFGzUiB4Uw
        uutNzF1iDXaCObESm2E0nxjqOmD4+yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Ne7FpE0mNGWkGdOK9osv9w-1; Mon, 06 Apr 2020 17:05:50 -0400
X-MC-Unique: Ne7FpE0mNGWkGdOK9osv9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA718017F4;
        Mon,  6 Apr 2020 21:05:49 +0000 (UTC)
Received: from [10.10.118.251] (ovpn-118-251.rdu2.redhat.com [10.10.118.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FBE15DA82;
        Mon,  6 Apr 2020 21:05:49 +0000 (UTC)
Subject: Re: [PATCH] target: pr: fix PR IN, READ FULL STATUS
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        target-devel@vger.kernel.org
References: <20200406182951.17446-1-bstroesser@ts.fujitsu.com>
Cc:     martin.petersen@oracle.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E8B99AC.2010303@redhat.com>
Date:   Mon, 6 Apr 2020 16:05:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20200406182951.17446-1-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04/06/2020 01:29 PM, Bodo Stroesser wrote:
> AFAICS there are some problems in target_core_fabric_lib.c
> that afflict PERSISTENT RESERVE IN / READ FULL STATUS command.
> 
> 1) Creation of the response to READ FULL STATUS fails for FC
>    based reservations. Reason is the too high loop limit (< 24)
>    in fc_get_pr_transport_id(). The string representation of FC
>    WWPN is 23 chars long only ("11:22:33:44:55:66:77:88"). So
>    when i is 23, the loop body is executed a last time for the
>    ending '\0' of the string and thus hex2bin() reports an error.
> 
> 2) For iSCSI based reservations that include an ISID, the
>    reported TRANSPORT ID is wrong. This has two reasons:
>    a) The code inserts an NULL byte between the ISCSI Name and
>       the SEPARATOR
>    b) Only the first 6 chars of the ISID are appended. AFAIK,
>       binary ISID is 48 bits, so 12 chars might be necessary.
> 
> The last hunk in this patch fixes a minor flaw that could be
> triggered by a PR OUT RESERVE on iSCSI, if TRANSPORT IDs with
> and without ISID are used in the same command. I don't know, if
> that ever could happen, but with the change the code is cleaner,
> I think.
> 
> This patch is based on code review only. It compiles fine, but
> unfortunately I wasn't able to test.

Your patch for #2 is still not going to work for iscsi, because there's
lots of issue in that code. Offlist I sent you my patch for #2 and a
hand full of other fixes in that code path.

Let's sync them up, so we can test it all together.

- We should break out the first chunk for your issue #1, and the last
chunk that sets port_nexus_ptr to NULL into separate patches.

I tested the NULL ptr chunk with my patches and it works fine.

- If you are ok with my patch for #2, I will post my patch for that and
the other ones to the list. As you saw I have other fixes in the same
lines of code and I fixed up the comments, so it would just be easier
code conflict wise.

There is actually another isid fix needed for the core pr code:

https://patchwork.kernel.org/patch/10525287/

Handling Bart's review comment for that patch ended up being crazy
because of other issues in the PR code so I have not completed that fix.


> 
> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
> ---
>  drivers/target/target_core_fabric_lib.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
> index 6b4b354c88aa..8a726076ae56 100644
> --- a/drivers/target/target_core_fabric_lib.c
> +++ b/drivers/target/target_core_fabric_lib.c
> @@ -63,7 +63,7 @@ static int fc_get_pr_transport_id(
>  	 * encoded TransportID.
>  	 */
>  	ptr = &se_nacl->initiatorname[0];
> -	for (i = 0; i < 24; ) {
> +	for (i = 0; i < 23; ) {
>  		if (!strncmp(&ptr[i], ":", 1)) {
>  			i++;
>  			continue;
> @@ -148,10 +148,6 @@ static int iscsi_get_pr_transport_id(
>  	 */
>  	len = sprintf(&buf[off], "%s", se_nacl->initiatorname);
>  	/*
> -	 * Add Extra byte for NULL terminator
> -	 */
> -	len++;
> -	/*
>  	 * If there is ISID present with the registration and *format code == 1
>  	 * 1, use iSCSI Initiator port TransportID format.
>  	 *
> @@ -185,17 +181,15 @@ static int iscsi_get_pr_transport_id(
>  		buf[off+len] = 0x30; off++; /* ASCII Character: "0" */
>  		buf[off+len] = 0x78; off++; /* ASCII Character: "x" */
>  		len += 5;
> -		buf[off+len] = pr_reg->pr_reg_isid[0]; off++;
> -		buf[off+len] = pr_reg->pr_reg_isid[1]; off++;
> -		buf[off+len] = pr_reg->pr_reg_isid[2]; off++;
> -		buf[off+len] = pr_reg->pr_reg_isid[3]; off++;
> -		buf[off+len] = pr_reg->pr_reg_isid[4]; off++;
> -		buf[off+len] = pr_reg->pr_reg_isid[5]; off++;
> -		buf[off+len] = '\0'; off++;
> -		len += 7;
> +		len += snprintf(&buf[off+len], PR_REG_ISID_LEN, "%s",
> +		                pr_reg->pr_reg_isid);
>  	}
>  	spin_unlock_irq(&se_nacl->nacl_sess_lock);
>  	/*
> +	 * Add Extra byte for NULL terminator
> +	 */
> +	len++;
> +	/*
>  	 * The ADDITIONAL LENGTH field specifies the number of bytes that follow
>  	 * in the TransportID. The additional length shall be at least 20 and
>  	 * shall be a multiple of four.
> @@ -224,10 +218,6 @@ static int iscsi_get_pr_transport_id_len(
>  	spin_lock_irq(&se_nacl->nacl_sess_lock);
>  	len = strlen(se_nacl->initiatorname);
>  	/*
> -	 * Add extra byte for NULL terminator
> -	 */
> -	len++;
> -	/*
>  	 * If there is ISID present with the registration, use format code:
>  	 * 01b: iSCSI Initiator port TransportID format
>  	 *
> @@ -236,12 +226,16 @@ static int iscsi_get_pr_transport_id_len(
>  	 */
>  	if (pr_reg->isid_present_at_reg) {
>  		len += 5; /* For ",i,0x" ASCII separator */
> -		len += 7; /* For iSCSI Initiator Session ID + Null terminator */
> +		len += strlen(pr_reg->pr_reg_isid); /* Initiator Session ID */
>  		*format_code = 1;
>  	} else
>  		*format_code = 0;
>  	spin_unlock_irq(&se_nacl->nacl_sess_lock);
>  	/*
> +	 * Add extra byte for NULL terminator
> +	 */
> +	len++;
> +	/*
>  	 * The ADDITIONAL LENGTH field specifies the number of bytes that follow
>  	 * in the TransportID. The additional length shall be at least 20 and
>  	 * shall be a multiple of four.
> @@ -341,7 +335,8 @@ static char *iscsi_parse_pr_out_transport_id(
>  			*p = tolower(*p);
>  			p++;
>  		}
> -	}
> +	} else
> +		*port_nexus_ptr = NULL;
>  
>  	return &buf[4];
>  }
> 

