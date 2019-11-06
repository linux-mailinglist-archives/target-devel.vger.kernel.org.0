Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 600FBF0D02
	for <lists+target-devel@lfdr.de>; Wed,  6 Nov 2019 04:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfKFD06 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 5 Nov 2019 22:26:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40785 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730655AbfKFD06 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573010817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjvI16trGWI5S4NFsG1Cu3fc/EhZpyIvkaPDqJsoF2c=;
        b=LzlTcbbCGapjTGKWwE1vyCW3+aZL6co3vbWlA5tG6sQcT54hWz2l3T8kMRB+J15TtKTYcu
        IN0K/Ey+wzjlWo8+T2me8f4KsH7sVEw6Cz8gIHNlJ8piWtzDhmEbJzsLOzhQShR9fIQbvx
        tzOIcBYtA3900RHfoV56xyGskJLyGXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-aqAwO3lKMrSyvZVFCW1l2A-1; Tue, 05 Nov 2019 22:26:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64C691005500
        for <target-devel@vger.kernel.org>; Wed,  6 Nov 2019 03:26:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-146.rdu2.redhat.com [10.10.121.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E55A8608AC
        for <target-devel@vger.kernel.org>; Wed,  6 Nov 2019 03:26:53 +0000 (UTC)
Date:   Tue, 5 Nov 2019 19:26:51 -0800
From:   Chris Leech <cleech@redhat.com>
To:     target-devel@vger.kernel.org
Subject: Re: [PATCH V3 0/3] iscsi: chap: introduce support for SHA1, SHA256
 and SHA3-256
Message-ID: <20191106032651.GA7899@localhost.localdomain>
Mail-Followup-To: target-devel@vger.kernel.org
References: <20191028123822.5864-1-mlombard@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028123822.5864-1-mlombard@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: aqAwO3lKMrSyvZVFCW1l2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:38:19PM +0100, Maurizio Lombardi wrote:
> iSCSI with the Challenge-Handshake Authentication Protocol is not FIPS co=
mpliant.
> This is due to the fact that CHAP currently uses MD5 as the only supporte=
d
> digest algorithm and MD5 is not allowed by FIPS.
>=20
> When FIPS mode is enabled on the target server, the CHAP authentication
> won't work because the target driver will be prevented from using the MD5=
 module.
>=20
> Given that CHAP is agnostic regarding the algorithm it uses, this
> patchset introduce support for three new alternatives: SHA1, SHA256 and S=
HA3-256.
>=20
> They all have their protocol identifiers assigned by IANA:
> https://www.iana.org/assignments/ppp-numbers/ppp-numbers.xml#ppp-numbers-=
9
>=20
> Initiator-side code for open-iscsi has already been merged:
> https://github.com/open-iscsi/open-iscsi/pull/170
>=20
> V2: adds SHA256
> V3: rebased on top of 5.5/scsi-queue
>     PATCH 3: renames initiatorchg_* variables to client_challenge_*
>=20
> Maurizio Lombardi (3):
>   target-iscsi: CHAP: add support to SHA1, SHA256 and SHA3-256 hash
>     functions
>   target-iscsi: tie the challenge length to the hash digest size
>   target-iscsi: rename some variables to avoid confusion.
>=20
>  drivers/target/iscsi/iscsi_target_auth.c | 235 +++++++++++++++--------
>  drivers/target/iscsi/iscsi_target_auth.h |  17 +-
>  2 files changed, 163 insertions(+), 89 deletions(-)
>=20
> --=20

I've tested this latest version against the latest upstream Open-iSCSI
tools and verified that all of the new digest modes negotiate and
function for mutual CHAP authentication.

Tested-by: Chris Leech <cleech@redhat.com>

Note that configfs in 5.5/scsi-queue is currently broken and you can't
actually configure the target subsystem with first applying the patch=20
"configfs: calculate the depth of parent item" from Honggang Li.

Also, I didn't actually put the target system into FIPS enforcing mode,
becuase that kernel failed to boot due to a FIPS self-test failure for
ofb(aes)

