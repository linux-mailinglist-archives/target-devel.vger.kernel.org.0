Return-Path: <target-devel+bounces-34-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F4813B87
	for <lists+target-devel@lfdr.de>; Thu, 14 Dec 2023 21:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFA41C21B0F
	for <lists+target-devel@lfdr.de>; Thu, 14 Dec 2023 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B026A34D;
	Thu, 14 Dec 2023 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mko5chAn"
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E46ABA2
	for <target-devel@vger.kernel.org>; Thu, 14 Dec 2023 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702585807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXuga73/c/MA5mQD7NNrVlnCLK003+KYeVkn9fwBS0Q=;
	b=Mko5chAnO2UCG07VQXmSeyDrlr8Yv3xu/DG9Fswisbau5cw6yskuyw8vAGkoz7wbXzj5M5
	5Rl7RaHl85ZFjRjz3enpVYMwDGKvz8ZVHeYYEqchpgawFVtZyf0XdAl1f7rGpFXAtWbW0d
	4R4oy9IC4qURTFBbrqDb7F54FxoaERc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-5RDRj6REPkG2aO5zjCKD4Q-1; Thu, 14 Dec 2023 15:30:02 -0500
X-MC-Unique: 5RDRj6REPkG2aO5zjCKD4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A11888FBA3;
	Thu, 14 Dec 2023 20:30:02 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.17.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CD052166B31;
	Thu, 14 Dec 2023 20:30:01 +0000 (UTC)
Date: Thu, 14 Dec 2023 12:29:59 -0800
From: Chris Leech <cleech@redhat.com>
To: Lee Duncan <lduncan@suse.com>
Cc: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, dbond@suse.com, hare@suse.de,
	michael.christie@oracle.com
Subject: Re: [PATCH 1/2] scsi: target: iscsi: handle SCSI immediate commands
Message-ID: <ZXtlxzVtY3M_WrQ2@rhel-developer-toolbox-latest>
References: <cover.1701540918.git.lduncan@suse.com>
 <dc0006176e90cf3fb90e5b1c1917b54fe07c91cd.1701540918.git.lduncan@suse.com>
 <ZXoOtgVZW_QpkU11@rhel-developer-toolbox-latest>
 <CAPj3X_W5kOEOapG3F8NETBRzBmrQ1Lfudy7QGmCLXPT3UwUrkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj3X_W5kOEOapG3F8NETBRzBmrQ1Lfudy7QGmCLXPT3UwUrkw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Wed, Dec 13, 2023 at 05:24:54PM -0800, Lee Duncan wrote:
> >
> > > @@ -1255,14 +1248,15 @@ int iscsit_process_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
> > >       /*
> > >        * Check the CmdSN against ExpCmdSN/MaxCmdSN here if
> > >        * the Immediate Bit is not set, and no Immediate
> > > -      * Data is attached.
> > > +      * Data is attached. Also skip the check if this is
> > > +      * an immediate command.
> >
> > This comment addition seems redundant, isn't that what the
> > "Immediate Bit is not set" already means?
> 
> The spec is confusing with respect to this. The "Immediate Bit" means
> an immediate command. These commands are done "now", not queued, and
> they do not increment the expected sequence number.
> 
> Immediate data is different, and unfortunately named IMHO. It's when a
> PDU supplies the data for the SCSI command in the current PDU instead
> of the next PDU.

I understand the protocol, just trying to make sense of the
implementation and what the existing comment meant. And the existing
comment already has two conditions in it, even if the code doesn't.

I think I understand now why this is delaying CmdSN validation when
there is immediate data, until after the DataCRC can be checked.

This comment in iscsit_get_immediate_data, where the delayed processing
occurs, also seems to read that "Immediate Bit" is in reference to an
immediate command.

  * A PDU/CmdSN carrying Immediate Data passed
  * DataCRC, check against ExpCmdSN/MaxCmdSN if
  * Immediate Bit is not set.

but neither of these locations (before these changes) that mention the
"Immediate Bit" in the comments actually check for cmd->immediate_cmd.

> > >        *
> > >        * A PDU/CmdSN carrying Immediate Data can only
> > >        * be processed after the DataCRC has passed.
> > >        * If the DataCRC fails, the CmdSN MUST NOT
> > >        * be acknowledged. (See below)
> > >        */
> > > -     if (!cmd->immediate_data) {
> > > +     if (!cmd->immediate_data && !cmd->immediate_cmd) {
> > >               cmdsn_ret = iscsit_sequence_cmd(conn, cmd,
> > >                                       (unsigned char *)hdr, hdr->cmdsn);
> > >               if (cmdsn_ret == CMDSN_ERROR_CANNOT_RECOVER)
> >
> > Are you sure this needs to be checking both conditions here?  I'm
> > struggling to understand why CmdSN checking would be bypassed for
> > immediate data.  Is this a longstanding bug where the condition should
> > have been on immediate_cmd (and only immediate_cmd) instead?
> 
> The immediate data check was there already, and there haven't been any
> bugs I know of, so I assumed that part of the code was ok.
> 
> >
> > Or is this because of the handling the immediate data with DataCRC case
> > mentioned?  I do see iscsit_sequence_cmd also being called in
> > iscsit_get_immediate_data.
> 
> I will check that but I suspect you are correct.

Is it correct to skip all of iscsit_sequence_cmd for an immediate
command here? You are already skipping iscsit_check_received_cmdsn
inside iscsit_sequence_cmd in this patch. If cmd->immediate_cmd is set,
where does iscsit_execute_cmd now get called from?

- Chris Leech


