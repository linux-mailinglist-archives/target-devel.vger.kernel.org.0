Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A3C1AAFA9
	for <lists+target-devel@lfdr.de>; Wed, 15 Apr 2020 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410995AbgDOR2L (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 15 Apr 2020 13:28:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2411047AbgDOR2I (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586971686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWVMXJj0PgE0ZtJFYMbnUIjfqT+kyQnX32fIyyeczQE=;
        b=W6jpEJUX6ZFtdej0ieZrrNZySU5ullvR75do5tfDNzaQOf9Lca5gCKARJ9yFFaFVoqNHSN
        2wdmtruEr1enfEDdPKyybqsC6GthfZpuBEH146p1665rlwidZTLELqx4k6WGbnMSliXd47
        7BlFQQx7CRWL+/ZfKoNohR+5kc9Yg90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-lua_s9gFPNaXB666v-lTaw-1; Wed, 15 Apr 2020 13:28:05 -0400
X-MC-Unique: lua_s9gFPNaXB666v-lTaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7AEA18B9FC2;
        Wed, 15 Apr 2020 17:28:03 +0000 (UTC)
Received: from [10.10.115.103] (ovpn-115-103.rdu2.redhat.com [10.10.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDF3F116D7C;
        Wed, 15 Apr 2020 17:28:02 +0000 (UTC)
Subject: Re: [RFC PATCH 1/5] target: add sysfs support
To:     Bart Van Assche <bvanassche@acm.org>, jsmart2021@gmail.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, nab@linux-iscsi.org
References: <20200414051514.7296-1-mchristi@redhat.com>
 <20200414051514.7296-2-mchristi@redhat.com>
 <b6b87cff-c359-b7f6-ffd0-ff5b49dccbb8@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E974422.2060107@redhat.com>
Date:   Wed, 15 Apr 2020 12:28:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <b6b87cff-c359-b7f6-ffd0-ff5b49dccbb8@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04/14/2020 09:23 PM, Bart Van Assche wrote:
> On 2020-04-13 22:15, Mike Christie wrote:
>> target_core/
>> `-- $fabric_driver
>>     `-- target_name
>>         |-- tpgt_1
>>         |   `-- sessions
>>         `-- tpgt_2
>>             `-- sessions
>>
>> iscsi example:
>> target_core/
>> `-- iscsi
>>     `-- iqn.1999-09.com.lio:tgt1
>>         |-- tpgt_1
>>         |   `-- sessions
>>         `-- tpgt_2
>>             `-- sessions
> 
> After the SCSI target core was added to the kernel tree an NVMe target
> core was added. How about using the name "scsi_target" for the top-level
> directory instead of "target_core" to prevent confusion with the NVMe
> target?
> 

Will do.

