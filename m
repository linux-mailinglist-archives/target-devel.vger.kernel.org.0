Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3767DFF1
	for <lists+target-devel@lfdr.de>; Thu,  1 Aug 2019 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfHAQSs (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 1 Aug 2019 12:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQSs (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:18:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A46D14D534;
        Thu,  1 Aug 2019 16:18:48 +0000 (UTC)
Received: from [10.10.120.21] (ovpn-120-21.rdu2.redhat.com [10.10.120.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 387EA5D9CA;
        Thu,  1 Aug 2019 16:18:48 +0000 (UTC)
Subject: Re: Reporting of errors detected by handler_read() before it returns
To:     David Butterfield <dab21774@gmail.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <5e14ffb2-d08d-7ee4-7bba-09a83627b0d5@gmail.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D4310E7.5020701@redhat.com>
Date:   Thu, 1 Aug 2019 11:18:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <5e14ffb2-d08d-7ee4-7bba-09a83627b0d5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 01 Aug 2019 16:18:48 +0000 (UTC)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Sorry for the late reply. Maybe add a tcmu prefix to the subject next time.

On 07/23/2019 09:07 PM, David Butterfield wrote:
> In tcmu-runner.h some comments in struct tcmur_handler say this:
> 
> 	/*
> 	 * Below callbacks are only executed by generic_handle_cmd.
> 	 * Returns:
> 	 * - TCMU_STS_OK if the handler has queued the command.
> 	 * - TCMU_STS_NO_RESOURCE if the handler was not able to allocate
> 	 *   resources for the command.
> 	 *
> 	 * If TCMU_STS_OK is returned from the callout the handler must call
> 	 * the tcmulib_cmd->done function with TCMU_STS return code.
> 	 */
> 	rw_fn_t write;
> 	rw_fn_t read;
> 	flush_fn_t flush;
> 	unmap_fn_t unmap;
> 
> It is not clear what the handler should do if it detects a non-resource error, processing
> one of those command types, before returning from the handler's callout function.
>     
> The comment appears to say that rhandler->write() could return TCMU_STS_OK after calling
> cmd->done(..., TCMU_STS_error) (so callers should be warned that the completion can occur
> before the request call returns).
> 
> But given that the caller has to check for TCMU_STS_NO_RESOURCE anyway, perhaps it is also
> permitted to simply return other errors directly from the callout function, always omitting
> the call to cmd->done() when TCMU_STS_OK is not returned.
> 
> However, the code in file_example.c does not do either of those things, and directly
> violates the comment in tcmu-runner.h -- this excerpt is from file_read():
> 
> 	while (remaining) {
> 		ret = preadv(state->fd, iov, iov_cnt, offset);
> 		if (ret < 0) {
> 			tcmu_err("read failed: %m\n");
> 			ret = TCMU_STS_RD_ERR;
> 			goto done;
> 		}
> 		...
> 	}
> 	ret = TCMU_STS_OK;
> done:
> 	return ret;
> 
> The file_read() function operates synchronously, and never issues a call to cmd->done()
> for successful reads returning TCMU_STS_OK, contradicting the comment in tcmu-runner.h.
> 
> Assuming the function is required to call cmd->done() for a successful operation, a
> question remains which of these solutions is more correct or preferred.  (I would prefer
> the first one be allowed -- to return any TCMU_STS_error directly from the function and
> omit the call to cmd->done() whenever returning TCMU_STS_OK.)
> 

Update your tcmu-runner git repo :)

A little bit ago, the comments in tcmu-runner.h were updated to make it
clear what type of handler can do what, and also support for not having
to call cmd->done in handlers like file_example was added.

