Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877FBD0232
	for <lists+target-devel@lfdr.de>; Tue,  8 Oct 2019 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfJHUf7 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 8 Oct 2019 16:35:59 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45974 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJHUf7 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:35:59 -0400
Received: by mail-pg1-f171.google.com with SMTP id q7so10896113pgi.12
        for <target-devel@vger.kernel.org>; Tue, 08 Oct 2019 13:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHuu6A1u8Uv02xU+/niF5UjS+tVFOR9OiKflFZ7NtZA=;
        b=hlUfaJqxXAMdJ/4tsiJzPtRlrw8jcMnS8UwQ/QscDuddVoAm0ITvVna/5Cgpg7bkbs
         q00rylZNSF4YmsvuiQ15HaeJjS2qWkkST0GrNQTzXtV/68NKrQYol2jJ+yfHA0pPrMm3
         3+eEuqiIhJ0hCJaq4L4mWJMDEoaxYlshjb6z3SLcqJFCI8C6AyuK/dA6EkxgYXq85QPv
         jqeNVEMmd3VLeYNjK3lm8+VVDa016j4aXqGOnlGlNQAWu94/j4/JssK/icaq8bh7pb72
         TlHBFzEBpN3rXz69OFDzIgT762emyzgDFwAK0dDVRRTYm6stmXmdHlbvFwRmZSOtzozM
         M7yw==
X-Gm-Message-State: APjAAAU26Dz/a9sxKiF7HoRyISnFBiE65Ak/fxlYhXiswo2Ahjto5Y4L
        RxBWj0jT+ayvkL3uxy9X8YvHedSo
X-Google-Smtp-Source: APXvYqyCW+rkGB64XYQTGsBB64zZtF8UhEEwFOj2wVqa3wkJI109kAHZ/i5LR8axEivK9JXVBZ70YQ==
X-Received: by 2002:a65:4942:: with SMTP id q2mr268602pgs.315.1570566958119;
        Tue, 08 Oct 2019 13:35:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q2sm12077pfg.144.2019.10.08.13.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 13:35:57 -0700 (PDT)
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     "bodo.stroesser@ts.fujitsu.com" <bodo.stroesser@ts.fujitsu.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Mike Christie (mchristi@redhat.com)" <mchristi@redhat.com>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <df214af8-a12a-205f-4627-d881b0960bd5@acm.org>
Date:   Tue, 8 Oct 2019 13:35:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/8/19 1:20 PM, bodo.stroesser@ts.fujitsu.com wrote:
> 3) Remove the code entirely, because it is no longer needed / useful (?)

I'd like to hear the opinion of Mike Christie. My favorite solution is 
(3) because I think the days of embedding LUN numbers in CDBs are long 
behind us.

Bart.
