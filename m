Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD013BCEB
	for <lists+target-devel@lfdr.de>; Wed, 15 Jan 2020 10:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgAOJ52 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 15 Jan 2020 04:57:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:39088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgAOJ51 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:57:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22502AC88;
        Wed, 15 Jan 2020 09:57:25 +0000 (UTC)
Date:   Wed, 15 Jan 2020 10:57:24 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Zhu Lingshan <lingshan.zhu@linux.intel.com>
Cc:     Hannes Reinecke <hare@suse.de>, target-devel@vger.kernel.org
Subject: Re: Cannot log in from BIOS to linux target
Message-ID: <20200115095724.GL4113@kitsune.suse.cz>
References: <20200113165128.GC4113@kitsune.suse.cz>
 <b8c09533-3d1e-bebf-6bb3-74f3a1aa6a75@linux.intel.com>
 <9c1d4e16-4cb6-5c78-46b1-f3f88158037d@suse.de>
 <bc2b330a-9624-9e21-6a41-7ad7675b1f63@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc2b330a-9624-9e21-6a41-7ad7675b1f63@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Jan 15, 2020 at 05:26:35PM +0800, Zhu Lingshan wrote:
> Hi Michal,
> 
> Why not give a try on Yast2 iscsi target module? It would be easy to config
> your target with it.

Presumably it's easy with targetcli as well, and should work on any
distribution. I don't think changing the tool will change the fact that
authentication is required when it is disabled.

Thanks

Michal
> 
> Thanks,
> BR
> Zhu Lingshan
> 
> On 1/15/2020 3:07 PM, Hannes Reinecke wrote:
> > On 1/15/20 6:15 AM, Zhu Lingshan wrote:
> > > Hi Michal,
> > > 
> > > try demo mode for a experiment? Here is a guide
> > > http://www.linux-iscsi.org/wiki/ISCSI#Demo_mode
> > > you can also find how to config username /password there.
> > > 
> > > Thanks,
> > > Zhu Lingshan
> > > On 1/14/2020 12:51 AM, Michal Suchánek wrote:
> > > > Hello,
> > > > 
> > > > my system BIOS support booting from iSCSI.
> > > > 
> > > > I set up readonly target with no authentication:
> > > > 
> > > > targetcli shell version 2.1.fb49
> > > > 
> > > > grub
> > > > ..................................................................
> > > > [/scratch/ISO/GRUB (1.8MiB) write-back activated]
> > > >     | |   o- alua
> > > > .................................................................................................
> > > > [ALUA Groups: 1]
> > > >     | |     o- default_tg_pt_gp
> > > > .....................................................................
> > > > [ALUA state: Active/optimized]
> > > > 
> > > >    | | o- tpg1
> > > > ................................................................................................
> > > > [gen-acls, no-auth]
> > > >     | |   |   o- mapped_lun0
> > > > ...............................................................................
> > > > [lun0 fileio/grub (rw)]
> > > > The readonly flag does not seem to be
> > > > honored
> > > > ^^^
> > > > 
> > > > Anyway, the initiator cannot log in:
> > > > 
> > > > 3,1360,2329588663878,-;Initiator sent zero length security payload,
> > > > login failed
> > > > 3,1361,2329588663897,-;iSCSI Login negotiation failed.
> > > > 
> > > > How can I export a LUN without a password?
> > > > 
> > > > Thanks
> > > > 
> > > > Michal
> > It's actually not the password that's missing, it's the ACL.
> > You have registered your iSCSI initiatorname with the target, right?
> > 
> > Cheers,
> > 
> > Hannes
