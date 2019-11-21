Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3361047E3
	for <lists+target-devel@lfdr.de>; Thu, 21 Nov 2019 02:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKUBLR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 20 Nov 2019 20:11:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37349 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUBLR (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:11:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id e187so1667599qkf.4;
        Wed, 20 Nov 2019 17:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UJFKLDUAQ8Rl8GVeE/OPZCBt930RD+KxHstB2Zo/uAQ=;
        b=p6Xi+7VVrIHmB8HPGfu454P5KQjU43bXsqwi+m69TNTRPUT2PHrnPolPjKIWhV26AF
         /gvykCKjEAlT2LbdK+rP6FL+g/B9/oz0XtJ0bFLHyy9ndM2sRPMYx+KCHKbKvmRsztlx
         X6gkBhZtSpgNNYlHSnDVZwVtfRZbF9WZd6pML4+WBUbYskLP4pJmR35FIjYs/r0fz/wL
         cbELRYMjkM0wszm81D9KuHU69h3Z4R36L9PgCcLhC3uG2J+o24jHIHrtZvfvDUpW7omP
         7BH4HTInogadcMnF0bIzQYAkKO2OXA4cZdzYmrUcIVTD1+9mCAmlNM5A+vzWTm0gfyTR
         cZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJFKLDUAQ8Rl8GVeE/OPZCBt930RD+KxHstB2Zo/uAQ=;
        b=AnrWFk5TNlyoi9zIdCHkRX/mPkKuU542vn4tdXepMxMEMCbeoSpSsdCJSq+X/g/BOQ
         e5dZlxBhtCsKICJafn65hxrjNcB5c508kETaN0ibMq8dlSv7KvkB3NxbGR6MopLD42uO
         XhH8ry2Lst/DSPRUshtSy8daAO1ROCvZfXW9d7ZczLaPSK5CvBscIxbcbdVhct+jGwfp
         5oEzqc/nqZEd6DD2niOR8MjdCDrT0qAnc1guW3NY8DOxSEpUNM6YgFxV5NSCdro1uhMo
         yWJ/fcqSdnPFVVqZaJvDMm+g97bTy6OpeR7NelKry2ooF+/Modyck3MedaYjaq2nwk8H
         ylhg==
X-Gm-Message-State: APjAAAXnTVtANq8oenQYaIUCKelgQtXE5FlRAgKBWJ4znSM8qNrpgDVF
        mKZ/vBI6h9r6o9D00rioTj0=
X-Google-Smtp-Source: APXvYqwNltaIrGVK57zRdlaae+SFzuUMZiWSy3/3CX8CUcs8ZplIM9A0GvHbAXtgKY+t4Q3FH0VOPQ==
X-Received: by 2002:a05:620a:536:: with SMTP id h22mr5451203qkh.480.1574298675918;
        Wed, 20 Nov 2019 17:11:15 -0800 (PST)
Received: from oc6857751186.ibm.com ([2601:1c2:1b7f:e860:c35a:1d95:8a0f:9ad0])
        by smtp.gmail.com with ESMTPSA id m186sm613335qkc.39.2019.11.20.17.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 17:11:15 -0800 (PST)
Subject: Re: [PATCH] scsi: ibmvscsi_tgt: Remove unneeded variable rc
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        mikecyr@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <20191101120407.GA9369@saurav>
From:   Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <25de88a9-b013-f5cc-06c2-3efb1f3f0001@gmail.com>
Date:   Wed, 20 Nov 2019 17:11:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101120407.GA9369@saurav>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/1/19 5:35 AM, Saurav Girepunje wrote:
> Variable rc is not modified in ibmvscsis_srp_i_logout function.
> So remove unneeded variable rc.
> 
> Issue found using coccicheck tool.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>

