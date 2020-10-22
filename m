Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1B2955D0
	for <lists+target-devel@lfdr.de>; Thu, 22 Oct 2020 02:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894403AbgJVAwR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 21 Oct 2020 20:52:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33278 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442801AbgJVAwR (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 21 Oct 2020 20:52:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M0pw67008105;
        Thu, 22 Oct 2020 00:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=ySwaYeUB/xfEEnLDVmYw9VoYrKUDbWZ+SilXkfBhYM4=;
 b=acTAdtPS1MXegaJEXHqj9+rQEvPY60Y86gMvzYdyd4n/6vsjKI9Go/FMOQ04UZMuO9Ga
 WoS1T9cBs3ULJtOEVI64JQlN7nRRIxBYKWQPhUIeaPQlykR2KQp8JI4JGQiMwOZgJerF
 Qrh05mCG2z7HdyqQYtAgFQgWMBVSZNQag4VLLsRruLsW3F9y0p30srVXOHD09ZWdXyxl
 JmcymIH2IG6/bmtwY5xMTnpKa8lXKRLMYmjBxTlzJEc0BUBGdSQsnma/bGuDw67+DIfA
 s/V2pUsY5nBJVM+69XBiWpnXSuKGdtp+xVxII5f7/8KmhdaWV8qp8Pvzk+MmjHk7Y8QE Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34ak16kq02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 00:52:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M0nghx027872;
        Thu, 22 Oct 2020 00:50:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 348ah0987v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 00:50:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09M0oAo2014875;
        Thu, 22 Oct 2020 00:50:11 GMT
Received: from [20.15.0.202] (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Oct 2020 17:50:09 -0700
Subject: Re: [PATCH 15/17] host: support delayed vq creation
From:   Mike Christie <michael.christie@oracle.com>
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-16-git-send-email-michael.christie@oracle.com>
Message-ID: <64d6396f-8dca-b932-6fa3-6847fd3ff0f6@oracle.com>
Date:   Wed, 21 Oct 2020 19:50:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603326903-27052-16-git-send-email-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220002
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

The email subject and patch description got cut and paste from the wrong
patch when I updated this patch. It should be:


[PATCH 15/17] vhost scsi: make completion per vq

In the last patches we are going to have a worker thread per IO vq.
This patch separates the scsi cmd completion code paths so we can
complete cmds based on their vq instead of having all cmds complete
on the same worker thread.


---

When I handle other review comments in the set I'll fix this up too.


On 10/21/20 7:35 PM, Mike Christie wrote:
> This allows vq creation to be done when it's first accessed by
> userspace. vhost-scsi doesn't know how many queues the user requested
> until they are first setup, and we don't want to allocate resources
> like the iovecs for 128 vqs when we are only using 1 or 2 most of the
> time. In the next pathces, vhost-scsi will also switch to preallocating
> cmds per vq instead of per lio session and we don't want to allocate
> them for 127 extra vqs if they are not in use.
> 
> With this patch when a driver calls vhost_dev_init they pass in the
> number of vqs that they know they need and the max they can support.
> This patch has all the drivers pass in the same value for both the
> initial number of vqs and the max. The next patch will convert scsi.
> The other drivers like net/vsock have their vqs hard coded in the
> kernel or setup/discovered via other methods like with vdpa.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 48 +++++++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index b348e9c..5d6dc15 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -178,6 +178,7 @@ enum {
>  
>  struct vhost_scsi_virtqueue {
>  	struct vhost_virtqueue vq;
> +	struct vhost_scsi *vs;
>  	/*
>  	 * Reference counting for inflight reqs, used for flush operation. At
>  	 * each time, one reference tracks new commands submitted, while we
> @@ -192,6 +193,9 @@ struct vhost_scsi_virtqueue {
>  	struct vhost_scsi_cmd *scsi_cmds;
>  	struct sbitmap scsi_tags;
>  	int max_cmds;
> +
> +	struct vhost_work completion_work;
> +	struct llist_head completion_list;
>  };
>  
>  struct vhost_scsi {
> @@ -202,9 +206,6 @@ struct vhost_scsi {
>  	struct vhost_dev dev;
>  	struct vhost_scsi_virtqueue vqs[VHOST_SCSI_MAX_VQ];
>  
> -	struct vhost_work vs_completion_work; /* cmd completion work item */
> -	struct llist_head vs_completion_list; /* cmd completion queue */
> -
>  	struct vhost_work vs_event_work; /* evt injection work item */
>  	struct llist_head vs_event_list; /* evt injection queue */
>  
> @@ -380,10 +381,11 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
>  	} else {
>  		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
>  					struct vhost_scsi_cmd, tvc_se_cmd);
> -		struct vhost_scsi *vs = cmd->tvc_vhost;
> +		struct vhost_scsi_virtqueue *svq =  container_of(cmd->tvc_vq,
> +					struct vhost_scsi_virtqueue, vq);
>  
> -		llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
> -		vhost_work_queue(&vs->dev, &vs->vs_completion_work);
> +		llist_add(&cmd->tvc_completion_list, &svq->completion_list);
> +		vhost_vq_work_queue(&svq->vq, &svq->completion_work);
>  	}
>  }
>  
> @@ -545,18 +547,17 @@ static void vhost_scsi_evt_work(struct vhost_work *work)
>   */
>  static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  {
> -	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
> -					vs_completion_work);
> -	DECLARE_BITMAP(signal, VHOST_SCSI_MAX_VQ);
> +	struct vhost_scsi_virtqueue *svq = container_of(work,
> +				struct vhost_scsi_virtqueue, completion_work);
>  	struct virtio_scsi_cmd_resp v_rsp;
>  	struct vhost_scsi_cmd *cmd, *t;
>  	struct llist_node *llnode;
>  	struct se_cmd *se_cmd;
>  	struct iov_iter iov_iter;
> -	int ret, vq;
> +	bool signal = false;
> +	int ret;
>  
> -	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
> -	llnode = llist_del_all(&vs->vs_completion_list);
> +	llnode = llist_del_all(&svq->completion_list);
>  	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
>  		se_cmd = &cmd->tvc_se_cmd;
>  
> @@ -576,21 +577,16 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  			      cmd->tvc_in_iovs, sizeof(v_rsp));
>  		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
>  		if (likely(ret == sizeof(v_rsp))) {
> -			struct vhost_scsi_virtqueue *q;
> +			signal = true;
>  			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
> -			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
> -			vq = q - vs->vqs;
> -			__set_bit(vq, signal);
>  		} else
>  			pr_err("Faulted on virtio_scsi_cmd_resp\n");
>  
>  		vhost_scsi_release_cmd_res(se_cmd);
>  	}
>  
> -	vq = -1;
> -	while ((vq = find_next_bit(signal, VHOST_SCSI_MAX_VQ, vq + 1))
> -		< VHOST_SCSI_MAX_VQ)
> -		vhost_signal(&vs->dev, &vs->vqs[vq].vq);
> +	if (signal)
> +		vhost_signal(&svq->vs->dev, &svq->vq);
>  }
>  
>  static struct vhost_scsi_cmd *
> @@ -1805,6 +1801,7 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
>  
>  static int vhost_scsi_open(struct inode *inode, struct file *f)
>  {
> +	struct vhost_scsi_virtqueue *svq;
>  	struct vhost_scsi *vs;
>  	struct vhost_virtqueue **vqs;
>  	int r = -ENOMEM, i;
> @@ -1820,7 +1817,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  	if (!vqs)
>  		goto err_vqs;
>  
> -	vhost_work_init(&vs->vs_completion_work, vhost_scsi_complete_cmd_work);
>  	vhost_work_init(&vs->vs_event_work, vhost_scsi_evt_work);
>  
>  	vs->vs_events_nr = 0;
> @@ -1831,8 +1827,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  	vs->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
>  	vs->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
>  	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++) {
> -		vqs[i] = &vs->vqs[i].vq;
> -		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
> +		svq = &vs->vqs[i];
> +
> +		vqs[i] = &svq->vq;
> +		svq->vs = vs;
> +		init_llist_head(&svq->completion_list);
> +		vhost_work_init(&svq->completion_work,
> +				vhost_scsi_complete_cmd_work);
> +		svq->vq.handle_kick = vhost_scsi_handle_kick;
>  	}
>  
>  	/*
> 

