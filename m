Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7C1493BA
	for <lists+target-devel@lfdr.de>; Sat, 25 Jan 2020 06:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAYFzq (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 25 Jan 2020 00:55:46 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40213 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAYFzp (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 25 Jan 2020 00:55:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id bg7so769210pjb.5
        for <target-devel@vger.kernel.org>; Fri, 24 Jan 2020 21:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cyNcOSf3/5C3RQzANOJENcfzg/mYED/t2MgfNkYtP1s=;
        b=HOoz64+X+p19FuAiJ2wMOLltldxQ5EqXeMtD+Zt/7B8IWiKE4e62WbIwWk67SK3+QJ
         o96AIpC0c91b421Q5k5Bz0rGNq6Jq/4HNN9zFlJF4/k95qB7z22aUQgO42Loov1FP/JW
         3v79rEcKqdzrEH3x8J+8k97K2/yfBb+Y4iMdv+ixNVb/oq7UxfV3XFUeQxukbsEyy11Y
         voExJalsPwmN2uS+xDce3lIW4ZNN70BG661dW6SEOz0dTpVWtzjFz8RXFxOkn0Tv4VuF
         CTwE7oL5LlXUS7/Cm/iai0sNn1kId2O6b9Xa+JO/1x6dWRSjCQyi5wdcn4FbXgc+jMA8
         ubHQ==
X-Gm-Message-State: APjAAAWBMDTZkgGbPy4IwSDz+QpZwKoC8/lZ2P601P3PtKaDsPpx7O7h
        XpYFs8DxcmPIceXKPX6fIdxnd8jB
X-Google-Smtp-Source: APXvYqxIY1oM6GJKXN2L9oaqpsMtNDw9UcSQWbKccw3Mk6ub+MOPT+B7g21HNLSCbdIl/ZT+CCZyrQ==
X-Received: by 2002:a17:902:740c:: with SMTP id g12mr7756512pll.166.1579931745122;
        Fri, 24 Jan 2020 21:55:45 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:1596:afb1:10e:95ae? ([2601:647:4000:d7:1596:afb1:10e:95ae])
        by smtp.gmail.com with ESMTPSA id x132sm8156200pfc.148.2020.01.24.21.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 21:55:44 -0800 (PST)
Subject: Re: [PATCH] tcm_qla2xxx: Make qlt_alloc_qfull_cmd() set
 cmd->se_cmd.map_tag
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>, target-devel@vger.kernel.org,
        Himanshu Madhani <hmadhani@marvell.com>
References: <20200103192719.205158-1-bvanassche@acm.org>
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
Message-ID: <b21b981b-bbb3-2362-63a6-39cb0e7ddfbb@acm.org>
Date:   Fri, 24 Jan 2020 21:55:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200103192719.205158-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2020-01-03 11:27, Bart Van Assche wrote:
> Reduce code duplication by introducing the tcm_qla2xxx_{get,rel}_cmd()
> functions. Introduce these functions in the tcm_qla2xxx.c source files
> such that the qla_target.c source file becomes independent of the SCSI
> target core header files. This patch fixes a bug, namely by ensuring that
> qlt_alloc_qfull_cmd() sets cmd->se_cmd.map_tag.

Ping?
