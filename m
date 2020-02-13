Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9615B906
	for <lists+target-devel@lfdr.de>; Thu, 13 Feb 2020 06:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgBMFZR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 13 Feb 2020 00:25:17 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38459 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgBMFZQ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:25:16 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so1892491pjz.3
        for <target-devel@vger.kernel.org>; Wed, 12 Feb 2020 21:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0N6a7UohSa2oe2Qa3vBulPloNqoFbYgWl/FqFpfY9dw=;
        b=DdWIYcWOCA9eaQ8PByqCgIBuyYItmZTyoYNJ7go9+7YPKyoDedMoyEbShnnPZi/+1c
         fMtkKm1mEIGEWc3xRiGykKWSFUmzX5p+1uzJiJYipEUemZrTYorusrP0QmEb5kr9Bs+G
         P8ChURPKAdVkemtk3vLDTek1QSrAxPiIT72AWllmcZIfsVGnQJxlo+LsjUHwZUxj30K9
         N88eZXJlYtY/OcOXQRyOvRwZsDWIm+jN89v03oxHb7NO8xNhT8BTy7FyiGuXzip9/w9D
         /7ezUGzIlI3SiwVJKNSYQn8NCm8QVkVJpSZn9RpU+Lin513M7WI+bZunC/4ZGgS/flVz
         F2yQ==
X-Gm-Message-State: APjAAAVFkw5mVcNnr9Yx74aJFNKUhvZ6WM898124HCDjKJaJgK96cHG2
        1/j5ZTOclRyVgwpiT6JKBgM=
X-Google-Smtp-Source: APXvYqz5n+j9I1zxvcoIvzX2HVbf7MPwued3lWa4OgEt/WM/oIBX0TPy3eFjCBeiRwVmAqIbZJr4Pg==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr11629880plb.309.1581571514802;
        Wed, 12 Feb 2020 21:25:14 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:a815:f3bb:71b5:79fa? ([2601:647:4000:d7:a815:f3bb:71b5:79fa])
        by smtp.gmail.com with ESMTPSA id k63sm875602pjb.10.2020.02.12.21.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 21:25:14 -0800 (PST)
Subject: Re: [PATCH 1/2] Revert "RDMA/isert: Fix a recently introduced
 regression related to logout"
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     target-devel@vger.kernel.org,
        Dakshaja Uppalapati <dakshaja@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Rahul Kundu <rahul.kundu@chelsio.com>
References: <20200213050900.19094-1-bvanassche@acm.org>
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
Message-ID: <fcc55797-40d0-a04f-e2de-6a20a02e6fb6@acm.org>
Date:   Wed, 12 Feb 2020 21:25:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200213050900.19094-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2020-02-12 21:08, Bart Van Assche wrote:
> [ ... ]

Oops, the cover letter has not been included. This is the cover letter I
wanted to include:

[PATCH 0/2] Revert two recent iSCSI / iSER patches

Hi Martin,

Recently Dakshaja Uppalapati reported a regression in the iSER driver
and confirmed that the regression is fixed by reverting the two most
recent iSCSI / iSER patches. Hence this patch series with two reverts.

Thanks,

Bart.

Bart Van Assche (2):
  Revert "RDMA/isert: Fix a recently introduced regression related to
    logout"
  Revert "target: iscsi: Wait for all commands to finish before freeing
    a session"

 drivers/infiniband/ulp/isert/ib_isert.c | 12 ++++++++++++
 drivers/target/iscsi/iscsi_target.c     | 16 +++++-----------
 include/scsi/iscsi_proto.h              |  1 -
 3 files changed, 17 insertions(+), 12 deletions(-)

