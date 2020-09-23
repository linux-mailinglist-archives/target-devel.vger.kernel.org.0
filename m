Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E311F27563C
	for <lists+target-devel@lfdr.de>; Wed, 23 Sep 2020 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIWKXM (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 23 Sep 2020 06:23:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36832 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbgIWKXL (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600856590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFgJToirjL1LcUbMYxqpCEwKfTDu3I+1Nj36cIZeHgU=;
        b=Yd0IdmQTpH+5D0QQ1w/Mb0SJ3HD/w1q6wrLgrcj+8ir03so6qzuOax5OWqOWdbB8APf+sJ
        KUQBtls6bZL0rRggnw5zrvIqY3v6COVWbj5mQyHhw12ZBj2Eayd3CvCZngbSHa2VeParIx
        XK+zJcHcDbxHiZ0MO1hT1H8KdcnAuFc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-fOSqIDmcNduMdU4A8WSzrQ-1; Wed, 23 Sep 2020 06:23:08 -0400
X-MC-Unique: fOSqIDmcNduMdU4A8WSzrQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so8613471wrk.12
        for <target-devel@vger.kernel.org>; Wed, 23 Sep 2020 03:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFgJToirjL1LcUbMYxqpCEwKfTDu3I+1Nj36cIZeHgU=;
        b=T/GscKgrJc4mUUNA9kUmMTEhCTu3tIjbzdMI5vxn56/qPyqPbSeGUEK+lDUMxsaedY
         8jEZuZZv95gyafVlGWJFWKAB6+Z42q5YIWAk6967kAF8AWgVdO4aokqOBXT5xKDACByD
         7ssbX57C2zmTvI9jO3k1pk8MFwDtwOHVzG24I7fbeJZfF0jAqobkVGB0jVqiIfAsiary
         7tsqYldKzQJ9Vxtb/SrANIRJKgjSn/f97xqiVbxI9kdC5h/pbKiKht8SeMjAHL4MDPF0
         9cfjClRgtMZA9fA56ti5sCMlkqVKdD8IxfZjop7cjcQFgBwjWsnh+qNwchBSsjedtyX+
         8bDg==
X-Gm-Message-State: AOAM530F2xxF1B2jzWIfSoj9JiW0iJYVpQo56EZs8FNfAxuUcJrE02ok
        xdAXZUM23Sed2uBE6x+5kdVNa8ilaIHf260SnK5+rsiBZ/LnzgI1La+EOS45dSLBW8QDC4JTgwx
        NM0K+oJy/PjIMA7DhazXQPv1n
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr4741715wmi.40.1600856587515;
        Wed, 23 Sep 2020 03:23:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvwid4yBpJLIUdhmHJZC1dioF+qkVR7rcecEnmaK5giSVtQGS8/+Yh8i8w9490r84enyaBxw==
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr4741681wmi.40.1600856587231;
        Wed, 23 Sep 2020 03:23:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9? ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
        by smtp.gmail.com with ESMTPSA id y6sm30308257wrn.41.2020.09.23.03.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 03:23:06 -0700 (PDT)
Subject: Re: [PATCH 5/8] vhost scsi: add lun parser helper
To:     Mike Christie <michael.christie@oracle.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org
References: <1600712588-9514-1-git-send-email-michael.christie@oracle.com>
 <1600712588-9514-6-git-send-email-michael.christie@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c981b20e-895a-d5ce-9973-ffe7b21bd724@redhat.com>
Date:   Wed, 23 Sep 2020 12:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600712588-9514-6-git-send-email-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 21/09/20 20:23, Mike Christie wrote:
> Move code to parse lun from req's lun_buf to helper, so tmf code
> can use it in the next patch.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 26d0f75..736ce19 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -899,6 +899,11 @@ static void vhost_scsi_submission_work(struct work_struct *work)
>  	return ret;
>  }
>  
> +static u16 vhost_buf_to_lun(u8 *lun_buf)
> +{
> +	return ((lun_buf[2] << 8) | lun_buf[3]) & 0x3FFF;
> +}
> +
>  static void
>  vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>  {
> @@ -1037,12 +1042,12 @@ static void vhost_scsi_submission_work(struct work_struct *work)
>  			tag = vhost64_to_cpu(vq, v_req_pi.tag);
>  			task_attr = v_req_pi.task_attr;
>  			cdb = &v_req_pi.cdb[0];
> -			lun = ((v_req_pi.lun[2] << 8) | v_req_pi.lun[3]) & 0x3FFF;
> +			lun = vhost_buf_to_lun(v_req_pi.lun);
>  		} else {
>  			tag = vhost64_to_cpu(vq, v_req.tag);
>  			task_attr = v_req.task_attr;
>  			cdb = &v_req.cdb[0];
> -			lun = ((v_req.lun[2] << 8) | v_req.lun[3]) & 0x3FFF;
> +			lun = vhost_buf_to_lun(v_req.lun);
>  		}
>  		/*
>  		 * Check that the received CDB size does not exceeded our
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

