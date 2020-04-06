Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9E1A0161
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 01:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDFXFM (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 6 Apr 2020 19:05:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgDFXFM (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:05:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E813AD5D;
        Mon,  6 Apr 2020 23:05:10 +0000 (UTC)
Date:   Tue, 7 Apr 2020 01:05:08 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Andreas Kinzler <hfp@posteo.de>
Cc:     target-devel@vger.kernel.org
Subject: Re: strange dm-crypt problem with qemu / LIO / vhost
Message-ID: <20200407010508.70bd36c6@suse.de>
In-Reply-To: <b05a9703-673b-8a14-c274-69258f28879b@posteo.de>
References: <5e29cc94-a21d-2506-9bac-48d8d29ab85b@posteo.de>
        <20200406233347.5c764427@suse.de>
        <b05a9703-673b-8a14-c274-69258f28879b@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, 7 Apr 2020 00:01:49 +0200, Andreas Kinzler wrote:

> > It's normally a good idea to provide your kernel version with any
> > bug reports...  
> 
> Sorry. Kernel is 5.3.18 vanilla from kernel.org

Thanks.

> >> [ 3683.414936] bio error: 0000000024d02dea,  err: 10
> >> This is from target_core_iblock.c function "iblock_bio_done".
> >> Any ideas? Hints?  
> > This looks like an I/O error from the block layer / underlying dm-crypt
> > block device. It's not much to go on, but I'd suggest tracing the I/O
> > further down the stack.  
> 
> In the meantime, I was able to debug further. Actually in Windows only 
> the "format disk" operation fails. If you do that otherwise and later 
> use the formatted disk, it seems to work. So I assume it is a special 
> SCSI opcode that is only used during "format disk" that fails.
> 
> What would be a simple debug statement in iblock_bio_done to print the 
> SCSI opcode to find out which operation failed?

You could print the SCSI opcode value with something like:

--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -290,7 +290,8 @@ static void iblock_bio_done(struct bio *bio)
        struct iblock_req *ibr = cmd->priv;
 
        if (bio->bi_status) {
-               pr_err("bio error: %p,  err: %d\n", bio, bio->bi_status);
+               pr_err("op: %#x, bio error: %p, err: %d\n", cmd->t_task_cdb[0],
+                      bio, bio->bi_status);
                /*
                 * Bump the ib_bio_err_cnt and release bio.
                 */


include/scsi/scsi_proto.h should allow you to lookup the name.

Cheers, David
