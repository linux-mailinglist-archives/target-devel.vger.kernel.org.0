Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2271BC546
	for <lists+target-devel@lfdr.de>; Tue, 28 Apr 2020 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgD1Qd4 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 28 Apr 2020 12:33:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44144 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727920AbgD1Qd4 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588091635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccgob0MKZgg8UerF5xxVAeCXi5RDEcSn6RIleYtOkD0=;
        b=a+bmHg3JpJQD8m27/dBtVmdmS2uvr7UWz+6UCbyxokJ7LwDpGDtZTH096cHSqtcYyC3s0S
        QABvBEiFFuxcObc5c3YwTaYKXR1k1som9xAIOVnxFHZ6q6SPqkch9c49WTAAZv+Y15yVQN
        spH78iUTGbJxjQoYsnhdbdzGnVkdhbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-gjp3eRPsMnKXudD4Jm4U2w-1; Tue, 28 Apr 2020 12:33:53 -0400
X-MC-Unique: gjp3eRPsMnKXudD4Jm4U2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E4E5835B41;
        Tue, 28 Apr 2020 16:33:52 +0000 (UTC)
Received: from [10.10.112.215] (ovpn-112-215.rdu2.redhat.com [10.10.112.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3AE45D710;
        Tue, 28 Apr 2020 16:33:51 +0000 (UTC)
Subject: Re: [PATCH 07/11] target: add sysfs support
To:     Bart Van Assche <bvanassche@acm.org>, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20200428061109.3042-1-mchristi@redhat.com>
 <20200428061109.3042-8-mchristi@redhat.com>
 <a79c2243-f4ee-4138-abd5-d9df70761bf0@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <e066ccc2-c13a-3c82-22d9-0d366d8efa34@redhat.com>
Date:   Tue, 28 Apr 2020 11:33:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a79c2243-f4ee-4138-abd5-d9df70761bf0@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 4/28/20 11:29 AM, Bart Van Assche wrote:
> On 2020-04-27 23:11, Mike Christie wrote:
>> @@ -3536,6 +3551,15 @@ static int __init target_core_init_configfs(void)
>>  
>>  	target_init_dbroot();
>>  
>> +	tcm_core_kobj = kobject_create_and_add("scsi_target", NULL);
>> +	if (!tcm_core_kobj)
>> +		goto out;
> 
> Is an ack from Greg KH required when adding a new directory under
> /sys/kernel?

I'm not sure. When I resend with your other comments handled, I will cc him.

