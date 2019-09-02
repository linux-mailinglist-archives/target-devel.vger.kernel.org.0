Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F712A51E1
	for <lists+target-devel@lfdr.de>; Mon,  2 Sep 2019 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfIBIgX (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 2 Sep 2019 04:36:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729534AbfIBIgX (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:36:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C3F9AF0D;
        Mon,  2 Sep 2019 08:36:22 +0000 (UTC)
Date:   Mon, 2 Sep 2019 10:36:22 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, mlombard@redhat.com
Subject: Re: [PATCH] target: compare full CHAP_A Algorithm strings
Message-ID: <20190902103622.0e6e6d54@suse.de>
In-Reply-To: <20190830171611.32540-1-ddiss@suse.de>
References: <20190830171611.32540-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, 30 Aug 2019 19:16:11 +0200, David Disseldorp wrote:

...
> LIO currently checks for this value by only comparing a single byte in
> the tokenized Algorithm string, which means that any value starting with
> a '5' (e.g. "55") is interpreted as "CHAP with MD5".

FWIW, this can be triggered via a simple libiscsi hack:
https://github.com/ddiss/libiscsi/commit/a6a41fd002c18edaad5d7df320373ec0232b460d.patch

Cheers, David
