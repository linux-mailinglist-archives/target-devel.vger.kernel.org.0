Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7BE2B44DF
	for <lists+target-devel@lfdr.de>; Mon, 16 Nov 2020 14:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgKPNie (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 16 Nov 2020 08:38:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729352AbgKPNie (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605533912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUCExb2Myfed67dyXicBK4o1FCf+8g+t7D84qw1NisQ=;
        b=QhPGYePavlc6nWW/AUhyBSobMro3R1VpXS2i7GHXeD3EXoGnJR1/tFqutZb/PWx45pJvLJ
        MtmaT8Ctcr7j/iYBdWtLl5uf0Sr/9s9kOi2hORkltXPB9JoFEL3Kvxc2V2wxyhXYpk+RUo
        oO48A7dKkrn8/8UNw4YV+l0gYV4Gtk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-PrBKkYCLMHGc4WdFIim1UQ-1; Mon, 16 Nov 2020 08:38:28 -0500
X-MC-Unique: PrBKkYCLMHGc4WdFIim1UQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7664B186DD21;
        Mon, 16 Nov 2020 13:38:27 +0000 (UTC)
Received: from [10.35.206.131] (unknown [10.35.206.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1CA5C3E3;
        Mon, 16 Nov 2020 13:38:25 +0000 (UTC)
Subject: Re: [PATCH] iscsi target: fix cmd abort fabric stop race
To:     Mike Christie <michael.christie@oracle.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <1605318378-9269-1-git-send-email-michael.christie@oracle.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <4c55f623-9347-ead7-0f5b-6cf1f7687584@redhat.com>
Date:   Mon, 16 Nov 2020 14:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1605318378-9269-1-git-send-email-michael.christie@oracle.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



Dne 14. 11. 20 v 2:46 Mike Christie napsal(a):
> Maurizio Lombardi <mlombard@redhat.com> found a race where the abort
> and cmd stop paths can race as follows:
> 
> 1. thread1 runs iscsit_release_commands_from_conn and sets
> CMD_T_FABRIC_STOP.
> 2. thread2 runs iscsit_aborted_task and then does __iscsit_free_cmd. It
> then returns from the aborted_task callout and we finish
> target_handle_abort and do:
> 
> target_handle_abort -> transport_cmd_check_stop_to_fabric ->
> lio_check_stop_free -> target_put_sess_cmd
> 
> The cmd is now freed.
> 3. thread1 now finishes iscsit_release_commands_from_conn and runs
> iscsit_free_cmd while accessing a command we just released.
> 
> In __target_check_io_state we check for CMD_T_FABRIC_STOP and set the
> CMD_T_ABORTED if the driver is not cleaning up the cmd because of
> a session shutdown. However, iscsit_release_commands_from_conn only
> sets the CMD_T_FABRIC_STOP and does not check to see if the abort path
> has claimed completion ownership of the command.
> 
> This adds a check in iscsit_release_commands_from_conn so only the
> abort or fabric stop path cleanup the command.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> 
> ---
>  drivers/target/iscsi/iscsi_target.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index f77e5ee..518fac4 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -483,8 +483,7 @@ int iscsit_queue_rsp(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
>  void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
>  {
>  	spin_lock_bh(&conn->cmd_lock);
> -	if (!list_empty(&cmd->i_conn_node) &&
> -	    !(cmd->se_cmd.transport_state & CMD_T_FABRIC_STOP))
> +	if (!list_empty(&cmd->i_conn_node))
>  		list_del_init(&cmd->i_conn_node);
>  	spin_unlock_bh(&conn->cmd_lock);
>  
> @@ -4083,12 +4082,22 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
>  	spin_lock_bh(&conn->cmd_lock);
>  	list_splice_init(&conn->conn_cmd_list, &tmp_list);
>  
> -	list_for_each_entry(cmd, &tmp_list, i_conn_node) {
> +	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_list, i_conn_node) {
>  		struct se_cmd *se_cmd = &cmd->se_cmd;
>  
>  		if (se_cmd->se_tfo != NULL) {
>  			spin_lock_irq(&se_cmd->t_state_lock);
> -			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
> +			if (se_cmd->transport_state & CMD_T_ABORTED) {
> +				/*
> +				 * LIO's abort path owns the cleanup for this,
> +				 * so put it back on the list and let
> +				 * aborted_task handle it.
> +				 */
> +				list_move_tail(&cmd->i_conn_node,
> +					       &conn->conn_cmd_list);
> +			} else {
> +				se_cmd->transport_state |= CMD_T_FABRIC_STOP;
> +			}
>  			spin_unlock_irq(&se_cmd->t_state_lock);
>  		}
>  	}
> 

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>

