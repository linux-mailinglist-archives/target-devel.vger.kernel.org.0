Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6195269DFF
	for <lists+target-devel@lfdr.de>; Tue, 15 Sep 2020 07:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgIOFpa (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 15 Sep 2020 01:45:30 -0400
Received: from verein.lst.de ([213.95.11.211]:46372 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgIOFp3 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:45:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F7B76736F; Tue, 15 Sep 2020 07:45:25 +0200 (CEST)
Date:   Tue, 15 Sep 2020 07:45:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: clean up is partition checks
Message-ID: <20200915054525.GA18276@lst.de>
References: <20200903054104.228829-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903054104.228829-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Jens,

can you pick this series up?
