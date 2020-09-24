Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A583276AAE
	for <lists+target-devel@lfdr.de>; Thu, 24 Sep 2020 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgIXHXD (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Sep 2020 03:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbgIXHXD (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600932181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9ho7ZxUFjV5yAYuN8t5tarm5DyMHoZty06HftqxrjU=;
        b=ZHxMuhxWIewaCNhWDU6gr+9OGZRkSD2HtvdHFW5XJON6ceWBwj2feGHmO46t5nGyxTUgXv
        KBjUF0GZzatTy70r1re/YKhaXlY0WzcfePcvv2ejf20kWeVisiSwJagN7iwbwn003gMjh/
        U9FMA364c6tmvV8jpah36uotBnvWtkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-O94fTBLHNcOBCXemmv_D7Q-1; Thu, 24 Sep 2020 03:22:59 -0400
X-MC-Unique: O94fTBLHNcOBCXemmv_D7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A38578015A5;
        Thu, 24 Sep 2020 07:22:58 +0000 (UTC)
Received: from [10.72.13.193] (ovpn-13-193.pek2.redhat.com [10.72.13.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CA421002C01;
        Thu, 24 Sep 2020 07:22:49 +0000 (UTC)
Subject: Re: [PATCH 2/8] vhost: add helper to check if a vq has been setup
To:     Mike Christie <michael.christie@oracle.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org
References: <1600712588-9514-1-git-send-email-michael.christie@oracle.com>
 <1600712588-9514-3-git-send-email-michael.christie@oracle.com>
 <e2d16333-d5ed-4c5c-58b3-7b5d0a9da47a@redhat.com>
 <63094bae-1f26-c21e-9b3c-3a6aa99a7e24@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e81db364-8b9e-bd01-5d22-3fd52375c8d3@redhat.com>
Date:   Thu, 24 Sep 2020 15:22:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <63094bae-1f26-c21e-9b3c-3a6aa99a7e24@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


On 2020/9/24 上午3:12, Mike Christie wrote:
> On 9/21/20 9:02 PM, Jason Wang wrote:
>> On 2020/9/22 上午2:23, Mike Christie wrote:
>>> This adds a helper check if a vq has been setup. The next patches
>>> will use this when we move the vhost scsi cmd preallocation from per
>>> session to per vq. In the per vq case, we only want to allocate cmds
>>> for vqs that have actually been setup and not for all the possible
>>> vqs.
>>>
>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>> ---
>>>    drivers/vhost/vhost.c | 9 +++++++++
>>>    drivers/vhost/vhost.h | 1 +
>>>    2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>> index b45519c..5dd9eb1 100644
>>> --- a/drivers/vhost/vhost.c
>>> +++ b/drivers/vhost/vhost.c
>>> @@ -305,6 +305,15 @@ static void vhost_vring_call_reset(struct vhost_vring_call *call_ctx)
>>>        spin_lock_init(&call_ctx->ctx_lock);
>>>    }
>>>    +bool vhost_vq_is_setup(struct vhost_virtqueue *vq)
>>> +{
>>> +    if (vq->avail && vq->desc && vq->used && vhost_vq_access_ok(vq))
>>> +        return true;
>>> +    else
>>> +        return false;
>>> +}
>>> +EXPORT_SYMBOL_GPL(vhost_vq_is_setup);
>>
>> This is probably ok but I wonder maybe we should have something like what vDPA did (VHOST_SET_VRING_ENABLE) to match virtio 1.0 device definition.
> It looks like I can make that work. Some questions:
>
> 1. Do you mean a generic VHOST_SET_VRING_ENABLE or a SCSI specific one VHOST_SCSI_SET_VRING_ENABLE?


It would be better if we can make it generic.


>
> 2. I can see the VHOST_VDPA_SET_VRING_ENABLE kernel code and the vhost_set_vring_enable qemu code, so I have an idea of how it should work for vhost scsi. However, I'm not sure the requirements for a generic VHOST_SET_VRING_ENABLE if that is what you meant. I could not find it in the spec either. Could you send me a pointer to the section?


In the spec, for PCI, it's the queue_enable for modern device.


>
> For example, for vhost-net we seem to enable a device in the VHOST_NET_SET_BACKEND ioctl, so I'm not sure what behavior should be or needs to be implemented for net and vsock.


Yes, but VHOST_NET_SET_BACKEND is for the whole device not a specific 
virtqueue.


Thanks


>

