Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40763551112
	for <lists+target-devel@lfdr.de>; Mon, 20 Jun 2022 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiFTHM7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 20 Jun 2022 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiFTHM6 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:12:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B67F4D;
        Mon, 20 Jun 2022 00:12:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A90B68AA6; Mon, 20 Jun 2022 09:12:55 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:12:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, hch@lst.de, axboe@kernel.dk,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 01/11] scsi: target: Rename sbc_ops to exec_cmd_ops
Message-ID: <20220620071254.GC11418@lst.de>
References: <20220603065536.5641-1-michael.christie@oracle.com> <20220603065536.5641-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603065536.5641-2-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
