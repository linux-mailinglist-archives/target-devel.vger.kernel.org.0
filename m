Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646834C3664
	for <lists+target-devel@lfdr.de>; Thu, 24 Feb 2022 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiBXUAA (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Feb 2022 15:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiBXUAA (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:00:00 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86E2763F7;
        Thu, 24 Feb 2022 11:59:30 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id m22so2956265pja.0;
        Thu, 24 Feb 2022 11:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=esSTEcxWYlmLPiSWhQ2VfsidNdEYUHFjatWC5lDvwME=;
        b=JKC3rWXT/VssfEuoTY2bAyZlMx8QEbsF/+agv+oa5zRwUVMnS+oIyOzpAfdxZXBWPS
         8lqAKGBrjTfOGsrUuAN5uHlRI0SopRKSKD9atTWkA+TSPc5x58yBP5+PQGPAXat/yJUe
         hB7/HGd19y6iBa2jdPlgT+V/Fm25+IkddhZC2wqMSYFZJ1t+EqdJ9QLYTZquNEjD5pv3
         QUOKoWX29ol58yXFFoBiXpMN3uU9Oou7UE1Ok+M9b+qGRs/zGFFVWbVnTMK/HbzKaEOP
         M8vniLbCIqZo6Qzs4aBcuhEy2aWt0os76vJmoWgxaofcP8QFF8eySyXALpoHDB3zKFR5
         WMyA==
X-Gm-Message-State: AOAM532aA8Bolz7pfhXpfWsoOeoEeq8zxA09sC43Ai0DDLYnrk+mJuPr
        Hba7At/NHV3+zUJu8RNQgdYMQGysSepDrQ==
X-Google-Smtp-Source: ABdhPJzeDm+bjC7Qr7a0yX3vCI+Uk6gyS7nas2k0g65/6PYg4Wro7UcVq9TH6BSOLLkvWZfi7WkqHA==
X-Received: by 2002:a17:902:70c4:b0:14f:9f56:1228 with SMTP id l4-20020a17090270c400b0014f9f561228mr3988093plt.114.1645732769532;
        Thu, 24 Feb 2022 11:59:29 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id s22-20020a056a0008d600b004f0eaa735f2sm311051pfu.57.2022.02.24.11.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 11:59:28 -0800 (PST)
Message-ID: <b9c43f2c-5888-41e6-a78f-355ef76121ac@acm.org>
Date:   Thu, 24 Feb 2022 11:59:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 8/8] scsi: remove <scsi/scsi_request.h>
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20220224175552.988286-1-hch@lst.de>
 <20220224175552.988286-9-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220224175552.988286-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 2/24/22 09:55, Christoph Hellwig wrote:
> This header is empty now except for an include of <linux/blk-mq.h>, so
> remove it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
