Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73844595716
	for <lists+target-devel@lfdr.de>; Tue, 16 Aug 2022 11:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiHPJvi (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 16 Aug 2022 05:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiHPJvP (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:51:15 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF9103C63
        for <target-devel@vger.kernel.org>; Tue, 16 Aug 2022 01:12:44 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id NrgXoquoiGDTnNrgXo13bw; Tue, 16 Aug 2022 10:12:26 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 16 Aug 2022 10:12:26 +0200
X-ME-IP: 90.11.190.129
Message-ID: <b6025226-4fcd-1d82-60eb-301734cc8e5a@wanadoo.fr>
Date:   Tue, 16 Aug 2022 10:12:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] scsi: target: Save a few cycles in
 transport_lookup_[cmd|tmr]_lun()
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael.christie@oracle.com" <michael.christie@oracle.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <03705222390bfa3b48ad7658f693fc0fc030b3ae.1660596679.git.christophe.jaillet@wanadoo.fr>
 <757f1326-bc70-aa93-b2d3-dfd91698406e@nvidia.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <757f1326-bc70-aa93-b2d3-dfd91698406e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Le 16/08/2022 à 08:06, Chaitanya Kulkarni a écrit :
> On 8/15/22 13:52, Christophe JAILLET wrote:
>> Use percpu_ref_tryget_live_rcu() instead of percpu_ref_tryget_live() to
>> save a few cycles when it is known that the rcu lock is already
>> taken/released.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
> do you have a quantitative data that shows actual savings of cycles?
>
> -ck
>

Some numbers were given for io_uring by the one who introduced 
percpu_ref_tryget_live_rcu().

See [1].

I don't have specific numbers for the patch against scsi.

CJ


[1]: 
https://lore.kernel.org/linux-kernel/cover.1634822969.git.asml.silence@gmail.com/

