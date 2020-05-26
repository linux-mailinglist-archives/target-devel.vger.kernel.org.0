Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3C1D6CE6
	for <lists+target-devel@lfdr.de>; Sun, 17 May 2020 22:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgEQUi5 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 17 May 2020 16:38:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44338 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726301AbgEQUi5 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 17 May 2020 16:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589747934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rU4j+ol/minrAUTkxgx0kVfD+l/6d1BXeTZMjrrlBjU=;
        b=bTga3qG1e4cCGs9O89dHfhY4F/ExkvKfYZoDb3XFLUv5CkWuODFDacHZ8c0KwGTpQuYOUV
        HND8xDOP19M8sPYJiBPbWIyU0RjNv7CX58ZIM7nWtrlFcPJm+UARWKpZ3rUTWqiwRXq8+f
        3jKQ0zmWFS8W2raH/oycafStoBwvHYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-ui-0TQWrPSm5dfeyjo80MA-1; Sun, 17 May 2020 16:38:52 -0400
X-MC-Unique: ui-0TQWrPSm5dfeyjo80MA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44B2E474;
        Sun, 17 May 2020 20:38:51 +0000 (UTC)
Received: from [10.10.112.55] (ovpn-112-55.rdu2.redhat.com [10.10.112.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 503D28206B;
        Sun, 17 May 2020 20:38:50 +0000 (UTC)
Subject: Re: [PATCH] scsi: target: tcmu: userspace must not complete queued
 commands
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20200512154250.12310-1-bstroesser@ts.fujitsu.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <06ebddec-bd10-2ac6-2435-eb3019352c5f@redhat.com>
Date:   Sun, 17 May 2020 15:38:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512154250.12310-1-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/12/20 10:42 AM, Bodo Stroesser wrote:
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
> To fix this bug, we no longer add queued commands to the idr.
> Instead the cmd_id is assign when a command is written to
> the command ring.
> 
> Due to this change I had to adapt the source code at several
> places where up to now an idr_for_each had been done.
> 
> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
> ---
>  drivers/target/target_core_user.c | 154 ++++++++++++++++++--------------------
>  1 file changed, 71 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index f769bb1e3735..de75583b74c6 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -882,41 +882,24 @@ static inline size_t tcmu_cmd_get_cmd_size(struct tcmu_cmd *tcmu_cmd,
>  	return command_size;
>  }
>  
> -static int tcmu_setup_cmd_timer(struct tcmu_cmd *tcmu_cmd, unsigned int tmo,
> -				struct timer_list *timer)
> +static void tcmu_setup_cmd_timer(struct tcmu_cmd *tcmu_cmd, unsigned int tmo,
> +				 struct timer_list *timer)
>  {
> -	struct tcmu_dev *udev = tcmu_cmd->tcmu_dev;
> -	int cmd_id;
> -
> -	if (tcmu_cmd->cmd_id)
> -		goto setup_timer;
> -
> -	cmd_id = idr_alloc(&udev->commands, tcmu_cmd, 1, USHRT_MAX, GFP_NOWAIT);
> -	if (cmd_id < 0) {
> -		pr_err("tcmu: Could not allocate cmd id.\n");
> -		return cmd_id;
> -	}
> -	tcmu_cmd->cmd_id = cmd_id;
> -
> -	pr_debug("allocated cmd %u for dev %s tmo %lu\n", tcmu_cmd->cmd_id,
> -		 udev->name, tmo / MSEC_PER_SEC);
> -
> -setup_timer:
>  	if (!tmo)
> -		return 0;
> +		return;
>  
>  	tcmu_cmd->deadline = round_jiffies_up(jiffies + msecs_to_jiffies(tmo));
>  	if (!timer_pending(timer))
>  		mod_timer(timer, tcmu_cmd->deadline);
>  
> -	return 0;
> +	pr_debug("Timeout set up for cmd %p, dev = %s, tmo = %lu\n", tcmu_cmd,
> +		 tcmu_cmd->tcmu_dev->name, tmo / MSEC_PER_SEC);
>  }
>  
>  static int add_to_qfull_queue(struct tcmu_cmd *tcmu_cmd)
>  {
>  	struct tcmu_dev *udev = tcmu_cmd->tcmu_dev;
>  	unsigned int tmo;
> -	int ret;
>  
>  	/*
>  	 * For backwards compat if qfull_time_out is not set use
> @@ -931,13 +914,11 @@ static int add_to_qfull_queue(struct tcmu_cmd *tcmu_cmd)
>  	else
>  		tmo = TCMU_TIME_OUT;
>  
> -	ret = tcmu_setup_cmd_timer(tcmu_cmd, tmo, &udev->qfull_timer);
> -	if (ret)
> -		return ret;
> +	tcmu_setup_cmd_timer(tcmu_cmd, tmo, &udev->qfull_timer);
>  
>  	list_add_tail(&tcmu_cmd->queue_entry, &udev->qfull_queue);
> -	pr_debug("adding cmd %u on dev %s to ring space wait queue\n",
> -		 tcmu_cmd->cmd_id, udev->name);
> +	pr_debug("adding cmd %p on dev %s to ring space wait queue\n",
> +		 tcmu_cmd, udev->name);
>  	return 0;
>  }
>  
> @@ -959,7 +940,7 @@ static int queue_cmd_ring(struct tcmu_cmd *tcmu_cmd, sense_reason_t *scsi_err)
>  	struct tcmu_mailbox *mb;
>  	struct tcmu_cmd_entry *entry;
>  	struct iovec *iov;
> -	int iov_cnt, ret;
> +	int iov_cnt, cmd_id;
>  	uint32_t cmd_head;
>  	uint64_t cdb_off;
>  	bool copy_to_data_area;
> @@ -1060,14 +1041,21 @@ static int queue_cmd_ring(struct tcmu_cmd *tcmu_cmd, sense_reason_t *scsi_err)
>  	}
>  	entry->req.iov_bidi_cnt = iov_cnt;
>  
> -	ret = tcmu_setup_cmd_timer(tcmu_cmd, udev->cmd_time_out,
> -				   &udev->cmd_timer);
> -	if (ret) {
> -		tcmu_cmd_free_data(tcmu_cmd, tcmu_cmd->dbi_cnt);
> +	cmd_id = idr_alloc(&udev->commands, tcmu_cmd, 1, USHRT_MAX, GFP_NOWAIT);
> +	if (cmd_id < 0) {
> +		pr_err("tcmu: Could not allocate cmd id.\n");
>  
> +		tcmu_cmd_free_data(tcmu_cmd, tcmu_cmd->dbi_cnt);
>  		*scsi_err = TCM_OUT_OF_RESOURCES;
>  		return -1;
>  	}
> +	tcmu_cmd->cmd_id = cmd_id;
> +
> +	pr_debug("allocated cmd id %u for cmd %p dev %s\n", tcmu_cmd->cmd_id,
> +		 tcmu_cmd, udev->name);
> +
> +	tcmu_setup_cmd_timer(tcmu_cmd, udev->cmd_time_out, &udev->cmd_timer);
> +
>  	entry->hdr.cmd_id = tcmu_cmd->cmd_id;
>  
>  	/*
> @@ -1279,50 +1267,39 @@ static unsigned int tcmu_handle_completions(struct tcmu_dev *udev)
>  	return handled;
>  }
>  
> -static int tcmu_check_expired_cmd(int id, void *p, void *data)
> +static void tcmu_check_expired_ring_cmd(struct tcmu_cmd *cmd)
>  {
> -	struct tcmu_cmd *cmd = p;
> -	struct tcmu_dev *udev = cmd->tcmu_dev;
> -	u8 scsi_status;
>  	struct se_cmd *se_cmd;
> -	bool is_running;
> -
> -	if (test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags))
> -		return 0;
>  
>  	if (!time_after(jiffies, cmd->deadline))
> -		return 0;
> +		return;
>  
> -	is_running = test_bit(TCMU_CMD_BIT_INFLIGHT, &cmd->flags);
> +	set_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags);
> +	list_del_init(&cmd->queue_entry);
>  	se_cmd = cmd->se_cmd;
> +	cmd->se_cmd = NULL;
>  
> -	if (is_running) {
> -		/*
> -		 * If cmd_time_out is disabled but qfull is set deadline
> -		 * will only reflect the qfull timeout. Ignore it.
> -		 */
> -		if (!udev->cmd_time_out)
> -			return 0;
> +	pr_debug("Timing out inflight cmd %u on dev %s.\n",
> +		 cmd->cmd_id, cmd->tcmu_dev->name);
>  
> -		set_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags);
> -		/*
> -		 * target_complete_cmd will translate this to LUN COMM FAILURE
> -		 */
> -		scsi_status = SAM_STAT_CHECK_CONDITION;
> -		list_del_init(&cmd->queue_entry);
> -		cmd->se_cmd = NULL;
> -	} else {
> -		list_del_init(&cmd->queue_entry);
> -		idr_remove(&udev->commands, id);
> -		tcmu_free_cmd(cmd);
> -		scsi_status = SAM_STAT_TASK_SET_FULL;
> -	}
> +	target_complete_cmd(se_cmd, SAM_STAT_CHECK_CONDITION);
> +}
>  
> -	pr_debug("Timing out cmd %u on dev %s that is %s.\n",
> -		 id, udev->name, is_running ? "inflight" : "queued");
> +static void tcmu_check_expired_queue_cmd(struct tcmu_cmd *cmd)
> +{
> +	struct se_cmd *se_cmd;
>  
> -	target_complete_cmd(se_cmd, scsi_status);
> -	return 0;
> +	if (!time_after(jiffies, cmd->deadline))
> +		return;
> +
> +	list_del_init(&cmd->queue_entry);
> +	se_cmd = cmd->se_cmd;
> +	tcmu_free_cmd(cmd);
> +
> +	pr_debug("Timing out queued cmd %p on dev %s.\n",
> +		  cmd, cmd->tcmu_dev->name);
> +
> +	target_complete_cmd(se_cmd, SAM_STAT_TASK_SET_FULL);
>  }
>  
>  static void tcmu_device_timedout(struct tcmu_dev *udev)
> @@ -1407,16 +1384,15 @@ static struct se_device *tcmu_alloc_device(struct se_hba *hba, const char *name)
>  	return &udev->se_dev;
>  }
>  
> -static bool run_qfull_queue(struct tcmu_dev *udev, bool fail)
> +static void run_qfull_queue(struct tcmu_dev *udev, bool fail)
>  {
>  	struct tcmu_cmd *tcmu_cmd, *tmp_cmd;
>  	LIST_HEAD(cmds);
> -	bool drained = true;
>  	sense_reason_t scsi_ret;
>  	int ret;
>  
>  	if (list_empty(&udev->qfull_queue))
> -		return true;
> +		return;
>  
>  	pr_debug("running %s's cmdr queue forcefail %d\n", udev->name, fail);
>  
> @@ -1425,11 +1401,10 @@ static bool run_qfull_queue(struct tcmu_dev *udev, bool fail)
>  	list_for_each_entry_safe(tcmu_cmd, tmp_cmd, &cmds, queue_entry) {
>  		list_del_init(&tcmu_cmd->queue_entry);
>  
> -	        pr_debug("removing cmd %u on dev %s from queue\n",
> -		         tcmu_cmd->cmd_id, udev->name);
> +	        pr_debug("removing cmd %p on dev %s from queue\n",
> +		         tcmu_cmd, udev->name);
>  
>  		if (fail) {
> -			idr_remove(&udev->commands, tcmu_cmd->cmd_id);
>  			/*
>  			 * We were not able to even start the command, so
>  			 * fail with busy to allow a retry in case runner
> @@ -1444,10 +1419,8 @@ static bool run_qfull_queue(struct tcmu_dev *udev, bool fail)
>  
>  		ret = queue_cmd_ring(tcmu_cmd, &scsi_ret);
>  		if (ret < 0) {
> -		        pr_debug("cmd %u on dev %s failed with %u\n",
> -			         tcmu_cmd->cmd_id, udev->name, scsi_ret);
> -
> -			idr_remove(&udev->commands, tcmu_cmd->cmd_id);
> +		        pr_debug("cmd %p on dev %s failed with %u\n",
> +			         tcmu_cmd, udev->name, scsi_ret);
>  			/*
>  			 * Ignore scsi_ret for now. target_complete_cmd
>  			 * drops it.
> @@ -1462,13 +1435,11 @@ static bool run_qfull_queue(struct tcmu_dev *udev, bool fail)
>  			 * the queue
>  			 */
>  			list_splice_tail(&cmds, &udev->qfull_queue);
> -			drained = false;
>  			break;
>  		}
>  	}
>  
>  	tcmu_set_next_deadline(&udev->qfull_queue, &udev->qfull_timer);
> -	return drained;
>  }
>  
>  static int tcmu_irqcontrol(struct uio_info *info, s32 irq_on)
> @@ -1652,6 +1623,8 @@ static void tcmu_dev_kref_release(struct kref *kref)
>  		if (tcmu_check_and_free_pending_cmd(cmd) != 0)
>  			all_expired = false;
>  	}
> +	if (!list_empty(&udev->qfull_queue))
> +		all_expired = false;

Just drop. It's never going to happen and doesn't tell us a lot. We
don't know what list it was on and why LIO core's refcounts got messed up.

The WARN_ON should just be removed in some other patchset one day. If we
wanted to detect if non timed out commands were running at this time
then it should go in lio core, because it would be a problem that
affects all drivers.

I think we actually want the opposite and should WARN or BUG if commands
have timed out and we are freeing the device. In this case userspace
could still be accessing the buffers we are going to free. It probably
won't happen now that we run this from the release function and so the
device is closed though.



>  	idr_destroy(&udev->commands);
>  	WARN_ON(!all_expired);
>  
> @@ -2037,9 +2010,6 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
>  	mutex_lock(&udev->cmdr_lock);
>  
>  	idr_for_each_entry(&udev->commands, cmd, i) {
> -		if (!test_bit(TCMU_CMD_BIT_INFLIGHT, &cmd->flags))
> -			continue;
> -
>  		pr_debug("removing cmd %u on dev %s from ring (is expired %d)\n",
>  			  cmd->cmd_id, udev->name,
>  			  test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags));
> @@ -2077,6 +2047,8 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
>  
>  	del_timer(&udev->cmd_timer);
>  
> +	run_qfull_queue(udev, false);
> +
>  	mutex_unlock(&udev->cmdr_lock);
>  }
>  
> @@ -2698,6 +2670,7 @@ static void find_free_blocks(void)
>  static void check_timedout_devices(void)
>  {
>  	struct tcmu_dev *udev, *tmp_dev;
> +	struct tcmu_cmd *ucmd, *tmp_cmd;

ucmd probably would have been best when the code was first written. Now,
you should use tcmu_cmd or cmd to match the existing naming style.


>  	LIST_HEAD(devs);
>  
>  	spin_lock_bh(&timed_out_udevs_lock);
> @@ -2708,9 +2681,24 @@ static void check_timedout_devices(void)
>  		spin_unlock_bh(&timed_out_udevs_lock);
>  
>  		mutex_lock(&udev->cmdr_lock);
> -		idr_for_each(&udev->commands, tcmu_check_expired_cmd, NULL);
>  
> -		tcmu_set_next_deadline(&udev->inflight_queue, &udev->cmd_timer);
> +		/*
> +		 * If cmd_time_out is disabled but qfull is set deadline
> +		 * will only reflect the qfull timeout. Ignore it.
> +		 */
> +		if (udev->cmd_time_out) {
> +			list_for_each_entry_safe(ucmd, tmp_cmd,
> +			                         &udev->inflight_queue,
> +			                         queue_entry) {
> +				tcmu_check_expired_ring_cmd(ucmd);
> +			}
> +			tcmu_set_next_deadline(&udev->inflight_queue,
> +			                       &udev->cmd_timer);
> +		}
> +		list_for_each_entry_safe(ucmd, tmp_cmd, &udev->qfull_queue,
> +			                 queue_entry) {
> +			tcmu_check_expired_queue_cmd(ucmd);
> +		}
>  		tcmu_set_next_deadline(&udev->qfull_queue, &udev->qfull_timer);
>  
>  		mutex_unlock(&udev->cmdr_lock);
> 

