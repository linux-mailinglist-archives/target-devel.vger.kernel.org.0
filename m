Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185D4E1005
	for <lists+target-devel@lfdr.de>; Wed, 23 Oct 2019 04:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbfJWCa2 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 22 Oct 2019 22:30:28 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:37610 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfJWCa2 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:30:28 -0400
Received: by mail-pf1-f170.google.com with SMTP id y5so11897106pfo.4
        for <target-devel@vger.kernel.org>; Tue, 22 Oct 2019 19:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6MsDRyTZ9EonxVtfjk0lJpPvQ+NP2ezk1jEdwUyIj1U=;
        b=LG8ReDmy4pDvJDaNAmxxHOqHZGkAso+2lkXX8xJiDi7kBaG+Idf0HgkLqZaDnIOMvP
         EvJqbVnRtWlhhz5IeWZfBWeCy6Ym70UNt6aJsJD4MxKe4RtGvFDaGgSnEImBFHwmderQ
         jh9xRCnsePCZby9yW1lUL0YnvwPUtudWOm2nADTXxrbTLRy/6ungoUsbTzp6QJ0TBcy8
         kx4LFm66weuLB66oaRdOyOaHv4nCY9RWzSCb1k5YVRKlGNW4tRPJi4mj7hehrpyozWso
         ERTHLTQps27sgDMjcaBho0AFPC+EmgkKDom6j4j/n9yN9FOa3vmJPSHDkUm6TKNsB2Ie
         4GZg==
X-Gm-Message-State: APjAAAXHtvfc/5wwEq/N7NBkACrHFWZ9rbOQnOUzjUCIn91qA7aW5Qj0
        /LWkTd0V03MpQBS/NojnuOdeeuny
X-Google-Smtp-Source: APXvYqxvmEx5zdRQFpr0nfhcxdme87gBlvWRNwz3cPgCy3CB6O1bYFnb9uiPj47DZjPDDcuIBmtp9A==
X-Received: by 2002:a63:9302:: with SMTP id b2mr4606680pge.342.1571797826467;
        Tue, 22 Oct 2019 19:30:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:28f0:4a5a:dfde:9bba])
        by smtp.gmail.com with ESMTPSA id x14sm4027569pfm.96.2019.10.22.19.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 19:30:25 -0700 (PDT)
Subject: Re: [bug report] target/cxgbit: Fix endianness annotations
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        target-devel@vger.kernel.org
References: <20191014115025.GA9350@mwanda> <yq1tv80dxnf.fsf@oracle.com>
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
Message-ID: <2cf646a5-3853-b07d-9b02-c0e5dbb9a91d@acm.org>
Date:   Tue, 22 Oct 2019 19:30:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <yq1tv80dxnf.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2019-10-22 19:05, Martin K. Petersen wrote:
> 
> Bart?
> 
>> This is a semi-automatic email about new static checker warnings.
>>
>> The patch 5cadafb236df: "target/cxgbit: Fix endianness annotations"
>> from Jan 13, 2017, leads to the following Smatch complaint:
>>
>>     drivers/target/iscsi/cxgbit/cxgbit_cm.c:1836 cxgbit_fw4_ack()
>>     warn: variable dereferenced before check 'p' (see line 1834)
>>

Hi Martin,

Thanks for the reminder - Dan's email had escaped from my attention. I
will submit a patch.

Bart.
