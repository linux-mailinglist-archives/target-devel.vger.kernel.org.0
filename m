Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDD1BC4C3
	for <lists+target-devel@lfdr.de>; Tue, 28 Apr 2020 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgD1QOv (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 28 Apr 2020 12:14:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35421 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgD1QOv (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:14:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8so8557390plt.2;
        Tue, 28 Apr 2020 09:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ma8iw3FSOuVaQ1mWciv9vAKHPP/q1ILwhEJ/+B0GY14=;
        b=nztBsuKpZ71dEz5tJmo3tvygB8Vp3dvTJMzb2wO/C8+P1wfZwrLsX/r+VcBnUlF+wj
         M13cm+rgqVEee8fGSq0Jji9X4PQ7bNDIHaA/mpThUKd1BBiO9JGvaFo2nFII+aSA8e0H
         HM+wBLD+VKf1kszFSo23/hg1px/jYOEeTY5VG1IjB8col0yywIo/srf6AElBQzzOyABs
         Dt1y6vqluLeHi22XAZHlx59AYhzv+3mQGIdMUkaCFpbv0t5MY4xAzt8yDy47yVLatkta
         0B55Te3x1MfEwoTOCbSN8oze30uOr/LTI7gfbeSmNtczoo98uisM6d3F0bFH9UYhvvSc
         gmzQ==
X-Gm-Message-State: AGi0Pubk34D/RVje4gBcyHk73F/PHVq74t4c70sIilpDJ9h1t3fmQ6zX
        VdNS0Me2iKlW8bFx8aB2OkpB/pj7NXqGHg==
X-Google-Smtp-Source: APiQypJeoFGfs57vKtBTU2SGY5wocAeiajohwDg4is+WPc4oPC5arqYmjnFGR5iGv8G0s7xa5Rd2AQ==
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr13001042plt.104.1588090490136;
        Tue, 28 Apr 2020 09:14:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:1473:9ec8:73db:e572? ([2601:647:4000:d7:1473:9ec8:73db:e572])
        by smtp.gmail.com with ESMTPSA id m129sm6805400pga.47.2020.04.28.09.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 09:14:49 -0700 (PDT)
Subject: Re: [PATCH 02/11] target: separate acl name from port ids
To:     Mike Christie <mchristi@redhat.com>, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20200428061109.3042-1-mchristi@redhat.com>
 <20200428061109.3042-3-mchristi@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <81c299f2-cb40-d910-f5ca-3ba0e700365f@acm.org>
Date:   Tue, 28 Apr 2020 09:14:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428061109.3042-3-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2020-04-27 23:11, Mike Christie wrote:
> The PGR code assumes the ACL name is going to be based on the SPC4
> transportID type of values. The problem is that for iSCSI we have an
> extra session id as part of the SCSI port id and some fabric modules
> support or would like to support non transportID values for the ACL
> name. For example, iSCSI and SRP would like to use the source address
> for the ACL name, but that is not a valud transportID value that you
> can get in a PGR request.
> 
> This patch adds a new transport_id struct which maps to the SPC
> transportID. In the future will be used for PGR commands instead of
> the ACL name. In this patchset, it is used to export the initiator
> info in the session's sysfs dir, so tools can disply the info and
                                                ^^^^^^
                                                display?
> daemons that execute commands like PGRs in userspace can build a
> session id to I_T nexus mapping.

[ ... ]

> --- a/drivers/target/loopback/tcm_loop.c
> +++ b/drivers/target/loopback/tcm_loop.c
> @@ -725,10 +725,11 @@ static int tcm_loop_alloc_sess_cb(struct se_portal_group *se_tpg,
>  
>  static int tcm_loop_make_nexus(
>  	struct tcm_loop_tpg *tl_tpg,
> -	const char *name)
> +	char *name)
>  {

What needs to be changed to keep the type of the argument as 'const char
*'? How about removing the target_cp_transport_id() call from
target_setup_session() and making all transports allocate the transport
ID dynamically such that target_setup_session() does not have to
duplicate the transport ID?

> +struct t10_transport_id *target_cp_transport_id(struct t10_transport_id *src)
> +{
> +	struct t10_transport_id *dst;
> +
> +	dst = kzalloc(sizeof(*dst), GFP_KERNEL);
> +	if (!dst)
> +		return NULL;
> +	dst->proto = src->proto;
> +
> +	dst->name = kstrdup(src->name, GFP_KERNEL);
> +	if (!dst->name)
> +		goto free_tpid;
> +
> +	if (src->session_id) {
> +		dst->session_id = kstrdup(src->session_id, GFP_KERNEL);
> +		if (!dst->session_id)
> +			goto free_name;
> +	}
> +
> +	return dst;
> +
> +free_name:
> +	kfree(dst->name);
> +free_tpid:
> +	kfree(dst);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(target_cp_transport_id);

How about changing "cp" into "dup" in the name of the
target_cp_transport_id() function?

> -static int scsiback_make_nexus(struct scsiback_tpg *tpg,
> -				const char *name)
> +static int scsiback_make_nexus(struct scsiback_tpg *tpg, char *name)
>  {

Also for this function, is it possible to keep the type of 'name' as
'const char *'?

Thanks,

Bart.
