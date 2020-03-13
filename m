Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32FD184DC6
	for <lists+target-devel@lfdr.de>; Fri, 13 Mar 2020 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCMRjd (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 13 Mar 2020 13:39:33 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51629 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCMRjd (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:39:33 -0400
Received: by mail-pj1-f66.google.com with SMTP id hg10so557921pjb.1
        for <target-devel@vger.kernel.org>; Fri, 13 Mar 2020 10:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tbc1EI7lEPXWGGWeEn14ZO9JQmfUzUArY59WqUMfG50=;
        b=IDRh3Y9hgbWTlzN6g7NvibMt/iuExx/s301uTa8kBkHSHgLjl/Qpp2PsW+Ml8Hwt2p
         oNqkmp1mONS3amscWWLsRLnYIxgXxfRPIqbDi8xEvuPtbxV8/5JcKIX1ghHctpKUTcp8
         VDNXbLrds6eALjpz61R2TJfd2Vh1nuSJw+zy39XrqmtknSgXrpgZYyJGkeD+yJaDdsjR
         3g0fG3kYKNYPIkc+9N8ZS+mL3jYhFUG/1Bhc0QJx7hKmupBpnnKpYDCjUbrncECoxHw7
         0vSSVgb/6lqNo8Rpd+e6En+ezy/4Pz/Y+SK4rvVgi4HLtR/M82khl3S4KNXBLv+f4Sby
         9u6g==
X-Gm-Message-State: ANhLgQ1WXUVVt+AqyPHH8mNOB7hsSdMvYYmrFCB2wV7r+bcMFnSvWc1v
        Bow4QlSViudvvohnmQU1Xec=
X-Google-Smtp-Source: ADFU+vtpvBLCNjQnDOx27xyIeG6AgSQE1QEaBten6QgKnJ7dDyHGy06R8UdcytlJCQVaHlB01z0D+g==
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr10949426pjb.89.1584121171042;
        Fri, 13 Mar 2020 10:39:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:af99:b4cf:6b17:1075? ([2601:647:4000:d7:af99:b4cf:6b17:1075])
        by smtp.gmail.com with ESMTPSA id i3sm10208525pfa.34.2020.03.13.10.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 10:39:30 -0700 (PDT)
Subject: Re: [PATCH 0/3] Fix a race condition in the target driver
To:     Maurizio Lombardi <mlombard@redhat.com>,
        target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, ddiss@suse.de, mcoleman@datto.com,
        Varun Prakash <varun@chelsio.com>,
        Rahul Kundu <rahul.kundu@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
References: <20200313161253.5507-1-mlombard@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <650e95a9-c055-304c-6f91-4b9f7c046bb4@acm.org>
Date:   Fri, 13 Mar 2020 10:39:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313161253.5507-1-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 3/13/20 9:12 AM, Maurizio Lombardi wrote:
> Multiple threads may try to destroy the same iscsi session
> structure by calling iscsit_close_session() and then end
> up hanging.
> 
> This patchset modifies the driver so the session
> structure is destroyed by iscsit_close_connection() when
> the last connection gets closed, thus preventing
> the race condition.
> 
> Maurizio Lombardi (3):
>    target: remove boilerplate code
>    target: fix target hang when multiple threads try to destroy the same
>      iscsi session.
>    iscsi target: calling iscsit_stop_session() inside
>      iscsit_close_session() has no effect
> 
>   drivers/target/iscsi/iscsi_target.c          | 82 ++++++--------------
>   drivers/target/iscsi/iscsi_target.h          |  1 -
>   drivers/target/iscsi/iscsi_target_configfs.c |  5 +-
>   drivers/target/iscsi/iscsi_target_login.c    |  5 +-
>   include/target/iscsi/iscsi_target_core.h     |  2 +-
>   5 files changed, 32 insertions(+), 63 deletions(-)
> 

Hi Mike, Varun and Rahul,

This patch series may affect the iSER target driver so you may want to 
verify this patch series on your test setups.

Thanks,

Bart.
