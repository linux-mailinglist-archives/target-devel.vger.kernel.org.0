Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3236CC825
	for <lists+target-devel@lfdr.de>; Tue, 28 Mar 2023 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjC1QhD (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 28 Mar 2023 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjC1QhC (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:37:02 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B1AF1C
        for <target-devel@vger.kernel.org>; Tue, 28 Mar 2023 09:36:11 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id ga7so12493490qtb.2
        for <target-devel@vger.kernel.org>; Tue, 28 Mar 2023 09:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZR6cbXQdwB5nUHvEEH2VeiB5R9CC8hRiYSzmgcjAyg=;
        b=6InBOou/hOaSp1aci98aQ1dYK60WmpP4xsUVouoBiZhXVdNmjBc4wjb/YzX1lTTFqe
         6uV20eVdHJnWjaU91NI7sUbVMiy72k4CCAq/5mbiQO7x+CaNcRP2NcE4M4QB9F2+sX6/
         yrmtG75Qi8NikTKF0lKghaSNXSdfXUVc/TBXLK7b01gKCczhymSGMsGHr0XGvyEDWrk3
         T6XqYpFLU04rDDP+tz6HzVs0bPVWygsSnPA2hPrvAOxNU5SMEncvwAC0EZCWkVHoXq/x
         U08YxSbeQiCTbRunJtgREJCxgQZP1fP4gGIqPDfyZ3ulaV/q2KrBepUJDkJZh8fLbAKf
         pAiw==
X-Gm-Message-State: AO0yUKUmD1gURvT1k9dCrM+dj2l6IFiMhraH54i4o+lbrSaJ3wPLgJX1
        1Y80lkAGKZkuBg81JJdsxOFt
X-Google-Smtp-Source: AK7set8/4ablYvt1w3rWWxBu5RP3Per1gtZi0bV85eHN9m6lD3okcPGkDhxHJ2UAhi56YjYdObx6pQ==
X-Received: by 2002:ac8:7d46:0:b0:3e3:95fb:8771 with SMTP id h6-20020ac87d46000000b003e395fb8771mr28046888qtb.31.1680021371021;
        Tue, 28 Mar 2023 09:36:11 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id t23-20020ac865d7000000b003b635a5d56csm15765739qto.30.2023.03.28.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:36:10 -0700 (PDT)
Date:   Tue, 28 Mar 2023 12:36:09 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 01/18] block: Add PR callouts for read keys and
 reservation
Message-ID: <ZCMXecSrJ97oCD+s@redhat.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
 <20230324181741.13908-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324181741.13908-2-michael.christie@oracle.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Mar 24 2023 at  2:17P -0400,
Mike Christie <michael.christie@oracle.com> wrote:

> Add callouts for reading keys and reservations. This allows LIO to support
> the READ_KEYS and READ_RESERVATION commands and will allow dm-multipath
> to optimize it's error handling so it can check if it's getting an error
> because there's an existing reservation or if we need to retry different
> paths.

Not seeing anything in DM's path selectors that adds these
optimizations. Is there accompanying multipath-tools callouts to get
at this data to optimize path selection (via DM table reloads)?

Mike
