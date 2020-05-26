Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E651F1D8857
	for <lists+target-devel@lfdr.de>; Mon, 18 May 2020 21:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgERTk1 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 18 May 2020 15:40:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48527 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728334AbgERTk1 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 18 May 2020 15:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589830826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tG4NW0XrpKeglSu1M3LhtqURiiCPd6FFbzkD+elHvV4=;
        b=hgKqhTbe8oJUr8lG6xaOpKDqS5ubTWgo5iPHkqUXu6haE/drB72AdYwlk27tAJQ4AVlzup
        xRRE2CrW6rGpwo2zb8nSiSp4scy66KvOmTxakE3pFkcYQphXr3Z+9XyDMTmiCF/Y6x6nuw
        9K6LfuA79In2ZHzhzUWuYBZdde1PKIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-U05quBLcPiW7lZDGRiusAg-1; Mon, 18 May 2020 15:40:24 -0400
X-MC-Unique: U05quBLcPiW7lZDGRiusAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90C0E835B40;
        Mon, 18 May 2020 19:40:23 +0000 (UTC)
Received: from [10.10.118.151] (ovpn-118-151.rdu2.redhat.com [10.10.118.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9ED919634;
        Mon, 18 May 2020 19:40:22 +0000 (UTC)
Subject: Re: [PATCH v1 target] target: Add initiatorname to NON_EXISTENT_LUN
 error
To:     Lance Digby <lance.digby@gmail.com>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9b13bb2e1f52f1792cd81850ee95bf3781bb5363.1589759816.git.lance.digby@gmail.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <cc4c1a62-ec8d-e0f4-f0ac-8584ec1d1885@redhat.com>
Date:   Mon, 18 May 2020 14:40:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9b13bb2e1f52f1792cd81850ee95bf3781bb5363.1589759816.git.lance.digby@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 5/17/20 8:02 PM, Lance Digby wrote:
> The NON_EXISTENT_LUN error can be written without an error condition
> on the initiator responsible. Adding the initiatorname to this message
> will reduce the effort required to fix this when many initiators are
> supported by a target.
> 
> This version ensures the initiator name is also printed on the same
> message in transport_lookup_tmr_lun for consistency.
> 

Reviewed-by: Mike Christie <mchristi@redhat.com>

