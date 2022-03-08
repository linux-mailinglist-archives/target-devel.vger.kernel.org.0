Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0D24D1256
	for <lists+target-devel@lfdr.de>; Tue,  8 Mar 2022 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiCHIfh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 8 Mar 2022 03:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiCHIfg (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:35:36 -0500
Received: from mail-m2835.qiye.163.com (mail-m2835.qiye.163.com [103.74.28.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67123CFEA;
        Tue,  8 Mar 2022 00:34:39 -0800 (PST)
Received: from [192.168.0.234] (unknown [218.94.118.90])
        by mail-m2835.qiye.163.com (Hmail) with ESMTPA id 13D0D8A0302;
        Tue,  8 Mar 2022 16:34:37 +0800 (CST)
Message-ID: <3952debd-cd3d-3d65-635d-985ddbb91b49@easystack.cn>
Date:   Tue, 8 Mar 2022 16:34:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] target: add iscsi/cpus_allowed_list in configfs
Content-Language: en-US
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     zoumingzhe@qq.com
References: <20220125083821.18225-1-mingzhe.zou@easystack.cn>
 <20220301075500.14266-1-mingzhe.zou@easystack.cn>
From:   Zou Mingzhe <mingzhe.zou@easystack.cn>
In-Reply-To: <20220301075500.14266-1-mingzhe.zou@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlCN1dZLVlBSVdZDwkaFQgSH1lBWUMfTBhWSktCTUNCSkJKHk
        seVRkRExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITk9VS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Fhw*PjIaFDgzOjUzPjEB
        NwoaCQ1VSlVKTU9NTElDT0xMTkpIVTMWGhIXVRYSFRwBEx5VARQOOx4aCAIIDxoYEFUYFUVZV1kS
        C1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSkpJQ043Bg++
X-HM-Tid: 0a7f68aa7a28841dkuqw13d0d8a0302
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi, christie

Have you started reviewing this patch?

Mingzhe

在 2022/3/1 15:55, mingzhe.zou@easystack.cn 写道:
> From: Mingzhe Zou <mingzhe.zou@easystack.cn>
>
> The RX/TX threads for iSCSI connection can be scheduled to
> any online cpus, and will not be rescheduled.
>
> If bind other heavy load threads with iSCSI connection
> RX/TX thread to the same cpu, the iSCSI performance will
> be worse.
>
> This patch add iscsi/cpus_allowed_list in configfs. The
> available cpus set of iSCSI connection RX/TX threads is
> allowed_cpus & online_cpus. If it is modified, all RX/TX
> threads will be rescheduled.
>
> Signed-off-by: Mingzhe Zou <mingzhe.zou@easystack.cn>
> ---
>   drivers/target/iscsi/iscsi_target.c          | 77 +++++++++++++++++++-
>   drivers/target/iscsi/iscsi_target_configfs.c | 32 ++++++++
>   drivers/target/iscsi/iscsi_target_login.c    |  8 ++
>   include/target/iscsi/iscsi_target_core.h     | 31 ++------
>   4 files changed, 120 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index 2c54c5d8412d..6fe6a6bab3f4 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -702,13 +702,19 @@ static int __init iscsi_target_init_module(void)
>   	if (!iscsit_global->ts_bitmap)
>   		goto configfs_out;
>   
> +	if (!zalloc_cpumask_var(&iscsit_global->allowed_cpumask, GFP_KERNEL)) {
> +		pr_err("Unable to allocate iscsit_global->allowed_cpumask\n");
> +		goto bitmap_out;
> +	}
> +	cpumask_setall(iscsit_global->allowed_cpumask);
> +
>   	lio_qr_cache = kmem_cache_create("lio_qr_cache",
>   			sizeof(struct iscsi_queue_req),
>   			__alignof__(struct iscsi_queue_req), 0, NULL);
>   	if (!lio_qr_cache) {
>   		pr_err("Unable to kmem_cache_create() for"
>   				" lio_qr_cache\n");
> -		goto bitmap_out;
> +		goto cpumask_out;
>   	}
>   
>   	lio_dr_cache = kmem_cache_create("lio_dr_cache",
> @@ -753,6 +759,8 @@ static int __init iscsi_target_init_module(void)
>   	kmem_cache_destroy(lio_dr_cache);
>   qr_out:
>   	kmem_cache_destroy(lio_qr_cache);
> +cpumask_out:
> +	free_cpumask_var(iscsit_global->allowed_cpumask);
>   bitmap_out:
>   	vfree(iscsit_global->ts_bitmap);
>   configfs_out:
> @@ -782,6 +790,7 @@ static void __exit iscsi_target_cleanup_module(void)
>   
>   	target_unregister_template(&iscsi_ops);
>   
> +	free_cpumask_var(iscsit_global->allowed_cpumask);
>   	vfree(iscsit_global->ts_bitmap);
>   	kfree(iscsit_global);
>   }
> @@ -3587,6 +3596,11 @@ static int iscsit_send_reject(
>   void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
>   {
>   	int ord, cpu;
> +	cpumask_t conn_allowed_cpumask;
> +
> +	cpumask_and(&conn_allowed_cpumask, iscsit_global->allowed_cpumask,
> +		    cpu_online_mask);
> +
>   	/*
>   	 * bitmap_id is assigned from iscsit_global->ts_bitmap from
>   	 * within iscsit_start_kthreads()
> @@ -3595,8 +3609,9 @@ void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
>   	 * iSCSI connection's RX/TX threads will be scheduled to
>   	 * execute upon.
>   	 */
> -	ord = conn->bitmap_id % cpumask_weight(cpu_online_mask);
> -	for_each_online_cpu(cpu) {
> +	cpumask_clear(conn->conn_cpumask);
> +	ord = conn->bitmap_id % cpumask_weight(&conn_allowed_cpumask);
> +	for_each_cpu(cpu, &conn_allowed_cpumask) {
>   		if (ord-- == 0) {
>   			cpumask_set_cpu(cpu, conn->conn_cpumask);
>   			return;
> @@ -3609,6 +3624,62 @@ void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
>   	cpumask_setall(conn->conn_cpumask);
>   }
>   
> +static void iscsit_thread_reschedule(struct iscsi_conn *conn)
> +{
> +	/*
> +	 * If iscsit_global->allowed_cpumask modified, reschedule iSCSI
> +	 * connection's RX/TX threads update conn->allowed_cpumask.
> +	 */
> +	if (!cpumask_equal(iscsit_global->allowed_cpumask,
> +			   conn->allowed_cpumask)) {
> +		iscsit_thread_get_cpumask(conn);
> +		conn->conn_tx_reset_cpumask = 1;
> +		conn->conn_rx_reset_cpumask = 1;
> +		cpumask_copy(conn->allowed_cpumask,
> +			     iscsit_global->allowed_cpumask);
> +	}
> +}
> +
> +void iscsit_thread_check_cpumask(
> +	struct iscsi_conn *conn,
> +	struct task_struct *p,
> +	int mode)
> +{
> +	/*
> +	 * The TX and RX threads maybe call iscsit_thread_check_cpumask()
> +	 * at the same time. The RX thread might be faster and return from
> +	 * iscsit_thread_reschedule() with conn_rx_reset_cpumask set to 0.
> +	 * Then the TX thread sets it back to 1.
> +	 * The next time the RX thread loops, it sees conn_rx_reset_cpumask
> +	 * set to 1 and calls set_cpus_allowed_ptr() again and set it to 0.
> +	 */
> +	iscsit_thread_reschedule(conn);
> +
> +	/*
> +	 * mode == 1 signals iscsi_target_tx_thread() usage.
> +	 * mode == 0 signals iscsi_target_rx_thread() usage.
> +	 */
> +	if (mode == 1) {
> +		if (!conn->conn_tx_reset_cpumask)
> +			return;
> +	} else {
> +		if (!conn->conn_rx_reset_cpumask)
> +			return;
> +	}
> +
> +	/*
> +	 * Update the CPU mask for this single kthread so that
> +	 * both TX and RX kthreads are scheduled to run on the
> +	 * same CPU.
> +	 */
> +	set_cpus_allowed_ptr(p, conn->conn_cpumask);
> +	if (mode == 1)
> +		conn->conn_tx_reset_cpumask = 0;
> +	else
> +		conn->conn_rx_reset_cpumask = 0;
> +}
> +EXPORT_SYMBOL(iscsit_thread_check_cpumask);
> +
>   int
>   iscsit_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
>   {
> diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
> index 2a9de24a8bbe..0cedcfe207b5 100644
> --- a/drivers/target/iscsi/iscsi_target_configfs.c
> +++ b/drivers/target/iscsi/iscsi_target_configfs.c
> @@ -1127,8 +1127,40 @@ static ssize_t lio_target_wwn_lio_version_show(struct config_item *item,
>   
>   CONFIGFS_ATTR_RO(lio_target_wwn_, lio_version);
>   
> +static ssize_t lio_target_wwn_cpus_allowed_list_show(
> +		struct config_item *item, char *page)
> +{
> +	return sprintf(page, "%*pbl\n",
> +		       cpumask_pr_args(iscsit_global->allowed_cpumask));
> +}
> +
> +static ssize_t lio_target_wwn_cpus_allowed_list_store(
> +		struct config_item *item, const char *page, size_t count)
> +{
> +	int ret;
> +	char *orig;
> +	cpumask_t new_allowed_cpumask;
> +
> +	orig = kstrdup(page, GFP_KERNEL);
> +	if (!orig)
> +		return -ENOMEM;
> +
> +	cpumask_clear(&new_allowed_cpumask);
> +	ret = cpulist_parse(orig, &new_allowed_cpumask);
> +
> +	kfree(orig);
> +	if (ret != 0)
> +		return ret;
> +
> +	cpumask_copy(iscsit_global->allowed_cpumask, &new_allowed_cpumask);
> +	return count;
> +}
> +
> +CONFIGFS_ATTR(lio_target_wwn_, cpus_allowed_list);
> +
>   static struct configfs_attribute *lio_target_wwn_attrs[] = {
>   	&lio_target_wwn_attr_lio_version,
> +	&lio_target_wwn_attr_cpus_allowed_list,
>   	NULL,
>   };
>   
> diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
> index 1a9c50401bdb..9c01fb864585 100644
> --- a/drivers/target/iscsi/iscsi_target_login.c
> +++ b/drivers/target/iscsi/iscsi_target_login.c
> @@ -1129,8 +1129,15 @@ static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
>   		goto free_conn_ops;
>   	}
>   
> +	if (!zalloc_cpumask_var(&conn->allowed_cpumask, GFP_KERNEL)) {
> +		pr_err("Unable to allocate conn->allowed_cpumask\n");
> +		goto free_conn_cpumask;
> +	}
> +
>   	return conn;
>   
> +free_conn_cpumask:
> +	free_cpumask_var(conn->conn_cpumask);
>   free_conn_ops:
>   	kfree(conn->conn_ops);
>   put_transport:
> @@ -1142,6 +1149,7 @@ static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
>   
>   void iscsit_free_conn(struct iscsi_conn *conn)
>   {
> +	free_cpumask_var(conn->allowed_cpumask);
>   	free_cpumask_var(conn->conn_cpumask);
>   	kfree(conn->conn_ops);
>   	iscsit_put_transport(conn->conn_transport);
> diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
> index 1eccb2ac7d02..adc87de0362b 100644
> --- a/include/target/iscsi/iscsi_target_core.h
> +++ b/include/target/iscsi/iscsi_target_core.h
> @@ -580,6 +580,7 @@ struct iscsi_conn {
>   	struct ahash_request	*conn_tx_hash;
>   	/* Used for scheduling TX and RX connection kthreads */
>   	cpumask_var_t		conn_cpumask;
> +	cpumask_var_t		allowed_cpumask;
>   	unsigned int		conn_rx_reset_cpumask:1;
>   	unsigned int		conn_tx_reset_cpumask:1;
>   	/* list_head of struct iscsi_cmd for this connection */
> @@ -878,6 +879,7 @@ struct iscsit_global {
>   	/* Thread Set bitmap pointer */
>   	unsigned long		*ts_bitmap;
>   	spinlock_t		ts_bitmap_lock;
> +	cpumask_var_t		allowed_cpumask;
>   	/* Used for iSCSI discovery session authentication */
>   	struct iscsi_node_acl	discovery_acl;
>   	struct iscsi_portal_group	*discovery_tpg;
> @@ -898,29 +900,8 @@ static inline u32 session_get_next_ttt(struct iscsi_session *session)
>   
>   extern struct iscsi_cmd *iscsit_find_cmd_from_itt(struct iscsi_conn *, itt_t);
>   
> -static inline void iscsit_thread_check_cpumask(
> -	struct iscsi_conn *conn,
> -	struct task_struct *p,
> -	int mode)
> -{
> -	/*
> -	 * mode == 1 signals iscsi_target_tx_thread() usage.
> -	 * mode == 0 signals iscsi_target_rx_thread() usage.
> -	 */
> -	if (mode == 1) {
> -		if (!conn->conn_tx_reset_cpumask)
> -			return;
> -		conn->conn_tx_reset_cpumask = 0;
> -	} else {
> -		if (!conn->conn_rx_reset_cpumask)
> -			return;
> -		conn->conn_rx_reset_cpumask = 0;
> -	}
> -	/*
> -	 * Update the CPU mask for this single kthread so that
> -	 * both TX and RX kthreads are scheduled to run on the
> -	 * same CPU.
> -	 */
> -	set_cpus_allowed_ptr(p, conn->conn_cpumask);
> -}
> +extern void iscsit_thread_check_cpumask(struct iscsi_conn *conn,
> +					struct task_struct *p,
> +					int mode);
> +
>   #endif /* ISCSI_TARGET_CORE_H */
