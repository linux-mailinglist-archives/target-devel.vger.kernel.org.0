Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CBD2D09B8
	for <lists+target-devel@lfdr.de>; Mon,  7 Dec 2020 05:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgLGE3A (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 6 Dec 2020 23:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgLGE3A (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607315253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFoxhbNduukcap6r+01I62kypDZmOjRAARCOf6fwshE=;
        b=YtKi6PEukF5HAXH+XK+FoEyc58QhYnFbqSGGZXJgtwCOxx9hqeztL7J//98RoHWxOeCpLh
        R+PDIsA7feCuQRMZlfQ1OKYHK4Pd27gwDAXlqqI8W2Y7iBx/9b/o5A/AsO0FYCNQw1Fn9u
        ChRNl6J8sXL0GKnPjyytwq5Ym8ta6tQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-erg1_CrfOmuWwfa7PI4a9Q-1; Sun, 06 Dec 2020 23:27:31 -0500
X-MC-Unique: erg1_CrfOmuWwfa7PI4a9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A29B7107ACE8;
        Mon,  7 Dec 2020 04:27:30 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC2A010016FA;
        Mon,  7 Dec 2020 04:27:21 +0000 (UTC)
Subject: Re: [RFC PATCH 5/8] vhost: allow userspace to bind vqs to CPUs
To:     Mike Christie <michael.christie@oracle.com>, sgarzare@redhat.com,
        stefanha@redhat.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org
References: <1607068593-16932-1-git-send-email-michael.christie@oracle.com>
 <1607068593-16932-6-git-send-email-michael.christie@oracle.com>
 <4546ef72-da7c-df9e-53be-c937a5437436@redhat.com>
 <30746f1c-ed8c-d2ae-9513-54fca8f52739@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ea5fa99c-7d8f-b7de-42f1-691dc26dc3d2@redhat.com>
Date:   Mon, 7 Dec 2020 12:27:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30746f1c-ed8c-d2ae-9513-54fca8f52739@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


On 2020/12/5 上午12:32, Mike Christie wrote:
> On 12/4/20 2:09 AM, Jason Wang wrote:
>>
>> On 2020/12/4 下午3:56, Mike Christie wrote:
>>> +static long vhost_vring_set_cpu(struct vhost_dev *d, struct 
>>> vhost_virtqueue *vq,
>>> +                void __user *argp)
>>> +{
>>> +    struct vhost_vring_state s;
>>> +    int ret = 0;
>>> +
>>> +    if (vq->private_data)
>>> +        return -EBUSY;
>>> +
>>> +    if (copy_from_user(&s, argp, sizeof s))
>>> +        return -EFAULT;
>>> +
>>> +    if (s.num == -1) {
>>> +        vq->cpu = s.num;
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (s.num >= nr_cpu_ids)
>>> +        return -EINVAL;
>>> +
>>> +    if (!d->ops || !d->ops->get_workqueue)
>>> +        return -EINVAL;
>>> +
>>> +    if (!d->wq)
>>> +        d->wq = d->ops->get_workqueue();
>>> +    if (!d->wq)
>>> +        return -EINVAL;
>>> +
>>> +    vq->cpu = s.num;
>>> +    return ret;
>>> +}
>>
>>
>> So one question here. Who is in charge of doing this set_cpu? Note 
>> that sched_setaffinity(2) requires CAP_SYS_NICE to work, so I wonder 
>> whether or not it's legal for unprivileged Qemu to do this.
>
>
> I was having qemu do it when it's setting up the vqs since it had the 
> info there already.
>
> Is it normally the tool that makes calls into qemu that does the 
> operations that require CAP_SYS_NICE? 


My understanding is that it only matter scheduling. And this patch wants 
to change the affinity which should check that capability.


> If so, then I see the interface needs to be changed.


Actually, if I read this patch correctly it requires e.g qemu to make 
the decision instead of the management layer. This may bring some 
troubles to for e.g the libvirt emulatorpin[1] implementation.

Thanks

[1] 
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_tuning_and_optimization_guide/sect-virtualization_tuning_optimization_guide-numa-numa_and_libvirt

