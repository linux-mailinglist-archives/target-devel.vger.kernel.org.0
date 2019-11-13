Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76193FB5E4
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 18:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKMRFU (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 12:05:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43320 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKMRFU (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:05:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id a18so1315653plm.10
        for <target-devel@vger.kernel.org>; Wed, 13 Nov 2019 09:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vq9vAnaNM7fAABba+X7tBRa8c1WMMFsYrj0YlWM3ko0=;
        b=SawPR9cB/18jmIqXqe3PjqZBwOsUUMhCaUrK+TpdbMfsPnEcDWEtZoFKQ2X5K0M73v
         t1MV7g/IED/xf+CechbaCL51eWgCA9ECuR7oqUJ6J3vMLbxFTynm2neOHexv2Vuw8ay9
         h35vbq9ySlzUXGxAwsQfZZrgwsKijYlJL22jXvLtEWCYHz4JGdcontuHrSS/XnuhatLc
         wTwRYxGbubuA3hdKCO02SUy5+YAg5mf3Jy6fiN3W9rrqsMcGTSP6jo8ohtc/KAYNspG4
         i98lRPTAJ4nxMmBLxTpx2mIK0z7PZZWPKGmItE9tW23BV9TxOSlojQsiJE+Z4EfW3XpK
         bQ/w==
X-Gm-Message-State: APjAAAXtwaslb5IibjYCBngiwlIHRnPHALr3D/Wr0vq5BvezUDyMIpKO
        eww0FigdZV8ns7KrBx1900bIr7KC
X-Google-Smtp-Source: APXvYqwU3V/9UGgYpUIKVGb1rwJ6/IlH7GEbYA5iFhDAVAsyqnPWu9aoiczXQD4wRP6oSsZHvtZC8A==
X-Received: by 2002:a17:902:7e4c:: with SMTP id a12mr4766947pln.219.1573664717622;
        Wed, 13 Nov 2019 09:05:17 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v17sm3854722pfc.41.2019.11.13.09.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 09:05:16 -0800 (PST)
Subject: Re: [PATCH 2/3] target/core: Fix a use-after-free in the TMF handling
 code
To:     Roman Bolshakov <r.bolshakov@yadro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
References: <20191112035752.8338-1-bvanassche@acm.org>
 <20191112035752.8338-3-bvanassche@acm.org>
 <20191113120249.bbzvld6yiwxpbobu@SPB-NB-133.local>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8e80dd8e-ae1e-1857-2b8c-0f5f341b4e4e@acm.org>
Date:   Wed, 13 Nov 2019 09:05:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113120249.bbzvld6yiwxpbobu@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/13/19 4:02 AM, Roman Bolshakov wrote:
> As far as I understand the change prevents backstore directory removal
> from TCM configfs when a TMF is processed and targetcli would start
> to fail sporadically as it tries to delete configfs directories only once:
>    https://github.com/open-iscsi/rtslib-fb/blob/master/rtslib/node.py#L228
> 
> Should we hold se_device device without preventing removal of backstore?

How about using config_item_get()/config_item_put() instead of 
target_depend_item()/target_undepend_item()?

Thanks,

Bart.
