Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0A1B536E
	for <lists+target-devel@lfdr.de>; Thu, 23 Apr 2020 06:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDWEYn (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 23 Apr 2020 00:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbgDWEYm (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:24:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB33FC03C1AB
        for <target-devel@vger.kernel.org>; Wed, 22 Apr 2020 21:24:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so5116332wrg.11
        for <target-devel@vger.kernel.org>; Wed, 22 Apr 2020 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoKoc1x3BmhWfv5xtnmkSfyZUB4n6vZHsSH2ElNirok=;
        b=uyZ024KU6rq0ZpfTCb+oFhzZK/QNTtyXSZ9f4b0dJWwzMNPSjsCkuRHE2ndsOFUBNA
         wz8qbs+XYwwYZCcyEtN1Cma2pogeMlS7MuBq/jc4AFDChaWvbpMLWvv9Zpf7MoFzjoc5
         pUJejdE+cNEqpo2GrxRShCrjQSHgthY5r2WQbH0ymnqQdk4XFVRpPC2vMdqcfKk0TR2V
         gzN1e2ErNg3KdqI7YE8HoBFfD0OkYYQJg2d8fLqBlZouu0JYCYZT3z6m6yzahGseDQnd
         8fOjH8Y3xRicNJ+AYKX3R8obLrE6bM89Okkj5//nyQvCt1Pl2lY7rxcBfGYKWyFI9JP9
         5exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoKoc1x3BmhWfv5xtnmkSfyZUB4n6vZHsSH2ElNirok=;
        b=fJg5/WZiL4ukAwhayVy4OF2gpmid7HYjYeTO0WYV1RygB6P7v51n0NA3l3hVVIq9JY
         EpvF8CWoRKRLafA8hC5ahwoptRtsVVvQljVtVhNxMIzgWOOOAoL9Z4jvZw9pTXabIntE
         0gWea+tvJG+fxVrtF5RSWGi41JdFvNjVJXnLJQuRfVJFsvW3K1djjFaY0YtyAUYRiNdD
         mifzkdrUYhgtmk8wauQBAM4soi7qblFm4dEKEJPYxY8a54VTbBNp17v9Om9qXn70NUog
         xDZoAoKfvsMSGg9PXOFPcqCbvDmok2pBPDYEUQiyxUH1WogEtz5b3eVYRPuAwi84QWg7
         JVGw==
X-Gm-Message-State: AGi0PuZ/Lhs6sS833NDOqPAXdPCLk5p3jISu8+Yvai74TmGbvGOtqJOo
        ZUot8G83gykv2AZHDPN0Bx3kDFLHNuligdXJXRVzPg==
X-Google-Smtp-Source: APiQypK8FnYOyS/1mCFY0CAunNStVW+7O7ABY6wHWrqUOLY5jAEtYKr1g0x4rtqg/aTWAwIGDQRLXpI/r4ecJF1VlZY=
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr2465532wrn.89.1587615879638;
 Wed, 22 Apr 2020 21:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200415080819.27327-1-houpu@bytedance.com> <20200415080819.27327-2-houpu@bytedance.com>
 <54e574b1-10b4-4385-11fb-773ef152fc2c@redhat.com>
In-Reply-To: <54e574b1-10b4-4385-11fb-773ef152fc2c@redhat.com>
From:   Hou Pu <houpu@bytedance.com>
Date:   Thu, 23 Apr 2020 12:24:28 +0800
Message-ID: <CAO9YExv2kWp=x+mMaWeOrYmu4c6gTu0PeBSkOwHgr7ZW9MywSg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] iscsi-target: fix login error when
 receiving is too fast
To:     Mike Christie <mchristi@redhat.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

> > +     /*
> > +      * LOGIN_FLAGS_READ_ACTIVE is cleared so that sk_data_ready
> > +      * could be trigger again after this.
> > +      *
> > +      * LOGIN_FLAGS_WRITE_ACTIVE is cleared after we successfully
> > +      * processing a login pdu. So that sk_state_chage could do login
>
> I think we need to drop "ing" from processing and do:
>
> process a login pdu, so that sk_state_chage could do login
>
Sure. Thanks for helping me with my language. ^-^
Will change this in v2.
>

> > diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
> > index 591cd9e4692c..0c2dfc81bf8b 100644
> > --- a/include/target/iscsi/iscsi_target_core.h
> > +++ b/include/target/iscsi/iscsi_target_core.h
> > @@ -570,6 +570,7 @@ struct iscsi_conn {
> >  #define LOGIN_FLAGS_CLOSED           2
> >  #define LOGIN_FLAGS_READY            4
> >  #define LOGIN_FLAGS_INITIAL_PDU              8
> > +#define LOGIN_FLAGS_WRITE_ACTIVE     12
>
> 12 works but seems odd. The current code uses test/set/clear_bit, so we
> want these to be:
>
> #define LOGIN_FLAGS_CLOSED 0
> #define LOGIN_FLAGS_READY 1
> #define LOGIN_FLAGS_INITIAL_PDU 2
> #define LOGIN_FLAGS_WRITE_ACTIVE 3
>
> right?
>
Yes, it is a little odd. What about this? I also changed the order of them
to be in sequence that happened.

--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -566,10 +566,11 @@ struct iscsi_conn {
        struct socket           *sock;
        void                    (*orig_data_ready)(struct sock *);
        void                    (*orig_state_change)(struct sock *);
-#define LOGIN_FLAGS_READ_ACTIVE                1
-#define LOGIN_FLAGS_CLOSED             2
-#define LOGIN_FLAGS_READY              4
-#define LOGIN_FLAGS_INITIAL_PDU                8
+#define LOGIN_FLAGS_READY              0
+#define LOGIN_FLAGS_INITIAL_PDU                1
+#define LOGIN_FLAGS_READ_ACTIVE                2
+#define LOGIN_FLAGS_WRITE_ACTIVE       3
+#define LOGIN_FLAGS_CLOSED             4

Thanks,
Hou

> 2, 4, 8 was probably from a time we set the bits our self like:
>
> login_flags |= LOGIN_FLAGS_CLOSED;
>
>
> >       unsigned long           login_flags;
> >       struct delayed_work     login_work;
> >       struct iscsi_login      *login;
> >
>
