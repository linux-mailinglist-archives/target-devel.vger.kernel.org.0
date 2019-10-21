Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA65DF267
	for <lists+target-devel@lfdr.de>; Mon, 21 Oct 2019 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfJUQGZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 21 Oct 2019 12:06:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33479 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbfJUQGZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571673983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4n683HFZLOiX/EWrwiLKOhWpCGTf5pC8zd1qhZEknc=;
        b=X0hpPhoB5TjJ2sWx5lYNfNZdYarCp3J4AfZQzaH1I81gb6riZZoBJzkFW8cNkG1WQXmWmO
        Sg1Ayi6zhrNtbLYtVHJL1QJOvVp5MxxvrQ2D+NbmTcBYr6S5OWJl7jE7QSJ9Ld8smzj/qY
        CzARZSE1ctqMXw4yG695i2dtcPWl1Ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-SWHQOxSaOySatwIMnCC7cg-1; Mon, 21 Oct 2019 12:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E0CC100550E;
        Mon, 21 Oct 2019 16:06:19 +0000 (UTC)
Received: from [10.10.120.68] (ovpn-120-68.rdu2.redhat.com [10.10.120.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2E8F196AE;
        Mon, 21 Oct 2019 16:06:18 +0000 (UTC)
Subject: Re: [PATCH 0/3] target: minor iSCSI parameter parsing fixes
To:     David Disseldorp <ddiss@suse.de>, target-devel@vger.kernel.org
References: <20190912095547.22427-1-ddiss@suse.de>
Cc:     martin.petersen@oracle.com, bvanassche@acm.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DADD77A.6010903@redhat.com>
Date:   Mon, 21 Oct 2019 11:06:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190912095547.22427-1-ddiss@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SWHQOxSaOySatwIMnCC7cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 09/12/2019 04:55 AM, David Disseldorp wrote:
> This patchset includes some minor fixes for parsing iSCSI CHAP_A and
> SendTargets fields. Patch 1/3 was already submitted and reviewed by
> Lee.
> I used the following libiscsi hacks to test for these bugs:
> https://github.com/ddiss/libiscsi/commits/bogus_chap_a
> https://github.com/ddiss/libiscsi/commits/bogus_sendtarget_key
> https://github.com/ddiss/libiscsi/commits/bogus_sendtarget_val
> I'll work on turning these into propper libiscsi regression tests
> (pending https://github.com/sahlberg/libiscsi/issues/297).
>=20
> Cheers, David
>=20
>  drivers/target/iscsi/iscsi_target.c            | 14 ++++++--------
>  drivers/target/iscsi/iscsi_target_auth.c       |  2 +-
>  drivers/target/iscsi/iscsi_target_parameters.h |  3 ---
>  3 files changed, 7 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Mike Christie <mchristi@redhat.com>

