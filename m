Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259411A002B
	for <lists+target-devel@lfdr.de>; Mon,  6 Apr 2020 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDFVdv (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 6 Apr 2020 17:33:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgDFVdv (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:33:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9910CAA55;
        Mon,  6 Apr 2020 21:33:49 +0000 (UTC)
Date:   Mon, 6 Apr 2020 23:33:47 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Andreas Kinzler <hfp@posteo.de>
Cc:     target-devel@vger.kernel.org
Subject: Re: strange dm-crypt problem with qemu / LIO / vhost
Message-ID: <20200406233347.5c764427@suse.de>
In-Reply-To: <5e29cc94-a21d-2506-9bac-48d8d29ab85b@posteo.de>
References: <5e29cc94-a21d-2506-9bac-48d8d29ab85b@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Andreas,

It's normally a good idea to provide your kernel version with any
bug reports...

On Mon, 6 Apr 2020 20:21:55 +0200, Andreas Kinzler wrote:

> [ 3683.414936] bio error: 0000000024d02dea,  err: 10
> 
> This is from target_core_iblock.c function "iblock_bio_done".
> 
> Any ideas? Hints?

This looks like an I/O error from the block layer / underlying dm-crypt
block device. It's not much to go on, but I'd suggest tracing the I/O
further down the stack.

Cheers, David
