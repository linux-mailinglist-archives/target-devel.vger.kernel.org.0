Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30122318E51
	for <lists+target-devel@lfdr.de>; Thu, 11 Feb 2021 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBKPYg (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 11 Feb 2021 10:24:36 -0500
Received: from verein.lst.de ([213.95.11.211]:55810 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhBKPWM (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:22:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9ABAD68B02; Thu, 11 Feb 2021 16:10:25 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:10:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 03/14] target: rename transport_init_se_cmd
Message-ID: <20210211151025.GB22082@lst.de>
References: <20210211122728.31721-1-michael.christie@oracle.com> <20210211122728.31721-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211122728.31721-4-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
