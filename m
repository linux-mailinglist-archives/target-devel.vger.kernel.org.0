Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F274CC68
	for <lists+target-devel@lfdr.de>; Mon, 10 Jul 2023 07:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGJFxL (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 10 Jul 2023 01:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGJFxK (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD82FA
        for <target-devel@vger.kernel.org>; Sun,  9 Jul 2023 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688968345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2K52jyfMXQ896NNNb2VdJ1cCkY7IZeKXb4JhCxLXus4=;
        b=SNxSiZnnUfquI0gvJPH3WE9Bv8henUDhK+INhI+6JyRuH9I+ylGxn0l23PVsJ1CSKGdE8R
        wUyGs/T/ECTWFoeBjoJxTVJW9E4aDMf7ZLfV6ot8FT7OFikdlS75S/qbmFiCrPvnh8tN/p
        vYY1XBdtGPbaFhsIvK0PLlGdTjoXpbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-JmiNHrHsMSW7HT9pu3XMzQ-1; Mon, 10 Jul 2023 01:52:24 -0400
X-MC-Unique: JmiNHrHsMSW7HT9pu3XMzQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa979d0c32so24124755e9.2
        for <target-devel@vger.kernel.org>; Sun, 09 Jul 2023 22:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688968343; x=1691560343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2K52jyfMXQ896NNNb2VdJ1cCkY7IZeKXb4JhCxLXus4=;
        b=SvEG5AZ+mDiYqfjdUOIm5m5LYwNuUKr+eKSCD7J6ZfSGrjvVK1smxZLlD3GXRaWhBM
         06eRqkG/nsHgjin6GXnimbEz42UT+h5vMutniK58sjVtSVVKs+Er8SdfdsbFHEdPZAAN
         KEark+xE1BWg7c98mdimEUjSEHFKHUr4cc0vVR2cCPgu+pQmTMp28q0L9D4GQ8FuLmjF
         2jNHv1zCVP+IQfOt9VREoY7l1ubJyDtzqKoxOhfZjcqOLOOAEHIFw1gQYn/LoF7CAxfY
         UkCCg24KVwYsrxUdWXq/l1mU98alLMOmibiOoUtPnEIoSa3Zaz15Fra4u0SXZPign/Un
         CG3A==
X-Gm-Message-State: ABy/qLZglTZh9UtDtHhR1OjYQ1Fb1YMoqjtjNUXM1c2t5y2xN0lpEXaf
        KLXyY/C4kxHrD0k4UWu3jCJpAgY22Z17sYN7R50zwLQXho93klMP9UPv+u0FuvyEgHSNfo8avUB
        orGglnluhKBaUxhkncrYLhxli
X-Received: by 2002:a05:600c:2313:b0:3fc:521:8492 with SMTP id 19-20020a05600c231300b003fc05218492mr5262422wmo.5.1688968342929;
        Sun, 09 Jul 2023 22:52:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEX0MBIPIVZb0Ml0+vup7VUgMycj1blZD7PFdfB9Im1EaU1Fa8yaiSZY7CKGQPrbwAQn1eEsQ==
X-Received: by 2002:a05:600c:2313:b0:3fc:521:8492 with SMTP id 19-20020a05600c231300b003fc05218492mr5262405wmo.5.1688968342576;
        Sun, 09 Jul 2023 22:52:22 -0700 (PDT)
Received: from redhat.com ([2.52.3.112])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d5588000000b0030fa3567541sm10646951wrv.48.2023.07.09.22.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 22:52:22 -0700 (PDT)
Date:   Mon, 10 Jul 2023 01:52:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/2] vhost-scsi: Fix IO hangs when using windows
Message-ID: <20230710015042-mutt-send-email-mst@kernel.org>
References: <20230709202859.138387-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709202859.138387-1-michael.christie@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Sun, Jul 09, 2023 at 03:28:57PM -0500, Mike Christie wrote:
> The following patches were made over Linus's tree and fix an issue
> where windows guests will send iovecs with offset/lengths that result
> in IOs that are not aligned to 512. The LIO layer will then send them
> to Linux's FS/block layer but it requires 512 byte alignment, so
> depending on the FS/block driver being used we will get IO errors or
> hung IO.
> 
> The following patches have vhost-scsi detect when windows sends these
> IOs and copy them to a bounce buffer. It then does some cleanup in
> the related code.


Thanks, tagged!
Mike, you are the main developer on vhost/scsi recently.
Do you want to be listed in MAINTAINERS too?
This implies you will be expected to review patches/bug reports
though.

Thanks,
-- 
MST

