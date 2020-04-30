Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD671C011A
	for <lists+target-devel@lfdr.de>; Thu, 30 Apr 2020 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgD3P7d (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 30 Apr 2020 11:59:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25645 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgD3P7d (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588262371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak/m1asrAP99s/7VmlulBMz0LCyiXcFOpOnnV/ukxY4=;
        b=VtOBPho2VXVPnYpFP4lC8UXFCtqp2rdmKS3YuznGKO7nq73e97YPDXV8XLaM34akn3fvp0
        BhIcM+JMYJSBQhwHiq9JfOHjRE74MuVeZAELZbOQFhV7z4q7M4cW1nM0JRLF9TlseO6kFn
        HFNobpzspTdHUF0i3qjAsujNZeKpEiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-DlyH0xI0MbmMXxwA8xusiA-1; Thu, 30 Apr 2020 11:59:26 -0400
X-MC-Unique: DlyH0xI0MbmMXxwA8xusiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C02618014D5;
        Thu, 30 Apr 2020 15:59:25 +0000 (UTC)
Received: from [10.10.116.41] (ovpn-116-41.rdu2.redhat.com [10.10.116.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4243E1C953;
        Thu, 30 Apr 2020 15:59:25 +0000 (UTC)
Subject: Re: [RFC] tcmu: wrong input from userspace can confuse tcmu
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        martin.petersen@oracle.com, target-devel@vger.kernel.org
References: <20200430151041.31053-1-bstroesser@ts.fujitsu.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <90283f89-c4e7-19c0-2fdf-64c791f33221@redhat.com>
Date:   Thu, 30 Apr 2020 10:59:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430151041.31053-1-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 4/30/20 10:10 AM, Bodo Stroesser wrote:
> Hi,
> 
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
> Of course this is easy to fix. E.g.:
> 
> 
> --- a/drivers/target/target_core_user.c	2020-04-30 14:15:36.177184668 +0200
> +++ b/drivers/target/target_core_user.c	2020-04-30 14:29:43.331882066 +0200
> @@ -1242,13 +1242,14 @@ static unsigned int tcmu_handle_completi
>  		}
>  		WARN_ON(tcmu_hdr_get_op(entry->hdr.len_op) != TCMU_OP_CMD);
>  
> -		cmd = idr_remove(&udev->commands, entry->hdr.cmd_id);
> -		if (!cmd) {
> +		cmd = idr_find(&udev->commands, entry->hdr.cmd_id);
> +		if (!cmd || !test_bit(TCMU_CMD_BIT_INFLIGHT, &cmd->flags)) {
>  			pr_err("cmd_id %u not found, ring is broken\n",
>  			       entry->hdr.cmd_id);
>  			set_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
>  			break;
>  		}
> +		idr_remove(&udev->commands, entry->hdr.cmd_id);
>  
>  		tcmu_handle_completion(cmd, entry);
>  
> 
> To avoid the second idr_*() call in main data path, it would also
> be possible to not replace the idr_remove() by idr_find(), but
> in case cmd was found without TCMU_CMD_BIT_INFLIGHT being set,
> during error handling re-add the cmd to the idr with the same id
> as before by calling idr_alloc(...,cmd_id, crmdd_id+1, ...).
> 
> 
> OTOH, I'm wondering whether the better solution would be to
> remove idr_alloc() from tcmu_setup_cmd_timer() and add it
> to queue_cmd_ring() immediately before or after it calls
> tcmu_setup_cmd_timer().
> Doing so would mean that commands in qfull_queue no longer have
> a cmd_id (which is not necessary AFAICS) and therefore the problem

It's done for logging, but its only debug logging so we could just print
the pointer value.

> cannot happen, because tcmu_handle_completions() cannot find them
> in the IDR.
> 

This is probably best if it's not a lot of trouble.

If you go this route then in tcmu_reset_ring I think I made a mistake
and we just continue the loop if TCMU_CMD_BIT_INFLIGHT is not set. I
think we want to do:

for cmd in qfull_list
    target_complete_cmd()

for cmd in idr
     target_complete_cmd()

