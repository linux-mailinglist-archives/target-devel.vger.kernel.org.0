Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C181C4230
	for <lists+target-devel@lfdr.de>; Tue,  1 Oct 2019 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfJAVAh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 1 Oct 2019 17:00:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfJAVAh (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:00:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E61A469078;
        Tue,  1 Oct 2019 21:00:36 +0000 (UTC)
Received: from [10.10.122.80] (ovpn-122-80.rdu2.redhat.com [10.10.122.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1351160BE0;
        Tue,  1 Oct 2019 21:00:35 +0000 (UTC)
Subject: Re: [PATCH] target: Remove tpg_list and se_portal_group.se_tpg_node
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20190930232224.58980-1-bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D93BE73.3080809@redhat.com>
Date:   Tue, 1 Oct 2019 16:00:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190930232224.58980-1-bvanassche@acm.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 01 Oct 2019 21:00:37 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 09/30/2019 06:22 PM, Bart Van Assche wrote:
> Maintaining tpg_list without ever iterating over it is not useful. Hence
> remove tpg_list. This patch does not change the behavior of the SCSI
> target code.
> 
> Cc: Mike Christie <mchristie@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Nicholas Bellinger <nab@linux-iscsi.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/target/target_core_tpg.c   | 12 ------------
>  drivers/target/target_core_xcopy.c |  1 -
>  include/target/target_core_base.h  |  1 -
>  3 files changed, 14 deletions(-)
> 

Reviewed-by: Mike Christie <mchristi@redhat.com>

