Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E590C40C5B6
	for <lists+target-devel@lfdr.de>; Wed, 15 Sep 2021 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhIOMxa (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 15 Sep 2021 08:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhIOMx1 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:53:27 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E32C0613C1
        for <target-devel@vger.kernel.org>; Wed, 15 Sep 2021 05:52:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso3449438otu.0
        for <target-devel@vger.kernel.org>; Wed, 15 Sep 2021 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwNaLwKA2of+DfbS4aeSMkDxKF6EVrxSWjkKLx+FQew=;
        b=AjebiobECjpg93+DFIVszP/9YpQLKyHjDCTFBucvyXusePtQDL90KisFIxndE8VC5H
         2xchnvGsUVSYGz8GKgh/DXQJtJJFL2RQobCERPeJwYleYXtYssetJPGM+dmeus6WtuNM
         cTb/PGobv0SBYjZBOlgfeMEK+m+hNZmdCOtMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwNaLwKA2of+DfbS4aeSMkDxKF6EVrxSWjkKLx+FQew=;
        b=ZcSGk6VApXDyUaE07e8Ajadr3pSIIRC2XFj4r27C1Iv4FMolN8WgcMGw5cs6zdkI9/
         Lfn3BVzzG0XrXhTeZu6yDSkeWruzaS41GqTqDEEu0uLnEzfpYzr9G1f/8JzTyLdMAJrp
         9fWW2l3Ozrr/HUlSyf/M+4+gjgId7JbZ6PguhArlFvQ+4jj4qVP3Kn6De3Y/PLMPZReM
         LaNKXAUzv8fjgMshUuneyWHCr0lFxeF2AgS/uinopM+sw6F1Pdwy76t1cs4amnzPxjY1
         vqgPPzxfKPMzykgc9f8BG/MGwsWOHwGPp1DKyO69R7ADv3ORKauXeli/V+uRRgYSPuJF
         FYLA==
X-Gm-Message-State: AOAM533yZrJUcrgyuDxzHS6OX8TnGUPw2miGPboNK3vWEcpk/uYNQNMk
        +xrJ4t1nKvK6+JaqGrv7/o40exfsrParag4I5GDw4/Lr3sGsrIKmbi65Z3BA5Q7wtyiVlR5BkyI
        8a1p4aSnUjhLWCA3CbA8quwY4fkS2SdQ=
X-Google-Smtp-Source: ABdhPJxnnR0QK6qMtREl+SinVJ6xtl8n4XV3T7gatXTeMwM1yJ02AgZhA30JFKYV0D6H8u+XrHDNnnum+EPoBxiIANc=
X-Received: by 2002:a9d:4e0f:: with SMTP id p15mr19229838otf.328.1631710327498;
 Wed, 15 Sep 2021 05:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210914105539.6942-1-d.bogdanov@yadro.com> <20210914105539.6942-4-d.bogdanov@yadro.com>
In-Reply-To: <20210914105539.6942-4-d.bogdanov@yadro.com>
From:   Ram Kishore Vegesna <ram.vegesna@broadcom.com>
Date:   Wed, 15 Sep 2021 18:21:56 +0530
Message-ID: <CAF7aS0q-us5evJUeN4ic-mvur-EnTQD7FFQO4+fFy6=2c2RQPg@mail.gmail.com>
Subject: Re: [PATCH 3/3] scsi: efct: decrease area under spinlock
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     Martin Petersen <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux@yadro.com, James Smart <james.smart@broadcom.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000082ff5405cc082a19"
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--00000000000082ff5405cc082a19
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 14, 2021 at 4:25 PM Dmitry Bogdanov <d.bogdanov@yadro.com> wrote:
>
> Under session level spinlock node->active_ios_lock in
> efct_scsi_io_alloc() there is a getting other spinlock of port level.
> That lead to competition between sessions and even between IOs in the
> same session due too much instructions under spinlock.
>
> This change reduces spinlock area just to active_ios list for which
> active_ios_lock is intended.
> Spinlock CPU usage is decreased from 18% down to 13% in efct driver.
> IOPS are increased from 220 kIOPS upto 264 kIOPS for one lun on my setup.
>
> Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> ---
>  drivers/scsi/elx/efct/efct_scsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/elx/efct/efct_scsi.c b/drivers/scsi/elx/efct/efct_scsi.c
> index 40fb3a724c76..8535bb7eabd8 100644
> --- a/drivers/scsi/elx/efct/efct_scsi.c
> +++ b/drivers/scsi/elx/efct/efct_scsi.c
> @@ -38,8 +38,6 @@ efct_scsi_io_alloc(struct efct_node *node)
>
>         xport = efct->xport;
>
> -       spin_lock_irqsave(&node->active_ios_lock, flags);
> -
>         io = efct_io_pool_io_alloc(efct->xport->io_pool);
>         if (!io) {
>                 efc_log_err(efct, "IO alloc Failed\n");
> @@ -66,6 +64,7 @@ efct_scsi_io_alloc(struct efct_node *node)
>
>         /* Add to node's active_ios list */
>         INIT_LIST_HEAD(&io->list_entry);
> +       spin_lock_irqsave(&node->active_ios_lock, flags);
>         list_add(&io->list_entry, &node->active_ios);
>
>         spin_unlock_irqrestore(&node->active_ios_lock, flags);
> --
> 2.25.1
>
Looks good. Thanks.

Reviewed-by: Ram Vegesna <ram.vegesna@broadcom.com>

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--00000000000082ff5405cc082a19
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Vxab43fOCbFozIOlzutBV4fhpWlA3FrVNhbPhbwO398TsV3gUkYHkxoS9kLeRXHnNcdOcFMo8Maz
mQF6P67d881N/0Tt0k0MfXGTHytZvfFdayivzlL9nAnyXTzPFU8CAwEAAaOCAdkwggHVMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
IwYDVR0RBBwwGoEYcmFtLnZlZ2VzbmFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFJYz0eZYF1s0dYqBVmTVvkjeoY/PMB0GA1UdDgQWBBQt2m9JVe4cejFw9Mog
spXwL7sKWzANBgkqhkiG9w0BAQsFAAOCAQEAARwXxUTPdWpdSOs12BsNVMRlHdaahp3UNv1LW20i
ps55UslOtXjHiznNQr5nyhmnkH0TLxn12NGEV0BnOmb70Ml2klfFLXTw73cp/mxM2eOZX5ho+f8v
TuqwzxbJ+WAoFHzMJfevy9SEdovoE1TeBhc+IgZQR3zCkMt00bsKvKD0SmgNKiSmkHr+WbJCjCq7
tlkydEDuGjuSfbNzIcS0qLpqIHaSh/3WmF7TWzBJ8Ln1HwrvuMZ3Txksjsmpt34GFSubX+CGrYyW
ORNGomSiW66FqRvj0iaYYbNTIfnU7/iJy3CN8Z5SvVroNAQbRfoooT/loWsoiUUNmTR9kebvLzGC
Am0wggJpAgEBMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAv
BgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAyIENBIDIwMjACDCHWmFjgp1UN
rBuhLTANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgdtnCLy/v3dpCnwFFumoUaCE6
QiF8qp4Bin3htpPI5ycwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MjEwOTE1MTI1MjA4WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYw
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZI
AWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJwDMMnK4/Z/IOFCERn8n6xAqi5TFc3KqJNkGRiK3QH8
VQpCCe81pYacYaifyaCJbSHJQe13OXxNYH4sCP3UboBiBEv1bNKCG4mNLST10H8u6VEcH5IzGwSd
TXK7QGAsBJS93eYs6KovvBIaDLaGZanRuRuUIFbfGxTOo0rJ6QykMn4cttU/Dax8AcraxxftTAcQ
PA1LFX7yIVj7VSnTVwDj8tMDgonv9wf9nxazs5x2AyinBIYr+BFAiv7RM3By6FL7yYEvEq6CNjfq
pgI4k/yAH8P4FKNIazdp58J96k1edFGNJA21vAmu0ZQyIb9D7By732oaXyqTe6QgU7adGFU=
--00000000000082ff5405cc082a19--
