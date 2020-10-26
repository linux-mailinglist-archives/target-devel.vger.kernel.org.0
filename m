Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252952985F2
	for <lists+target-devel@lfdr.de>; Mon, 26 Oct 2020 04:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421927AbgJZDfK (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 25 Oct 2020 23:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1420388AbgJZDfK (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 25 Oct 2020 23:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603683308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpZqq9xg61UBmOXJ8EQECYPW+0Do3I4VYlD4OUNg0Jg=;
        b=DtUAv/bhd6DM4Uohuw3L9pjLeNq5HhrkDO/FIRu7HXiSergtoDWorJveQ5CGog3qJBqiys
        cT7uB4ikmXJlOgFOJ9VypvL8F/WChO4A0yUpyzHv1l+9yrI4qDiT1myQz5bq34i5+dJ+zU
        ggMtjTFjloCenoTeKHoL1XBgiKLjP9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-mMSEYOAYN5uyaIzsDswmRg-1; Sun, 25 Oct 2020 23:35:07 -0400
X-MC-Unique: mMSEYOAYN5uyaIzsDswmRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B04A8803F4C;
        Mon, 26 Oct 2020 03:35:05 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E08E50B44;
        Mon, 26 Oct 2020 03:34:52 +0000 (UTC)
Subject: Re: [PATCH 03/17] vhost net: use goto error handling in open
To:     Mike Christie <michael.christie@oracle.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-4-git-send-email-michael.christie@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8a3779da-74e6-7eff-28c4-5bfd2c981728@redhat.com>
Date:   Mon, 26 Oct 2020 11:34:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603326903-27052-4-git-send-email-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


On 2020/10/22 上午8:34, Mike Christie wrote:
> In the next patches vhost_dev_init will be able to fail. This patch has
> vhost_net_open use goto error handling like is done in the other vhost
> code to make handling vhost_dev_init failures easier to handle and
> extend in the future.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vhost/net.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 531a00d..831d824 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1286,27 +1286,18 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>   	if (!n)
>   		return -ENOMEM;
>   	vqs = kmalloc_array(VHOST_NET_VQ_MAX, sizeof(*vqs), GFP_KERNEL);
> -	if (!vqs) {
> -		kvfree(n);
> -		return -ENOMEM;
> -	}
> +	if (!vqs)
> +		goto err_vqs;
>   
>   	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
>   			      GFP_KERNEL);
> -	if (!queue) {
> -		kfree(vqs);
> -		kvfree(n);
> -		return -ENOMEM;
> -	}
> +	if (!queue)
> +		goto err_queue;
>   	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
>   
>   	xdp = kmalloc_array(VHOST_NET_BATCH, sizeof(*xdp), GFP_KERNEL);
> -	if (!xdp) {
> -		kfree(vqs);
> -		kvfree(n);
> -		kfree(queue);
> -		return -ENOMEM;
> -	}
> +	if (!xdp)
> +		goto err_xdp;
>   	n->vqs[VHOST_NET_VQ_TX].xdp = xdp;
>   
>   	dev = &n->dev;
> @@ -1338,6 +1329,14 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>   	n->refcnt_bias = 0;
>   
>   	return 0;
> +
> +err_xdp:
> +	kfree(queue);
> +err_queue:
> +	kfree(vqs);
> +err_vqs:
> +	kvfree(n);
> +	return -ENOMEM;
>   }
>   
>   static struct socket *vhost_net_stop_vq(struct vhost_net *n,

