Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F4D82FA3
	for <lists+target-devel@lfdr.de>; Tue,  6 Aug 2019 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfHFKXy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 6 Aug 2019 06:23:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44087 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFKXy (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:23:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so81764920edr.11;
        Tue, 06 Aug 2019 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nHAZm0GZeVyi0k2jXAqZJ6+K/F+OXmkni52x4h/2WKU=;
        b=W6yaIi5Eo9POup4WUZfRIHlyJ8IGxq+DvAHVwLOkie5rWs0Fk9vvDlFBrcwFpoK+VL
         Tj0JydlTDm1RimAaQo0IBtt0NGVl1bzVHDI3DDYlzgCDaqlQoQAc43r3qj7Ivm8RcyhC
         eJKN/HvOYiTmeFsPcLvX9daiIIXSgCUlLR/bJOUTieraPl+UPBZrrJQFtXaclzq/bra+
         AF+Zksj+MchmgA6LNPHlmULwQwjjdyA4PjX01pHQg3/ZCrqEzkOKxlLBpKVN6jmSv01r
         C80UUtClWdQqFzFISc93OQENgf7/tFHSDLNumfYDptwVttiXjO3XgQEc1Tc+85IfBkBA
         9y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nHAZm0GZeVyi0k2jXAqZJ6+K/F+OXmkni52x4h/2WKU=;
        b=tdMKdsBAdbrtBhxYHaokf5Ibn8HPuH0qfkGNbT9ewlu3G53+zDCY7us5ksycetQ2h7
         FwJDyc/3bYG7IxkiJz1H2jq4VaD5ifz+PK4x3PcJmgURTUAamDCVMppm5BTWasdnuFNI
         FdaX/uicv9gbV3FqAk5Vontu7PjgXXrPEQKGz77dBRPW+YMANLuv6ffSxkAAyq98CQ1v
         +hGjiNrdkkyUBD3vk6qqimDRME+4CyQAuj6gHpLIQcJgikQunC9ja1Wz07efWj+DIr/x
         W5v/IYufaoqS+IP5nNJFJqLkwUwTBAIDDCKJrem5zWYBThyvXe8hLj3kcqnqGAv6Esjf
         mGeg==
X-Gm-Message-State: APjAAAXnHzPpDYVmlDzTcxBmn72mkgc1nizfYx7ehTUl3n9XDfEeYsA7
        KfWiSDPa9ZRdjbGSZ7rTp3k=
X-Google-Smtp-Source: APXvYqxNSOOeEKipsPzXzNB35eNLgJeH0dlFgOZerwtyAg1/J6mRzv95o7+dpOqMTQU7nPiqxQkS0w==
X-Received: by 2002:a17:906:8386:: with SMTP id p6mr2356514ejx.139.1565087031956;
        Tue, 06 Aug 2019 03:23:51 -0700 (PDT)
Received: from continental ([187.112.244.117])
        by smtp.gmail.com with ESMTPSA id jt17sm14779247ejb.90.2019.08.06.03.23.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 03:23:51 -0700 (PDT)
Date:   Tue, 6 Aug 2019 07:24:56 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
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
Message-ID: <20190806102456.GA29914@continental>
References: <20190806011754.7722-1-marcos.souza.org@gmail.com>
 <20190806051911.GA13409@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806051911.GA13409@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:19:11AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 05, 2019 at 10:17:51PM -0300, Marcos Paulo de Souza wrote:
> > +void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
> > +			int at_head, rq_end_io_fn *done)
> 
> We store a ->rq_disk in struct request, so we should also not need
> that.  And at_head should either become a bool, or be replaced with
> a flags argument, ints used boolean are usually not a good idea.

Makes sense.

> 
> > @@ -81,7 +80,7 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
> 
> And all the same argument changes that apply to blk_execute_rq_nowait
> apply to blk_execute_rq as well.

Thanks for the suggestions, I will send a v2 soon.
