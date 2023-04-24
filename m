Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17EA6DF1E9
	for <lists+target-devel@lfdr.de>; Wed, 12 Apr 2023 12:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjDLK0K (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 12 Apr 2023 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDLK0I (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:26:08 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3810D5
        for <target-devel@vger.kernel.org>; Wed, 12 Apr 2023 03:26:05 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id b26so9941116vsa.11
        for <target-devel@vger.kernel.org>; Wed, 12 Apr 2023 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681295164; x=1683887164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s5vg+YiNoxs31Tbnrbv2vsVS/DbOkcWGxusmaV9cfKk=;
        b=DM3bChJapodBr2WHktIVXkF4wESvZSLuZZn2zwhzSHR/k6aeEsuyuFmPaLw5+pOEUH
         38OFPm/u+VF2r1UB6keKE0knkwIJ5ONc5nihQRbRBi4ys6eO9dD/BwWOhpwU1lnUAsoQ
         QWbjR57oIsH1xb7GH369h+6pXCS185B8PYydBy/JDB17T1tWZ9hNiiHN1LHHjEY6+0Hy
         0Q0+E9O5D0VcLEepEGChzSMZ6z/f/v+YVqLuO6Miuh3vJuk84aN1Hki0sQx6NJbLdCmQ
         Jrb3ja03hDHyBjgR4WXtGsDSxFNmfB6ohsQgcmFwlzfyCv/HuWB142U0UN9sAYewWI/8
         2Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681295164; x=1683887164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5vg+YiNoxs31Tbnrbv2vsVS/DbOkcWGxusmaV9cfKk=;
        b=AwpBnHEiEL2Zc/Z2ajbsP5Zx3irkwPDLBEVbMjMNP9cev/SopIhqvAWf6hYCctSF44
         tl4H1erXHo/wbLKnwbWYjLBqx6m5o26ICbog8IfE9fRcx8DAI/kLIx36IuuLiL2BnvaI
         LFIuZvpcJrRIzIt+DSNo72c0VVVMDxOM2JBakCLMYvsmfFyA6+2i2EQ+Lp2Ha0kxuiaI
         UEbxoqX7fWQDQv43gyziniiSHRx/MakM+NYv8BkZTL4uxMlfovz0iMYefM/CwGoQAZmD
         cJUnCmbyFvw8Ggzi3ulZBjMkNWQTq84+jItHwlkADJUyexem2/eiHVCSu3fPnmXr3h+K
         cZGg==
X-Gm-Message-State: AAQBX9fRcFWQ2IcRk6txDyss3OvCsGfPWmVe41iQ2hLdpnx8m+/SMtce
        CgSXnGDCaaqJ6rV2ag1+WR+NdJT6i0tBCWqAGgbOEA==
X-Google-Smtp-Source: AKy350Y0FPXWa3mLhpuSfB2wOlCNyI4G0X8q0GPeu0ZGyUt76BO9Zf7I0z0F2H0jq5JCqvcQzrzp/+A3FO8XMIP0FFg=
X-Received: by 2002:a67:cc0f:0:b0:42c:74a1:424f with SMTP id
 q15-20020a67cc0f000000b0042c74a1424fmr3659466vsl.1.1681295164459; Wed, 12 Apr
 2023 03:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230407200551.12660-1-michael.christie@oracle.com> <20230412093617.285177-1-naresh.kamboju@linaro.org>
In-Reply-To: <20230412093617.285177-1-naresh.kamboju@linaro.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Apr 2023 15:55:53 +0530
Message-ID: <CA+G9fYv2nEBe=kJK4veunkvXD9GvqyaPFQ7rUbMD1S4+0nUS3Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Use block pr_ops in LIO
To:     michael.christie@oracle.com
Cc:     axboe@kernel.dk, bvanassche@acm.org, chaitanyak@nvidia.com,
        dm-devel@redhat.com, hch@lst.de,
        james.bottomley@hansenpartnership.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        snitzer@kernel.org, target-devel@vger.kernel.org, vbabka@suse.cz,
        mgorman@techsingularity.net, halbuer@sra.uni-hannover.de,
        keescook@chromium.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        mkoutny@suse.com, roman.gushchin@linux.dev, ryan.roberts@arm.com,
        shy828301@gmail.com, yuzhao@google.com, zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, 12 Apr 2023 at 15:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> [sorry for the adding you in CC]
>
> While running LTP controllers test suite on this patch set applied on top of
> the next-20230406 and the following kernel panic noticed on qemu-i386.

Also noticed on qemu-x86_64.

Crash log link,
------------------
- https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230404140835_25166-1-sergei_shtepa_veeam_com/testrun/16171908/suite/log-parser-test/test/check-kernel-panic/log
- https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230404140835_25166-1-sergei_shtepa_veeam_com/testrun/16171908/suite/log-parser-test/tests/

lore link,
https://lore.kernel.org/linux-block/20230407200551.12660-1-michael.christie@oracle.com/


--
Linaro LKFT
https://lkft.linaro.org
