Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF81D8852
	for <lists+target-devel@lfdr.de>; Mon, 18 May 2020 21:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgERTjo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 18 May 2020 15:39:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727987AbgERTjo (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 18 May 2020 15:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589830782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=elcnZwqR+coazwj7IQdMXJlNU9TW6tqy6BaIJjAVsVY=;
        b=HwPh1u943k8pmRKj4ATeZE0KiitVTAgSXS+kLRbxX2BC8qigsoxgYjqbKN5iguEZcPTlx/
        iSHaVqvcBl0ErUcNJKO4ZlFs6zusnCODHID7at/b4zb/0M08egibFveXA6+YMQ4xbieIso
        iO0CAB6iG2QDAMP3DblKFcQGG96/yAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-4Acsoz8PNpeiPq8WpmIw5Q-1; Mon, 18 May 2020 15:39:41 -0400
X-MC-Unique: 4Acsoz8PNpeiPq8WpmIw5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F3C107ACCD;
        Mon, 18 May 2020 19:39:39 +0000 (UTC)
Received: from [10.10.118.151] (ovpn-118-151.rdu2.redhat.com [10.10.118.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6343E5D9DC;
        Mon, 18 May 2020 19:39:39 +0000 (UTC)
Subject: Re: [PATCH v2] scsi: target: tcmu: userspace must not complete queued
 commands
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20200518164833.12775-1-bstroesser@ts.fujitsu.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <cbc8d169-2bf0-34ed-ccd7-e4a6f74260e7@redhat.com>
Date:   Mon, 18 May 2020 14:39:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518164833.12775-1-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/18/20 11:48 AM, Bodo Stroesser wrote:
> When tcmu queues a new command - no matter whether in command
> ring or in qfull_queue - a cmd_id from IDR udev->commands is
> assigned to the command.
> 
> If userspaces sends a wrong command completion containing the
> cmd_id of a command on the qfull_queue, tcmu_handle_completions()
> finds the command in the IDR and calls tcmu_handle_completion()
> for it. This might do some nasty things, because commands in
> qfull_queue do not have a valid dbi list.
> 
> To fix this bug, we no longer add queued commands to the idr.
> Instead the cmd_id is assign when a command is written to
> the command ring.
> 
> Due to this change I had to adapt the source code at several
> places where up to now an idr_for_each had been done.
> 
> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>

Acked-by: Mike Christie <mchristi@redhat.com>

