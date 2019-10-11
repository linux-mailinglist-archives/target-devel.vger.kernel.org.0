Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88AD488A
	for <lists+target-devel@lfdr.de>; Fri, 11 Oct 2019 21:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfJKTiP (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 11 Oct 2019 15:38:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5351 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbfJKTiP (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Fri, 11 Oct 2019 15:38:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B27E2A09B1;
        Fri, 11 Oct 2019 19:38:14 +0000 (UTC)
Received: from [10.10.123.1] (ovpn-123-1.rdu2.redhat.com [10.10.123.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B89D6012A;
        Fri, 11 Oct 2019 19:38:13 +0000 (UTC)
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Bart Van Assche <bvanassche@acm.org>,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        Hannes Reinecke <hare@suse.de>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
 <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
 <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
 <c87f1206-4abd-d7d3-bc68-369abf80950f@ts.fujitsu.com>
 <c5c1b35f-6dcf-dedc-b380-f28b1684c69e@acm.org> <5D9FA02E.3050909@redhat.com>
 <b5c4de4c-b93d-8579-e427-79cb565e3d08@suse.de>
 <38ec5155-9dd1-480a-a542-141f652bc2eb@ts.fujitsu.com>
 <1ab6c1c0-1928-f8c7-ab8d-d655725d32aa@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DA0DA24.3080707@redhat.com>
Date:   Fri, 11 Oct 2019 14:38:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1ab6c1c0-1928-f8c7-ab8d-d655725d32aa@acm.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 11 Oct 2019 19:38:14 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/11/2019 12:13 PM, Bart Van Assche wrote:
> On 10/11/19 3:12 AM, Bodo Stroesser wrote:
>> If I understood correctly, we all would prefer to make TCMU completely
>> transparent regarding the CDB.
>>
>> For pscsi I think we all agree, that the code is wrong or incomplete.
>> But for pscsi up to now no one complained. So I'm wondering whether we
>> should spend much effort for pscsi to discuss / find out the right
>> solution? Especially as the original comment in the code, as posted by
>> Mike, as well as the current comment are not very clear. Thus 'fixing'
>> pscsi would mean to change or remove something we don't understand
>> completely.
>>
>> So I agree to Hannes: we should simply move that code from
>> passthrough_parse_cdb() to pscsi_parse_cdb(), at least as a first step.
> 
> Hannes wrote "[ ... ] delegate it to pscsi if there is a need." Is there
> really a need for such code in the SCSI passthrough driver? The upstream
> SCSI target code is one of the four Linux SCSI target stacks that I know
> of. I haven't found any SCSI-2 LUN number filtering code in the tgt
> project (http://stgt.sourceforge.net/). I'm not sure about IET. SCST is
> around since 2006 and has SCSI-2 LUN number filtering code in its CDROM
> and MODISK passthrough drivers. That LUN number filtering code is there
> since the initial commit so it is not the result of a recent request of
> a user. SCST does not have LUN filtering code in its disk passthrough
> driver nor in its tape passthrough driver. In other words, I do not
> expect that anyone's setup will be broken by removing
> passthrough_parse_cdb() entirely.

I originally thought it was for a really specific case Nick hit a long
time ago because the code is so odd. However, the original code's
comment sounds like Nick might have read the specs incorrectly or was
working off a older iscsi rfc draft. I think this happened in some
persistent reservation code that is wrong too.

I think if the code it was for a specific initiator then he would have
added that in the code comments. For example for a while we had a really
specific comment about the mac os initiator or qlogic on windows or
something, and there is still a comment about solaris. If on the other
hand it was a spec thing then it seems he writes the scsi spec name like
he did in the original comment.
