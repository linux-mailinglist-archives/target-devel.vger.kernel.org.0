Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE271CF9E7
	for <lists+target-devel@lfdr.de>; Tue, 12 May 2020 17:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgELPz4 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 12 May 2020 11:55:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58188 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727840AbgELPzy (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 12 May 2020 11:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589298952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMCjU33qYGO6AVBY72d2cbej+vdzOEEkt+eE3OkviF4=;
        b=Gi4kfU6EXu88UCHTLSYnirI5Y/oMqaHfYUUV+ClK/x6TiXWGgLx9UfxQfvkUNCS60ovwy4
        sebWR4vLHaSPD6fgkXq3ZkEnp0mlP6wlidivGkXoAQlX6UjK5AxRuv9Wvt7Ot7QmjevhYs
        SWApJ/DkmE9xtOmTW4IB1qMwLgFhgN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-DnJUG0hxO-WZ08XVvLB5Fw-1; Tue, 12 May 2020 11:55:36 -0400
X-MC-Unique: DnJUG0hxO-WZ08XVvLB5Fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D75FC18FF669;
        Tue, 12 May 2020 15:55:34 +0000 (UTC)
Received: from [10.10.113.28] (ovpn-113-28.rdu2.redhat.com [10.10.113.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A2BA7D8EC;
        Tue, 12 May 2020 15:55:33 +0000 (UTC)
Subject: Re: [PATCH 12/15] target: add sysfs session helper functions
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        Bart Van Assche <bvanassche@acm.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
References: <20200510215744.21999-1-mchristi@redhat.com>
 <20200510215744.21999-13-mchristi@redhat.com>
 <66e9bbf8-fdb2-d819-a496-75a1dea779cf@ts.fujitsu.com>
 <a3686299-8fab-3cf7-0641-5e7c98a7292d@acm.org>
 <5234c678-92e6-0689-1eca-aa0c252adf58@redhat.com>
 <a1ca0d10-9011-52a6-f40b-dc5086d9e273@ts.fujitsu.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <52a13df8-3d36-2ebc-a288-88d4dbfe9cd1@redhat.com>
Date:   Tue, 12 May 2020 10:55:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a1ca0d10-9011-52a6-f40b-dc5086d9e273@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/12/20 6:19 AM, Bodo Stroesser wrote:
> On 05/11/20 22:16, Mike Christie wrote:
>> On 5/11/20 2:21 PM, Bart Van Assche wrote:
>>> On 2020-05-11 11:39, Bodo Stroesser wrote:
>>>> On 05/10/20 23:57, Mike Christie wrote:
>>>>> This patch adds helpers to add/remove a dir per session. There is
>>>>> only 2
>>>>> files/dirs initially.
>>>>>
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +int target_sysfs_add_session(struct se_portal_group *se_tpg,
>>>>> +                 struct se_session *se_sess)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    /*
>>>>> +     * Copy ACL name so we don't have to worry about mixing configfs
>>>>> +     * and sysfs refcounts.
>>>>> +     */
>>>>> +    if (!se_sess->se_node_acl->dynamic_node_acl) {
>>>>> +        se_sess->acl_name =
>>>>> kstrdup(se_sess->se_node_acl->initiatorname,
>>>>> +                        GFP_KERNEL);
>>>>> +        if (!se_sess->acl_name)
>>>>> +            return -ENOMEM;
>>>>> +    }
>>>>> +
>>>>> +    ret = kobject_add(&se_sess->kobj, se_tpg->sessions_kobj, "%s-%d",
>>>>> +              se_sess->tpt_id->name, se_sess->sid);
>>>>> +    if (ret) {
>>>>> +        pr_err("Could not add session%d to sysfs. Error %d.\n",
>>>>> +               se_sess->sid, ret);
>>>>> +        goto free_acl_name;
>>>>> +    }
>>>>> +
>>>>> +    ret = add_transport_id_attrs(se_sess);
>>>>> +    if (ret)
>>>>> +        goto del_kobj;
>>>>> +
>>>>> +    if (se_sess->tfo->session_attrs) {
>>>>> +        ret = sysfs_create_group(&se_sess->kobj,
>>>>> +                     se_sess->tfo->session_attrs);
>>>>> +        if (ret)
>>>>> +            goto rm_tpt_id_grps;
>>>>> +    }
>>>>> +
>>>>> +    ret = sysfs_create_link(tcm_core_sessions_kobj, &se_sess->kobj,
>>>>> +                se_sess->kobj.name);
>>>>
>>>> I would prefer to have links named "session-%d" or "%d" only, of course
>>>> with se_sess->sid as the value for '%d'.
>>
>> Yeah for the part of your comment that got chopped I can see your point.
>> For the dynamic acl case (userspace did not create an ACL so the kernel
>> made a tmp one), then doing session-$id will be easier for userspace to
>> lookup a specific session since it does not know the initiator name and
>> only knows the session id.
> 
> Yes, I meant, that "session-%d" or even "%d" only would be fine for the
> links in scsi_target/sessions. When looking for a session if session-id
> is known only, then this is easy to use.
> 
> Regarding the session folders in the tpgt_X folder, I think the "%s-%d"
> format with acl or initiator name followed by the session-id would be
> fine for both cases, with acl and with dynamic acl. Again the above
> links can be used for dynamic acl lookup.
>
I don't think that's possible.

To handle Greg's comment we will use device structs instead of kobjects
directly. It's going to end up looking like
drivers/scsi_transport_iscsi.c where that initiator side session has a
device struct in it. You have a scsi_target_session class and device
structs show up in /sys/class/scsi_target_session. In this case, you do
not have control over the symlink name from
/sys/class/scsi_target_session to /sys/devices/. The dir name and
symlink name are going to be the device structs name.

