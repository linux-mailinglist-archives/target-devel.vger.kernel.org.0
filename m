Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55C1F9698
	for <lists+target-devel@lfdr.de>; Tue, 12 Nov 2019 18:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKLRFj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 12 Nov 2019 12:05:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38018 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfKLRFj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:05:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so9675961plq.5
        for <target-devel@vger.kernel.org>; Tue, 12 Nov 2019 09:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZ8OsInf4PzPfPHVoiv1YTYtbofzPfwhO6DbATq07F4=;
        b=LWenE5QtQC9SK0biiHP8ZFPeGXr28P2+DGv/kQNnAG6JF1Q/0APQFp/vq5CZ+9Ga+4
         MfNwBGEvxb46YZQJOtNqsw5qnI7H9kzkcCwDGinGoSyHVq2bmAOrVBctr7dvXoH2LZ9U
         x5ALn9ORSqZ6mvvDF8oXxKyBGc/rQ10KlLn2Ib2sBSe4D8cQKBOdyX7dh90IjzevJsVZ
         KpipyOINOll5/Lk00sE/C31WAM2/UvU8s5+S2aNFRWt7h/ISCu51E76IQzgDPY6NUzfx
         N1MSyDbf+aKT3NLxoVCg78pwc47Z7b5t8SbvjDVuAterwUgJttK3F6oMuPWkgJ6u+4Ip
         xuLw==
X-Gm-Message-State: APjAAAUofNt/kZH8e6fqgbloGs+QVIMHTPeRZxJxHYoUxO7KWRKuJH81
        ODYkhMNpOFIWm1F40O5Lg2hw/nNE
X-Google-Smtp-Source: APXvYqzeInCs5pyB/g+YmX3e4Mtr444whxUhMkI6dzC8eZ8mvBco4x1fPSAjzzc0s77fno2LHUOq8w==
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr13932944pln.232.1573578337792;
        Tue, 12 Nov 2019 09:05:37 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l72sm3511148pjb.18.2019.11.12.09.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:05:36 -0800 (PST)
Subject: Re: [PATCH 0/3] Three reliability improvements
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
References: <20191112035752.8338-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fd927f32-2150-9c34-22f7-dc3e31db6bca@acm.org>
Date:   Tue, 12 Nov 2019 09:05:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112035752.8338-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/11/19 7:57 PM, Bart Van Assche wrote:
> The three patches in this series fix the complaints that were reported while
> running the libiscsi test tool against the SCSI target code. I'm not sure why
> I hadn't noticed these issues before - maybe new tests have been added to the
> test tool. Please consider these patches for Linux kernel version v5.5.

This is the second version of this patch series. The changes compared to 
v1 are:
- The patch that declares target_release_reservation() static has been 
left out because a patch in this series introduces a call to that 
function outside the file in which that function has been defined.
- The patch for releasing SPC-2 reservations has been reworked as 
requested by Roman.
- Two new patches have been added.

Bart.
