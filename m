Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB695D435
	for <lists+target-devel@lfdr.de>; Tue,  2 Jul 2019 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfGBQ0V (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 2 Jul 2019 12:26:21 -0400
Received: from verein.lst.de ([213.95.11.211]:43972 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBQ0V (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:26:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88E10227A81; Tue,  2 Jul 2019 18:26:19 +0200 (CEST)
Date:   Tue, 2 Jul 2019 18:26:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Christie <mchristie@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH 0/2] Use REQ_OP_WRITE_SAME to implement WRITE SAME
Message-ID: <20190702162619.GA19142@lst.de>
References: <20190702153031.3832-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702153031.3832-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

I actually rather wanted to get rid of REQ_OP_WRITE_SAME entirely.
Do you have a use case for this?

Note that it isn't going to help with nvme either, as there is no
write same command in nvme.
