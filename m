Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B684D318E11
	for <lists+target-devel@lfdr.de>; Thu, 11 Feb 2021 16:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBKPUP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 11 Feb 2021 10:20:15 -0500
Received: from verein.lst.de ([213.95.11.211]:55782 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230155AbhBKPRm (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:17:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4038F68BFE; Thu, 11 Feb 2021 16:15:36 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:15:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, stefanha@redhat.com,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 10/14] usb gadget: Convert to new submission API
Message-ID: <20210211151535.GI22082@lst.de>
References: <20210211122728.31721-1-michael.christie@oracle.com> <20210211122728.31721-11-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211122728.31721-11-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
