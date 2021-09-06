Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE3401DB8
	for <lists+target-devel@lfdr.de>; Mon,  6 Sep 2021 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhIFPpo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 6 Sep 2021 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhIFPpn (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 6 Sep 2021 11:45:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A7CC061575;
        Mon,  6 Sep 2021 08:44:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s25so10102255edw.0;
        Mon, 06 Sep 2021 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CP/L6trNtJt+zRzY7oBdWtRfg7ANZZU7xhOLZ2L8JmY=;
        b=gUQBCzDQ97o56gLhNc6jwxfhKc5bkrEd4u3/Y/yZLiELUy++Em9ldHLXhlh2veqTwO
         aKchPqZpcQrTRaD1LVQXAkrAH6cdTbaPuHOFR7afWx6gSxqYbuWkb5hd8RnpBx1lBcN0
         kSKlW0EpTbicAybupq0RPwcXQHryOPe8JE1jOEtBMEjttWkly1OFksBJSJ3Gi0+8h81l
         siLvuZDpP0UnZVhphU28d0GQv7SnGWjAXW+5sRc1QpBK5I1eY3V9b4g1ISVUvttQdHIZ
         L9rjbRuqw7R+Ke5xQoDf8UF2Zk8CVH8u2Pyg7FlQtmgj2aTwGvtHOcRX26D8vEHA+U9Y
         ZCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CP/L6trNtJt+zRzY7oBdWtRfg7ANZZU7xhOLZ2L8JmY=;
        b=flQLFgrD65fk4jdTo3jmWtCJ+I3X3bgRHXFuQ61bYk2jmmf4bU2LOGjwEtDsv/gYoR
         KXl1Vw2LI/eWVaGd5heJJtaoipf4JbrXnbeq7Z3j5VpGqs40Cum6KhiIRiX11z5rtR+N
         cLmp9qa7nLHvR/VtYU9Ww67cDz+atEhumb+d6S2P4e0mXB9YUihLC3CTmTE923/Jy0eh
         qmQyDwnF2iepb9+YwAM2siCZBUfVnVIQri7PDDGkQL21z4sOwSZxHR4O6kp/kcGHLafo
         wLgUeSTZyBF+RvJqZEvET1UKTYiG4ldPFW/s51ujvob5RV2YCAhiF90cOUtnjmaoBZSy
         TnZQ==
X-Gm-Message-State: AOAM53063hI6LJDkpZk6vUVuWFHZNJeDHEaHsDDINOwtChwTv7Vk2+et
        4xDrEqDJr9O+7sxBVW31OA2ksMRu4DY=
X-Google-Smtp-Source: ABdhPJw3Ii0S5QxMcuNImn6egZB0qYvqvWBqe9rBgUFdJz2b3DgbWxm5tfeJWNW4tDknH1UQsICNCg==
X-Received: by 2002:a05:6402:1249:: with SMTP id l9mr14273738edw.177.1630943077297;
        Mon, 06 Sep 2021 08:44:37 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc061e7.dynamic.kabel-deutschland.de. [188.192.97.231])
        by smtp.gmail.com with ESMTPSA id qq16sm4109255ejb.120.2021.09.06.08.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 08:44:37 -0700 (PDT)
Subject: Re: [PATCH V2] target: fix the pgr/alua_support_store functions
To:     Maurizio Lombardi <mlombard@redhat.com>, martin.petersen@oracle.com
Cc:     michael.christie@oracle.com, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20210906151809.52811-1-mlombard@redhat.com>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <b1a05684-92a5-f209-a81f-96a1cfc4ea49@gmail.com>
Date:   Mon, 6 Sep 2021 17:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210906151809.52811-1-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 06.09.21 17:18, Maurizio Lombardi wrote:
> Commit 356ba2a8bc8d ("scsi: target: tcmu: Make pgr_support and
> alua_support attributes writable")
> introduced support for changeable alua_support and pgr_support
> target attributes. They can only be changed
> if the backstore is user-backed, otherwise the kernel returns -EINVAL.
> 
> This triggers a warning in the targetcli/rtslib code when performing
> a target restore that includes non-userbacked backstores:
> 
> #targetctl restore
> Storage Object block/storage1: Cannot set attribute alua_support:
> [Errno 22] Invalid argument, skipped
> Storage Object block/storage1: Cannot set attribute pgr_support:
> [Errno 22] Invalid argument, skipped
> 
> Fix this warning by returning an error code only if we are really
> going to flip the PGR/ALUA bit in the transport_flags field,
> otherwise we'll do nothing and return success.
> 
> Return ENOSYS instead of EINVAL if the pgr/alua attributes
> can't be changed, this way it'll be possible for userspace to understand
> if the operation failed because an invalid value has been passed
> to strtobool() or because the attributes are fixed.
> 
> Fixes: 356ba2a8bc8d ("scsi: target: tcmu: Make pgr_support and alua_support attributes writable")
> 
> v2: replace EOPNOTSUPP with ENOSYS
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
