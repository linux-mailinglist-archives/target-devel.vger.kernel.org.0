Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1770DF7D5C
	for <lists+target-devel@lfdr.de>; Mon, 11 Nov 2019 19:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfKKS4B (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 11 Nov 2019 13:56:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40502 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729966AbfKKSzz (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573498554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vV3wkbSPwMyDDvkOTJ54r/QQVDxVteKGm1nEtOp1owA=;
        b=VADvBSmzdvgbhCyhgeGH3lppIljr1SotLmegs1hEbSikYc7fedV55d6p3Z7m2j41ywpGIa
        VpKoJsH4jAK+j4GThYKMZlaVNx2slcNqzVnrAaj/zXSYJYl3F56PMEz030/8wmAPlE3cDG
        Mj0eZgecVYdcg96P7PLylAWe5hLvSG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-4XYBaZ5VMmWoRAsg3neyqg-1; Mon, 11 Nov 2019 13:55:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFFC710E2630;
        Mon, 11 Nov 2019 18:55:47 +0000 (UTC)
Received: from [10.10.123.234] (ovpn-123-234.rdu2.redhat.com [10.10.123.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D48E600CC;
        Mon, 11 Nov 2019 18:55:47 +0000 (UTC)
Subject: Re: [PATCH 0/2] Improve SPC-2 reservation support
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20191111182944.191123-1-bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, target-devel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DC9AEB2.4050202@redhat.com>
Date:   Mon, 11 Nov 2019 12:55:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20191111182944.191123-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4XYBaZ5VMmWoRAsg3neyqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 11/11/2019 12:29 PM, Bart Van Assche wrote:
> Hi Martin,
>=20
> This patch series improves support for SPC-2 reservations in the SCSI tar=
get
> code. Please consider these patches for inclusion in the v5.5 kernel.
>=20
> Thanks,
>=20
> Bart.
>=20
> Bart Van Assche (2):
>   target/core: Declare target_release_reservation() 'static'
>   target/iscsi: Fix a use-after-free while closing a session
>=20

Patches look and tested ok for me.

Reviewed-by: Mike Christie <mchristi@redhat.com>

