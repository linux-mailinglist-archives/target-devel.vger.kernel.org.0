Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0279782AD4
	for <lists+target-devel@lfdr.de>; Tue,  6 Aug 2019 07:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfHFFTR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 6 Aug 2019 01:19:17 -0400
Received: from verein.lst.de ([213.95.11.211]:53047 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFFTR (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:19:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4033C68B05; Tue,  6 Aug 2019 07:19:12 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:19:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:SCSI TARGET SUBSYSTEM" <target-devel@vger.kernel.org>
Subject: Re: [PATCH] block: Remove request_queue argument from
 blk_execute_rq_nowait
Message-ID: <20190806051911.GA13409@lst.de>
References: <20190806011754.7722-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806011754.7722-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:17:51PM -0300, Marcos Paulo de Souza wrote:
> +void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
> +			int at_head, rq_end_io_fn *done)

We store a ->rq_disk in struct request, so we should also not need
that.  And at_head should either become a bool, or be replaced with
a flags argument, ints used boolean are usually not a good idea.

> @@ -81,7 +80,7 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,

And all the same argument changes that apply to blk_execute_rq_nowait
apply to blk_execute_rq as well.
