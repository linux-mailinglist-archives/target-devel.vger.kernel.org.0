Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1FC318E1A
	for <lists+target-devel@lfdr.de>; Thu, 11 Feb 2021 16:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhBKPUz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 11 Feb 2021 10:20:55 -0500
Received: from verein.lst.de ([213.95.11.211]:55799 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhBKPSe (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:18:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 995DE68CFC; Thu, 11 Feb 2021 16:17:50 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:17:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 14/14] target: remove target_submit_cmd_map_sgls
Message-ID: <20210211151750.GL22082@lst.de>
References: <20210211122728.31721-1-michael.christie@oracle.com> <20210211122728.31721-15-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211122728.31721-15-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

> + * This function must only be used by drivers that do their own
> + * sync during shutdown and does not use target_stop_session. If there
> + * is a failure this function will call into the fabric driver's
> + * queue_status with a CHECK_CONDITION.
>   */
> -int target_submit_cmd(struct se_cmd *se_cmd, struct se_session *se_sess,
> +void target_submit_cmd(struct se_cmd *se_cmd, struct se_session *se_sess,
>  		unsigned char *cdb, unsigned char *sense, u64 unpacked_lun,
>  		u32 data_length, int task_attr, int data_dir, int flags)
>  {
> +	target_init_cmd(se_cmd, se_sess, sense, unpacked_lun, data_length,
> +			task_attr, data_dir, flags);
> +	target_submit_prep(se_cmd, cdb, NULL, 0, NULL, 0, NULL, 0);

Do we want a WARN_ON_ONCE here to catch the case where the API is
misued?
