Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94BC31C77C
	for <lists+target-devel@lfdr.de>; Tue, 16 Feb 2021 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBPInO (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 16 Feb 2021 03:43:14 -0500
Received: from verein.lst.de ([213.95.11.211]:40326 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBPIlR (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:41:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91EE667373; Tue, 16 Feb 2021 09:40:30 +0100 (CET)
Date:   Tue, 16 Feb 2021 09:40:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     mst@redhat.com, stefanha@redhat.com, Chaitanya.Kulkarni@wdc.com,
        hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 11/25] vhost-scsi: Convert to new submission API
Message-ID: <20210216084030.GB23615@lst.de>
References: <20210212072642.17520-1-michael.christie@oracle.com> <20210212072642.17520-12-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212072642.17520-12-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
