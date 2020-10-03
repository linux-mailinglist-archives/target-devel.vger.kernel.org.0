Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA86F28220E
	for <lists+target-devel@lfdr.de>; Sat,  3 Oct 2020 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJCHqq (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 3 Oct 2020 03:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgJCHqq (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 3 Oct 2020 03:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601711205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2AzxtYaTSxka2r1iICnzEmVQjFVNOuyh2nVtFkxPpI=;
        b=WGrHr3/tYaxltTH7r2iMPyDVK2VcSzJr5TKbeQk7DU8BIu2Osev79pVauea9JuHwCeKoK3
        i4/Ul8OrtXc+G9Y8ypUs49Yz7JlFmatUpoIIu5HCrQoFbKVp6w5aeuP0FyvPQHMYPTak/n
        lUrR0nBdtuhR/kW8LOTZw9CBSd0TJNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-TIdd74KbP4m2-EPAoxLqoA-1; Sat, 03 Oct 2020 03:46:43 -0400
X-MC-Unique: TIdd74KbP4m2-EPAoxLqoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 072798030BE;
        Sat,  3 Oct 2020 07:46:42 +0000 (UTC)
Received: from [10.40.192.38] (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B19E85D9D3;
        Sat,  3 Oct 2020 07:46:40 +0000 (UTC)
Subject: Re: [PATCH] Revert "scsi: target/iscsi: Detect conn_cmd_list
 corruption early"
To:     Bart Van Assche <bvanassche@acm.org>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20201002073341.12470-1-mlombard@redhat.com>
 <ce44115e-f8ac-0307-88bd-f6a2e9d7f7f3@acm.org>
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <fea1f8a6-615e-6d44-ec20-b4f46da10d55@redhat.com>
Date:   Sat, 3 Oct 2020 09:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ce44115e-f8ac-0307-88bd-f6a2e9d7f7f3@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



Dne 03. 10. 20 v 2:23 Bart Van Assche napsal(a):
> Hi Maurizio,
> 
> I agree that the same WARN_ON() occurs inside __iscsit_free_cmd(). What is not
> clear to me is how removing the WARN_ON() statement from iscsit_free_cmd() can
> help since an identical statement occurs inside __iscsit_free_cmd()?


It doesn't help indeed, this patch just removes one duplicate warning but doesn't
really change anything.

The bug I am trying to fix will need a different patch to prevent the race condition.

Maurizio

