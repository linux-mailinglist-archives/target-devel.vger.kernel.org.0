Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74E4C3135
	for <lists+target-devel@lfdr.de>; Thu, 24 Feb 2022 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiBXQ1s (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Feb 2022 11:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiBXQ1s (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:27:48 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACAA38BFA;
        Thu, 24 Feb 2022 08:27:17 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C17068AFE; Thu, 24 Feb 2022 17:27:13 +0100 (CET)
Date:   Thu, 24 Feb 2022 17:27:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 3/8] scsi: don't memset the entire scsi_cmnd in
 scsi_init_command
Message-ID: <20220224162713.GA31469@lst.de>
References: <20220222140443.589882-1-hch@lst.de> <20220222140443.589882-4-hch@lst.de> <d94e5e8a-9793-ab48-88f8-6f6bb878cecd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d94e5e8a-9793-ab48-88f8-6f6bb878cecd@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Feb 24, 2022 at 08:28:48AM +0000, John Garry wrote:
>> +	if (!blk_rq_is_passthrough(rq) && !(cmd->flags & SCMD_INITIALIZED)) {
>> +		cmd->flags |= SCMD_INITIALIZED;
>
> Maybe I'm being dozy, but isn't this being cleared below *

with below you mean the

	cmd->flags &= SCMD_PRESERVED_FLAGS;

?  No, that doen't clear the flag, but all the others.
