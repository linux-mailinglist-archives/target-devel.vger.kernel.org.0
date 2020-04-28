Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC41BC62C
	for <lists+target-devel@lfdr.de>; Tue, 28 Apr 2020 19:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgD1RGz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 28 Apr 2020 13:06:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22484 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728298AbgD1RGz (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588093614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vyBZEVhw3dMUt2Tf+hRNHPwErg0PhFD0D+NSQMeOFE=;
        b=G/I68mv7FYTnHBl8ATqcC3OX2w4oPXO5n/DvMmpRWInslX05DQINnPgwjjo6fac4BhpuiV
        caj0StVQCZQfSJzy24vSR6o4DmfxlpU6bCUo8QRZFwnyAtEnBee1mH2hi1gDSactuwCLHd
        RovnWaL1Msj2oI4SjnLfNZ+VbOuyBo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-yQcfkX2INkaTu5OTUrcTRQ-1; Tue, 28 Apr 2020 13:06:49 -0400
X-MC-Unique: yQcfkX2INkaTu5OTUrcTRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 076D6800C78;
        Tue, 28 Apr 2020 17:06:48 +0000 (UTC)
Received: from [10.10.112.215] (ovpn-112-215.rdu2.redhat.com [10.10.112.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1778F5D715;
        Tue, 28 Apr 2020 17:06:46 +0000 (UTC)
Subject: Re: [PATCH 08/11] target: add sysfs session helper functions
To:     Bart Van Assche <bvanassche@acm.org>, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20200428061109.3042-1-mchristi@redhat.com>
 <20200428061109.3042-9-mchristi@redhat.com>
 <1c97ee38-7a0e-5aac-6065-41267baea648@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <3b071301-3fc4-bc5b-d367-a9e9d5595e0e@redhat.com>
Date:   Tue, 28 Apr 2020 12:06:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1c97ee38-7a0e-5aac-6065-41267baea648@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 4/28/20 11:43 AM, Bart Van Assche wrote:
> On 2020-04-27 23:11, Mike Christie wrote:
>> +	ret = kobject_add(&se_sess->kobj, se_tpg->sessions_kobj, "session-%d",
>> +			  se_sess->sid);
>> +	if (ret) {
>> +		pr_err("Could not add session%d to sysfs. Error %d.\n",
>> +		       se_sess->sid, ret);
>> +		goto free_acl_name;
>> +	}
> 
> Has it been considered to derive the directory name for a session from
> the initiator name (se_node_acl.initiatorname-%d)? Would that be more
> convenient for users than the session-%d naming scheme?

It seems nicer. I can do the initaitorname-%d.

It will also handle the iscsi case where we have multiple sessions from
the same initiator to the same target port.

> 
> Thanks,
> 
> Bart.
> 

