Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6087A964F
	for <lists+target-devel@lfdr.de>; Thu, 21 Sep 2023 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjIURCY (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 21 Sep 2023 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjIURCH (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF8198C
        for <target-devel@vger.kernel.org>; Thu, 21 Sep 2023 09:59:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CF9D1FDC0;
        Thu, 21 Sep 2023 07:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695281491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OruL5nIIluFkb6XPtYcdPGQdg7ifDBI4/nhrPj1d9Yk=;
        b=fdaKAL5QC6CARYrERyEx3TYjuJCBUQzPucyU5c3+39rHF6EUBk1ou48NR6bHCtc4DtPODz
        GItyvlhnSsHRZsK/mtR9Gef+VNhKA/GdKmy5rUTUzTM0Zz/NRPH4EVjPJ+6X2qXEXIeIyj
        5uFI0z9dQh0hCKI3iNeKZvUpDjRh6J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695281491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OruL5nIIluFkb6XPtYcdPGQdg7ifDBI4/nhrPj1d9Yk=;
        b=fqijiDP/kQF7Z1yHfVhaWNc3Fb8FoxD/XjI1ILwWVXW6YudD98hfZgPOrirRhsCAJeeQta
        YtZxArZEzm361PDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9F2313513;
        Thu, 21 Sep 2023 07:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GWIuL1HxC2V6eQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 21 Sep 2023 07:31:29 +0000
Message-ID: <ca46b0f2-779e-46fe-8653-03654e5188ea@suse.de>
Date:   Thu, 21 Sep 2023 09:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] scsi: target: Change nab@linux-iscsi.org into
 nab@kernel.org
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230920200232.3721784-1-bvanassche@acm.org>
 <20230920200232.3721784-4-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230920200232.3721784-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 9/20/23 22:00, Bart Van Assche wrote:
> Nicholas A. Bellinger owns both email addresses. Perform this
> replacement because the linux-iscsi.org domain name no longer has any MX
> records associated. This patch has been generated by running the
> following shell command:
> 
>      git grep -li 'nab@linux-iscsi.org' |
>          while read f; do
> 	    awk '{ if (match($0, "Copyright") == 0) gsub("nab@[lL]inux-i[sS][cC][sS][iI].org", "nab@kernel.org"); print $0 }' <$f >/tmp/awk.tmp &&
> 	        mv /tmp/awk.tmp $f
> 	done
> 
> Note: I received the following reply after having sent an email to
> nab@kernel.org: "I'm sorry to have to inform you that your message
> could not be delivered to one or more recipients. It's attached below.
> For further assistance, please send mail to postmaster. If you do so,
> please include this problem report. You can delete your own text from
> the attached returned message. The mail system."
> 
Didn't you want to drop this patch?
The 'Author' line is a historic reference; Nic Bellinger wrote this code
using that e-mail address. This fact will not change, even if Nic is 
using a different e-mail address now.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

