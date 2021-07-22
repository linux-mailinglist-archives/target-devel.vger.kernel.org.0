Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CAF3D2496
	for <lists+target-devel@lfdr.de>; Thu, 22 Jul 2021 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhGVMr2 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 22 Jul 2021 08:47:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45882 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhGVMrZ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:47:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 705E72264F;
        Thu, 22 Jul 2021 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626960479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNXQNB/96woKgdHnQ7p8XYn2uueQuNS+714AUhZqOLw=;
        b=gXcDaYquz57iBbAGCdlKrN3nd5w3j6u/7o6cF/7SeSw4hFQUaCq4r2f7zGpWXlKOm1FemV
        WSoYzwFy3sVg8sDgMiX3A88k8kOFZ3HJy0io/Pro4yFy9+HYcnVOtCaRTadgcrIhIDqle2
        O9y2F7wD6EAZDiufGO2EhaNj7ZDg0aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626960479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNXQNB/96woKgdHnQ7p8XYn2uueQuNS+714AUhZqOLw=;
        b=vc6XakHcJTxGQgii0IjB1GKqZad22wXDiDNk046O5L2alVUqg2YJ2CAPpd3bArhsTm1WFO
        xdkiFXh+1cikEaBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 34126139A1;
        Thu, 22 Jul 2021 13:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2RQsC19y+WByeQAAGKfGzw
        (envelope-from <ddiss@suse.de>); Thu, 22 Jul 2021 13:27:59 +0000
Date:   Thu, 22 Jul 2021 15:27:58 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Sergey Samoylenko <s.samoylenko@yadro.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "michael.christie@oracle.com" <michael.christie@oracle.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re: [PATCH 0/1] scsi: target: core: Fix sense key for invalid XCOPY
 request
Message-ID: <20210722152758.3adaa28b@suse.de>
In-Reply-To: <a860bf3f89594f6982ce126ebaa0ab94@yadro.com>
References: <20210624111926.63176-1-s.samoylenko@yadro.com>
        <20210721234505.45c93a48@suse.de>
        <a860bf3f89594f6982ce126ebaa0ab94@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, 22 Jul 2021 11:03:02 +0000, Sergey Samoylenko wrote:

> Hi David,
> 
> > Hi Sergey,
> >
> > On Thu, 24 Jun 2021 14:19:25 +0300, Sergey Samoylenko wrote:
> >  
> >> EXTENDED COPY tests in libiscsi [1] show that TCM doesn't follow SPC4 
> >> when detects invalid parameters in a XCOPY command or IO errors. The 
> >> replies from TCM contain wrong sense key or ASCQ for incorrect 
> >> request.
> >> 
> >> The series fixes the following tests from libiscsi:  
> >
> > We've hit this too. The incorrect sense reporting appears to also affect VMware XCOPY fallback to initiator driven READ/WRITE. I'm pretty sure this is a regression from
> > d877d7275be34ad70ce92bcbb4bb36cec77ed004, so should probably be marked as such via a Fixes tag.
> >
> > Cheers, David  
> 
> The d877d7275be34ad70ce92bcbb4bb36cec77ed004 was added for v4.10.x kernel and it was necessary
> for to avoid LUN removal race conditions. Later you excluded using configfs in the XCOPY workqueue.
> It was the 2896c93811e39d63a4d9b63ccf12a8fbc226e5e4.
> 
> If we remove the d877d7275be34ad70ce92bcbb4bb36cec77ed004, will it break anything?
> We have accumulated many changes between v4.10 and v5.14.
> 
> David, maybe can we move the helper 'target_complete_cmd_with_sense' from your path to mainline kernel?
> I think it will be useful in the future.

I don't think it makes sense to revert d877d7275be34. I agree that
Mike's target_complete_cmd_with_sense() patch should be helpful for
proper sense propagation here.

Cheers, David
