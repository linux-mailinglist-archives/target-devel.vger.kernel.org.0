Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0DD7243A
	for <lists+target-devel@lfdr.de>; Wed, 24 Jul 2019 04:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfGXCHS (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 23 Jul 2019 22:07:18 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:41873 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfGXCHS (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:07:18 -0400
Received: by mail-io1-f52.google.com with SMTP id j5so82020021ioj.8
        for <target-devel@vger.kernel.org>; Tue, 23 Jul 2019 19:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NVD5ySMjyMrDAVy/OaPz+2yNPpXNwEYLlx6gGuq7jcg=;
        b=KRqbd+ghb0nqmNwnCrn6fCVjM72pPMEE/wxBRRxvy6LWdZcjvSpsICWn70vv/MAiDM
         Zcz3PlEal98f8VmB2FFfT2fjBbujX7OEqm9PmuNNmCj0XOZtAfIJk01OJuKXVg2u9INf
         fZgBDUKv/+4CF/4q0W/vpFn9+DQVu3xewnw0lggMoVP5gec5Nh9zB2G3Dl2aBFLqocyw
         IHFW1txS1cMIHWYKWmRwDYzQ1qQyGlcHdbX/EzWpY8UCCu+uKHmDpEA9r3eP7mmCG6pm
         1v46xtAhR6s2nDqg78RyGoTsSMFdrFs3F8wr0o+NkdOWx90MtUS78TBsObRdgJYUp09N
         6wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=NVD5ySMjyMrDAVy/OaPz+2yNPpXNwEYLlx6gGuq7jcg=;
        b=X68InhEThc1cVMDqNqkVkHl8qTiU1/I+WHXJLroi8qT3gT8VgEysVTN3FBAL+iBVLB
         Fvfl68yTlo1GVv1ursMKGf45sd9onTeSJ7npdjC5NiqxHPUhTs1+rMB8DwpcXN4knWXR
         +YNP+dSQEy9oCjkx0tfDsDpbc1f1CtwKezVANMYR+6Pw5LfEbcvpj1nZG7nCu4+xEEfr
         Kr17ciU10PVxAJUJZXZsuaV1L1FsH/k3fI1YEc8IT6KZr4chiB+J43I8mwJuxQggox5J
         65peuhnB8gIcEM0EYp8iNn5g8CoRHhuOhtcQqhRHEwhEQqafE6kpnrMHTsccRE9Z9G06
         wq6g==
X-Gm-Message-State: APjAAAXsUiC5y0hVIYWRL8RrdFpPuIPOAPf4kr5qYJNJeQH2w3FIoBRP
        FR2IC9FqLN3ug3y7wn/I3k0TXd/f
X-Google-Smtp-Source: APXvYqxVPEQWFlwNvNZgxDXSrJowN9x/gA20Hcem6RxoltQCFCQbrkDbGcyFZXgX0EL7HgsB4Q9l0A==
X-Received: by 2002:a6b:c803:: with SMTP id y3mr61119174iof.275.1563934037178;
        Tue, 23 Jul 2019 19:07:17 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net. [73.78.150.191])
        by smtp.gmail.com with ESMTPSA id c81sm69078970iof.28.2019.07.23.19.07.16
        for <target-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 19:07:16 -0700 (PDT)
To:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
From:   David Butterfield <dab21774@gmail.com>
Subject: Reporting of errors detected by handler_read() before it returns
Organization: PGP: 70C7 0309 E859 40AB 4D1F CDC5 F7CE 9A64 95EB 9D1B
Message-ID: <5e14ffb2-d08d-7ee4-7bba-09a83627b0d5@gmail.com>
Date:   Tue, 23 Jul 2019 20:07:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

In tcmu-runner.h some comments in struct tcmur_handler say this:

	/*
	 * Below callbacks are only executed by generic_handle_cmd.
	 * Returns:
	 * - TCMU_STS_OK if the handler has queued the command.
	 * - TCMU_STS_NO_RESOURCE if the handler was not able to allocate
	 *   resources for the command.
	 *
	 * If TCMU_STS_OK is returned from the callout the handler must call
	 * the tcmulib_cmd->done function with TCMU_STS return code.
	 */
	rw_fn_t write;
	rw_fn_t read;
	flush_fn_t flush;
	unmap_fn_t unmap;

It is not clear what the handler should do if it detects a non-resource error, processing
one of those command types, before returning from the handler's callout function.
    
The comment appears to say that rhandler->write() could return TCMU_STS_OK after calling
cmd->done(..., TCMU_STS_error) (so callers should be warned that the completion can occur
before the request call returns).

But given that the caller has to check for TCMU_STS_NO_RESOURCE anyway, perhaps it is also
permitted to simply return other errors directly from the callout function, always omitting
the call to cmd->done() when TCMU_STS_OK is not returned.

However, the code in file_example.c does not do either of those things, and directly
violates the comment in tcmu-runner.h -- this excerpt is from file_read():

	while (remaining) {
		ret = preadv(state->fd, iov, iov_cnt, offset);
		if (ret < 0) {
			tcmu_err("read failed: %m\n");
			ret = TCMU_STS_RD_ERR;
			goto done;
		}
		...
	}
	ret = TCMU_STS_OK;
done:
	return ret;

The file_read() function operates synchronously, and never issues a call to cmd->done()
for successful reads returning TCMU_STS_OK, contradicting the comment in tcmu-runner.h.

Assuming the function is required to call cmd->done() for a successful operation, a
question remains which of these solutions is more correct or preferred.  (I would prefer
the first one be allowed -- to return any TCMU_STS_error directly from the function and
omit the call to cmd->done() whenever returning TCMU_STS_OK.)

/**************************************/
	ret = TCMU_STS_OK;
	cmd->done(dev, cmd, ret);
done:
	return ret;
/**************************************/

or

/**************************************/
	ret = TCMU_STS_OK;
done:
	cmd->done(dev, cmd, ret);
	return TCMU_STS_OK;
/**************************************/
