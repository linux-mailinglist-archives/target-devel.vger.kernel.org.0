Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E1926445
	for <lists+target-devel@lfdr.de>; Wed, 22 May 2019 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfEVNET (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 22 May 2019 09:04:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:58878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbfEVNET (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 22 May 2019 09:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51765AD87;
        Wed, 22 May 2019 13:04:18 +0000 (UTC)
Date:   Wed, 22 May 2019 15:04:17 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: tcmu-runner libtcmu.so versioning
Message-ID: <20190522150417.0650ed2f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,

Some ABI changes went into libtcmu between v1.3.0 and v1.4.0 without a
corresponding .so version bump (e.g. 566c2ad5c8a). This breaks
dependency checking in some package managers, allowing for a v1.4.0
tcmu-runner to be installed alongside a v1.3.0 libtcmu.so

Should we consider adding a 2nd (minor) .so version number to libtcmu,
so that it can be bumped for backwards compatible ABI changes like this
one?

Cheers, David
