Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C01DBAEB
	for <lists+target-devel@lfdr.de>; Wed, 20 May 2020 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETRPX (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 20 May 2020 13:15:23 -0400
Received: from mail3.bemta25.messagelabs.com ([195.245.230.81]:22324 "EHLO
        mail3.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgETRPX (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 20 May 2020 13:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1589994919; i=@ts.fujitsu.com;
        bh=oBA+5vfk8yhfVgNwFI8AU+Y2q7fckRA8o8jmPETc66I=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=UzxYUuIbUUPBTnNcu1Nj0ps6MJcnUVUr0lOk8WZiLplehMy4YN9SqVpV3m4S197cO
         ohA8+Re6i9zet0N4zx0aboTuZQOJNOcMMkvPBJaLPPa9Nt1IPKOLHlX9fonQsFMFqb
         87b3/BuvEUrdnPsm9JJjlf6FveLMSvwMCrfG3kdU+A0SLykyVazIx9wJZsXB6emC4T
         pFdQihxOcnciYu27Pvf8Dv+knvs8B7WSE9DPrRElLzp5oe4C/laigssOlikd70qn6Z
         OBMPBq1W076X6a+ceGiQ+PlExnRDnr+PwZzbF1Ii0CgQKn2IY+HJd+r9prg/XJEWzv
         rKQ7Uok9EYsiQ==
Received: from [100.112.199.17] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id F2/9F-23301-6A565CE5; Wed, 20 May 2020 17:15:18 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRWlGSWpSXmKPExsViZ8MxVXdZ6tE
  4g/a18hY7r39kspj24SezxbY7mRbLj/9jslh/ZAOjRcPp7SwWrUvfMjmwe1y+4u3x/98UZo/W
  6W1MHh+f3mLxeL/vKpvHmcudjB6fN8kFsEexZuYl5VcksGYs2O9WMF+jYt7/w8wNjJsVuxi5O
  IQEJjNKvL8/ixXC6WeU+LX6DVsXIyeHsIC7xL4JK5lBEiICPxgl7sy5ApYQErCTaPr7mRXEZh
  MwkFgx6T4LiM0r4CjR8KSTGcRmEVCV2P/oCTuILSoQLvFiyx9WiBpBiZMzn4DVcwrYS3zY9wM
  szixgJjFv80NmCFtc4taT+UwQtrbEsoWvmScw8s1C0j4LScssJC2zkLQsYGRZxWiRVJSZnlGS
  m5iZo2toYKBraGika2hprmtoZqKXWKWbpJdaqlueWlyia6iXWF6sV1yZm5yTopeXWrKJERgbK
  QVHl+xg3Lb8vd4hRkkOJiVR3ojko3FCfEn5KZUZicUZ8UWlOanFhxhlODiUJHing+QEi1LTUy
  vSMnOAcQqTluDgURLh3Q6S5i0uSMwtzkyHSJ1iVJQS5/0BkhAASWSU5sG1wVLDJUZZKWFeRgY
  GBiGegtSi3MwSVPlXjOIcjErCvPNSgKbwZOaVwE1/BbSYCWix9LFDIItLEhFSUg1MMmue+i3z
  nDg/OXvJ5WUhYZKZ5Rp88upbfK7t2M/w5lbD9s1avnoqa174/WvhZry3feGJzlPR2+VmfeJLO
  pqRodA7Wa5rkoPn5S0u8QWLXEI4deos8+NiPi4vbRaQbNBz9beV7fB+vv4ug99VjSmOGkqaZw
  9MfmHvpjpPv7xaibf5jHiHYNrio+/M7C9Vt4kH6l5ceHhJSsT3IA7HEt9gW868vLedh7XnsG+
  WDZmwJPBVSG2O3Xn//cvPJ5t1dS468LdTa1n/rMiTq5XVn77zbn8UPt/WU/XEgt5SX6X5vzuy
  S+6sOtO149jOXrdllk6F9+WNONfNPdzGWPxap/D87rauEMcQ7cX/JlV7ySmxFGckGmoxFxUnA
  gAOXjZViAMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-6.tower-285.messagelabs.com!1589994917!688696!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12561 invoked from network); 20 May 2020 17:15:18 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-6.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 May 2020 17:15:18 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 04KHEt0N008187;
        Wed, 20 May 2020 18:15:04 +0100
Received: from [172.17.39.90] (unknown [172.17.39.90])
        by x-serv01 (Postfix) with ESMTP id 24AB220561;
        Wed, 20 May 2020 19:14:42 +0200 (CEST)
Subject: Re: [PATCH] scsi: target: put lun_ref at end of tmr processing
To:     Pavel Zakharov <pavel.zakharov@delphix.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        bvanassche@acm.org, mchristi@redhat.com,
        linux-scsi@vger-kernel.org, target-devel@vger.kernel.org,
        bly@catalogicsoftware.com
References: <96A62932-C9F9-4BB3-88B4-9B0A879A155E@delphix.com>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <381c05ca-cefd-c127-0f26-1e5238e773bb@ts.fujitsu.com>
Date:   Wed, 20 May 2020 19:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <96A62932-C9F9-4BB3-88B4-9B0A879A155E@delphix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 05/20/20 17:50, Pavel Zakharov wrote:
> Hopefully I didn=E2=80=99t mess-up the recipients/Subject list as I jus=
t subscribed to target-devel and so following-up to an email I found in t=
he archive.
>=20
> Bodo, I happened to have run into the same issue and was just about to =
submit a similar patch when I randomly stumbled on yours.
> I think we can improve on that patch by moving the call to transport_lu=
n_remove_cmd() into transport_cmd_check_stop_to_fabric().

Yeah, I also thought about doing this. But then decided to better
add the one lost line for fixing only.

>=20
> Here=E2=80=99s the patch I was about to propose. Let me know what you t=
hink.
> Note that we could also do this simplification as a separate patch late=
r if you think it=E2=80=99s better.

I think it is a good idea to do this simplification in a separate patch.


>=20
> ---
> When ABORT and LUN RESET were made synchronous, a call to
> transport_lun_remove_cmd() was acidentally removed. This caused a lun_r=
ef
> to be leaked every time an ABORT or LUN RESET was processed in
> target_tmr_work().
>=20
> Given that transport_lun_remove_cmd() should always be called before
> transport_cmd_check_stop_to_fabric(), move that call into this function=
.
> This ensures that the lun_ref is released before setting .se_lun to NUL=
L.
>=20
> Signed-off-by: Pavel Zakharov <pavel.zakharov@delphix.com>
> ---
>   drivers/target/target_core_transport.c | 36 ++++++++++++-------------=
-
>   1 file changed, 16 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/target/target_core_transport.c b/drivers/target/ta=
rget_core_transport.c
> index 594b724bbf79..ec578822709a 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
> @@ -653,6 +653,17 @@ static void target_remove_from_state_list(struct s=
e_cmd *cmd)
>   	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
>   }
>=20
> +static void transport_lun_remove_cmd(struct se_cmd *cmd)
> +{
> +	struct se_lun *lun =3D cmd->se_lun;
> +
> +	if (!lun)
> +		return;
> +
> +	if (cmpxchg(&cmd->lun_ref_active, true, false))
> +		percpu_ref_put(&lun->lun_ref);
> +}
> +
>   /*
>    * This function is called by the target core after the target core h=
as
>    * finished processing a SCSI command or SCSI TMF. Both the regular c=
ommand
> @@ -664,6 +675,11 @@ static int transport_cmd_check_stop_to_fabric(stru=
ct se_cmd *cmd)
>   {
>   	unsigned long flags;
>=20
> +	/*
> +	 * Remove cmd ref from lun if needed before clearing the se_lun.
> +	 */
> +	transport_lun_remove_cmd(cmd);
> +
>   	target_remove_from_state_list(cmd);
>=20
>   	/*
> @@ -698,17 +714,6 @@ static int transport_cmd_check_stop_to_fabric(stru=
ct se_cmd *cmd)
>   	return cmd->se_tfo->check_stop_free(cmd);
>   }
>=20
> -static void transport_lun_remove_cmd(struct se_cmd *cmd)
> -{
> -	struct se_lun *lun =3D cmd->se_lun;
> -
> -	if (!lun)
> -		return;
> -
> -	if (cmpxchg(&cmd->lun_ref_active, true, false))
> -		percpu_ref_put(&lun->lun_ref);
> -}
> -
>   static void target_complete_failure_work(struct work_struct *work)
>   {
>   	struct se_cmd *cmd =3D container_of(work, struct se_cmd, work);
> @@ -799,8 +804,6 @@ static void target_handle_abort(struct se_cmd *cmd)
>=20
>   	WARN_ON_ONCE(kref_read(&cmd->cmd_kref) =3D=3D 0);
>=20
> -	transport_lun_remove_cmd(cmd);
> -
>   	transport_cmd_check_stop_to_fabric(cmd);
>   }
>=20
> @@ -1726,7 +1729,6 @@ static void target_complete_tmr_failure(struct wo=
rk_struct *work)
>   	se_cmd->se_tmr_req->response =3D TMR_LUN_DOES_NOT_EXIST;
>   	se_cmd->se_tfo->queue_tm_rsp(se_cmd);
>=20
> -	transport_lun_remove_cmd(se_cmd);
>   	transport_cmd_check_stop_to_fabric(se_cmd);
>   }
>=20
> @@ -1918,7 +1920,6 @@ void transport_generic_request_failure(struct se_=
cmd *cmd,
>   		goto queue_full;
>=20
>   check_stop:
> -	transport_lun_remove_cmd(cmd);
>   	transport_cmd_check_stop_to_fabric(cmd);
>   	return;
>=20
> @@ -2216,7 +2217,6 @@ static void transport_complete_qf(struct se_cmd *=
cmd)
>   		transport_handle_queue_full(cmd, cmd->se_dev, ret, false);
>   		return;
>   	}
> -	transport_lun_remove_cmd(cmd);
>   	transport_cmd_check_stop_to_fabric(cmd);
>   }
>=20
> @@ -2311,7 +2311,6 @@ static void target_complete_ok_work(struct work_s=
truct *work)
>   		if (ret)
>   			goto queue_full;
>=20
> -		transport_lun_remove_cmd(cmd);
>   		transport_cmd_check_stop_to_fabric(cmd);
>   		return;
>   	}
> @@ -2337,7 +2336,6 @@ static void target_complete_ok_work(struct work_s=
truct *work)
>   			if (ret)
>   				goto queue_full;
>=20
> -			transport_lun_remove_cmd(cmd);
>   			transport_cmd_check_stop_to_fabric(cmd);
>   			return;
>   		}
> @@ -2373,7 +2371,6 @@ static void target_complete_ok_work(struct work_s=
truct *work)
>   			if (ret)
>   				goto queue_full;
>=20
> -			transport_lun_remove_cmd(cmd);
>   			transport_cmd_check_stop_to_fabric(cmd);
>   			return;
>   		}
> @@ -2409,7 +2406,6 @@ static void target_complete_ok_work(struct work_s=
truct *work)
>   		break;
>   	}
>=20
> -	transport_lun_remove_cmd(cmd);
>   	transport_cmd_check_stop_to_fabric(cmd);
>   	return;
>=20
> --
> 2.21.1 (Apple Git-122.3)
>=20
