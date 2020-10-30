Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5552A0AA7
	for <lists+target-devel@lfdr.de>; Fri, 30 Oct 2020 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgJ3QET (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 30 Oct 2020 12:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgJ3QET (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604073857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOY0se4WQ8x55VAXnO7UrS7S0TCfPfbJZdpu+fnITnI=;
        b=WXskK6t7FRAtMsIY0YJqykjRb+gsvb5m476JG/ytxsPzL3VYusaBnK8cFGUtQKyD/scch8
        6x4g6s/mDLVpnXfRhkU7vPES0Hv/Q5Me+pcr4ARSpffIQX/s/Ze3z2XyvkeDoldzD5lgKe
        w8yHS3U0xLPd4NQrYOdd1Mmq899zTMI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-H2m06cMPMbqZYErYYcvCEA-1; Fri, 30 Oct 2020 12:04:16 -0400
X-MC-Unique: H2m06cMPMbqZYErYYcvCEA-1
Received: by mail-ej1-f70.google.com with SMTP id gr9so919508ejb.19
        for <target-devel@vger.kernel.org>; Fri, 30 Oct 2020 09:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZOY0se4WQ8x55VAXnO7UrS7S0TCfPfbJZdpu+fnITnI=;
        b=XUiPQ7q7aPb7iHJUGWgOlIJ1aEYMZO1l+Rw6US12W3zAd5tiJfzPhjKk7eg2yvsdLa
         wlEcw8mddJM/fcGc9JpA6XlQ/5ri9/FPdf8ptOLNPEOvvBDhYq8mgSarAqyhPdYWfUM1
         myFpJoDeKBj48/KGY2uK7oWYXT6732slVDDLTtDShgPD/VIqgNv7/0DvzJlwMfnglcUU
         dOOKgIsi9Q6Th8Y2lmXl+M+3nkaEY5m17wW2ibN0QIj7q0J7OULuWgEPCKAx74m/U8Ie
         FawP4mz8AGiTy/U7EafUI80VrUWj9IfCpbWjJ09mlwd8fLZheU3RuL9ND98iKe+GbJCb
         uWVw==
X-Gm-Message-State: AOAM533Wb58yKMGwpZaAYsWjsalydiKmXFZSooi8HhfTptbksRxBRO/V
        u6IbTPVhNY6XY2c9+LinZoxE1bJYQmtURLBcUM7Dhpdb8cSqPKw4f1IKLJcy20+vTxn1iTtJUKA
        rXzwRaK+xKG4uFWoyeHfMsUek
X-Received: by 2002:a17:906:7844:: with SMTP id p4mr3180817ejm.26.1604073854716;
        Fri, 30 Oct 2020 09:04:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1LhBtUe4RfD7vdz6T+WU0b0bdIKVll+yCKX7zLk8O+pUhvNlQ2Df5Opp8ngLp1ngs7C94iQ==
X-Received: by 2002:a17:906:7844:: with SMTP id p4mr3180802ejm.26.1604073854514;
        Fri, 30 Oct 2020 09:04:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h26sm3266273edr.71.2020.10.30.09.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 09:04:13 -0700 (PDT)
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, jasowang@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-10-git-send-email-michael.christie@oracle.com>
 <20201030045053-mutt-send-email-mst@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/17] vhost scsi: fix cmd completion race
Message-ID: <5c319f1a-cf4c-f522-ecde-5b6b5a2e1ddd@redhat.com>
Date:   Fri, 30 Oct 2020 17:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030045053-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 30/10/20 09:51, Michael S. Tsirkin wrote:
> On Wed, Oct 21, 2020 at 07:34:55PM -0500, Mike Christie wrote:
>> We might not do the final se_cmd put from vhost_scsi_complete_cmd_work.
>> When the last put happens a little later then we could race where
>> vhost_scsi_complete_cmd_work does vhost_signal, the guest runs and sends
>> more IO, and vhost_scsi_handle_vq runs but does not find any free cmds.
>>
>> This patch has us delay completing the cmd until the last lio core ref
>> is dropped. We then know that once we signal to the guest that the cmd
>> is completed that if it queues a new command it will find a free cmd.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> 
> Paolo, could you review this one?

I don't know how LIO does all the callbacks, honestly (I have only ever
worked on the virtio-scsi driver, not vhost-scsi, and I have only ever
reviewed some virtio-scsi spec bits of vhost-scsi).

The vhost_scsi_complete_cmd_work parts look fine, but I have no idea why
vhost_scsi_queue_data_in and vhost_scsi_queue_status call.

Paolo

