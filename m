Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EF29729E
	for <lists+target-devel@lfdr.de>; Fri, 23 Oct 2020 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463288AbgJWPnj (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 23 Oct 2020 11:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S463279AbgJWPnj (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603467818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNSGPrDZt0KFZ/gEfGLt+00ZQJB1j+rqXJsHwi7p7Tw=;
        b=LtBq/dBAJJak5nh/gKY/rTuHkqmfUrCk8bvbTe94+EvUkBW8GGBlSyxN7YDiILsftkU9DR
        Pd9mnUEzzl7FGJhNcicIISvHeGEnrfw9h2/Y8snh8z4jG/7983FKmJ7H5CXjK9gAYl1E3/
        IfUCRfSnoybYDYppj6BUypONJMc5VAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-P7gkMaW6MZ6sGX5cfiMobA-1; Fri, 23 Oct 2020 11:43:27 -0400
X-MC-Unique: P7gkMaW6MZ6sGX5cfiMobA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6999B86ABD9;
        Fri, 23 Oct 2020 15:43:25 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A19FA27CC2;
        Fri, 23 Oct 2020 15:43:18 +0000 (UTC)
Date:   Fri, 23 Oct 2020 11:43:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org, kbuild-all@lists.01.org
Subject: Re: [PATCH 14/16] vhost: poll support support multiple workers
Message-ID: <20201023114247-mutt-send-email-mst@kernel.org>
References: <1602104101-5592-15-git-send-email-michael.christie@oracle.com>
 <202010080822.dOGbzKC9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010080822.dOGbzKC9-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Thu, Oct 08, 2020 at 08:46:42AM +0800, kernel test robot wrote:
> Hi Mike,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on vhost/linux-next]
> [also build test ERROR on next-20201007]
> [cannot apply to v5.9-rc8]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Mike-Christie/vhost-fix-scsi-cmd-handling-and-IOPs/20201008-045802
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> config: m68k-allyesconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/c9bcafefcac3c32ade0ba533609d7b1ddc343c54
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Mike-Christie/vhost-fix-scsi-cmd-handling-and-IOPs/20201008-045802
>         git checkout c9bcafefcac3c32ade0ba533609d7b1ddc343c54
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> m68k-linux-ld: drivers/vhost/scsi.o:(.bss+0x0): multiple definition of `vq'; drivers/vhost/net.o:(.bss+0x0): first defined here
>    m68k-linux-ld: drivers/vhost/vsock.o:(.bss+0x0): multiple definition of `vq'; drivers/vhost/net.o:(.bss+0x0): first defined here
>    m68k-linux-ld: drivers/vhost/vdpa.o:(.bss+0x0): multiple definition of `vq'; drivers/vhost/net.o:(.bss+0x0): first defined here
>    m68k-linux-ld: drivers/vhost/vhost.o:(.bss+0x0): multiple definition of `vq'; drivers/vhost/net.o:(.bss+0x0): first defined here

Mike, what's going on with these failures?
Can you figure it out pls?

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


