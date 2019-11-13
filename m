Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF98FB5F1
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfKMRHp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 12:07:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33399 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfKMRHp (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:07:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id h27so1774889pgn.0
        for <target-devel@vger.kernel.org>; Wed, 13 Nov 2019 09:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aDcbzZ/oXYixCaYaGDGyoTefQH1M05FGc37uSsbr3w4=;
        b=dY9GdjKgt8/+Twk68rVxZ1JVjuDc2axyTyF3W34Ks/TXdTxj1vZcRc6UYpUAYDnUhm
         5npPaS3+LS1MLt6+09gw0yDC9fqHBaXTVNTJX3IJvtiSUI/dS23LWeRYJHSGIGMqur6H
         7MAoraQbxP9xDY8HX4R0PUrdRp6Z0R4+CDqHbUMfy50oARX42Fv+Kgnsg2UjpAmtB5H/
         Smtku7SDOl9dmrz46z4ftwbiP14aVuq2ps/fyiIa2c2kr7i+WOUnV3qcAGdrHEaVi9/9
         A8wOJ4Z9zI0uxvu2DlseLEiHIeSzRepYefjAszH9AGZQOJQSsbzNipTEKdeP2AZtdLOv
         GDGQ==
X-Gm-Message-State: APjAAAVLaOWGdTdOwTmp8MHbP4Nbbb1un5d/chc2xrbmtszt8+9Lsb6E
        SW58j9usKDTfY8MjBaDaXzKvfktU
X-Google-Smtp-Source: APXvYqyMs1slOxKd6lxZfBDvhiiWhUet5EhHSq0WxlKbzFjbumsUOqsdQutZAUgSUkVaMGwCelQ8Kw==
X-Received: by 2002:a63:ff46:: with SMTP id s6mr4897561pgk.337.1573664863878;
        Wed, 13 Nov 2019 09:07:43 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b137sm3435834pga.91.2019.11.13.09.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 09:07:43 -0800 (PST)
Subject: Re: [PATCH 3/3] target/iscsi: Wait for all commands to finish before
 freeing a session
To:     Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
References: <20191112035752.8338-1-bvanassche@acm.org>
 <20191112035752.8338-4-bvanassche@acm.org>
 <20191113134253.rlypgdve7qwfynjz@SPB-NB-133.local>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <04168d9b-bd0e-0fb0-1977-8671ab9db282@acm.org>
Date:   Wed, 13 Nov 2019 09:07:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113134253.rlypgdve7qwfynjz@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/13/19 5:42 AM, Roman Bolshakov wrote:
> On Mon, Nov 11, 2019 at 07:57:52PM -0800, Bart Van Assche wrote:
>> -	target_get_sess_cmd(&cmd->se_cmd, true);
>> +	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
>> +		return iscsit_add_reject_cmd(cmd,
>> +				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
> 
> Sending the reject reason implies initiator can resend original PDU,
> according to https://tools.ietf.org/html/rfc7143#section-11.17.1
> 
> Is it intended, i.e. do we want the retry?

Hi Roman,

The two new iscsit_add_reject_cmd() can only be triggered if the 
initiator sends one or more iSCSI PDUs after the logout PDU. I think 
that's a violation of the iSCSI protocol. Anyway, how about changing the 
reject reason into ISCSI_REASON_PROTOCOL_ERROR?

Thanks,

Bart.

