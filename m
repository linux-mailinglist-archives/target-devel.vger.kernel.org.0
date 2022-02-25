Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D24C42FB
	for <lists+target-devel@lfdr.de>; Fri, 25 Feb 2022 11:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiBYK77 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 25 Feb 2022 05:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiBYK76 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:59:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B722F977;
        Fri, 25 Feb 2022 02:59:25 -0800 (PST)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4mw95GCMz683wp;
        Fri, 25 Feb 2022 18:58:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:59:23 +0100
Received: from [10.47.84.151] (10.47.84.151) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Feb
 2022 10:59:22 +0000
Message-ID: <b7b9c439-4259-1821-dbff-9e4f69820894@huawei.com>
Date:   Fri, 25 Feb 2022 10:59:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 7/8] scsi: remove struct scsi_request
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>
References: <20220224175552.988286-1-hch@lst.de>
 <20220224175552.988286-8-hch@lst.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220224175552.988286-8-hch@lst.de>
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
> Let submitters initialize the scmd->allowed field directly instead of
> indirecting through struct scsi_request and remove the now superflous
> structure.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Bart Van Assche<bvanassche@acm.org>

FWIW,

Reviewed-by: John Garry <john.garry@huawei.com>
