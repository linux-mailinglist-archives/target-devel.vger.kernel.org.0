Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D5B19B6B6
	for <lists+target-devel@lfdr.de>; Wed,  1 Apr 2020 22:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbgDAUFe (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 1 Apr 2020 16:05:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25262 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbgDAUFe (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585771532;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmS37GsfkMUoM24XB9xGfwurUlaC9bu/oDoTkejcGHo=;
        b=Ur4/TbGnpXwTtoXxGsFGgkrWCCWEkBgxmdFdOkpQBSuvtcHFQBxw6APwoy9zOWi4BGG+qO
        sZKd+kJE8X8Hauqd1yuIYdvp1hHc6aBbNm+b8r3QMGMUhotULRW5flQiVPT1vuSzZcq5C1
        v85PZDPX4aND1+9shvIWNryArrn7A5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-3u8kf0J6N1KbAEHZ5l2IQg-1; Wed, 01 Apr 2020 16:05:28 -0400
X-MC-Unique: 3u8kf0J6N1KbAEHZ5l2IQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AB45107ACC7;
        Wed,  1 Apr 2020 20:05:27 +0000 (UTC)
Received: from mchristi.msp.csb (ovpn-115-141.rdu2.redhat.com [10.10.115.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3D6C90817;
        Wed,  1 Apr 2020 20:05:25 +0000 (UTC)
Reply-To: mchristi@redhat.com
Subject: Re: [PATCH] target: tcmu: add missing pr attributes to passthrough
 backends
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        target-devel@vger.kernel.org
Cc:     ddiss@suse.de, hch@lst.de, martin.petersen@oracle.com
References: <20200401132153.23501-1-bstroesser@ts.fujitsu.com>
From:   Michael Christie <mchristi@redhat.com>
Organization: Red Hat
Message-ID: <76689136-62a7-65d7-7eb8-44c459f95aa7@redhat.com>
Date:   Wed, 1 Apr 2020 15:05:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20200401132153.23501-1-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04/01/2020 08:21 AM, Bodo Stroesser wrote:
> In commit b49d6f7885306ee636d5c1af52170f3069ccf5f7 the new attribute> e=
mulate_pr was added.
> passthrough_parse_cdb() uses the attribute's value to distinguish,
> whether reservation commands should be rejected or not.
> But the new attribute was not added to passthrough_attrib_attrs, so in
> pscsi and tcmu - the users of passthrough_parse_cdb() - the attribute
> is not available to change parser's behavior.
> This patch adds the new attribute as well as the "pr control" attribute=
s
> enforce_pr_isids and force_pr_aptpl to passthrough_attrib_attrs.
>=20
> Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
> ---
>  drivers/target/target_core_configfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/tar=
get_core_configfs.c
> index ff82b21fdcce..c5a974c5b31d 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1203,6 +1203,9 @@ struct configfs_attribute *passthrough_attrib_att=
rs[] =3D {
>  	&attr_hw_block_size,
>  	&attr_hw_max_sectors,
>  	&attr_hw_queue_depth,
> +	&attr_emulate_pr,

This one seems ok here, because it works for both pscsi and tcmu.

> +	&attr_enforce_pr_isids,
> +	&attr_force_pr_aptpl,

These only work for tcmu. pscsi will do whatever the physical device
does, and we can't control it. I guess the options would be:

1. Just add them above.

2. Add them above and add some TRANSPORT_FLAG_PASSTHROUGH_PGR checks in
functions like force_pr_aptpl_store like we did for the pr functions, so
the user gets some feedback if they try to use them for pscsi. We would
have to add a isid function too.

3. Export the attrs or some common lib/helper functions to get/set the
values then target_core_user.c can setup the attrs and add it to
tcmu_attrib_attrs.


>  	&attr_alua_support,
>  	&attr_pgr_support,
>  	NULL,



