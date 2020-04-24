Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76801B6D2C
	for <lists+target-devel@lfdr.de>; Fri, 24 Apr 2020 07:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgDXFZV (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 24 Apr 2020 01:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbgDXFZU (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:25:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4BC09B045
        for <target-devel@vger.kernel.org>; Thu, 23 Apr 2020 22:25:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so7595336wrx.3
        for <target-devel@vger.kernel.org>; Thu, 23 Apr 2020 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3xlhYgS/zLqigYSC49t4/AriSS2ZjycNOlqxwfYVsk=;
        b=Bz8AYVwWyABZPDn+Tvm7H7x613yeA324uXHkMcDaqBqprAuMlh+t9Ouz934pUlerqe
         n1E2a9ulEdqITvo6HwecBknJ9BX9V/73WrKYCSd0ZlalXJq4XkgBUEK2Ub4xKbNGLM9P
         1/D/TQA5FlmUWvua0j6YXVeLRzPENcgLkde2O43FW4lYhanDXDxR5EL3+CDxDPBza+d+
         RtmYeDgmmogFgEWmnvqfT23Ot4g2o8+zn7u7ZJmcX8mS8NTqLDK6LG7LcISU0OrC5J0P
         0ny125Bc/2gInL7Lr+7RTW8ypQC19DlTAfGGbTcWT5PIe7QYhBEgOnrv+B3e80AphlKs
         Ht9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3xlhYgS/zLqigYSC49t4/AriSS2ZjycNOlqxwfYVsk=;
        b=ijMWM0CwGwBPsdcbXiJtth/5kudvy0oqOGIB4bX1XPjgLXPfLNNNIbaQJ5ZK8l+PRc
         3/K2J+m3eyvJAdNWDQVRz83BeK/fY/g8fksQtqNdPgMdXZY2ALx83rRWza4xQ6/9wh08
         3rdvco9n1e/WMRndpw6FdMRjv9d6DJc+NLbFQGEfzWWa/am1q/66Rj8Owxx8gQVcfNBZ
         E1fAlQbmL6TdMF+2ZTNX/Pm7DyU6CRu5mNTE1FJjNE/pkIx3sKIP0CvI5fZsun4/5g8Q
         QIgFoi5iUzpMVHH0VHvWm5tS5/faMTgqb+UDcVMX+jVPnrXDtZkh8Jqq0BjHTQVKUrR9
         YcGQ==
X-Gm-Message-State: AGi0Pub7+ZK8ml1rrouB81itmf/sCq6+bdwUF2F+5PZ/6kUVVezLEqQL
        5naMbx2LltRPtoOCGa4DjbOcaE2o8KZ0jEaNq2dH4A==
X-Google-Smtp-Source: APiQypJkodcSlQExGqyQ0SRDtm4MoJrCEMgXxWF7r2P5IyrMTrnqwzbRvItPW5KmrilVbf+Rs1aU81saFKgpjh5PDcc=
X-Received: by 2002:adf:aa8e:: with SMTP id h14mr9598857wrc.371.1587705918162;
 Thu, 23 Apr 2020 22:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200424035843.5914-1-houpu@bytedance.com> <20200424035843.5914-3-houpu@bytedance.com>
 <DM6PR04MB4972B3BE33D83FE7BA78570986D00@DM6PR04MB4972.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB4972B3BE33D83FE7BA78570986D00@DM6PR04MB4972.namprd04.prod.outlook.com>
From:   Hou Pu <houpu@bytedance.com>
Date:   Fri, 24 Apr 2020 13:25:07 +0800
Message-ID: <CAO9YExvkEAYstXxmE=MR5aXGYZSO6pmZHC+zwfiURi1yH3-JMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iscsi-target: Fix inconsistent debug message in __iscsi_target_sk_check_close
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mchristi@redhat.com" <mchristi@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:16 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Ho
>
> On 04/23/2020 08:59 PM, Hou Pu wrote:
> > commit 25cdda95fda78d22d44157da15aa7ea34be3c804
> > Author: Nicholas Bellinger<nab@linux-iscsi.org>
> > Date:   Wed May 24 21:47:09 2017 -0700
> >
> >      iscsi-target: Fix initial login PDU asynchronous socket close OOPs
>
> Thanks for the patch.
>
> Did you get a chance to run checkpatch.pl on this patch ?

Will fix it. Sorry for the stupid format error.

Thanks,
Hou
