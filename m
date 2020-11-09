Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0502AC8A3
	for <lists+target-devel@lfdr.de>; Mon,  9 Nov 2020 23:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgKIWcf (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 9 Nov 2020 17:32:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729451AbgKIWce (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604961154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ilWn6M2YeSNAy1OjrKgETUEYS6rW9P62pTXErbsPxXU=;
        b=cFMO4r9FSW76m+kcc4Khvu1eo9mixpaStn54MZBqq3JNALIXExMCBe1QYXjw3lJ2e8NhVz
        QU6XIvHBuwK6kWsI2Llq8/dJKV6pjK9K3RQeK9iWGlpEa04Ve0gF7UVItzns9ctdAQxVAd
        JRutEibOoAHqN2SS14dSe0PqOPJSNvs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-r5SB0jBmPICf0KetENGeBw-1; Mon, 09 Nov 2020 17:32:24 -0500
X-MC-Unique: r5SB0jBmPICf0KetENGeBw-1
Received: by mail-wr1-f71.google.com with SMTP id f11so4871127wro.15
        for <target-devel@vger.kernel.org>; Mon, 09 Nov 2020 14:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilWn6M2YeSNAy1OjrKgETUEYS6rW9P62pTXErbsPxXU=;
        b=ksMCEFF20oJMPZ6zKmpRJYOz5/fmzJnVwuftt0OQumswe34MFh046DMCJj+8ohUNTA
         A5Vsfqy67KHt2WLP9UMJ9AoJdD/Up5FzAk8yC26Q98k3HqEWo74ZeaLzYIrCHbJGZl2o
         hw1DSDCJAHtDmLIg8Xyl7IcgdRrRcWa27w/Y8tBgK3LT0tKlOqKbmXWJJRX+wBcvewg2
         vnG8X3xYKkvNc2m7knFH0N8hgCiKgGTfphYIBI4k8SWWLZdI3kgJMmcy2xZ000hDNzV7
         PK8gHYq914uro7Eqe8tri8j2dQCnvXK+5WDbNKhU/ldUNZ+J93zbqtIPPj1EvzSWd/Mq
         PTCA==
X-Gm-Message-State: AOAM533BOZJEX49O/Kg0mRjntv7F4b+h1O4w6Lm8Vj3gV1yNLaxyJONT
        Kry59MPUqEULFShZmHg4KPpeHtOWmziSQLCJXfq7bYV5v3D95zcbgqUzGUqiT4+JghtDj7oOFr5
        LPI5FEThqLViM3iQ1OGhKWi1l
X-Received: by 2002:adf:9544:: with SMTP id 62mr20108966wrs.223.1604961143332;
        Mon, 09 Nov 2020 14:32:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyh47AqupUQogPqD176lZqagmPngj1Pmkx6eJjzzl/nhQE8xwUWQt+djiOvPwM7ngtjJEbr0g==
X-Received: by 2002:adf:9544:: with SMTP id 62mr20108951wrs.223.1604961143173;
        Mon, 09 Nov 2020 14:32:23 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id y185sm841543wmb.29.2020.11.09.14.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:32:21 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:32:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 06/11] vhost: support delayed vq creation
Message-ID: <20201109173058-mutt-send-email-mst@kernel.org>
References: <1604528804-2878-1-git-send-email-michael.christie@oracle.com>
 <1604528804-2878-7-git-send-email-michael.christie@oracle.com>
 <56056e8d-d6ff-9a6e-2a7e-1ea1737b1d27@redhat.com>
 <54285b79-637e-3dcd-382f-ddeff44f6019@oracle.com>
 <fc22b679-08c1-85bb-515a-8f63de7148a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc22b679-08c1-85bb-515a-8f63de7148a2@oracle.com>
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Nov 09, 2020 at 02:30:36PM -0600, Mike Christie wrote:
> On 11/9/20 12:41 PM, Mike Christie wrote:
> > 
> > If you want to pair this patchset down to it's bare bug fixes that
> > prevent users from getting IO errors, I would do ring.addr check only
> > approach for this bug fix patchset.
> 
> Oh yeah, just so we don't have to burn an extra day, above I'm proposing I
> repost the original patchset:
> 
> https://lore.kernel.org/linux-scsi/1600712588-9514-1-git-send-email-michael.christie@oracle.com/t/
> 
> for the bug fix only patches. It will have the compile error fixed and
> Bart's comment handled.
> 
> To even trim it down more I can also drop the last 2 patches:
> 
> 0007-vhost-remove-work-arg-from-vhost_work_flush.patch
> 0008-vhost-scsi-remove-extra-flushes.patch
> 
> and send separately in a cleanups patchset since the extra flushes it kills
> don't really hurt.

Makes sense to me.

-- 
MST

