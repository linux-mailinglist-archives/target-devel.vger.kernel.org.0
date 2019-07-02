Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4675D51B
	for <lists+target-devel@lfdr.de>; Tue,  2 Jul 2019 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGBRP7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 2 Jul 2019 13:15:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41102 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRP7 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:15:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so705716pls.8
        for <target-devel@vger.kernel.org>; Tue, 02 Jul 2019 10:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCDhPMiQa1Le+SJi4XXe1s1OFRdXhdDqYhBfwhgd86M=;
        b=V2iCzQP3fiW761BMjgwIK5hbHEAigQe68UptrsWI85c1FVpXcNdKIe8RUpdQGXWHww
         LR2BKgAgePGIEIwhKO04VxWzgVAXFOqFx0sXJv6fN7Lbd3GDqYxASDSYYFWKrc/uRWPZ
         hERp0tZYDawhnSuNzDDPIlmyzHGdsys7EpkvDRWsdA49u1gx+WJjcUAxUN/9OS0TPBm8
         ObeB8kNS8fqG/t4Lk0uCNnY7HHr5kasW6wqGV7owGKxh4LYRlfGirVbK5Mh8sQF5NW02
         SQaXNYbnP3Ap7xg83oGK2H15JcMI8TAc+aK35+M7n46iYGDiCCo4sDt/J/kAFKpFk9Wk
         qa8A==
X-Gm-Message-State: APjAAAUhm8wmkKBqDlnyCV1IH59RGa2qa3fImwjG+AsTR+3iVuHJ/9hx
        fhJa5EF9Q7TI4OUE/7KZTJI=
X-Google-Smtp-Source: APXvYqz8+7PPsjEOUifwweel9kIf0qAjS1LMMYGrtPPiCPWyGRj7494HKzmg5Of7w9STavQcDcsQkg==
X-Received: by 2002:a17:902:4283:: with SMTP id h3mr2920626pld.15.1562087758858;
        Tue, 02 Jul 2019 10:15:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x128sm38544714pfd.17.2019.07.02.10.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 10:15:58 -0700 (PDT)
Subject: Re: [PATCH 0/2] Use REQ_OP_WRITE_SAME to implement WRITE SAME
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Christie <mchristie@redhat.com>,
        target-devel@vger.kernel.org,
        Roman Bolshakov <r.bolshakov@yadro.com>
References: <20190702153031.3832-1-bvanassche@acm.org>
 <20190702162619.GA19142@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a2d20f62-2f2f-cf61-6ab2-38e7bf1caf72@acm.org>
Date:   Tue, 2 Jul 2019 10:15:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702162619.GA19142@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 7/2/19 9:26 AM, Christoph Hellwig wrote:
> I actually rather wanted to get rid of REQ_OP_WRITE_SAME entirely.
> Do you have a use case for this?

Hi Christoph,

I don't have a use case for this myself. I posted these patches because 
Roman Bolshakov reported a bug in the SCSI target WRITE SAME 
implementation. I think that means that he uses this functionality.

Bart.
