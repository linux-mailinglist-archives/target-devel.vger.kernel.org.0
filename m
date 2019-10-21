Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A1DDE281
	for <lists+target-devel@lfdr.de>; Mon, 21 Oct 2019 05:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfJUDSi (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 20 Oct 2019 23:18:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbfJUDSi (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Sun, 20 Oct 2019 23:18:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D28FB4FD;
        Mon, 21 Oct 2019 03:18:36 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:18:18 +1100
From:   David Disseldorp <ddiss@suse.de>
To:     Mike Christie <mchristi@redhat.com>
Cc:     target-devel@vger.kernel.org, martin.petersen@oracle.com,
        bvanassche@acm.org
Subject: Re: [PATCH 2/3] target: fix SendTargets=All string compares
Message-ID: <20191021141818.1418e5db@suse.de>
In-Reply-To: <5D94D9D2.7030709@redhat.com>
References: <20190912095547.22427-1-ddiss@suse.de>
        <20190912095547.22427-3-ddiss@suse.de>
        <5D94D9D2.7030709@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Mike,

On Wed, 2 Oct 2019 12:09:38 -0500, Mike Christie wrote:

> On 09/12/2019 04:55 AM, David Disseldorp wrote:
> > strncmp is currently used for "SendTargets" key and "All" value matching
> > without checking for trailing garbage. This means that Text request PDUs
> > with garbage such as "SendTargetsPlease=All" and "SendTargets=Alle" are
> > processed successfully as if they were "SendTargets=All" requests.
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  drivers/target/iscsi/iscsi_target.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> > index d19e051f2bc2..09e55ea0bf5d 100644
> > --- a/drivers/target/iscsi/iscsi_target.c
> > +++ b/drivers/target/iscsi/iscsi_target.c
> > @@ -2189,24 +2189,22 @@ iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
> >  		}
> >  		goto empty_sendtargets;
> >  	}
> > -	if (strncmp("SendTargets", text_in, 11) != 0) {
> > +	if (strncmp("SendTargets=", text_in, 12) != 0) {
> >  		pr_err("Received Text Data that is not"
> >  			" SendTargets, cannot continue.\n");
> >  		goto reject;
> >  	}
> > +	/* '=' confirmed in strncmp */
> >  	text_ptr = strchr(text_in, '=');
> > -	if (!text_ptr) {
> > -		pr_err("No \"=\" separator found in Text Data,"
> > -			"  cannot continue.\n");
> > -		goto reject;
> > -	}
> > -	if (!strncmp("=All", text_ptr, 4)) {
> > +	BUG_ON(!text_ptr);
> > +	if (!strncmp("=All", text_ptr, 5)) {  
> 
> Why is the count 5 now?

To ensure that the compare includes the null terminator, rejecting
trailing garbage (e.g. "SendTargets=AllGarbage"). strcmp() would also be
an option.

> Did the ones below need to be increased too then?
> 
> >  		cmd->cmd_flags |= ICF_SENDTARGETS_ALL;
> >  	} else if (!strncmp("=iqn.", text_ptr, 5) ||
> >  		   !strncmp("=eui.", text_ptr, 5)) {
> >  		cmd->cmd_flags |= ICF_SENDTARGETS_SINGLE;

No, in this case we only want to check for the valid prefix. The full
string is later compared against existing target names.

Cheers, David
