Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F261551145
	for <lists+target-devel@lfdr.de>; Mon, 20 Jun 2022 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbiFTHSL (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 20 Jun 2022 03:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiFTHSK (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:18:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5650E2DC8;
        Mon, 20 Jun 2022 00:18:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A406968AFE; Mon, 20 Jun 2022 09:18:04 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:18:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, hch@lst.de, axboe@kernel.dk,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 08/11] scsi: target: Add block PR support to iblock.
Message-ID: <20220620071804.GH11418@lst.de>
References: <20220603065536.5641-1-michael.christie@oracle.com> <20220603065536.5641-9-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603065536.5641-9-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

> +static sense_reason_t iblock_execute_pr_in(struct se_cmd *cmd, u8 sa,
> +					   unsigned char *param_data)
> +{
> +	sense_reason_t ret;
> +
> +	switch (sa) {
> +	case PRI_REPORT_CAPABILITIES:
> +		iblock_pr_report_caps(param_data);
> +		break;
> +	case PRI_READ_KEYS:
> +		ret = iblock_pr_read_keys(cmd, param_data);
> +		break;
> +	case PRI_READ_RESERVATION:
> +		ret = iblock_pr_read_reservation(cmd, param_data);
> +		break;
> +	case PRI_READ_FULL_STATUS:
> +	default:
> +		pr_err("Unknown PERSISTENT_RESERVE_IN SA: 0x%02x\n", sa);
> +		return TCM_UNSUPPORTED_SCSI_OPCODE;
> +	}
> +
> +	return ret;


ret is uninitialize in the iblock_pr_report_caps case.

> +	switch (cdb[0]) {
> +	case RESERVE:
> +	case RESERVE_10:
> +	case RELEASE:
> +	case RELEASE_10:
> +		/*
> +		 * The block layer pr_ops don't support the old RESERVE/RELEASE
> +		 * commands.
> +		 */
> +		if (dev->dev_attrib.emulate_pr &&
> +		    (dev->transport_flags & TRANSPORT_FLAG_PASSTHROUGH_PGR))
> +			return TCM_UNSUPPORTED_SCSI_OPCODE;
> +	}

Can't this check go straight int sbc_parse_cdb?
