Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A584C42E1
	for <lists+target-devel@lfdr.de>; Fri, 25 Feb 2022 11:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiBYK4S (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 25 Feb 2022 05:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiBYK4S (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:56:18 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE51DAC4C;
        Fri, 25 Feb 2022 02:55:44 -0800 (PST)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4mlY4zTxz67vpG;
        Fri, 25 Feb 2022 18:50:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:55:42 +0100
Received: from [10.47.84.151] (10.47.84.151) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Feb
 2022 10:55:41 +0000
Message-ID: <d1448987-69cf-b37d-039b-507f642343f0@huawei.com>
Date:   Fri, 25 Feb 2022 10:55:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 6/8] scsi: move the result field from struct scsi_request
 to struct scsi_cmnd
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>
References: <20220224175552.988286-1-hch@lst.de>
 <20220224175552.988286-7-hch@lst.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220224175552.988286-7-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.151]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 24/02/2022 17:55, Christoph Hellwig wrote:
> Prepare for removing the scsi_request structure by moving the result
> field to struct scsi_cmnd.

Hmm..it seems that we are just using the pre-existing scsi_cmnd result 
field.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Anyway, FWIW,

Reviewed-by: John Garry <john.garry@huawei.com>
