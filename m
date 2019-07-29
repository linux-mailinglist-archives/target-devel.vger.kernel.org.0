Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8B478E97
	for <lists+target-devel@lfdr.de>; Mon, 29 Jul 2019 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfG2PCp (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 29 Jul 2019 11:02:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36088 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbfG2PCo (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:02:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3D4EF8EE128;
        Mon, 29 Jul 2019 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1564412564;
        bh=AXFFEJd9Z+18E4ObOxvkjLDLsngNOvQy6aoRiwcys2A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EprW1r+EW/YWTOUw/uvCXRsE7c7By6UIgumC4MaW1eJu2fXPEecjGfFRQfkdy0U2I
         B8HdedUX5X0f0fbVa0MDGNpR6c/0Wl600FHmM+Z5t1Yj7ayetkPnygB+bcqiLnCkvs
         r+9sqS+4sCpGDEZjL2W4X6Hl2wEe45cRXMEkmnWA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ql8M7lsLqgpc; Mon, 29 Jul 2019 08:02:44 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.71.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 943F48EE116;
        Mon, 29 Jul 2019 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1564412564;
        bh=AXFFEJd9Z+18E4ObOxvkjLDLsngNOvQy6aoRiwcys2A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EprW1r+EW/YWTOUw/uvCXRsE7c7By6UIgumC4MaW1eJu2fXPEecjGfFRQfkdy0U2I
         B8HdedUX5X0f0fbVa0MDGNpR6c/0Wl600FHmM+Z5t1Yj7ayetkPnygB+bcqiLnCkvs
         r+9sqS+4sCpGDEZjL2W4X6Hl2wEe45cRXMEkmnWA=
Message-ID: <1564412562.3501.9.camel@HansenPartnership.com>
Subject: Re: [PATCH] target: iscsi: iscsi_target_tpg: Fix a possible
 null-pointer dereference in iscsit_tpg_add_network_portal()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, martin.petersen@oracle.com,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        rfontana@redhat.com, tglx@linutronix.de, gregkh@linuxfoundation.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 08:02:42 -0700
In-Reply-To: <20190729022956.18192-1-baijiaju1990@gmail.com>
References: <20190729022956.18192-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Mon, 2019-07-29 at 10:29 +0800, Jia-Ju Bai wrote:
> In iscsit_tpg_add_network_portal(), there is an if statement on line
> 496
> to check whether tpg->tpg_tiqn is NULL:
>     if (tpg->tpg_tiqn)
> 
> When tpg->tpg_tiqn is NULL, it is used on line 508:
>     pr_debug(..., tpg->tpg_tiqn->tiqn, ...);
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, tpg->tpg_tiqn is checked before being used.
> 
> This bug is found by a static analysis tool STCheck written by us.

I don't really think this is helpful.  The first question is, is the
implied might be NULL check correct?  The tpg_tiqn is always set by a
non-dummy driver and I think network configuration is only done for the
non dummy driver, so I suspect the NULL check is wrong.  Secondly even
if the NULL check were correct, I think there's still a need for some
debugging output, so the proposed patch also looks wrong.

James

