Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADB1679DC
	for <lists+target-devel@lfdr.de>; Fri, 21 Feb 2020 10:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBUJwT (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 21 Feb 2020 04:52:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:47340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBUJwT (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:52:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45889B034;
        Fri, 21 Feb 2020 09:52:18 +0000 (UTC)
Date:   Fri, 21 Feb 2020 10:52:17 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>, martin.petersen@oracle.com,
        mchristi@redhat.com
Subject: Re: [PATCH v2 2/2] scsi: target: convert boolean se_dev_attrib
 types to bool
Message-ID: <20200221105217.27470200@suse.de>
In-Reply-To: <20200219230616.575e0721@suse.de>
References: <20200219130136.18946-1-ddiss@suse.de>
        <20200219130136.18946-3-ddiss@suse.de>
        <b68f71dc-a0df-dfdf-2790-6e4d3ced075a@acm.org>
        <20200219230616.575e0721@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, 19 Feb 2020 23:06:16 +0100, David Disseldorp wrote:

> On Wed, 19 Feb 2020 09:37:48 -0800, Bart Van Assche wrote:
> 
> > How about introducing an enum type for emulate_ua_intlck_ctrl? Anyway:  
> 
> Yes, that'd make sense. I'll send it as a separate follow up when I get
> a chance.

I've sent the follow up as <20200221094401.32021-1-ddiss@suse.de>. It's
dependent on this patch set.

Cheers, David
