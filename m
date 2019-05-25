Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823BC2A753
	for <lists+target-devel@lfdr.de>; Sun, 26 May 2019 01:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfEYXKp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 25 May 2019 19:10:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfEYXKp (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Sat, 25 May 2019 19:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B050C0587F5;
        Sat, 25 May 2019 23:10:45 +0000 (UTC)
Received: from [10.10.120.40] (ovpn-120-40.rdu2.redhat.com [10.10.120.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35BA55C23E;
        Sat, 25 May 2019 23:10:45 +0000 (UTC)
Subject: Re: tcmu-runner libtcmu.so versioning
To:     David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org
References: <20190522150417.0650ed2f@suse.de>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5CE9CB74.8070109@redhat.com>
Date:   Sat, 25 May 2019 18:10:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190522150417.0650ed2f@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 25 May 2019 23:10:45 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 05/22/2019 08:04 AM, David Disseldorp wrote:
> Hi,
> 
> Some ABI changes went into libtcmu between v1.3.0 and v1.4.0 without a
> corresponding .so version bump (e.g. 566c2ad5c8a). This breaks
> dependency checking in some package managers, allowing for a v1.4.0
> tcmu-runner to be installed alongside a v1.3.0 libtcmu.so
> 
> Should we consider adding a 2nd (minor) .so version number to libtcmu,
> so that it can be bumped for backwards compatible ABI changes like this
> one?
> 

That seems ok to me.

