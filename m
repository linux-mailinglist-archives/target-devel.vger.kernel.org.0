Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4814E25E4
	for <lists+target-devel@lfdr.de>; Mon, 21 Mar 2022 13:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbiCUMDQ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 21 Mar 2022 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346746AbiCUMDO (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD6CB56227
        for <target-devel@vger.kernel.org>; Mon, 21 Mar 2022 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647864109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjyieAFQj3bcVjxdPEDIjVTjL278YKH95kf+yFJHAWk=;
        b=RpzE2QFEIiof3jDspDEZynIg1sdDcaOgZzlaQDi2SWtGUEun6SSb4ZB4zx1FKiZ6z9gTom
        xVRmgwGU61GDEEslPCeOqLppf8S5CI1JOc9WVq/53IRLLUmDSBq791M+qopXA856ctopQ0
        0aJD7JU761lW5bhwrz3ldwXXnhRhPBM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-tRaS0adJM9ebmUrp6OP27w-1; Mon, 21 Mar 2022 08:01:47 -0400
X-MC-Unique: tRaS0adJM9ebmUrp6OP27w-1
Received: by mail-wr1-f69.google.com with SMTP id s8-20020adfc548000000b00203eba1052eso1895490wrf.1
        for <target-devel@vger.kernel.org>; Mon, 21 Mar 2022 05:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hjyieAFQj3bcVjxdPEDIjVTjL278YKH95kf+yFJHAWk=;
        b=JRY8exGCfCF6nlG+QXvOAAOR4yzqVPnpubEYW5pRfpvIbdXDY86Our/+ubTbAIQSgN
         /dj+ugSGtu3pfyK5Tuls6bDN3UpSY9GEUftNpKvTX895sBFPiHO+/4NHn3PZeM2hAHHS
         s2E2L5C+LNxZ4QWWHFNiUQySC3H6PKXud1d1PmP3+6flws+JeqRGv402GDKxNhk3ECL5
         z25N86hijqKcbGG+mtAhNi7jo4DuJHAbq05XdMN3groQlWgEXUI+VqU7LU+WMaDy1VD/
         j/w60kdMBOlEpdezk2iCTsLf+hWK5TM4wmwwsjuVCI5XfvQneZitDxJ8HHc5rHLvmR7J
         akzg==
X-Gm-Message-State: AOAM530tRYkW8uoO4fZ5V4REZjilBymd1RDfNIVx2N5FGlBl2lUC9IpO
        Dr9WP7ClkHo185kJTkJ37PPSFgeRXyEIDtXQvO4jE2PTU4RWmG4GeP5gcWvZAFO4xMUw0B8HU1K
        b7DbPSjJIRPEnHd3pogrwRfLE
X-Received: by 2002:a5d:6405:0:b0:204:1ef:56e8 with SMTP id z5-20020a5d6405000000b0020401ef56e8mr8378180wru.677.1647864106233;
        Mon, 21 Mar 2022 05:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhZuEfJSaXjpaErJyh2L9DkMAaRb0WEaJXZhhj0Z+2/QVCT0rFeZuYjApA/Lz7WeWZRTfZiw==
X-Received: by 2002:a5d:6405:0:b0:204:1ef:56e8 with SMTP id z5-20020a5d6405000000b0020401ef56e8mr8378159wru.677.1647864105940;
        Mon, 21 Mar 2022 05:01:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000188100b002041a652dfdsm1639674wri.25.2022.03.21.05.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 05:01:45 -0700 (PDT)
Message-ID: <a37e9ba2-354b-0b75-cb05-bc730cb30151@redhat.com>
Date:   Mon, 21 Mar 2022 13:01:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC 2/3] mm: export zap_page_range()
Content-Language: en-US
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-block@vger.kernel.org, xuyu@linux.alibaba.com,
        bostroesser@gmail.com
References: <20220318095531.15479-1-xiaoguang.wang@linux.alibaba.com>
 <20220318095531.15479-3-xiaoguang.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220318095531.15479-3-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 18.03.22 10:55, Xiaoguang Wang wrote:
> Module target_core_user will use it to implement zero copy feature.
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> ---
>  mm/memory.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f745e4d11c2..9974d0406dad 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1664,6 +1664,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_finish_mmu(&tlb);
>  }
> +EXPORT_SYMBOL_GPL(zap_page_range);
>  
>  /**
>   * zap_page_range_single - remove user pages in a given range

To which VMAs will you be applying zap_page_range? I assume only to some
special ones where you previously vm_insert_page(s)_mkspecial'ed pages,
not to some otherwise random VMAs, correct?

-- 
Thanks,

David / dhildenb

