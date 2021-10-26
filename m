Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CDF43ABBA
	for <lists+target-devel@lfdr.de>; Tue, 26 Oct 2021 07:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhJZFjt (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 26 Oct 2021 01:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235007AbhJZFjr (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 26 Oct 2021 01:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635226643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xfd3dwMAAsMHJotb8OA2R9twXclXz/4djuMCcwgH+IU=;
        b=MBLlJlipO1RJH6zVRfz+zFLO2Fc6T6tbqMwVg/6mQe+I2fvw91Hxjfz4I6ZkBc5re8l3VA
        I18TeShCy1udwQKyEsWacb7c3HVQEGL80tQx5hnb3BLFqCK1B//aD9GFE8f6TxQufGo/1g
        l/cXJoMOK4FGNEADdGfucIr0FKDCqPo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-PIlruZoXOuGP1cAIeSQqBw-1; Tue, 26 Oct 2021 01:37:22 -0400
X-MC-Unique: PIlruZoXOuGP1cAIeSQqBw-1
Received: by mail-pf1-f200.google.com with SMTP id p10-20020a056a000b4a00b0044cf01eccdbso7782537pfo.19
        for <target-devel@vger.kernel.org>; Mon, 25 Oct 2021 22:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xfd3dwMAAsMHJotb8OA2R9twXclXz/4djuMCcwgH+IU=;
        b=wZ/W1kVtjFPvtgKvHCa+WmKz9KxRElx2lWu2KWj84cJG1vCr5F5gg2mFts88lUms+V
         +6l6SvsQDt6Za4gbICwT56UcGDmIvyoVE9r1Ye2aSB5lMgm5756t5uXYTBHOSmjHAdie
         BmckmRjDVspVXZn6ShzWq9C3/pOGIySSB6VQWm2/QimVHwNGRGytupu6Sdfw5XXswygM
         6BRAfgTWt893oULADjKghXlx1ifu/Dnk7VhAV1I8HXxK7BkogJEMuhPbOvwCULT3FG7Y
         T7WdaLlml9XF0n9R6fRb65tlDvba3+ftjS5C9+OlabdkroSZZuM+zvW8ap0n5dlJq9CL
         N/og==
X-Gm-Message-State: AOAM533+pLrAalyTobZp2D4gjs1rILBD5sc3/DAr4SNQRLq2PIIyTTnb
        XOZ4TENln3OLI5XI+N1VqURFlePfoV2kufwNVuI93IYDlRwb1OFmHE30D0Zj308suCA7rUBONxJ
        1XeI48gdwsI0ddWFd9QvzuwhF
X-Received: by 2002:a17:903:120c:b0:13f:d043:3477 with SMTP id l12-20020a170903120c00b0013fd0433477mr20535897plh.89.1635226640827;
        Mon, 25 Oct 2021 22:37:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJUJHIk88OOXYw7L7HtLYAGqE/3rfVGGxtEo8KTcV+5Pg2dL5aZ8yLIEcqirroi0BS231tRQ==
X-Received: by 2002:a17:903:120c:b0:13f:d043:3477 with SMTP id l12-20020a170903120c00b0013fd0433477mr20535860plh.89.1635226640394;
        Mon, 25 Oct 2021 22:37:20 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d17sm8769526pfj.98.2021.10.25.22.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 22:37:19 -0700 (PDT)
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
To:     Mike Christie <michael.christie@oracle.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        stefanha@redhat.com, pbonzini@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8aee8f07-76bd-f111-bc5f-fc5cad46ce56@redhat.com>
Date:   Tue, 26 Oct 2021 13:37:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022051911.108383-13-michael.christie@oracle.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


�� 2021/10/22 ����1:19, Mike Christie д��:
> This patch allows userspace to create workers and bind them to vqs. You
> can have N workers per dev and also share N workers with M vqs.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>


A question, who is the best one to determine the binding? Is it the VMM 
(Qemu etc) or the management stack? If the latter, it looks to me it's 
better to expose this via sysfs?


> ---
>   drivers/vhost/vhost.c            | 99 ++++++++++++++++++++++++++++----
>   drivers/vhost/vhost.h            |  2 +-
>   include/uapi/linux/vhost.h       | 11 ++++
>   include/uapi/linux/vhost_types.h | 12 ++++
>   4 files changed, 112 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 04f43a6445e1..c86e88d7f35c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -493,7 +493,6 @@ void vhost_dev_init(struct vhost_dev *dev,
>   	dev->umem = NULL;
>   	dev->iotlb = NULL;
>   	dev->mm = NULL;
> -	dev->worker = NULL;
>   	dev->iov_limit = iov_limit;
>   	dev->weight = weight;
>   	dev->byte_weight = byte_weight;
> @@ -576,20 +575,40 @@ static void vhost_worker_stop(struct vhost_worker *worker)
>   	wait_for_completion(worker->exit_done);
>   }
>   
> -static void vhost_worker_free(struct vhost_dev *dev)
> -{
> -	struct vhost_worker *worker = dev->worker;
>   
> +static void vhost_worker_put(struct vhost_worker *worker)
> +{
>   	if (!worker)
>   		return;
>   
> -	dev->worker = NULL;
> +	if (!refcount_dec_and_test(&worker->refcount))
> +		return;
> +
>   	WARN_ON(!llist_empty(&worker->work_list));
>   	vhost_worker_stop(worker);
>   	kfree(worker);
>   }
>   
> -static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> +static void vhost_vq_clear_worker(struct vhost_virtqueue *vq)
> +{
> +	if (vq->worker)
> +		vhost_worker_put(vq->worker);
> +	vq->worker = NULL;
> +}
> +
> +static void vhost_workers_free(struct vhost_dev *dev)
> +{
> +	int i;
> +
> +	if (!dev->use_worker)
> +		return;
> +
> +	for (i = 0; i < dev->nvqs; i++)
> +		vhost_vq_clear_worker(dev->vqs[i]);
> +}
> +
> +static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev,
> +						int init_vq_map_count)
>   {
>   	struct vhost_worker *worker;
>   	struct task_struct *task;
> @@ -598,9 +617,9 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>   	if (!worker)
>   		return NULL;
>   
> -	dev->worker = worker;
>   	worker->kcov_handle = kcov_common_handle();
>   	init_llist_head(&worker->work_list);
> +	refcount_set(&worker->refcount, init_vq_map_count);
>   
>   	/*
>   	 * vhost used to use the kthread API which ignores all signals by
> @@ -617,10 +636,58 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>   
>   free_worker:
>   	kfree(worker);
> -	dev->worker = NULL;
>   	return NULL;
>   }
>   
> +static struct vhost_worker *vhost_worker_find(struct vhost_dev *dev, pid_t pid)
> +{
> +	struct vhost_worker *worker = NULL;
> +	int i;
> +
> +	for (i = 0; i < dev->nvqs; i++) {
> +		if (dev->vqs[i]->worker->task->pid != pid)
> +			continue;
> +
> +		worker = dev->vqs[i]->worker;
> +		break;
> +	}
> +
> +	return worker;
> +}
> +
> +/* Caller must have device mutex */
> +static int vhost_vq_setup_worker(struct vhost_virtqueue *vq,
> +				 struct vhost_vring_worker *info)
> +{
> +	struct vhost_dev *dev = vq->dev;
> +	struct vhost_worker *worker;
> +
> +	if (!dev->use_worker)
> +		return -EINVAL;
> +
> +	/* We don't support setting a worker on an active vq */
> +	if (vq->private_data)
> +		return -EBUSY;


Is it valuable to allow the worker switching on active vq?


> +
> +	if (info->pid == VHOST_VRING_NEW_WORKER) {
> +		worker = vhost_worker_create(dev, 1);
> +		if (!worker)
> +			return -ENOMEM;
> +
> +		info->pid = worker->task->pid;
> +	} else {
> +		worker = vhost_worker_find(dev, info->pid);
> +		if (!worker)
> +			return -ENODEV;
> +
> +		refcount_inc(&worker->refcount);
> +	}
> +
> +	vhost_vq_clear_worker(vq);
> +	vq->worker = worker;
> +	return 0;
> +}
> +
>   /* Caller should have device mutex */
>   long vhost_dev_set_owner(struct vhost_dev *dev)
>   {
> @@ -636,7 +703,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>   	vhost_attach_mm(dev);
>   
>   	if (dev->use_worker) {
> -		worker = vhost_worker_create(dev);
> +		worker = vhost_worker_create(dev, dev->nvqs);
>   		if (!worker)
>   			goto err_worker;
>   
> @@ -650,7 +717,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>   
>   	return 0;
>   err_iovecs:
> -	vhost_worker_free(dev);
> +	vhost_workers_free(dev);
>   err_worker:
>   	vhost_detach_mm(dev);
>   err_mm:
> @@ -742,7 +809,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>   	dev->iotlb = NULL;
>   	vhost_clear_msg(dev);
>   	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
> -	vhost_worker_free(dev);
> +	vhost_workers_free(dev);
>   	vhost_detach_mm(dev);
>   }
>   EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> @@ -1612,6 +1679,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>   	struct eventfd_ctx *ctx = NULL;
>   	u32 __user *idxp = argp;
>   	struct vhost_virtqueue *vq;
> +	struct vhost_vring_worker w;
>   	struct vhost_vring_state s;
>   	struct vhost_vring_file f;
>   	u32 idx;
> @@ -1719,6 +1787,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>   		if (copy_to_user(argp, &s, sizeof(s)))
>   			r = -EFAULT;
>   		break;
> +	case VHOST_SET_VRING_WORKER:
> +		if (copy_from_user(&w, argp, sizeof(w))) {
> +			r = -EFAULT;
> +			break;
> +		}
> +		r = vhost_vq_setup_worker(vq, &w);
> +		if (!r && copy_to_user(argp, &w, sizeof(w)))
> +			r = -EFAULT;
> +		break;
>   	default:
>   		r = -ENOIOCTLCMD;
>   	}
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 33c63b24187a..0911d1a9bd3b 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -35,6 +35,7 @@ struct vhost_worker {
>   	struct llist_head	work_list;
>   	u64			kcov_handle;
>   	unsigned long		flags;
> +	refcount_t		refcount;
>   };
>   
>   /* Poll a file (eventfd or socket) */
> @@ -160,7 +161,6 @@ struct vhost_dev {
>   	struct vhost_virtqueue **vqs;
>   	int nvqs;
>   	struct eventfd_ctx *log_ctx;
> -	struct vhost_worker *worker;
>   	struct vhost_iotlb *umem;
>   	struct vhost_iotlb *iotlb;
>   	spinlock_t iotlb_lock;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c998860d7bbc..e5c0669430e5 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -70,6 +70,17 @@
>   #define VHOST_VRING_BIG_ENDIAN 1
>   #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
>   #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> +/* By default, a device gets one vhost_worker created during VHOST_SET_OWNER
> + * that its virtqueues share. This allows userspace to create a vhost_worker
> + * and map a virtqueue to it or map a virtqueue to an existing worker.
> + *
> + * If pid > 0 and it matches an existing vhost_worker thread it will be bound
> + * to the vq. If pid is VHOST_VRING_NEW_WORKER, then a new worker will be
> + * created and bound to the vq.
> + *
> + * This must be called after VHOST_SET_OWNER and before the vq is active.
> + */
> +#define VHOST_SET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15, struct vhost_vring_worker)
>   
>   /* The following ioctls use eventfd file descriptors to signal and poll
>    * for events. */
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index f7f6a3a28977..af654e3cef0e 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -47,6 +47,18 @@ struct vhost_vring_addr {
>   	__u64 log_guest_addr;
>   };
>   
> +#define VHOST_VRING_NEW_WORKER -1


Do we need VHOST_VRING_FREE_WORKER? And I wonder if using dedicated 
ioctls are better:

VHOST_VRING_NEW/FREE_WORKER
VHOST_VRING_ATTACH_WORKER

etc.

Thanks


> +
> +struct vhost_vring_worker {
> +	unsigned int index;
> +	/*
> +	 * The pid of the vhost worker that the vq will be bound to. If
> +	 * pid is VHOST_VRING_NEW_WORKER a new worker will be created and its
> +	 * pid will be returned in pid.
> +	 */
> +	__kernel_pid_t pid;
> +};
> +
>   /* no alignment requirement */
>   struct vhost_iotlb_msg {
>   	__u64 iova;

