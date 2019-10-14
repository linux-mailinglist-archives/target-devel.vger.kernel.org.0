Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A40D6B60
	for <lists+target-devel@lfdr.de>; Mon, 14 Oct 2019 23:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfJNVva (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 14 Oct 2019 17:51:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38654 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfJNVva (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:51:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so3908411pgt.5
        for <target-devel@vger.kernel.org>; Mon, 14 Oct 2019 14:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vdT2jhyFglXILciuRScXUtHnQzj9rFOfHhQQtpbvbnw=;
        b=VK49KRE+qyE0IiQA7UBKP0pfWhi1pp0m4frUqFv0yaO+yR144dhEZeEMojXCIzB6+B
         n9u60jX5zJre0jvx6zZuZhhFGMpDhvXvi8RMNM/GMgDccYAU9McFGXXp8Om1DHOiMtRm
         SU9Yym1Hu5h4Q+qNNEqqcgsZQWGP64YUPAvrZavedfCdlKU7rlDaVbr/Wg5y8Z4slAQo
         tFFVoULlpGIFN1JbV9M4/YLQ66k9yvjfulNN9fMz8hvD3IStAhRLJakrH2s4+F4towDF
         q/Pwv/zoQMu3iNK1z4wJMsgptFT1Vv00/e3zlPtFlhyuxwrVmnG94Ro5klHMc1qcSI3b
         ArYw==
X-Gm-Message-State: APjAAAVBqSWZuhDdfx9cBLnnUs3oe/lf7xF8/6PtQ5dzhYLa12R1qu9Q
        J2o00vrbud2b+2+DfEykaQo=
X-Google-Smtp-Source: APXvYqymae0YvAbalLVm+z+cGpMT/ApLc+lCNr4UA0is9CkPIBoxs9V3l66LZFJPhoe27oHSXk3M0g==
X-Received: by 2002:a63:1f48:: with SMTP id q8mr16494763pgm.215.1571089889565;
        Mon, 14 Oct 2019 14:51:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u65sm12957870pgb.36.2019.10.14.14.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 14:51:28 -0700 (PDT)
Subject: Re: [PATCH] target: do not overwrite CDB byte 1
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Cc:     Mike Christie <mchristi@redhat.com>, Hannes Reinecke <hare@suse.de>
References: <12498eab-76fd-eaad-1316-c2827badb76a@ts.fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <623feb9c-cca8-621c-849e-3e7702f00782@acm.org>
Date:   Mon, 14 Oct 2019 14:51:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <12498eab-76fd-eaad-1316-c2827badb76a@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/14/19 11:29 AM, Bodo Stroesser wrote:
> passthrough_parse_cdb() - used by TCMU and PSCSI - attepts to
> reset the LUN field of SCSI-2 CDBs (bits 5,6,7 of byte 1).
> The current code is wrong, as for newer commands not having the
> LUN field it overwrites relevant command bits (e.g. for SECURITY
> PROTOCOL IN / OUT)
> We think this code was unnecessary from the beginning or at least
> it is no longer useful. So we remove it entirely.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
