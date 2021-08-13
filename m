Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6043EB703
	for <lists+target-devel@lfdr.de>; Fri, 13 Aug 2021 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbhHMOxZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 13 Aug 2021 10:53:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51288 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbhHMOxZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:53:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49330201E3;
        Fri, 13 Aug 2021 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628866377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCbvlNAE/XCCePf2KtRtVGsFAqd9edK7rNW6LfivHNo=;
        b=1cRQRhOhx/KQkAp7bLFA70GT0BNGlvG3x/mm0twST+Zsb6Nj2f44rs1BBDlcENeLigeWRS
        ht4pN3enbbcYDuTNUrxre8HmgGpRbaGsgeM6bHCrq1iUpjoqk5JQd2uINwJclhjtWpT0DI
        KTuIu639r/5J0HX9gPHJ67x8GqO1On8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628866377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCbvlNAE/XCCePf2KtRtVGsFAqd9edK7rNW6LfivHNo=;
        b=PSESSqk875+8LxbRQRzv6Pf70TjQtr8ywahA2iY2wpnul/H5j5CiBODRL9e14iXWrwKAZh
        xn6HkAa/vG8DG4Dw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EB46513806;
        Fri, 13 Aug 2021 14:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id I+nZN0iHFmFSEQAAGKfGzw
        (envelope-from <ddiss@suse.de>); Fri, 13 Aug 2021 14:52:56 +0000
Date:   Fri, 13 Aug 2021 16:52:55 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Sergey Samoylenko <s.samoylenko@yadro.com>
Cc:     <martin.petersen@oracle.com>, <michael.christie@oracle.com>,
        <bvanassche@acm.org>, <target-devel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux@yadro.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Anastasia Kovaleva <a.kovaleva@yadro.com>
Subject: Re: [PATCH 1/1] scsi: target: core: Add 8Fh VPD page
Message-ID: <20210813165255.650257ce@suse.de>
In-Reply-To: <20210729201943.40222-2-s.samoylenko@yadro.com>
References: <20210729201943.40222-1-s.samoylenko@yadro.com>
        <20210729201943.40222-2-s.samoylenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Sergey,

On Thu, 29 Jul 2021 23:19:43 +0300, Sergey Samoylenko wrote:

> The 8Fh VPD page announces the capabilities supported by
> the TCM XCOPY manager. It helps to expand the coverage of
> the third-party copy manager with SCSI testing utilities.

Please list which initiators use this VPD page, if you know of any.
Also, is there any test coverage for this? I don't see anything in
libiscsi...

> Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
> Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> Reviewed-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
> Signed-off-by: Sergey Samoylenko <s.samoylenko@yadro.com>
> ---
>  drivers/target/target_core_spc.c | 230 ++++++++++++++++++++++++++++++-
>  1 file changed, 226 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
> index 22703a0dbd07..169341712b10 100644
> --- a/drivers/target/target_core_spc.c
> +++ b/drivers/target/target_core_spc.c
...
> +/* Third-party Copy VPD page */
> +static sense_reason_t
> +spc_emulate_evpd_8f(struct se_cmd *cmd, unsigned char *buf)
> +{
> +	struct se_device *dev = cmd->se_dev;
> +	int off;
> +	u16 page_len;
> +
> +	if (!dev->dev_attrib.emulate_3pc)
> +		return TCM_INVALID_CDB_FIELD;
> +
> +	/*
> +	 * Since the Third-party copy manager in TCM is quite simple
> +	 * and supports only two commands, the function sets
> +	 * many descriptor parameters as constants.
> +	 *
> +	 * As the Copy manager supports the EXTENDED COPY(LID1) command,
> +	 * the Third-party Copy VPD page should include five mandatory
> +	 * Third-party copy descriptors. Its are:
> +	 *   0001h - Supported Commands
> +	 *   0004h - Parameter Data
> +	 *   0008h - Supported Descriptors
> +	 *   000Ch - Supported CSCD Descriptor IDs
> +	 *   8001h - General Copy Operations
> +	 *
> +	 * See spc4 section 7.8.17
> +	 */
> +
> +	off = 4;
> +
> +	/* fill descriptors */
> +	off += spc_evpd_8f_encode_supp_cmds(&buf[off]);
> +	off += spc_evpd_8f_encode_param_data(&buf[off]);
> +	off += spc_evpd_8f_encode_supp_descrs(&buf[off]);
> +	off += spc_evpd_8f_encode_supp_cscd_descr_id(&buf[off]);
> +	off += spc_evpd_8f_encode_general_copy_ops(&buf[off]);

This looks risky in terms of buf overrun. I think it'd be good to pass
a @remaining or @buf_end param to these helper functions.

Cheers, David
