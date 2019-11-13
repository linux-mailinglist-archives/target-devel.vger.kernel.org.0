Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CEFB66E
	for <lists+target-devel@lfdr.de>; Wed, 13 Nov 2019 18:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfKMR3y (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 13 Nov 2019 12:29:54 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:35380 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfKMR3x (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:29:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D926B41293;
        Wed, 13 Nov 2019 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1573666190;
         x=1575480591; bh=MHf0i9d9iqK7IJ4I7+WQ8RIi7Iu69aJo+xynMiC7vNc=; b=
        Hwv/jGg5qaFKnIcO6WmWYzczAkNtdjUvpIQv3niObvNzsBQSdztAgTbqUr3r4MVI
        mkJracJID/Kq6+vnFYlOCzj2LSWvOUiI3klz6xfpFaE/jvQ7jkKbYPEillXV+XFK
        8klP9mjE6+n4DWhEaotCcB1yAtsjymWVgOnZ9t8qZiA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1RMLfT43aXVI; Wed, 13 Nov 2019 20:29:50 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 66B8A4120B;
        Wed, 13 Nov 2019 20:29:50 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 13
 Nov 2019 20:29:49 +0300
Date:   Wed, 13 Nov 2019 20:29:49 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>, <target-devel@vger.kernel.org>
Subject: Re: [PATCH 3/3] target/iscsi: Wait for all commands to finish before
 freeing a session
Message-ID: <20191113172949.dkcantqtx7c2zcpo@SPB-NB-133.local>
References: <20191112035752.8338-1-bvanassche@acm.org>
 <20191112035752.8338-4-bvanassche@acm.org>
 <20191113134253.rlypgdve7qwfynjz@SPB-NB-133.local>
 <04168d9b-bd0e-0fb0-1977-8671ab9db282@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <04168d9b-bd0e-0fb0-1977-8671ab9db282@acm.org>
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:07:41AM -0800, Bart Van Assche wrote:
> On 11/13/19 5:42 AM, Roman Bolshakov wrote:
> > On Mon, Nov 11, 2019 at 07:57:52PM -0800, Bart Van Assche wrote:
> > > -	target_get_sess_cmd(&cmd->se_cmd, true);
> > > +	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
> > > +		return iscsit_add_reject_cmd(cmd,
> > > +				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
> > 
> > Sending the reject reason implies initiator can resend original PDU,
> > according to https://tools.ietf.org/html/rfc7143#section-11.17.1
> > 
> > Is it intended, i.e. do we want the retry?
> 
> Hi Roman,
> 
> The two new iscsit_add_reject_cmd() can only be triggered if the initiator
> sends one or more iSCSI PDUs after the logout PDU. I think that's a
> violation of the iSCSI protocol. Anyway, how about changing the reject
> reason into ISCSI_REASON_PROTOCOL_ERROR?
> 
> Thanks,
> 
> Bart.
> 

Thanks for the context, would reason code "Waiting for Logout" (0x0c) be
suffice for the case as documented in 11.9.1. AsyncEvent
(https://tools.ietf.org/html/rfc7143#section-11.9.1):

        1 (Logout Request) - the target requests Logout.  This Async
          Message MUST be sent on the same connection as the one
          requesting to be logged out.  The initiator MUST honor this
          request by issuing a Logout as early as possible but no later
          than Parameter3 seconds.  The initiator MUST send a Logout
          with a reason code of "close the connection" OR "close the
          session" to close all the connections.  Once this message is
          received, the initiator SHOULD NOT issue new iSCSI commands on
          the connection to be logged out.  The target MAY reject any
          new I/O requests that it receives after this message with the
          reason code "Waiting for Logout". If the initiator does not
          log out in Parameter3 seconds, the target should send an Async
          PDU with iSCSI event code "Dropped the connection" if possible
          or simply terminate the transport connection.  Parameter1 and
          Parameter2 are reserved.


--
Roman
